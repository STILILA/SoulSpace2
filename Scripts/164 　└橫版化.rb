#=begin

#==============================================================================
# ■ Sprite_Battler
#------------------------------------------------------------------------------
# 　バトラー表示用のスプライトです。Game_Battler クラスのインスタンスを監視し、
# スプライトの状態を自動的に変化させます。
#==============================================================================

class Sprite_Battler < RPG::Sprite
  
  
  #--------------------------------------------------------------------------
  # ● 初始化物件
  #     viewport : 顯示連接埠
  #     battler  : 戰鬥者 (Game_Battler)
  #--------------------------------------------------------------------------
  def initialize(viewport, battler = nil)
    super(viewport)
    @battler = battler
    @battler_visible = false

    ######################### 
   # @shake_power = 0 # 左右震動力量
    #@shake_speed = 0 #左右震動速度
    @shake_duration = 0 # 左右震動時間
  #  @shake_direction = 1 # 左右震動方向
    @shake_x = 0   # 左右震動
    @shake_y = 0   # 上下震動
    @shake_count = 0 # 震完後，要不要再繼續震
    @shake_critical = false # 爆擊計錄
    #########################

    # 模組相關
    @frame_duration = 0
    @frame_number = 0
    @action_name = nil
    @action_flag = false
    @frame_time = 0
    @action_time = 0
    @next_frame = 0
    # 受傷時間
    @damage_wait = 0
    # 瞬移時間
    @transfer_time = 0
    # 瞬移位置補正
    @transfer_x = 0
    @transfer_y = 0
    # 殘影時間
    @afterimage_time = 0
    # 歸位時間 (目前時間, 總時間)
    @turnback_time = [0, 0]
    # 歸位時X、Z位移量
    @turnback_x = 0
    @turnback_z = 0
    # 著地時的動作
    @landing_action = nil
    
    # 生成敵人AT條
   # if @battler.is_a?(Game_Enemy)
      x = @battler.screen_x - 20
      y = @battler.screen_y - 26#24
      @at_window = Window_Base.new(x, y, 150, 60)
      @at_window.contents = Bitmap.new(150 - 32, 60 - 32)
      @at_window.opacity = 0
      @at_window.z = self.z + 1
      @at_window.draw_actor_atg(@battler, 4, 0, 56)   
      @at_window.visible = false
  #  end 
      @battler_shadow = Sprite.new(self.viewport)
      @battler_shadow.tone.set(-255,-255,-255)
      @battler_shadow.visible = false
      @battler_shadow.mirror = self.mirror
  end
  
  
  #--------------------------------------------------------------------------
  # ● 釋放
  #--------------------------------------------------------------------------
  def dispose
    if self.bitmap != nil
      self.bitmap.dispose
    end
    
    @battler_shadow.bitmap.dispose
    @battler_shadow.dispose

    @at_window.dispose if @at_window != nil
    
    super
  end
  
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    # バトラーが nil の場合
    if @battler == nil
      self.bitmap = nil
      loop_animation(nil)
      return
    end
    # ファイル名か色相が現在のものと異なる場合
    if @battler.battler_name != @battler_name or
       @battler.battler_hue != @battler_hue
      # ビットマップを取得、設定
      @battler_name = @battler.battler_name
      @battler_hue = @battler.battler_hue
      self.bitmap = RPG::Cache.battler(@battler_name, @battler_hue)
      @width = bitmap.width
      @height = bitmap.height
      self.ox = @width / 2
      self.oy = @height
      
      @battler.halfheight = @height / 2
      
      if @battler.is_a?(Game_Enemy)
        @battler.height = @height
        self.mirror = true 
      end
      # 戦闘不能または隠れ状態なら不透明度を 0 にする
      if @battler.dead? or @battler.hidden
        self.opacity = 0
      end
    end
    # アニメーション ID が現在のものと異なる場合
    if @battler.state_animation_id != @state_animation_id
      @state_animation_id = @battler.state_animation_id
      loop_animation($data_animations[@state_animation_id])
    end
    # 表示されるべきアクターの場合
  #  if @battler.is_a?(Game_Actor) and @battler_visible
      # メインフェーズでないときは不透明度をやや下げる
     # if $game_temp.battle_main_phase
     #   self.opacity += 3 if self.opacity < 255
     # else
     #   self.opacity -= 3 if self.opacity > 207
      #end
    #end
    # 明滅
    if @battler.blink
      blink_on
    else
      blink_off
    end
    
    # 不可視の場合
    unless @battler_visible
      # 出現
      if not @battler.hidden and not @battler.dead? and
         (@battler.damage.size < 2 or @battler.damage_pop.size < 2)
        appear
        @battler_visible = true
        
        # 設定初期位置
        @battler.set_default_pos(@battler.index)
        # 設定模組用參數
        set_motion_data
        
      end
    end
    
   # 刷新腳下AT條
   if @battler.is_a?(Game_Enemy) 
     if  $BTEST or $game_temp.see_enemy_at # or $game_party.items.include?(STILILA::SEE_AT_ITEM)
       if @battler.exist?
         @at_window.visible = true
         @at_window.draw_actor_atg(@battler, 4, 0, 56) 
         @at_window.x = screen_x(@battler.base_x) - 50 #@battler.screen_x - 50
         @at_window.y = screen_y(@battler.base_z) - 26  # @battler.screen_y - 24
       else
         @at_window.visible = false
       end
     end
   else
      if @battler.exist?
        @at_window.visible = true
        @at_window.draw_actor_atg(@battler, 4, 0, 56) 
        @at_window.x = screen_x(@battler.base_x) - 50 #@battler.screen_x - 50
        @at_window.y = screen_y(@battler.base_z) - 26  # @battler.screen_y - 24
      else
        @at_window.visible = false
     end
   end
   
    # 受傷
    for battler in @battler.damage_pop
      
      # 取得位置
      d_x_pos = @battler.x_pos  # @battler.screen_x
      d_y_pos = @battler.z_pos + @battler.y_pos# @battler.screen_y - @height/2
      
      if battler[0].class == Array
        if battler[0][1] >= 0
          $scene.skill_se
        else
          $scene.levelup_se
        end
        # 顯示字符
         damage(@battler.damage[battler[0]], false, 2, d_x_pos, d_y_pos)
      else
        # 如果是狀態傷害(中毒、灼傷...)
        if @battler.damage_pop.include?("slip") #or @battler.damage_pop.include?("scarlet")
           damage(@battler.damage[battler[0]], @battler.critical[battler[0]], 0, d_x_pos, d_y_pos)
        else 
           damage(@battler.damage[battler[0]], @battler.critical[battler[0]], 0, d_x_pos, d_y_pos, @battler.weakness[battler[0]])

           # 設定擊退擊飛
          if @battler.damage_x_speed != 0
            if @battler.damage[battler[0]].to_i > 0 
              @battler.x_speed = @battler.damage_x_speed * (self.mirror ? 1 : -1) 
            end
            @battler.damage_x_speed = 0
          end
           
          if @battler.damage_y_speed != 0
            if @battler.damage[battler[0]].to_i > 0 
              @battler.y_speed = @battler.damage_y_speed
             end
            @battler.damage_y_speed = 0
          end
=begin       
       # (170305移到攻擊方行動完統一執行)
           # 如果是被攻擊
           if @battler.damage[battler[0]].to_i > 0
            # 傷害motion處理
             start_damage
             # 如果連擊結束
             if @battler.total_damage.empty?
                @damage_wait = 20 # $scene.damage_wait
             else
                @damage_wait = 20#-1
             end
           end
           
           # 防止最後一下沒被打到
           if @battler.total_damage.empty? and @damage_wait != 0
             @damage_wait = 20
           end
=end   
        end 
      end
      
      # 如果傷害值包含SP傷害
      if @battler.damage_sp.include?(battler[0])
        damage(@battler.damage_sp[battler[0]], @battler.critical[battler[0]], 1, d_x_pos, d_y_pos, @battler.weakness[battler[0]])
        
        # 設定擊退擊飛
        if @battler.damage_x_speed != 0
          if @battler.damage_sp[battler[0]].to_i > 0 
            @battler.x_speed = @battler.damage_x_speed * (self.mirror ? 1 : -1) 
           end
          @battler.damage_x_speed = 0
        end
           
        if @battler.damage_y_speed != 0
          if @battler.damage_sp[battler[0]].to_i > 0 
            @battler.y_speed = @battler.damage_y_speed
          end
          @battler.damage_y_speed = 0
        end
=begin       
       # (170305移到攻擊方行動完統一執行)
        # 如果是被攻擊 
        if @battler.damage_sp[battler[0]].to_i > 0
        # 傷害motion處理
           start_damage
          # 如果連擊結束
          if @battler.total_damage.empty?
            @damage_wait = 20 # $scene.damage_wait
          else
            @damage_wait = 20#-1
          end
        end
         
        # 防止最後一下沒被打到
        if @battler.total_damage.empty? and @damage_wait != 0
          @damage_wait = 20
        end
=end        
        @battler.damage_sp.delete(battler[0])
      end
      
      # 顯示總傷害
      if @battler.combo_appear and @battler.combohit > 1
        # 取得位置
        td_x_pos = @battler.screen_x
        td_y_pos = @battler.screen_y - @height/2
        total_damage(@battler.td_damage, td_x_pos, td_y_pos)
        @battler.combo_appear = false
      end
      
      @battler.damage_pop.delete(battler[0])
      @battler.damage.delete(battler[0])
      @battler.critical.delete(battler[0])
      
      @battler.weakness.delete([battler[0]])  # 180414  弱點傷害顏色
    end
    
    # 可視の場合
    if @battler_visible
      # 逃走
      if @battler.hidden
        $game_system.se_play($data_system.escape_se)
        escape
        @battler_visible = false
      end
      # 白フラッシュ
      if @battler.white_flash
        whiten
        @battler.white_flash = false
      end
      #  戰鬥動畫
      unless @battler.animation.empty?
        for animation in @battler.animation.reverse
          animation[2] = 1 if animation[2].nil?
          # 設定動畫(動畫、命中判定、方向、x座標、y座標)
          animation($data_animations[animation[0]], animation[1], animation[2], @battler.true_x, @battler.z_pos)
          @battler.animation.delete(animation)
        end
      end
      # 陣亡演出
      if @battler.total_damage.empty? and @battler.dead? #and !moving?
        if $scene.dead_ok?(@battler)
          if @battler.is_a?(Game_Enemy)
            $game_system.se_play($data_system.enemy_collapse_se)
          else
            $game_system.se_play($data_system.actor_collapse_se)
          end
          # 爆炸處理
          start_dead
        end
      end
    end
    
    
    # 詠唱中
    if @battler.rtp > 0 and !(@battler.phase > 3)  and !(@action_name == :"damaging") and !not_on_basepos? and @battler.exist? and !$scene.fin? and @battler.current_action.skill_id > 0 #and @battler.restriction == 0 # and (@battler.spell and @battler.current_action.spell_id != 0)
      
      # 變成詠唱motion
      if @action_name != :"spelling"
        start_spelling
      end

      if $data_skills[@battler.current_action.skill_id].element_set.include?(STILILA::ELM_SPELL_P)
        # 附加詠唱物理技的狀態
        @battler.add_state($data_states[STILILA::STATE_SPELL_P].id, true)  
      elsif $data_skills[@battler.current_action.skill_id].element_set.include?(STILILA::ELM_SPELL_M)
        # 附加詠唱魔法技的狀態
        @battler.add_state($data_states[STILILA::STATE_SPELL_M].id, true)  
      end
      
    else
      
      # 移除詠唱的狀態
      @battler.remove_state($data_states[STILILA::STATE_SPELL_P].id, true) 
      @battler.remove_state($data_states[STILILA::STATE_SPELL_M].id, true) 
      # 矯正姿勢
     # do_straighten
    end
    
    #時停解除
     if  $game_temp.cleartheworld  #這變數為true時
       #依序處理場上所有戰鬥對象，將world這個變數設為false，並解除附帶的狀態
       for thebattler in $game_party.actors + $game_troop.enemies
         thebattler.world = false
         thebattler.remove_state(STILILA::WORLD_STATE_ID)
       end
       $game_temp.cleartheworld = false
     end  
     
     #時停中改變色調
     if @battler.world
       self.tone.gray = 255 if self.tone.gray != 255
     else
       self.tone.gray = 0
     end    
  
    # 模組更新 
    if !@battler.world
       @damage_wait -= 1 if @damage_wait > 0
       @frame_duration -= 1 if @frame_duration >= 0 # 最小為-1，此時將不會觸發update_motion
       @action_time += 1 if @action_name != nil  # 有行動時才增加時間
       @frame_time += 1
       # 更新震動
       update_shake
       # 更新模組下個影格
       if @frame_duration == 0 and @action_name != nil
         update_motion(@next_frame) 
       end 
      # 更新移動
      update_move
      update_transfer
      update_turnback
      # 常時監視
      respective_update 
      # 受傷後歸位(170305移到攻擊方行動完統一執行)
    #  start_damage_turnback if can_damage_turnback?

      
      # 如果該動作有對應名稱的方法，一併執行
      if @action_name != nil 
        send(@action_name.to_s) if respond_to?(@action_name)
      end
    end
    
    
    # if @battler.is_a?(Game_Enemy)
    self.zoom_x = $game_temp.battle_camera_z * @battler.zoom
    self.zoom_y = $game_temp.battle_camera_z * @battler.zoom
    #  end  
    # スプライトの座標を設定
    self.x = @battler.screen_x
    self.y = @battler.screen_y
    self.z = @battler.screen_z
    update_shadow
  
  end # def end
  
  #--------------------------------------------------------------------------
  # ● 更新影子
  #--------------------------------------------------------------------------
  def update_shadow
    @battler_shadow.visible = @battler_visible
    @battler_shadow.ox = @width / 2
    @battler_shadow.oy = @height
    @battler_shadow.bitmap = self.bitmap
    @battler_shadow.x = self.x
    @battler_shadow.y = ((@battler.z_pos) * $game_temp.battle_camera_z + $game_temp.battle_camera_y).to_i + 10 - 3
    @battler_shadow.z = self.z - 1
    @battler_shadow.zoom_x = self.zoom_x
    @battler_shadow.zoom_y = self.zoom_y - 0.6
    @battler_shadow.opacity = [[170 + @battler.y_pos * 3, self.opacity].min, 170].min
    @battler_shadow.mirror = self.mirror
    
    
  end
  
end  # class end






#============================================================================
# ■ module  RPG
#----------------------------------------------------------------------------
# 　RPG模塊
#============================================================================

module RPG
  class Sprite < ::Sprite
    
    #--------------------------------------------------------------------------
    # ● 彈出傷害
    #       type ： (0：HP攻擊、1：SP攻擊、2：升級)
    #       weakness：(0：傷害沒加成、1：效果拔群、-1：沒啥效果)
    #--------------------------------------------------------------------------
    def damage(value, critical, type = 0, x_pos=0, y_pos=0, weakness = 0)
      if value.is_a?(Numeric)
        damage_string = value.abs.to_s
      else
        damage_string = value.to_s
      end
      #傷害值為數字。攻擊的情況(傷害值為正)
      if value.is_a?(Numeric) and value >= 0       
        if type == 0   #HP攻擊
          if critical   #爆擊
            d_bitmap = draw_damage(value, 1)
          else           #沒爆擊
            case weakness
            when 1  
              d_bitmap = draw_damage(value, 5)  # 效果拔群
            when -1
              d_bitmap = draw_damage(value, 6)  # 效果差
            else
              d_bitmap = draw_damage(value, 0)  # 效果普通
            end

          end 
          
        else       #SP攻擊       
          d_bitmap = draw_damage(value, 2)
        end
      #恢復的情況(傷害值為負)  
       else    
        if type == 0   #HP攻擊
          d_bitmap = draw_damage(value, 3)
        else      #SP攻擊
          d_bitmap = draw_damage(value, 4)
        end
      end
      
      if type == 2
        d_bitmap = draw_damage(value, 5)
      end
      num = @_damage.size
      
      if type != 2
        #恢復
        if value.to_i < 0
          # SP恢復
          if type == 1
            @_damage.push([::Sprite.new, 40, 0, 0, 60, x_pos, y_pos])
            #HP恢復 
          else
            @_damage.push([::Sprite.new, 40, 0, 0, 75, x_pos, y_pos])
          end  
        else # 損傷 
          @_damage.push([::Sprite.new, 40, 0, rand(40) - 20, rand(30) + 50, x_pos, y_pos])
        end
      else
        @_damage.push([::Sprite.new, 40, 0, 0, 30, x_pos, y_pos])
      end
      @_damage[num][0].bitmap = d_bitmap 
      @_damage[num][0].ox = d_bitmap.width / 2
      @_damage[num][0].oy = d_bitmap.height / 2
      @_damage[num][0].x = screen_x(x_pos)
      @_damage[num][0].y = screen_y(y_pos) - self.bitmap.height / 2# +  self.viewport.oy / 2 - 50
      @_damage[num][0].z = 3500
    end #def end
    
    #--------------------------------------------------------------------------
    # ● 彈出總傷害
    #--------------------------------------------------------------------------
    def total_damage(value, x_pos, y_pos)
      # 計算總傷害(如果為狀態攻擊不計算)
      td_bitmap = draw_total_damage(value) 
      num2 = @_total_damage.size   
      @_total_damage.push([::Sprite.new, 60, x_pos, y_pos]) 
    #  @_total_damage[num2][0].visible = false  #設為不可視
      @_total_damage[num2][0].bitmap = td_bitmap 
      @_total_damage[num2][0].ox = td_bitmap.width / 2
      @_total_damage[num2][0].oy = td_bitmap.height / 2
      @_total_damage[num2][0].x = x_pos #+ self.viewport.ox
      @_total_damage[num2][0].y = y_pos -  18
      @_total_damage[num2][0].z = 3500
      @_total_damage[num2][0].zoom_x = 2.5
      @_total_damage[num2][0].zoom_y = 2.5
    end
    

  #--------------------------------------------------------------------------
  # ● 刷新畫面
  #--------------------------------------------------------------------------
    def update
      super
      if @_whiten_duration > 0
        @_whiten_duration -= 1
        self.color.alpha = 128 - (16 - @_whiten_duration) * 10
      end
      if @_appear_duration > 0
        @_appear_duration -= 1
        self.opacity = (16 - @_appear_duration) * 16
      end
      if @_escape_duration > 0
        @_escape_duration -= 1
       self.opacity = 256 - (32 - @_escape_duration) * 10
      end
      if @_collapse_duration > 0
        @_collapse_duration -= 1
        self.opacity = 256 - (48 - @_collapse_duration) * 6
      end

      for damage in @_damage
        if damage[1] > 0
          damage[1] -= 1
          damage[4] -= 3
          damage[2] -= damage[4]
          
          damage[0].x = screen_x(damage[5]) + (40 - damage[1]) * damage[3] / 10
          damage[0].y = screen_y(damage[6]) + damage[2] / 10 - self.bitmap.height / 2#- self.oy / 2
          
          
          damage[0].zoom_x = self.zoom_x
          damage[0].zoom_y = self.zoom_y
          damage[0].z = 2960 + damage[1]
          damage[0].opacity = 256 - (12 - damage[1]) * 32
          if damage[1] == 0
       #     damage[0].bitmap.dispose
            damage[0].dispose
           @_damage.delete(damage)
          end
        end
      end
      
      for total_damage in @_total_damage
        if total_damage[1] > 0  
           total_damage[1] -= 1 
           total_damage[0].x = screen_x(self.battler.base_x) #+ 150

          if total_damage[1]  > 40
            total_damage[0].zoom_x = 1 + 0.1 * (total_damage[1] - 40) 
            total_damage[0].zoom_y = 1 + 0.1 * (total_damage[1] - 40) 
          end
           
          total_damage[0].y = (screen_y(self.battler.base_z) - 115) + self.viewport.rect.y + 1 * total_damage[1] - self.bitmap.height * self.zoom_y / 2  #  - self.oy * self.zoom_y / 2
           total_damage[0].z = 3500
           total_damage[0].opacity = 256 - (10 - total_damage[1]) * 32
           if total_damage[1] == 0
             #total_damage[0].bitmap.dispose
             total_damage[0].dispose
             total_damage.clear 
             @_total_damage.delete(total_damage)
           end
         end 
      end


      for anime in @_animation
        if (Graphics.frame_count % 2 == 0)
          anime[2] -= 1
          update_animation(anime)
        end
      end
      
      #循環動畫的情況
      if @_loop_animation != nil and (Graphics.frame_count % 2 == 0)
        update_loop_animation
        @_loop_animation_index += 1
        @_loop_animation_index %= @_loop_animation.frame_max
      end

      if @_blink
        @_blink_count = (@_blink_count + 1) % 32
        if @_blink_count < 16
          alpha = (16 - @_blink_count) * 6
        else
          alpha = (@_blink_count - 16) * 6
        end
        self.color.set(255, 255, 255, alpha)
      end
      @@_animations.clear
    end
    
    #--------------------------------------------------------------------------
    # ●設定動畫
    #      animation：動畫
    #      hit：命中判定
    #      direction：方向
    #      x_pos：X座標
    #      y_pos：Y座標
    #--------------------------------------------------------------------------      
    def animation(animation, hit, direction = 1, x_pos=0, y_pos=0)
      return if animation == nil
      num = @_animation.size
      @_animation.push([animation, hit, animation.frame_max, [], direction, x_pos, y_pos])
      bitmap = RPG::Cache.animation(animation.animation_name,
                                    animation.animation_hue)
      if @@_reference_count.include?(bitmap)
        @@_reference_count[bitmap] += 1
      else
        @@_reference_count[bitmap] = 1
      end
      if @_animation[num][0].position != 3 or not @@_animations.include?(animation)
        for i in 0..15
          #修正(戰鬥時，指定視口)
           if  $game_temp.in_battle
             sprite = ::Sprite.new(self.viewport) 
          else
             sprite = ::Sprite.new
           end 
          sprite.bitmap = bitmap
          sprite.visible = false
          @_animation[num][3].push(sprite)
        end
        unless @@_animations.include?(animation)
          @@_animations.push(animation)
        end
      end
      update_animation(@_animation[num])
    end
    
  #--------------------------------------------------------------------------
  # ● 更新動畫
  #     數組分佈－－0：動畫資料
  #                             1：命中判定
  #                             2：動畫總畫格數
  #                             3：動畫圖像
  #                             4：動畫方向
  #                             5：X座標
  #                             6：Y座標
  #--------------------------------------------------------------------------   
    def update_animation(anime)
      if anime[2] > 0
        frame_index = anime[0].frame_max - anime[2]
        cell_data = anime[0].frames[frame_index].cell_data
        position = anime[0].position
        # 設定動畫座標
        if $game_temp.in_battle
          x_pos = anime[5]
          y_pos = anime[6]
        else
          x_pos = self.x
          y_pos = self.y
        end
        
        animation_set_sprites(anime[3], cell_data, position, anime[4], x_pos, y_pos)
        
        for timing in anime[0].timings
          if timing.frame == frame_index
            animation_process_timing(timing, anime[1])
          end
        end
      else
        
      # 除錯用
        unless anime[3].empty?
          @@_reference_count[anime[3][0].bitmap] -= 1 
          if @@_reference_count[anime[3][0].bitmap] == 0
            anime[3][0].bitmap.dispose
           end
         end
         
        for sprite in anime[3]
          
          # 除錯用
          if anime[3].empty?
            next
          end
          
          sprite.dispose
        end
        @_animation.delete(anime)
      end
    end
    
    #--------------------------------------------------------------------------
    # ● 更新狀態動畫
    #--------------------------------------------------------------------------
    def update_loop_animation
      
      # 不在原位就不更新
      if self.not_on_basepos?
        if @_loop_animation_sprites != nil and @_loop_animation_sprites[0].visible 
          for i in 0..15
            @_loop_animation_sprites[i].visible = false
          end
        end
        return
      else
        if @_loop_animation_sprites != nil and !@_loop_animation_sprites[0].visible 
          for i in 0..15
            @_loop_animation_sprites[i].visible = true
          end
        end
      end
      
      
      frame_index = @_loop_animation_index
      cell_data = @_loop_animation.frames[frame_index].cell_data
      position = @_loop_animation.position
      animation_set_sprites(@_loop_animation_sprites, cell_data, position, 1, @battler.true_x, @battler.z_pos)
      for timing in @_loop_animation.timings
        if timing.frame == frame_index
          animation_process_timing(timing, true)
        end
      end
    end
    
    
   #--------------------------------------------------------------------------
   # ● 設置動畫內容
   #--------------------------------------------------------------------------    
   def animation_set_sprites(sprites, cell_data, position, direction = 1, x_pos = 0, y_pos = 0)

     for i in 0..15
       sprite = sprites[i]
       pattern = cell_data[i, 0]
       if sprite == nil or pattern == nil or pattern == -1
          sprite.visible = false if sprite != nil
          next
        end
        sprite.visible = true
        sprite.src_rect.set(pattern % 5 * 192, pattern / 5 * 192, 192, 192)
        
        # 全畫面攻擊
        if position == 3
          if self.viewport != nil
       #     sprite.x = self.viewport.rect.width / 2
       #     sprite.y = self.viewport.rect.height - 320
            # 「使用方」判斷
            if self.is_a?(Game_Enemy)  
              sprite.x = screen_x(520)
            else
              sprite.x = screen_x(90)
            end
            sprite.y = screen_y(210)
       
          else
            sprite.x = 320
            sprite.y = 240
          end
          
          
        else
          # 戰鬥中顯示
          if $game_temp.in_battle
            sprite.x = screen_x(x_pos) #self.x + self.viewport.rect.x - self.base_ox + self.src_rect.width / 2
            sprite.y = screen_y(y_pos) - self.src_rect.height / 2# self.y + self.viewport.rect.y - self.base_oy + self.src_rect.height / 2
          # 原野中顯示
          else
            sprite.x = self.x + self.viewport.rect.x - self.ox + self.src_rect.width / 2
            sprite.y = self.y + self.viewport.rect.y - self.oy + self.src_rect.height / 2
          end
          sprite.y -= self.src_rect.height / 4 if position == 0
          sprite.y += self.src_rect.height / 4 if position == 2
        end
        # 如果是敵方使用戰鬥動畫而且非狀態動畫，反轉位置
        if direction == -1
          sprite.x -= cell_data[i, 1]
        else
          sprite.x += cell_data[i, 1]
        end

        sprite.y += cell_data[i, 2]
        
        #非全螢幕顯示的情況下(而且是戰鬥中)，動畫的Z軸等於作用對象的Z軸
        if position == 3  or !$game_temp.in_battle
          sprite.z = 2000
        else        
          sprite.z = self.battler.screen_z + 2
        end
        sprite.ox = 96
        sprite.oy = 96
        sprite.zoom_x = cell_data[i, 3] / 100.0
        sprite.zoom_y = cell_data[i, 3] / 100.0
   #     if position != 3
          sprite.zoom_x *= self.zoom_x
          sprite.zoom_y *= self.zoom_y
     #   end

        # 如果是敵方使用戰鬥動畫而且非狀態動畫，反轉動畫與角度
        if direction == -1
            sprite.angle = (360 - cell_data[i, 4])
            sprite.mirror = (cell_data[i, 5] == 0)
        else
          sprite.angle = cell_data[i, 4]
          sprite.mirror = (cell_data[i, 5] == 1)
        end    
        # 如果旋轉角度為360度就設為0度以免吃資源         
        if sprite.angle == 360
          sprite.angle = 0
        end
        
        sprite.opacity = cell_data[i, 6] #* self.opacity / 255.0
        sprite.blend_type = cell_data[i, 7]
      end
      
      
      
    end
    
    
    
    #--------------------------------------------------------------------------
    # ● 畫面X座標
    #--------------------------------------------------------------------------
    def screen_x(now_x)
      return 320 + (now_x - 320) * $game_temp.battle_camera_z + $game_temp.battle_camera_x
    end
    #--------------------------------------------------------------------------
    # ● 畫面Y座標
    #--------------------------------------------------------------------------
    def screen_y(now_y)
      return now_y * $game_temp.battle_camera_z + $game_temp.battle_camera_y + 10
    end
    
    #--------------------------------------------------------------------------
    # ● 變更X座標 (你這小兲蛋害我找動畫亂跑的原因找得好累啊)
    #-------------------------------------------------------------------------- 
    def x=(x)
      super
    end
    #--------------------------------------------------------------------------
    # ● 變更Y座標 (你這小兲蛋和上面半斤八兩)
    #-------------------------------------------------------------------------- 
    def y=(y)
      super
    end

  end
end

#==============================================================================
# ■ Interpreter
#------------------------------------------------------------------------------
# 　イベントコマンドを実行するインタプリタです。このクラスは Game_System クラ
# スや Game_Event クラスの内部で使用されます。
#==============================================================================

class Interpreter
  
  #--------------------------------------------------------------------------
  # ● 更換隊員
  #--------------------------------------------------------------------------
  def command_129
    
    # 獲取角色
    actor = $game_actors[@parameters[0]]
    # 角色存在的情況
    if actor != nil
      # 操作で分岐
      if @parameters[1] == 0 # 加入的情況
        if @parameters[2] == 1  # 有勾選初始化
          $game_actors[@parameters[0]].setup(@parameters[0])
        end
        $game_party.add_actor(@parameters[0])
        # 戰鬥時替換
        if $game_temp.in_battle
          # 建立戰鬥Sprite
          actor.sprite_initialize($scene.spriteset.viewport2)
       #   $game_actors[@parameters[0]].battle_sprite = Sprite_Battler.new($scene.spriteset.viewport2, actor)
          $game_actors[@parameters[0]].at = 0
          $game_actors[@parameters[0]].atp = 0
          $scene.spell_reset($game_actors[@parameters[0]])
          $game_actors[@parameters[0]].damage_pop = {}
          $game_actors[@parameters[0]].damage = {}
          $game_actors[@parameters[0]].damage_sp = {}
          $game_actors[@parameters[0]].critical = {}
          $game_actors[@parameters[0]].recover_hp = {}
          $game_actors[@parameters[0]].recover_sp = {}
          $game_actors[@parameters[0]].state_p = {}
          $game_actors[@parameters[0]].state_m = {}
          $game_actors[@parameters[0]].animation = []
          
          actor.set_default_pos(actor.index)
          
        end
      else  # 離開的情況
        $game_actors[@parameters[0]].battle_sprite.dispose if $game_actors[@parameters[0]].battle_sprite != nil
        $game_actors[@parameters[0]].battle_sprite = nil
        $game_party.remove_actor(@parameters[0])
        for a in $game_party.actors
          a.set_default_pos(a.index)
        end
      end
    end
    if $game_temp.in_battle
      $scene.status_window.update
    end
    # 繼續事件
    return true
  end
  
  
  #--------------------------------------------------------------------------
  # ● アニメーションの表示
  #--------------------------------------------------------------------------
  def command_337
    # イテレータで処理
    iterate_battler(@parameters[0], @parameters[1]) do |battler|
      # バトラーが存在する場合
      if battler.exist?
        # アニメーション ID を設定
        battler.animation.push([@parameters[2], true], 1)
      end
    end
    # 継続
    return true
  end
end
#=end
