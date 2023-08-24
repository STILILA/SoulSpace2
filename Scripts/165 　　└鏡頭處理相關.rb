#==============================================================================
# ■ 和鏡頭有關的處理都放這
#------------------------------------------------------------------------------
#      進行縮放時不要低於1倍 (就是把整個畫面拉遠) ，否則有可能破圖

# 鏡頭移動到某處
# @spriteset.screen_target(x, y, 縮放率)
#  x為0時鏡頭在正中央，正往左、負往右
#  y正往上、負往下
#  更詳細的說明請看方法 screen_over 的註解

#==============================================================================




#==============================================================================
# ■ Game_Actor
#------------------------------------------------------------------------------
# 　アクターを扱うクラスです。このクラスは Game_Actors クラス ($game_actors)
# の内部で使用され、Game_Party クラス ($game_party) からも参照されます。
#==============================================================================

class Game_Actor < Game_Battler
  
  #--------------------------------------------------------------------------
  # ● 設定與紀錄初始位置
  #--------------------------------------------------------------------------
  def set_default_pos(index)
    
    # ============= X 軸設定
    if index != nil
      case index
      when 0
        base = 350 
      when 1
        base = 400
      when 2
        base = 460
      when 3
        base = 490 
      end
    else
      base = 0
    end
    @base_x = @x_pos = base# + 60
    # ============= Y軸設定
    @base_y = @y_pos = 0
    
    # ============= Z軸設定
    if index != nil
      case index
      when 0
        base = 220 
      when 1
        base = 280
      when 2
        base = 200
      when 3
        base = 300
      end
   #   base += $game_temp.basic_camera_y
    else
      base = 0#$game_temp.basic_camera_y
    end
    @base_z = @z_pos = base
    
  end
  
  #--------------------------------------------------------------------------
  # ● 基本 X 座標
  #--------------------------------------------------------------------------
  def true_x
    return @x_pos
  end
  #--------------------------------------------------------------------------
  # ● 畫面X座標
  #--------------------------------------------------------------------------
  def screen_x
    return (320 + (true_x - 320) * $game_temp.battle_camera_z  + $game_temp.battle_camera_x).to_i
 #   return 320 + (true_x - @real_x) * @real_zoom
  end
  #--------------------------------------------------------------------------
  # ● 基本Y座標
  #--------------------------------------------------------------------------
  def true_y
    return @y_pos
  end
  #--------------------------------------------------------------------------
  # ● 畫面Y座標
  #--------------------------------------------------------------------------
  def screen_y
    return ((@z_pos + true_y) * $game_temp.battle_camera_z + $game_temp.battle_camera_y).to_i + 10
 #   return (true_y + @real_y) * @real_zoom 
  end

  #--------------------------------------------------------------------------
  # ● 基本Z座標
  #--------------------------------------------------------------------------
  def true_z
    return @z_pos
  end
  #--------------------------------------------------------------------------
  # ● 畫面Z座標
  #--------------------------------------------------------------------------
  def screen_z
    return true_z #true_y + @fly
  end
  #--------------------------------------------------------------------------
  # ● 畫面放大率
  #--------------------------------------------------------------------------
  def zoom
    return ($scene.zoom_rate[1] - $scene.zoom_rate[0]) * (true_z + @fly) / 320 + $scene.zoom_rate[0]
  end

end

#==============================================================================
# ■ Game_Enemy
#------------------------------------------------------------------------------
# 　エネミーを扱うクラスです。このクラスは Game_Troop クラス ($game_troop) の
# 内部で使用されます。
#==============================================================================

class Game_Enemy < Game_Battler
  
  #--------------------------------------------------------------------------
  # ● 設定與紀錄初始位置
  #--------------------------------------------------------------------------
  def set_default_pos(index)
    # ============= X 軸設定
    @base_x = @x_pos = $data_troops[@troop_id].members[@member_index].x - 90 + 30
    # ============= Y軸設定
    @base_y = @y_pos = 0
    # ============= Z軸設定
     @base_z = @z_pos = $data_troops[@troop_id].members[@member_index].y - 30 #+ $game_temp.basic_camera_y
  end
  
  
  #--------------------------------------------------------------------------
  # ● 基本 X 座標
  #--------------------------------------------------------------------------
  def true_x
    return @x_pos
  end
  #--------------------------------------------------------------------------
  # ● 基本 Y 座標
  #--------------------------------------------------------------------------
  def true_y
    return @y_pos
  end
  #--------------------------------------------------------------------------
  # ● 基本Z座標
  #--------------------------------------------------------------------------
  def true_z
    return @z_pos
  end
  #--------------------------------------------------------------------------
  # ● 畫面X座標
  #--------------------------------------------------------------------------
  def screen_x
    return 320 + (true_x - 320) * $game_temp.battle_camera_z + $game_temp.battle_camera_x
  end
  #--------------------------------------------------------------------------
  # ● 畫面Y座標
  #--------------------------------------------------------------------------
  def screen_y
    return (true_y + true_z) * $game_temp.battle_camera_z + $game_temp.battle_camera_y + 10
  end
  #--------------------------------------------------------------------------
  # ● バトル画面 Z 座標の取得
  #--------------------------------------------------------------------------
  def screen_z
    return true_z #true_y + @fly
  end
  #--------------------------------------------------------------------------
  # ● 攻撃用、バトル画面 X 座標の取得
  #--------------------------------------------------------------------------
  def attack_x(z)
    return (320 - true_x) * z * 0.75
  end
  #--------------------------------------------------------------------------
  # ● 攻撃用、バトル画面 Y 座標の取得
  #--------------------------------------------------------------------------
  def attack_y(z)
    return (160 - (true_y + true_z  + @fly / 4) * z + @height * zoom * z / 2) * 0.75
  end
  #--------------------------------------------------------------------------
  # ● バトル画面 拡大率の取得
  #--------------------------------------------------------------------------
  def zoom
    return ($scene.zoom_rate[1] - $scene.zoom_rate[0]) * (true_z + @fly) / 320 + $scene.zoom_rate[0]
  end
end



#==============================================================================
# ■ Scene_Battle
#------------------------------------------------------------------------------
# 　處理戰鬥畫面的類別。
#==============================================================================
class Scene_Battle
  
  
  #--------------------------------------------------------------------------
  # ● 有角色在行動中？ (歸位判定用)
  #--------------------------------------------------------------------------
  def have_in_action_battler?
    if @action_battlers.empty?
      return false
    else
      for battler in @action_battlers
        return true if battler.action_flag
      end
    end
    return false
  end
  
  
  #--------------------------------------------------------------------------
  # ● phase更新  (AT槽更新 phase) (對應時停) (對應橫版)
  #--------------------------------------------------------------------------
  def update_phase0
    if $game_temp.battle_turn == 0
      $game_temp.battle_turn = 1
    end
    # ATゲージ増加処理
    cnt = 0
    for battler in $game_party.actors + $game_troop.enemies
      active?(battler)
      unless battler.world  # 時停判定追加 
        if battler.rtp == 0
          if battler.at >= @max
            if battler.is_a?(Game_Actor)
              if battler.inputable?
                unless @action_battlers.include?(battler) or @command.include?(battler) or @escape == true
                  if battler.current_action.forcing
                    fullat_se
                    force_action(battler)
                    action_start(battler)
                  else
                    
                    # AI控制
                    if battler.state?(STILILA::AI_STATE)
                      battler.make_action_ai
                      action_start(battler)
                    else
                       fullat_se
                      @command.push(battler)
                    end
                  end # if battler.current_action.forcing
                end # unless  @action_battlers.include?(battler) or @command.include?(battler) or @escape == true
              else
                unless @action_battlers.include?(battler) or battler == @command[0]
                  battler.current_action.clear
                  if @command.include?(battler)
                    @command.delete(battler)
                  else
                    if battler.movable?
                      fullat_se
                    end
                  end #  if @command.include?(battler)
                  action_start(battler)
                end # unless @action_battlers.include?(battler) or battler == @command[0]
              end # if battler.inputable?
            else  # ================================== 敵人的處理
              unless @action_battlers.include?(battler)
                if battler.current_action.forcing
                  force_action(battler)
                  action_start(battler)
                else
                  if @enemy_speed != 0
                    if rand(@enemy_speed) == 0
                      number = cnt - $game_party.actors.size
                      enemy_action(number) if @action_battlers.empty?
                    end
                  else
                    number = cnt - $game_party.actors.size
                    enemy_action(number) if @action_battlers.empty?
                  end # if @enemy_speed != 0
                end
              end # unless @action_battlers.include?(battler)
            end # if battler.is_a?(Game_Actor)
          else
            battler.at += battler.agi
      #    battler.at += battler.agi  if battler.guarding?
            if battler.movable?
              battler.atp = 100 * battler.at / @max
            end
          end
        else
           if battler.rt >= battler.rtp   #角色詠唱完畢
            speller = synthe?(battler)
            if speller != nil
              battler = speller[0]
            end
            unless @action_battlers.include?(battler)
              if battler.is_a?(Game_Actor)
          #      fullat_se
              end
              battler.rt = battler.rtp
              action_start(battler)
            end
          else  #角色詠唱中...
            battler.rt += battler.dex #AT槽以dex計算
            speller = synthe?(battler)
            if speller != nil  
              for spell in speller
                if spell != battler
                  spell.rt += battler.dex  #AT槽以dex計算
                end
              end
            end
          end
        end
      end # unless battler.world
      cnt += 1
    end # for battler in $game_party.actors + $game_troop.enemies
    
    # 刷新 AT 槽
    @status_window.at_refresh
  end
  
  #--------------------------------------------------------------------------
  # ● アニメウェイト判断処理
  #--------------------------------------------------------------------------
  def anime_wait_return
    if (@action_battlers.empty? or @anime_wait == false) and !$game_system.battle_interpreter.running? and !@spriteset.battlers_moving?
      # エネミーアローが有効の場合
      if @enemy_arrow != nil
        return [@active - 2, 0].min == 0
      # アクターアローが有効の場合
      elsif @actor_arrow != nil
        return [@active - 2, 0].min == 0
      # スキルウィンドウが有効の場合
      elsif @skill_window != nil
        return [@active - 3, 0].min == 0
      # アイテムウィンドウが有効の場合
      elsif @item_window != nil
        return [@active - 3, 0].min == 0
      # アクターコマンドウィンドウが有効の場合
      elsif @actor_command_window.active
        return [@active - 1, 0].min == 0
      else
        return true
      end
    else
      return false
    end
  end
  
  #--------------------------------------------------------------------------
  # ● アクターコマンドウィンドウのセットアップ
  #--------------------------------------------------------------------------
  def phase3_setup_command_window
    # アクターコマンドウィンドウを有効化
    @actor_command_window.active = true
    @actor_command_window.visible = true
    # アクターコマンドウィンドウの位置を設定
    #@actor_command_window.x = @active_actor.screen_x
    @actor_command_window.x = @actor_index * 160 + (4 - $game_party.actors.size) * 80 + 40
    @actor_command_window.y = 190
    # インデックスを 0 に設定
    @actor_command_window.index = 0
  end
  
  #--------------------------------------------------------------------------
  # ● フレーム更新 (アクターコマンドフェーズ : 基本コマンド)
  #--------------------------------------------------------------------------
  alias :old_update_phase3_basic_command :update_phase3_basic_command
  def update_phase3_basic_command
   # if @active_actor != nil and @active_actor.is_a?(Game_Actor)
   #   @actor_command_window.x = @active_actor.screen_x - @actor_command_window.width * 1.3
  #    @actor_command_window.y = @active_actor.screen_y - @actor_command_window.height * 0.8
   # end
    old_update_phase3_basic_command
    

    
    if Input.press?(Input::SHIFT) and @action_battlers.empty?
      update_phase0
    end
    
    
  end
  #--------------------------------------------------------------------------
  # ● 命令階段開始
  #--------------------------------------------------------------------------
  def start_phase3
    if victory?
      return
    end
    # メインフェーズフラグをクリア
    $game_temp.battle_main_phase = false
    @command_a = true
    @active_actor = @command[0]
    cnt = 0
    for actor in $game_party.actors
      if actor == @active_actor
        @actor_index = cnt
      end
      cnt += 1
    end
    @active_actor.blink = true
    unless @active_actor.inputable?
      @active_actor.current_action.clear
      phase3_next_actor
      return
    end
    phase3_setup_command_window
    # カメラの設定
    @camera = "command"
#    plus = ($game_party.actors.size - 1) / 2.0 - @actor_index
#    y = [(plus.abs - 1.5) * 10 , 0].min
#p @active_actor.screen_x - 480

   # @spriteset.screen_target(320 - @active_actor.true_x, 240 - @active_actor.true_z, 1.02)
    move_x = 30 + @active_actor.index * 8
    move_y = @active_actor.index % 2 * 15
    @spriteset.screen_target(0 - move_x, -move_y, 1.02) #if @action_battlers.empty?
  end
  #--------------------------------------------------------------------------
  # ● 命令輸入結束
  #--------------------------------------------------------------------------
  def phase3_next_actor
    @command.shift
    @command_a = false
    # メインフェーズフラグをセット
    $game_temp.battle_main_phase = true
    # アクターコマンドウィンドウを無効化
    @actor_command_window.active = false
    @actor_command_window.visible = false
    # アクターの明滅エフェクト OFF
    if @active_actor != nil
      @active_actor.blink = false
    end
    action_start(@active_actor)
    # カメラを元に戻す
   # if @camera == "command"
   #   @spriteset.screen_target(320 - @active_actor.true_x, 240 - @active_actor.true_y, 1.05)
    #  @spriteset.screen_target(0, 0, 1.02)
   # end
    return
  end
  
  #--------------------------------------------------------------------------
  # ● フレーム更新 (アクターコマンドフェーズ : エネミー選択)
  #(武器范围定义必须)
  #--------------------------------------------------------------------------
  def update_phase3_enemy_select
    # コマンド選択中に行動不能になった場合
    unless @active_actor.inputable?
      # カメラを元に戻す
      if @camera == "select"
        @spriteset.screen_target(0, 0, 1.02)
      end
      @active_actor.current_action.clear
      command_delete
      # 次のアクターのコマンド入力へ
      phase3_next_actor
      return
    end
   @active_actor.set_xrxs19_special_scope(@active_actor.equip_element_set) if @skill_window == nil
   @active_actor.set_xrxs19_special_scope(@active_actor.skill_element_set(@skill)) if @skill_window != nil
    case @active_actor.current_action.scope_force 
    when 2,4,6,7,8,9,10,11
        # アクションを設定
        @active_actor.current_action.kind = 0
        @active_actor.current_action.basic = 0
        # スキルの選択を終了
        end_enemy_select
        # 次のアクターのコマンド入力へ
        phase3_next_actor
    when 3
      # アクターアローを更新
      @actor_arrow.update
      # B ボタンが押された場合
      if Input.trigger?(Input::B)
        # キャンセル SE を演奏
        $game_system.se_play($data_system.cancel_se)
        # アクターの選択を終了
        end_enemy_select
        return
      end
      # C ボタンが押された場合
      if Input.trigger?(Input::C)
      # 決定 SE を演奏
        $game_system.se_play($data_system.decision_se)
        # アクションを設定
        @active_actor.current_action.kind = 0
        @active_actor.current_action.basic = 0
        @active_actor.current_action.target_index = @actor_arrow.index
        # アクターの選択を終了
        end_enemy_select
        # 次のアクターのコマンド入力へ
        phase3_next_actor
     end 
   else
    # エネミーアローを更新
    @enemy_arrow.update
    # B ボタンが押された場合
    if Input.trigger?(Input::B)
      # キャンセル SE を演奏
      $game_system.se_play($data_system.cancel_se)
      # カメラを元に戻す
      if @camera == "select"
        # カメラの設定
        @camera = "command"
      #  plus = ($game_party.actors.size - 1) / 2.0 - @actor_index
     #   y = [(plus.abs - 1.5) * 10 , 0].min
        #@spriteset.screen_target(320 - @active_actor.true_x, 240 - @active_actor.true_z, 1.02)
         move_x = 30 + @active_actor.index * 8
         move_y = @active_actor.index % 2 * 15
        @spriteset.screen_target(0 - move_x, -move_y, 1.02)
      end
      # エネミーの選択を終了
      end_enemy_select
      return
    end
    # C ボタンが押された場合
    if Input.trigger?(Input::C)
      # 決定 SE を演奏
      $game_system.se_play($data_system.decision_se)
      # アクションを設定
      @active_actor.current_action.kind = 0
      @active_actor.current_action.basic = 0
      @active_actor.current_action.target_index = @enemy_arrow.index
      # スキルウィンドウ表示中の場合
      if @skill_window != nil
        # アクションを再設定
        @active_actor.current_action.kind = 1
        # スキルの選択を終了
        end_skill_select
      end
      # アイテムウィンドウ表示中の場合
      if @item_window != nil
        # アクションを再設定
        @active_actor.current_action.kind = 2
        # アイテムの選択を終了
        end_item_select
      end
      # エネミーの選択を終了
      end_enemy_select
      # 次のアクターのコマンド入力へ
      phase3_next_actor
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # ● 敵人選択開始
  #--------------------------------------------------------------------------
  def start_enemy_select
    
    # ========== 從RTAB戰鬥特效搬來
    @active_actor.set_xrxs19_special_scope(@active_actor.equip_element_set) if @skill_window == nil
    @active_actor.set_xrxs19_special_scope(@active_actor.skill_element_set(@skill)) if @skill_window != nil
     if @active_actor.current_action.scope_force == 3
       # 生成角色箭头
      @actor_arrow = Arrow_Actor.new(@spriteset.viewport2)
      # 关联帮助窗口
      @actor_arrow.help_window = @help_window
    #  elsif @active_actor.current_action.scope_force == 2
    else
      # 生成敌人箭头
      @enemy_arrow = Arrow_Enemy.new(@spriteset.viewport2)
       # 关联帮助窗口
      @enemy_arrow.help_window = @help_window
    end
    # 无效化角色指令窗口
    @actor_command_window.active = false
    @actor_command_window.visible = false
    # ========== 從RTAB戰鬥特效搬來
    
    @camera = "select"
    for enemy in $game_troop.enemies
      if enemy.exist?
        zoom = 1
     #   zoom = 1 / enemy.zoom
        @spriteset.screen_target(enemy.attack_x(zoom) * 0.75, enemy.attack_y(zoom) * 0.75, zoom)
        break
      end
    end
    
    # オリジナルの処理
   # start_enemy_select_rtab
  end
  #--------------------------------------------------------------------------
  # ● 敵人選択終了
  #--------------------------------------------------------------------------
  def end_enemy_select
    # ========== 從RTAB戰鬥特效搬來
     # 释放敌人箭头
    @enemy_arrow.dispose if @enemy_arrow != nil
    @actor_arrow.dispose if @actor_arrow != nil
    @enemy_arrow = nil
    @actor_arrow = nil
    # 指令为 [战斗] 的情况下
    if @actor_command_window.index == 0
      # 有效化角色指令窗口
      @actor_command_window.active = true
      @actor_command_window.visible = true
      # 隐藏帮助窗口
      @help_window.visible = false
    end
    # ========== 從RTAB戰鬥特效搬來
    
    if (@action == 0 and not @action_battlers.empty?) or
          (@camera == "select" and (@active_actor.current_action.kind != 0 or
                                            @active_actor.animation1_id != 0))
      @spriteset.screen_target(0, 0, 1.02)
    end
  end
  
  #--------------------------------------------------------------------------
  # ● カメラセット
  #--------------------------------------------------------------------------
  def camera_set(battler)

  #  return if @camera == "command" and !victory?

    @camera = battler
    if battler.target.size == 1 # 單體系
      if battler.current_action.kind == 0 and battler.current_action.basic < 1
        zoom = 1.2 / battler.target[0].zoom
      elsif synthe?(battler) == nil
        zoom = 1.5 / battler.target[0].zoom
      else
        zoom = 2.0 / battler.target[0].zoom
      end
        # 對己方用判定
        sup = battler.target[0].class == battler.class
        # 使用者是敵方
        if battler.is_a?(Game_Enemy)
          if sup # 敵 => 敵
            @spriteset.screen_target((battler.target[0].true_x - 320).abs, 200 - battler.target[0].true_z + battler.target[0].halfheight, 1.02)
          else # 敵 => 我
            @spriteset.screen_target(320 - battler.target[0].true_x , 200 -  battler.target[0].true_z + battler.target[0].halfheight, 1.02)
          end
        else
        # 使用者是我方  
          if sup # 我 => 我
            @spriteset.screen_target(320 - battler.target[0].true_x , 200 - battler.target[0].true_z + battler.target[0].halfheight, 1.02)
          else # 我 => 敵
            @spriteset.screen_target((battler.target[0].true_x - 320).abs, 200 - battler.target[0].true_z + battler.target[0].halfheight, 1.02)
          end
        end
     # ================== 全體系   
      else 
        # 對己方用判定
        sup = battler.target[0].class == battler.class
        # 使用者是敵方
       if battler.is_a?(Game_Enemy)
          if sup # 敵 => 敵
            @spriteset.screen_target(160, -30, 1.1)
          else  # 敵 => 我
            @spriteset.screen_target(-160, -30, 1.1)
          end
        else
         # 使用者是我方 
          if sup # 我 => 我
            @spriteset.screen_target(-160, -30, 1.1)
          else # 我 => 敵
            @spriteset.screen_target(160, -30, 1.1)
          end
       end
    end
  end
  
  #--------------------------------------------------------------------------
  # ● カメラセット2
  #--------------------------------------------------------------------------
  def camera_set2(x, y, zoom)
    @spriteset.screen_target(x, y, zoom)
  end

  #--------------------------------------------------------------------------
  # ● カメラセット 自己
  #--------------------------------------------------------------------------
  def camera_setself(battler)
    if battler.true_x < 0
      @spriteset.screen_target(320 - battler.true_x, 200 - battler.true_z + battler.halfheight, 1.02)
    else
      @spriteset.screen_target((battler.true_x - 320).abs, 200 - battler.true_z + battler.halfheight, 1.02)
    end
  end
  
 #--------------------------------------------------------------------------
 # ● アクション更新 (メインフェーズ)
 #--------------------------------------------------------------------------
  def action_phase(battler)
    while true
      # action が 1 の場合、バトラーが行動中かどうか確認
      if @action == 1 and battler.phase < 3
        for target in battler.target
          speller = synthe?(target)
          if speller == nil
            # ターゲットが通常行動中の場合
            if @action_battlers.include?(target)
              if target.phase > 2
                return
              end
            end
          else
            # ターゲットが連携スキル発動中の場合
            for spell in speller
              if @action_battlers.include?(spell)
                if spell.phase > 2
                  return
                end
              end
            end
          end
        end
      end # if @action == 1 and battler.phase < 3
      case battler.phase
      when 1
        update_phase4_step1(battler)
      when 2
        update_phase4_step2(battler)
      when 3
        update_phase4_step3(battler)
      when 4
        update_phase4_step4(battler)
      when 5
        update_phase4_step5(battler)
      when 6
        update_phase4_step6(battler)
      end
      # ウェイトが入った場合
      if battler.wait > 0
        # ウェイトカウントを減らして終了
        battler.wait -= 1
        break
      end
      # 行動終了した場合ループを抜ける
      unless @action_battlers.include?(battler)
        break
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # ● フレーム更新 (メインフェーズ ステップ 1 : アクション準備)
  #--------------------------------------------------------------------------
  def update_phase4_step1(battler)
    # すでに戦闘から外されている場合
    if battler.index == nil
      @action_battlers.delete(battler)
      anime_wait_return
      battler.wait = 1
      return
    end
    
    # 有人還在移動時中斷
    if @spriteset.battlers_moving?
      # 可以行動但又不在原位時，先歸位
      if battler.battle_sprite.action_name == :"damaging" and battler.x_speed == 0 and battler.y_speed == 0 and battler.y_pos == 0# and battler.exist? and battler.battle_sprite.damage_wait == 0
        battler.battle_sprite.start_damage_turnback
      end
      
      battler.wait = 1
      return
    end

    speller = synthe?(battler)
    if speller == nil
      # ダメージ食らい中の場合
      unless battler.damage.empty? or @action > 2
        p battler.name
        battler.wait = 1
        return
      end
      # 行動可能かどうか判定
      unless battler.movable?
        battler.phase = 6
        return
      end
      # 時停判定追加(已選擇指令時，直接將動作取消)
      if battler.world 
        battler.phase = 6
        return
      end
    else
      # ダメージ食らい中の場合
      for spell in speller
        unless spell.damage.empty? or @action > 2
          battler.wait = 1
          return
        end
        # 行動可能かどうか判定
        unless spell.movable?
          battler.phase = 6
          return
        end
      end
    end

    # スキル使用時、詠唱時間設定
    # 強制アクションかつ @force が 2 の時はスキルを即時発動
    if battler.current_action.kind == 1 and
      (not battler.current_action.forcing or @force != 2)
      if battler.rtp == 0
        # スキル詠唱中ならば、解除
        skill_reset(battler)
        # スキル詠唱時間設定
        recite_time(battler)
        # 連携技設定
        synthe_spell(battler)
        # スキルを詠唱する場合
        if battler.rtp > 0
          # 強制アクションかつ @force が 1 の時は連携スキルのみ即時発動
          speller = synthe?(battler)
          if battler.current_action.forcing and @force > 0 and speller != nil
            for spell in speller
              spell.rt = spell.rtp
            end
          else
      #      battler.blink = true
            if battler.current_action.forcing
              $game_temp.forcing_battler = nil
              battler.current_action.forcing = false
            end
            @action_battlers.delete(battler)
            return
          end
        end
      end
    end
    # アクターの明滅エフェクト OFF
    if battler != nil
      battler.blink = false
    end
    speller = synthe?(battler)
    if speller == nil
      @spell_p.delete(battler)
      @spell_e.delete(battler)
    else
      for spell in speller
        spell.blink = false
        @spell_p.delete(spell)
        @spell_e.delete(spell)
      end
    end
    # ステップ 2 に移行
    battler.phase = 2
  end
  
  #--------------------------------------------------------------------------
  # ● フレーム更新 (メインフェーズ ステップ 2 : アクション開始)
  #--------------------------------------------------------------------------
  def update_phase4_step2(battler)

    # 強制アクションでなければ
    unless battler.current_action.forcing
      # 制約が [敵を通常攻撃する] か [味方を通常攻撃する] の場合
      if battler.restriction == 2 or battler.restriction == 3
        # アクションに攻撃を設定
        battler.current_action.kind = 0
        battler.current_action.basic = 0
      end
    end
    # アクションの種別より攻撃アニメーションを取得する
    case battler.current_action.kind
    when 0 # 基本
      if battler.is_a?(Game_Actor)
        base_id = battler.weapon_id
      end
      anime_id = battler.animation2_id
      # 防御など特殊行動の場合は次のステップへ
      unless make_basic_action_preparation(battler)
        return
      end
      # 戦闘が終了した場合は行動をキャンセル
      if fin?
        battler.phase = 6
       return
      end
    when 1 # スキル
      base_id = battler.current_action.skill_id
      anime_id = $data_skills[battler.current_action.skill_id].animation2_id
      # スキルが使用できない場合は行動をキャンセル
      unless make_skill_action_preparation(battler)
        return
      end
      # 戦闘が終了した場合は行動をキャンセル
      if fin? and $data_skills[anime_id].scope == 1..2
        battler.phase = 6
        return
      end
    when 2 # アイテム
      base_id = battler.current_action.item_id
      anime_id = $data_items[battler.current_action.item_id].animation2_id  
      # アイテムが使用できない場合は行動をキャンセル
      unless make_item_action_preparation(battler)
        return
      end
      # 戦闘が終了した場合は行動をキャンセル
      if fin? and $data_items[anime_id].scope == 1..2
        battler.phase = 6
        return
      end
    end

 #    if battler.is_a?(Game_Actor)
      # 混亂時的動畫處理
      if battler.restriction == 3  
        anime_id = 4
      end
 #    end

    # アニメーションを検索し、連撃性を変数serialに代入する
    serial = []
    frame = 0
  #  hit_count = 0
    if $data_animations[anime_id] != nil
      for animation in $data_animations[anime_id].timings
        #獲取色彩
        color = animation.flash_color
        #閃爍的強度為0的情況
        if color.alpha == 0
          serial.push([color.red.to_i, color.green, animation.frame - frame, color.blue.to_i,
          atk_movement(anime_id, animation.frame+1)])
          frame = animation.frame
        end
      end

    # 沒連擊的情況
    if serial.empty?
        serial = [[20, 100, $data_animations[anime_id].frame_max - 5]]
      end
    else
      # アニメーションが存在しない場合
      serial = [[20, 100, 0]]
    end
    # ハッシュ total_damage の作成
    total_damage = {}
    for target in battler.target
      total_damage[target] = []
    end
    
    # 連撃回数分ダメージ計算を行う
    for attack in serial

      # アクションの種別で分岐
      case battler.current_action.kind
      when 0  # 基本
        if battler.is_a?(Game_Actor)
          # バトラーがアクターの場合、攻撃時に武器を変更する
          battler.change_weapon(base_id + attack[1] - 100)
        end
        make_basic_action_result(battler)
      when 1  # スキル
        # 連携スキルのことを考え、スキルIDの変更は内部処理で行う
        make_skill_action_result(battler, attack[1] - 100)
      when 2  # アイテム
        # アイテムIDを設定分変化させる
        battler.current_action.item_id = base_id + attack[1] - 100
        make_item_action_result(battler)
      end
      
      # total_damage へダメージを代入
      for target in battler.target
        # 有損傷的情況、損傷為總損傷 / 閃光次數。
        if target.damage[battler].is_a?(Numeric)
          damage = target.damage[battler] / serial.size
        else
          damage = target.damage[battler]
        end
        # 回復HP量がある場合、回復HP量をX/20倍する。
        if target.recover_hp[battler].is_a?(Numeric)
        #  recover_hp = target.recover_hp[battler] * serial.size
          recover_hp = target.recover_hp[battler] / serial.size
        end
        # 回復SP量がある場合、回復SP量をX/20倍する。
        if target.recover_sp[battler].is_a?(Numeric)
        #  recover_sp = target.recover_sp[battler] * serial.size
          recover_sp = target.recover_sp[battler] / serial.size
        end
        
        # 藍色 255 的情況，強制爆擊
        if !target.critical[battler] and attack[3] == 255 and damage != "Miss" and damage.to_i > 0
          damage *= 2
          target.critical[battler] = true
        end
        
        critical = target.critical[battler]
        
        # 有傷害時，設定目標位移
        if damage != "Miss" and damage.to_i > 0
          target_move = attack[4]
        end
        
     #   if battler.current_action.kind == 1 and Skill_Target_Move[battler.current_action.skill_id] != nil
          
        #  if damage != "Miss" and damage.to_i > 0 and Skill_Target_Move[battler.current_action.skill_id][hit_count] != nil and !Skill_Target_Move[battler.current_action.skill_id][hit_count].empty?
        #    target_move = Skill_Target_Move[battler.current_action.skill_id][hit_count]
        #  end
          
       # end
        
        # total_damage = [損傷, 爆擊與否, 回復HP量, 回復SP量,
        #                 狀態變化, 狀態恢復, 等待畫格時間, move]
          total_damage[target].push([damage, critical, recover_hp, recover_sp, 
          target.state_p[battler], target.state_m[battler], attack[2], target_move])
      end # for target in battler.target
      
   #  hit_count += 1
      
    end # for attack in serial
    
    
    # トータルダメージを、バトラーのインスタンスに代入
    for target in battler.target
      target.total_damage[battler] = total_damage[target]
      
      #如果為連擊
      if target.total_damage[battler].size >= 2 
       target.combo_flag = true
     end
     for tt in target.total_damage[battler]
       # 紀錄打數(傷害為正，而且不miss才算)
       target.combo_count += 1 if tt[0].to_i > 0
     end
     
   end
   
  
   
    # 武器・スキル・アイテムIDを通常に戻す
    case battler.current_action.kind
    when 0  # 基本
      if battler.is_a?(Game_Actor)
        battler.change_weapon(base_id)
      end
    when 1  # スキル
      battler.current_action.skill_id = base_id
    when 2  # アイテム
      battler.current_action.item_id = base_id
    end
    if battler.phase == 2
      # ステップ 3 に移行
      battler.phase = 3
    end
  end
  
  #--------------------------------------------------------------------------
  # ● 階段更新 (主階段步驟 3 : 行動方動畫)
  #--------------------------------------------------------------------------
  def update_phase4_step3(battler)

    # 更新說明。行動種類分歧
    case battler.current_action.kind
    when 0  # 基本
      if battler.current_action.basic == 1
        @help_window.set_text($data_system.words.guard, 1)
        @help_wait = @help_time
      end
#========RTAB 1.16==================================      
      if battler.current_action.basic == 2
        # 逃跑
        @help_window.set_text("【逃跑】", 1)
        @help_wait = @help_time
        battler.escape
        battler.phase = 4
        return
      end
      # 逃跑個別化
      if battler.current_action.basic == 4
       update_phase2_escape
      end
#===================================================        
    when 1  # 技能
      $game_temp.statusWindow = false   #########大絕隱藏狀態視窗用
      skill =  $data_skills[battler.current_action.skill_id]
      @help_window.set_text(skill.name, 1)
      @help_wait = @help_time
      # 大絕隱藏狀態視窗
      if skill.element_set.include?(STILILA::BECOME_TRANSLUSENT) 
        $game_temp.statusWindow = true
      end   
    when 2  # 道具
      item = $data_items[battler.current_action.item_id]
      @help_window.set_text(item.name, 1)
      @help_wait = @help_time
    end
    # 混亂中的攻擊動畫設定                                      (攻擊目標為自己才成立)
    if battler.restriction == 3
  #   if battler.target == [battler]
       battler.anime1 = 0
       battler.anime2 = 4
   #   end   
    end
    # 行動方動畫 (ID是0的情況以白閃光代替)
    if battler.anime1 == 0
      battler.white_flash = true
      battler.wait = 5
      # 鏡頭設定
  #    if battler.target[0].is_a?(Game_Enemy)
     #  camera_set(battler)
 #     end
    else
      # 敵人時反轉戰鬥動畫
      if battler.is_a?(Game_Enemy)
        battler.animation.push([battler.anime1, true, -1])
      else
        battler.animation.push([battler.anime1, true, 1])
      end
      speller = synthe?(battler)
      if speller != nil
        for spell in speller
          
          # 合體技狀態時的處理，
          # 因為只能有一個成員進度先滿執行phase1~6(其餘合擊者會停在phase1)
          # 要進行合擊模組動作得在這特別指定
          
          if spell != battler
            if spell.current_action.spell_id == 0
              # 敵人時反轉戰鬥動畫
              if spell.is_a?(Game_Enemy)
                 spell.animation.push([battler.anime1, true, -1])
              else
                 spell.animation.push([battler.anime1, true, 1])
              end
            else
              skill = spell.current_action.spell_id
              # 敵人時反轉戰鬥動畫
              if spell.is_a?(Game_Enemy)
                 spell.animation.push([$data_skills[skill].animation1_id, true, -1])
              else
                 spell.animation.push([$data_skills[skill].animation1_id, true, 1])
              end
              
              # 合唱者的motion處理
              spell.target = battler.target  # <= 模組中有些判斷需要取得敵方資訊
              spell.battle_sprite.motion_set(skill, 1)
              spell.wait = 0   # 消掉不必要的wait
              spell.current_action.spell_id = 0
              spell.phase = 999  # < 為了迴避掉轉換成詠唱motion的判斷式
            end
          end
        end
      end
      # 設置等待
      battler.wait = 2 * $data_animations[battler.anime1].frame_max - 5 unless STILILA::NO_WAIT_PHASE3_SKILL.include?(battler.current_action.skill_id)
    end
    
    # 重要：目標方動畫為無或混亂時不起動模組
    if battler.anime2 != 0 and battler.restriction != 3
      # 設置等待
    #  battler.wait = @scroll_time #+ 50
    #  camera_set(battler)
      
      # 執行模組
      case battler.current_action.kind
      when 0  # 基本
        if battler.current_action.basic == 0
          battler.battle_sprite.motion_set(battler.weapon_id, 0)
        end
      when 1
        battler.battle_sprite.motion_set(battler.current_action.skill_id, 1)
      when 2
        battler.battle_sprite.motion_set(battler.current_action.item_id, 1)
      end
      
    end
    
    # 進行步驟 4
    battler.phase = 4
  end

  
  
  #--------------------------------------------------------------------------
  # ● フレーム更新 (メインフェーズ ステップ 4 : 対象側アニメーション)
  #--------------------------------------------------------------------------
  def update_phase4_step4(battler)
    # 設定鏡頭
   # if battler.anime2 != 0 #and !battler.target[0].is_a?(Game_Enemy)
    #  camera_set(battler)
  #  end
    

    
    # 対象側アニメーション
    for target in battler.target
      # 目標是角色時反轉動畫
      if target.is_a?(Game_Actor)
        target.animation.push([battler.anime2, (target.damage[battler] != "Miss"), -1])
      else
        target.animation.push([battler.anime2, (target.damage[battler] != "Miss"), 1])
      end
      unless battler.anime2 == 0
        battler.wait = 2 * target.total_damage[battler][0][6] - 1 + Graphics.frame_count % 2
      end
    end
    
    
    # 使用的技能為世界
    if STILILA::WORLD_SKILL.include?(battler.current_action.skill_id)
      # 依序處理場上所有戰鬥者(設為目標)
      for thetarget in $game_party.actors + $game_troop.enemies
        #如果目標是使用者就略過
        if  thetarget == battler
          next
        end
        #將目標的world開關ON
        thetarget.world = true
      end       
      #回合計數代入1
      @turn_cnt  = 0        #時停判定追加
      #配合背景變化的開關
      $game_temp.theworlding = true
     end  
    
    # ステップ 5 に移行
    battler.phase = 5
  end
  
  
  #--------------------------------------------------------------------------
  # ● フレーム更新 (メインフェーズ ステップ 5 : ダメージ表示)
  #--------------------------------------------------------------------------
  def update_phase4_step5(battler)

    #設置往phase6的標誌
    next_step = true
    
    # ダメージ表示
    for target in battler.target
      
    # total_damage より全ダメージを算出
      total_damage = target.total_damage[battler].shift
      
      target.damage[battler] = total_damage[0]
      
      target.critical[battler] = total_damage[1]
      target.recover_hp[battler] = total_damage[2]
      target.recover_sp[battler] = total_damage[3]
      
      # 目標震動
      if !(total_damage[0].to_i <= 0 or total_damage[2].to_i > 0 or total_damage[3].to_i > 0) and target.damage[battler] != "Miss"
        target.battle_sprite.start_shake(1, total_damage[1])
        # (170305 目標進入受傷狀態機)
        target.battle_sprite.start_damage(target.total_damage[battler].empty?)
        
      end

      
      # 最後一下
      if target.total_damage[battler].empty?
        # 衝擊治療
      #  case battler.current_action.kind 
      #  when 0 # 普攻
      #    target.remove_states_shock(target.combo_count) # if battler.atk > 0
      #  when 1 # 技能
      #    target.remove_states_shock(target.combo_count) #if $data_skills[battler.current_action.skill_id].power > 0   #total_damage[0].to_i > 0 
      #  when 2 # 道具
      #  end

      
        # 衝擊治療
        target.remove_states_shock(target.combo_count) if !(total_damage[0].to_i < 0 or total_damage[2].to_i > 0 or total_damage[3].to_i > 0) and target.damage[battler] != "Miss"
        
        # 連打數歸零
        target.combo_count = 0
        # 狀態附加
        target.state_p[battler] = total_damage[4]
        # 狀態解除
        target.state_m[battler] = total_damage[5]
        
        
        # 中斷敵人詠唱
        case battler.current_action.kind
        when 0  # 基本
          if battler.is_a?(Game_Actor) and battler.weapon_id > 0
             spell_break = target.spell_can_break?(battler.weapon_id, 0) 
           else
             spell_break = target.spell_can_break?(0, 0) 
           end
        when 1  # 技能
          spell_break = target.spell_can_break?(battler.current_action.skill_id, 1)
        when 2  # 道具
          spell_break = target.spell_can_break?(battler.current_action.item_id, 2)
        end
        
        # 目標詠唱中
        if target.rtp > 0 and spell_break and target.damage[battler] != "Miss" and (target.damage[battler].to_i > 0 or target.recover_hp[battler].to_i < 0 or total_damage[3].to_i < 0)
          # 處理詠唱者的AT槽
          spellers = synthe?(target) # 取得目標合技與他的合唱者
          # 是合技的情況
          if spellers
            for speller in spellers
              speller.at = @max / 3 # 把他們的AT槽弄剩1/3 (詠唱時AT是滿的)
            end
          # 不是合技的情況  
          else
            target.at = @max / 3 # 把目標AT槽弄剩1/3 (詠唱時AT是滿的)
          end
          
          skill_reset(target) # 中斷詠唱
          
         # spell_reset(target)
         # 彈出中斷詠唱字樣
          target.battle_sprite.damage("SpellBreak", false, 2, target.x_pos, target.z_pos + target.y_pos)
        end
        
      else
        # 狀態附加
        target.state_p[battler] = []
        # 狀態解除
        target.state_m[battler] = []
      end
      
      # 設定目標擊退
      if total_damage[7] != nil
        target.damage_x_speed = total_damage[7][0] if total_damage[7][0] != nil
        target.damage_y_speed = total_damage[7][1] if total_damage[7][1] != nil
      end
      
      # ダメージ表示フラグをON
      target.damage_pop[battler] = true
      # 恭喜你发现了连击计算的关键一行！
      target.combohit_count if target.damage[battler].to_i > 0 and target.damage[battler] != "Miss"
      # 実際にダメージを与える
      #target.damage_effect(battler, battler.current_action.kind)
      target.damage_effect(battler, battler.current_action.kind, skill, target.total_damage[battler].empty?)  #到此一游
      # 余計なハッシュを削除
      target.recover_hp.delete(battler)
      target.recover_sp.delete(battler)
       target.state_p.delete(battler)
       target.state_m.delete(battler)
      
        #如果為連擊
      if target.combo_flag
        #除錯用
        if target.td_damage.nil?
          target.td_damage = 0
        end
        target.td_damage += target.damage[battler].to_i
     end
      
      # 攻擊完畢的情況
      if target.total_damage[battler].empty?

        #除錯用
        if target.td_damage.nil?
          target.td_damage = 0
        end

        # ターゲットへの全ダメージを削除
        target.total_damage.delete(battler)
       
        #顯示總傷害
        if target.td_damage > 0
          target.combo_appear = true
          target.combo_flag = false
        end
        # 指定時間淡出
        battler.wait = @damage_wait

        # 如果是被攻擊，進入傷害motion
     #   if target.damage[battler].to_i > 0 or target.damage_sp[battler].to_i > 0
      #  # 傷害motion處理
      #    target.battle_sprite.start_damage
      #    target.battle_sprite.damage_wait = battler.wait 
     #   end
        
      else
        #取消往phase6的標誌，回頭進行下次連擊
        next_step = false
        # 指定時間淡出
        battler.wait = 2 * target.total_damage[battler][0][6]
        
        # 如果是被攻擊，進入傷害motion
     #   if target.damage[battler].to_i > 0 or target.damage_sp[battler].to_i > 0
        #  target.battle_sprite.start_damage
       #   target.battle_sprite.damage_wait = -1
    #    end
        
      end
      # ステータスウィンドウをリフレッシュ
      status_refresh(target)
    end
    
    if next_step
      # ステップ 6 に移行
      battler.phase = 6
    end
    
    # ========== 連擊數處理
    max = 0
    hit_target = nil
    for target in battler.target
      #修正敵人打第一下時如果miss會變成nil的錯誤
      target.combohit = 0 if target.combohit.nil?
      if target.combohit > max
        max = target.combohit
        hit_target = target
      end
    end
    if max >= 2 and !hit_target.nil?
      @combohit_window.x = hit_target.is_a?(Game_Enemy) ? 512 : 512
      @combohit_window.refresh(max, hit_target.combohit_duration)
    end
    # ========== RTAB戰鬥特效
    # 行动者伤害表示(HP/SP吸收的表示用)
    if battler.damage[battler] != nil or  battler.damage_sp[battler] != nil
       battler.damage_pop[battler] = true
    # 行动者状态栏刷新
      status_refresh(battler)
    end
    
  end
  
  
  #--------------------------------------------------------------------------
  # ● フレーム更新 (メインフェーズ ステップ 6 : リフレッシュ)
  #--------------------------------------------------------------------------
  def update_phase4_step6(battler)
    
    # 目標的damage_wait為-1時，設成@damage_wait的值(防卡)
  #  for target in battler.target
   #   if target.battle_sprite.damage_wait == -1 and target.exist?
    #    target.battle_sprite.damage_wait = @damage_wait
   #   end
   # end
    
    # 還在進行模組時不往下執行
    if battler.action_flag
      battler.wait = 1
      return 
    end
   
    # (170305 改為等位移目標結束)
      for target in battler.target
        # 可以行動但又不在原位時，先歸位
        if target.battle_sprite.action_name == :"damaging" 
          # 可歸位
          if  target.x_speed == 0 and target.y_speed == 0 and target.y_pos == 0# and battler.exist? and battler.battle_sprite.damage_wait == 0
            target.battle_sprite.start_damage_turnback
          # 不可歸位，等  
          else
            battler.wait = 1
            return
          end
        end
      end
    
      

    
    # カメラを戻す
 #   if battler.target[0].is_a?(Game_Enemy) and @camera == battler
 
      @spriteset.screen_target(0, 0, 1.02) if @camera != "command"
   # end
    # スキルラーニング
    if battler.target[0].is_a?(Game_Actor) and battler.current_action.kind == 1
      for target in battler.target        
        if target.is_a?(Game_Actor)#(0.16)
        skill_learning(target, target.class_id,
                        battler.current_action.skill_id)
        end #(0.16)               
      end
    end
    
    # 大絕隱藏狀態視窗
    if battler.current_action.kind == 1
     #獲取技能
      skill =  $data_skills[battler.current_action.skill_id]
      #如果技能屬性符合設定
     if skill.element_set.include?(STILILA::BECOME_TRANSLUSENT) 
        $game_temp.statusWindow = false
      end  
    end     
    
     # 清除強制行動標誌
    if battler.current_action.forcing == true and
        battler.current_action.force_kind == 0 and
        battler.current_action.force_basic == 0 and
        battler.current_action.force_skill_id == 0
      $game_temp.forcing_battler = nil
      battler.current_action.forcing = false
    end
    

    
    refresh_phase(battler)
    speller = synthe?(battler)
    if speller != nil
      for spell in speller
        if spell != battler
          spell.target.clear
          spell.wait = 0   # 防止合唱者有battler.wait，讓下次出招時要先等
          refresh_phase(spell)
        end
      end
      synthe_delete(speller)
    end
    # コモンイベント ID が有効の場合
    if battler.event > 0
      # イベントをセットアップ
      common_event = $data_common_events[battler.event]
      $game_system.battle_interpreter.setup(common_event.list, 0)
    end
    act = 0
#    for actor in $game_party.actors + $game_troop.enemies
  #    if actor.movable?
   #     act += 1
   #   end
   # end
    # 時停判定追加
    if $game_temp.theworlding == true
      act += 1
    else  #以外的情況
      for actor in $game_party.actors + $game_troop.enemies
        if actor.movable?
          act += 1
        end
      end 
    end
    
    # 自身回合+1
    battler.battler_turn += 1 if battler.movable? and battler.exist?

    # 計算戰鬥回合
    if @turn_cnt >= act and act > 0
      @turn_cnt %= act
      $game_temp.battle_turn += 1
      # 處理所有戰鬥事件頁
      for index in 0...$data_troops[@troop_id].pages.size
        # 獲取事件頁
        page = $data_troops[@troop_id].pages[index]
        # 執行條件為"回合"的情況
        if page.span == 1
          # 實行過的 flag為off
          $game_temp.battle_event_flags[index] = false
        end
      end
    end

    # 戰鬥者技能冷卻時間減少
    battler.skill_cd_time_minus
    
    # 如果戰鬥者使用技能
    if battler.current_action.kind == 1
      # 技能冷卻
      battler.skill_cd_add(battler.current_action.skill_id)
      # 使用自爆技的情況，陣亡
       battler.hp = 0 if STILILA::EXPLOSION_SKILL.include?(battler.current_action.skill_id)
    end
    
    # 戰鬥者phase回到1
    battler.phase = 1
    # 從可行動成員剔除
    @action_battlers.delete(battler)
    
    for all_battler in $game_party.actors + $game_troop.enemies
      #連擊數歸零 
      all_battler.combohit = 0
      #總傷害歸零
      all_battler.td_damage = 0
      #連擊顯示關閉
      all_battler.combo_appear = false
    end
    
    # 逃跑成功開關為on
    if @escapesuccess == true
      @escapesuccess = false
    # 演奏逃跑 SE
      $game_system.se_play($data_system.escape_se)
      # 戰鬥中斷標誌設為on
      $game_temp.battle_abort = true
      return
    end
  end
  
  
  
end

#==============================================================================
# ■ Spriteset_Battle
#------------------------------------------------------------------------------
# 　バトル画面のスプライトをまとめたクラスです。このクラスは Scene_Battle クラ
# スの内部で使用されます。
#==============================================================================

class Spriteset_Battle
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_reader   :real_x                   # x座標補正（現在値）
  attr_reader   :real_y                   # y座標補正（現在値）
  attr_reader   :real_zoom                # 拡大率（現在値）
  attr_reader   :battleback_sprite
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    # ビューポートを作成
    @viewport1 = Viewport.new(0, 0, 640, 480)
    @viewport2 = Viewport.new(0, 0, 640, 480)
    @viewport3 = Viewport.new(0, 0, 640, 480)
    @viewport4 = Viewport.new(0, 0, 640, 480)
    @viewport2.z = 101
    @viewport3.z = 200
    @viewport4.z = 5000
    @wait = 0
 #   @real_x = 0
  #  @real_y = 0
  #  @real_zoom = 1.0
    @scroll_time = 0
    
    $game_temp.battle_camera_x = 0
    $game_temp.battle_camera_y = 50
    
    if $game_config.battle_camera 
       $game_temp.battle_camera_z = 0.9
    else 
       $game_temp.battle_camera_z = 0.9
    end
    
    
    
    @target_x = 0
    @target_y = 0
    @target_zoom = 1.0
    @gap_x = 0
    @gap_y = 0
    @gap_zoom = 0.0
    # バトルバックスプライトを作成
    @battleback_sprite = Sprite.new(@viewport1)
    
     make_battleback
     
     
     
     
    # エネミースプライトを作成
  #  @enemy_sprites = []
    for enemy in $game_troop.enemies#.reverse
      enemy.sprite_initialize(@viewport2)
      
   #   enemy.battle_sprite = Sprite_Battler.new(@viewport2, enemy)
    end
    # アクタースプライトを作成
   # @actor_sprites = []
   # @actor_sprites.push(Sprite_Battler.new(@viewport2))
   # @actor_sprites.push(Sprite_Battler.new(@viewport2))
    #@actor_sprites.push(Sprite_Battler.new(@viewport2))
    #@actor_sprites.push(Sprite_Battler.new(@viewport2))
    
    for actor in $game_party.actors
      actor.sprite_initialize(@viewport2)
   #   actor.battle_sprite = Sprite_Battler.new(@viewport2,actor)
    end
    
    # 設定初期位置
    for battler in $game_troop.enemies + $game_party.actors
      battler.set_default_pos(battler.index)
    end
    # 恢復鏡頭位置
    screen_target(0, 0, 1)
    
    # 天候を作成
    @weather = RPG::Weather.new(@viewport1)
    # ピクチャスプライトを作成
    @picture_sprites = []
    for i in 51..100
      @picture_sprites.push(Sprite_Picture.new(@viewport3,
        $game_screen.pictures[i]))
    end
    # タイマースプライトを作成
    @timer_sprite = Sprite_Timer.new
    # フレーム更新
    update
  end
  
  #--------------------------------------------------------------------------
  # ● 释放
  #--------------------------------------------------------------------------
  def dispose
    # 如果战斗背景位图存在的情况下就释放
    if @battleback_sprite.bitmap != nil
      @battleback_sprite.bitmap.dispose
    end
    # 释放战斗背景活动块
    @battleback_sprite.dispose
    
    # 释放敌人活动块、角色活动块
   # for sprite in @enemy_sprites + @actor_sprites
   #   sprite.dispose
  #  end

  
    for battler in $game_troop.enemies + $game_party.actors

      battler.target = []
      battler.battle_sprite.dispose
      battler.battle_sprite = nil
    end
    
    # 清除敵人
    $game_troop.enemies.clear
    
    # 释放天候
    @weather.dispose
    # 释放图片活动块
    for sprite in @picture_sprites
      sprite.dispose
    end
    # 释放计时器活动块
    @timer_sprite.dispose
    # 释放显示端口
    @viewport1.dispose
    @viewport2.dispose
    @viewport3.dispose
    @viewport4.dispose
  end
  #--------------------------------------------------------------------------
  # ● 显示效果中判定
  #--------------------------------------------------------------------------
  def effect?
    # 如果是在显示效果中的话就返回 true
    for sprite in $game_troop.enemies + $game_party.actors
      return true if sprite.battle_sprite.effect?
    end
    return false
  end
  
  #--------------------------------------------------------------------------
  # ● 移動中判定
  #--------------------------------------------------------------------------
  def battlers_moving?
    # 如果是在显示效果中的话就返回 true
    for battler in $game_troop.enemies + $game_party.actors
      next if (!battler.exist? or battler.world) # 沒出現、已經爆炸、時停的對像無視
      return true if (battler.battle_sprite.moving? or battler.battle_sprite.not_on_basepos?)
    end
    return false
  end
  
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    # アクタースプライトの内容を更新 (アクターの入れ替えに対応)
  #  @actor_sprites[0].battler = $game_party.actors[0]
  #  @actor_sprites[1].battler = $game_party.actors[1]
  #  @actor_sprites[2].battler = $game_party.actors[2]
  #  @actor_sprites[3].battler = $game_party.actors[3]
  
   # for actor in $game_party.actors
     # actor.battle_sprite.battler = actor
   # end

    # バトルバックのファイル名が現在のものと違う場合
    if @battleback_name != $game_temp.battleback_name
      make_battleback
    end

    # 画面のスクロール
    screen_scroll

    # モンスターの位置補正
   # for battler in $game_troop.enemies + $game_party.actors
#      battler.real_x = @real_x
   #   battler.real_y = @real_y
    #  battler.real_zoom = @real_zoom
    #end
    
    
    
    
    # バトラースプライトを更新
  #  for sprite in @enemy_sprites + @actor_sprites
    #  sprite.update
  #  end
  
    for sprite in $game_troop.enemies + $game_party.actors
      sprite.battle_sprite.update
    end
  
    # 天候グラフィックを更新
    @weather.type = $game_screen.weather_type
    @weather.max = $game_screen.weather_max
    @weather.update
    # ピクチャスプライトを更新
    for sprite in @picture_sprites
      sprite.update
    end
    # タイマースプライトを更新
    @timer_sprite.update
    
     # 世界發動中
    if $game_temp.theworlding
       @battleback_sprite.tone.gray = 255  if @battleback_sprite.tone.gray != 255
     else
       @battleback_sprite.tone.gray = 0
     end
    
    # 画面の色調とシェイク位置を設定
    @viewport1.tone = $game_screen.tone
    @viewport1.ox = $game_screen.shake_x
    @viewport1.oy = $game_screen.shake_y
    @viewport2.ox =  $game_screen.shake_x
    @viewport2.oy =  $game_screen.shake_y
    # 画面のフラッシュ色を設定
    @viewport4.color = $game_screen.flash_color
    # ビューポートを更新
    @viewport1.update
    @viewport2.update
    @viewport4.update
  end
  #--------------------------------------------------------------------------
  # ● バトル背景の設定
  #--------------------------------------------------------------------------
  def make_battleback
    @battleback_name = $game_temp.battleback_name
    if @battleback_sprite.bitmap != nil
      @battleback_sprite.bitmap.dispose
    end
    @battleback_sprite.bitmap = RPG::Cache.battleback(@battleback_name)
    if @battleback_sprite.bitmap.width == 640 and
       @battleback_sprite.bitmap.height == 320
      @battleback_sprite.src_rect.set(0, 0, 1280, 640)
      @base_zoom = 2.0
      @battleback_sprite.zoom_x = @base_zoom * $game_temp.battle_camera_z
      @battleback_sprite.zoom_y = @base_zoom * $game_temp.battle_camera_z
      @battleback_sprite.x = $game_temp.battle_camera_x + 320
      @battleback_sprite.y = $game_temp.battle_camera_y + 4
      @battleback_sprite.ox = @battleback_sprite.bitmap.width / 2
      @battleback_sprite.oy = @battleback_sprite.bitmap.height / 4
    elsif @battleback_sprite.bitmap.width == 640 and
          @battleback_sprite.bitmap.height == 480
      @battleback_sprite.src_rect.set(0, 0, 960, 720)
      @base_zoom = 1.5
      @battleback_sprite.zoom_x = @base_zoom * $game_temp.battle_camera_z
      @battleback_sprite.zoom_y = @base_zoom * $game_temp.battle_camera_z
      @battleback_sprite.x = $game_temp.battle_camera_x + 320
      @battleback_sprite.y = $game_temp.battle_camera_y
      @battleback_sprite.ox = @battleback_sprite.bitmap.width / 2
      @battleback_sprite.oy = @battleback_sprite.bitmap.height / 4
    else
      @battleback_sprite.src_rect.set(0, 0, @battleback_sprite.bitmap.width,
                                      @battleback_sprite.bitmap.height)
      @base_zoom = 1.0
      @battleback_sprite.zoom_x = @base_zoom * $game_temp.battle_camera_z
      @battleback_sprite.zoom_y = @base_zoom * $game_temp.battle_camera_z
      @battleback_sprite.x = $game_temp.battle_camera_x + 320  # <- 320為RM視窗的中心位置
      @battleback_sprite.y = $game_temp.battle_camera_y
      @battleback_sprite.ox = @battleback_sprite.bitmap.width / 2
      @battleback_sprite.oy = 80  #@battleback_sprite.bitmap.height / 10 #6
   #   @cam_y_plus = 50
   end
 
 #  $game_temp.basic_camera_y = @battleback_sprite.oy
 
  #  screen_target(0, 60, 1)
  end
  #--------------------------------------------------------------------------
  # ● 画面のスクロール目標の位置・拡大率設定
  #       time：捲動時間
  #       aoe：區域性攻擊(好像沒用到...)
  #--------------------------------------------------------------------------
  def screen_target(x, y, zoom, time = nil, aoe = false)
    return unless $scene.drive
    
   # zoom = 1.0  # 先強制將放大率設為0方便觀察
   #pre_method(caller)
   if time != nil
     @wait = @scroll_time = time
   else
     @wait = @scroll_time = $scene.scroll_time
   end

    if aoe
      @target_x = x + x * ((zoom-1)*2)
      @target_y = y + y  * ((zoom-1)*2)  
    else
      @target_x = x
      @target_y = y + 50 #+ $game_temp.basic_camera_y
    end

    @target_zoom = zoom
    screen_over
    @gap_x = @target_x - $game_temp.battle_camera_x
    @gap_y = @target_y - $game_temp.battle_camera_y
    @gap_zoom = @target_zoom - $game_temp.battle_camera_z
  end

  #--------------------------------------------------------------------------
  # ● 画面のスクロール
  #--------------------------------------------------------------------------
  def screen_scroll
    if @wait > 0
      $game_temp.battle_camera_x = (@target_x - @gap_x * (@wait ** 2) / (@scroll_time ** 2)).round
      $game_temp.battle_camera_y = (@target_y - @gap_y * (@wait ** 2) / (@scroll_time ** 2)).round
      $game_temp.battle_camera_z = @target_zoom - @gap_zoom * (@wait ** 2) / (@scroll_time ** 2)
      
      @battleback_sprite.x = $game_temp.battle_camera_x + 320 
      @battleback_sprite.y = $game_temp.battle_camera_y
      @battleback_sprite.zoom_x = @base_zoom * $game_temp.battle_camera_z
      @battleback_sprite.zoom_y = @base_zoom * $game_temp.battle_camera_z
      @battleback_sprite.ox = @battleback_sprite.bitmap.width / 2
      @battleback_sprite.oy = 80     #  40  #@battleback_sprite.bitmap.height / 10 #6
      @wait -= 1
    end
  end
  #--------------------------------------------------------------------------
  # ● スクリーンが画面外に出た時の補正処理
  # @target_x，鏡頭的 X 軸目標。
  #  極限(放大率最小1倍的情況)：  960-640 = 320，左右可移動160幅度
  #  正值往左，負值往右
  
  # @target_y，鏡頭的 Y 軸目標。
  #  極限(放大率最小1倍的情況)： 圖高600、視窗480，有120可移動範圍
  #  往上極限是戰鬥背景的oy(正值)，往下極限是戰鬥背景oy - 120(可能是負值)
  #--------------------------------------------------------------------------
  def screen_over

    x_limit_left = (320 / 2) + (320 / 2) * ((@target_zoom-1) * 2) 
    x_limit_right = (320 / -2) - (320 / -2) * ((@target_zoom-1) * 2)
    
    y_limit_top = (@battleback_sprite.oy) + (@battleback_sprite.oy) * ((@target_zoom-1)*2)
    y_limit_bot = (@battleback_sprite.oy - 120) + (@battleback_sprite.oy - 120) * ((@target_zoom-1)*2) #+ @cam_y_plus

 #   $scene.test_windows[0].refresh(@target_y)
 #   $scene.test_windows[1].refresh(y_limit_bot)
    
    # 目標X軸超過畫面左邊 或 右邊
    if @target_x > x_limit_left or @target_x < x_limit_right
      if @target_x > x_limit_left
        @target_x = x_limit_left
      elsif @target_x < x_limit_right
        @target_x = x_limit_right
      end
    end
    
    
 #   $scene.test_windows[0].refresh(height)
  #  $scene.test_windows[1].refresh(height-4)
  #  $scene.test_windows[2].refresh(height*3)
    
    
    # 第一項：目標Y軸沒在最高點內，第二項：目標Y軸沒在最低點內
    if @target_y > y_limit_top or @target_y < y_limit_bot
      if @target_y > y_limit_top
        @target_y = y_limit_top
      elsif @target_y < y_limit_bot
        @target_y = y_limit_bot
      end
    end
  end
  
end # class end


#==============================================================================
# ■ Arrow_Enemy
#------------------------------------------------------------------------------
# 　エネミーを選択させるためのアローカーソルです。このクラスは Arrow_Base クラ
# スを継承します。
#==============================================================================

class Arrow_Enemy < Arrow_Base
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    # 存在しないエネミーを指していたら飛ばす
    $game_troop.enemies.size.times do
      break if self.enemy.exist?
      @index += 1
      @index %= $game_troop.enemies.size
    end
    # カーソル右
    if Input.repeat?(Input::DOWN) || Input.repeat?(Input::RIGHT)
      $game_system.se_play($data_system.cursor_se)
      $game_troop.enemies.size.times do
        @index += 1
        @index %= $game_troop.enemies.size
        break if self.enemy.exist?
      end
      $scene.camera = "select"
    #  zoom = 1 / self.enemy.zoom
      zoom = 1
      #$scene.spriteset.screen_target(self.enemy.attack_x(zoom) * 0.75, self.enemy.attack_y(zoom) * 0.75, zoom)
      $scene.spriteset.screen_target(self.enemy.attack_x(zoom) * 0.75, 200 - self.enemy.true_z + self.enemy.halfheight, zoom)
      
    end
    # カーソル左
    if Input.repeat?(Input::UP) || Input.repeat?(Input::LEFT)
      $game_system.se_play($data_system.cursor_se)
      $game_troop.enemies.size.times do
        @index += $game_troop.enemies.size - 1
        @index %= $game_troop.enemies.size
        break if self.enemy.exist?
      end
      $scene.camera = "select"
    #  zoom = 1 / self.enemy.zoom
      zoom = 1
     # $scene.spriteset.screen_target(self.enemy.attack_x(zoom) * 0.75, self.enemy.attack_y(zoom) * 0.75, zoom)
     $scene.spriteset.screen_target(self.enemy.attack_x(zoom) * 0.75, 200 - self.enemy.true_z + self.enemy.halfheight, zoom)
    end
    # スプライトの座標を設定
    if self.enemy != nil
      self.x = self.enemy.screen_x
      self.y = self.enemy.screen_y 
    end
  end
end
