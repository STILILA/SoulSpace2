#==============================================================================
# ■ 模組主系統
#------------------------------------------------------------------------------
#==============================================================================

class Sprite_Battler < RPG::Sprite
  
  # 著地用戰鬥動畫ID
  LANDING_ANIME_ID = 658
  
  #-------------------------------------------------------------------------------
  # ○ 公開變量
  #-------------------------------------------------------------------------------
  attr_accessor :x_fric                   # 摩擦力
  attr_accessor :y_down               # 重力加速度
  attr_accessor :y_fixed               # Y軸固定
  attr_accessor :damage_wait      # 傷害時間(判定能不能歸位)
  
  attr_reader   :action_name  # 補充
  
  #-------------------------------------------------------------------------------
  # ○ 模組清單
  #-------------------------------------------------------------------------------
  Motion_Data = {
  :"skill_basic" => [], # <= 使用技能的基本motion
  :"item_sup_basic" => [], # <= 使用輔助道具的基本motion
  :"item_atk_basic" => [], # <= 使用攻擊道具的基本motion
  }

  #--------------------------------------------------------------------------
  # ○ 變更圖片
  #--------------------------------------------------------------------------
  def change_picture(id)
    if id == 1
      name = @battler_name
    else
      name = @battler_name + "_#{id}"
    end
    begin
      self.bitmap = RPG::Cache.battler(name, @battler_hue)
      @width = bitmap.width
      @height = bitmap.height
      self.ox = @width / 2
      self.oy = @height
      @battler.halfheight = @height / 2
      if @battler.is_a?(Game_Enemy)
        @battler.height = @height
      #  self.mirror = true 
      end
    rescue
      # 如果找不到圖就什麼都不做
    end
    
  end
  
  #--------------------------------------------------------------------------
  # ○ 進行影格
  #      frame：更新時的畫格
  #--------------------------------------------------------------------------
  def update_motion(frame)
    
    @frame_time = 0
    
    # 要執行的影格為符號時的特別處理
    if frame.is_a?(Symbol)
      eval(frame.to_s)
      return
    else
      
    end
    
   # if frame >= @motion_data[@action_name].size 
    #  start_turnback
    #  return
   # end

   frame_data = @motion_data[@action_name][frame]
   
   
    # 設定圖片
    change_picture(frame_data[:"pic"])
    # 設定停留時間
    @frame_duration = frame_data[:"wait"]
    # 設定影格
    @frame_number = frame
    # 設定下一個影格
    @next_frame = frame_data[:"next"]
    
    # 轉向
    self.mirror = !self.mirror if frame_data[:"turn"] != nil
    
    # 播放指定戰鬥動畫(動畫、方向、x座標、y座標)
    if frame_data[:"anime"] != nil
      anime = frame_data[:"anime"] 
      
      # 對敵人
      if anime[4] == 1
        # 全畫面系動畫
        if $data_animations[anime[0]].position == 3
          @battler.target[0].battle_sprite.animation($data_animations[anime[0]], 1, anime[1]  * (self.mirror ? -1 : 1), @battler.x_pos + anime[2] * (self.mirror ? 1 : -1), anime[3] + @battler.z_pos - @battler.y_pos)
        else
          # 單體技對多人
          if @battler.target.size > 1
            for t in @battler.target
              t.battle_sprite.animation($data_animations[anime[0]], 1, anime[1]  * (self.mirror ? -1 : 1), @battler.x_pos + anime[2] * (self.mirror ? 1 : -1), anime[3] + @battler.z_pos - @battler.y_pos)
            end
          # 單體技對單人  
          else
            @battler.target[0].battle_sprite.animation($data_animations[anime[0]], 1, anime[1]  * (self.mirror ? -1 : 1), @battler.x_pos + anime[2] * (self.mirror ? 1 : -1), anime[3] + @battler.z_pos - @battler.y_pos)
          end
        end
       # 對自己   
       else
         animation($data_animations[anime[0]], 1, anime[1]  * (self.mirror ? -1 : 1), @battler.x_pos + anime[2] * (self.mirror ? 1 : -1), anime[3] + @battler.z_pos - @battler.y_pos) # + @battler.y_pos
       end
    end
    
    # 設定速度
    @battler.x_speed = frame_data[:"x_speed"] * (self.mirror ? 1 : -1) if frame_data[:"x_speed"] != nil
    @battler.y_speed = frame_data[:"y_speed"] if frame_data[:"y_speed"] != nil
    
    # 使用瞬移效果
    start_transfer(frame_data[:"transfer"][0],frame_data[:"transfer"][1]) if frame_data[:"transfer"] != nil 
    
    # 設定畫面震動
    if frame_data[:"shake"] != nil
      shake = frame_data[:"shake"]
      $game_screen.start_shake(shake[0], shake[1], shake[2], shake[3])
    end
    
    # 修改摩擦力
    @x_fric = frame_data[:"x_fric"] if frame_data[:"x_fric"] != nil

    # 修改重力加速度
    @y_down = frame_data[:"y_down"] if frame_data[:"y_down"] != nil
    
    # Y軸固定
    @y_fixed = frame_data[:"y_fixed"] if frame_data[:"y_fixed"] != nil
    
    # 修改彈跳速度判定
    @bounce_speed = frame_data[:"bounce_speed"] if frame_data[:"bounce_speed"] != nil
    
    # 設定著地時的動作
    @landing_action = frame_data[:"landing_act"] if frame_data[:"landing_act"] != nil

    # 設定鏡頭
    if frame_data[:"camera"]
      data = frame_data[:"camera"]
      if data.is_a?(Array)
        camera_set(false, data[0], data[1], data[2])
      else
        camera_set(data)
      end
    end
    
=begin
    # 設定敵人 X 速度
    if @motion_data[@action_name][frame][:"target_x_speed"] != nil
      for target in @battler.target
        target.x_speed = @motion_data[@action_name][frame][:"target_x_speed"] * (self.mirror ? 1 : -1) 
      end
    end
    
    # 設定敵人 Y 速度
    if @motion_data[@action_name][frame][:"target_y_speed"] != nil  
      for target in @battler.target
        target.y_speed = @motion_data[@action_name][frame][:"target_y_speed"] 
      end
    end
    
    # 設定敵人 Y 軸固定
    if @motion_data[@action_name][frame][:"target_y_fixed"] != nil  
      for target in @battler.target
        target.battle_sprite.y_fixed = @motion_data[@action_name][frame][:"target_y_fixed"] 
      end
    end
    
    # 設定敵人摩擦力
    if @motion_data[@action_name][frame][:"target_x_fric"] != nil  
      for target in @battler.target
        target.battle_sprite.x_fric = @motion_data[@action_name][frame][:"target_x_fric"] 
      end
    end
    
    # 設定敵人重力加速度
    if @motion_data[@action_name][frame][:"target_y_down"] != nil  
      for target in @battler.target
        target.battle_sprite.y_down = @motion_data[@action_name][frame][:"target_y_down"] 
      end
    end
=end

    # 設定等待(註：motion生效時是在放完使用者動畫、step3最後)
    @battler.wait = frame_data[:"battler_wait"] if frame_data[:"battler_wait"] != nil 
  end
  
  #--------------------------------------------------------------------------
  # ● 設定動作模組
  #      kind：類型(0：武器、1：技能、2：道具)
  #      action_name：武器(weapon_1~999)、技能(skill_1~999)、道具ID(item_1~999)、其他特殊動作
  #--------------------------------------------------------------------------
  def motion_set(action_id, kind)
    @frame_number = 0
    case kind
    when 0
      name = "weapon_"
    when 1
      name = "skill_"
    when 2
      name = "item_"
    end
     
     full = :"#{name}#{action_id}"
     
     # 沒設定對應 motion 時
     if @motion_data[full] == nil
       case kind
       when 0  # 普攻
         weapon_basic_start
         return
       when 1  # 技能
         skill_basic_start
         return
       when 2  # 道具
         item_basic_start
         return
       end
     end
     @action_name = full
     @battler.action_flag = true
     @action_time = 0
     @frame_time = 0
     update_motion(0)
   end
  

  
  #--------------------------------------------------------------------------
  # ● 更新移動
  #--------------------------------------------------------------------------
  def update_move
    
    if @battler.x_speed != 0
      @battler.x_pos += @battler.x_speed
      if @battler.x_speed > 0 
        @battler.x_speed = [@battler.x_speed - @x_fric, 0].max
      elsif @battler.x_speed < 0 
        @battler.x_speed = [@battler.x_speed + @x_fric, 0].min
      end
    end
    
    # 在空中或是有Y速度時，而且Y軸非固定狀態
    if (@battler.y_pos < 0 or @battler.y_speed != 0) and !@y_fixed
      @battler.y_pos -= @battler.y_speed
      @battler.y_speed -= @y_down
      if @battler.y_pos >= 0 
        # 反彈
        if @battler.y_speed < @bounce_speed and @bounce_speed < 0 and @action_name == :"damaging"
          @battler.y_speed = -@battler.y_speed * 0.3
        else
          @battler.y_pos = 0
          @battler.y_speed = 0
          start_landing
        end
      end
    end
  end

  
  
  #-------------------------------------------------------------------------------
  # ○ 泛用：普攻 起始
  #-------------------------------------------------------------------------------
  def weapon_basic_start
    
    @action_name = :"weapon_basic"  # 必須是符號
    @frame_duration = -1  # <= 不觸發update_motion
     @battler.action_flag = true
     @action_time = 0
     @frame_time = 0
     @frame_number = 0
  #   update_motion(0)
    # 重設運動能力
    reset_athletic_ability
    # 設定位移量
    @turnback_x = ((@battler.base_x - @battler.target[0].x_pos + @width/2 * (self.mirror ? 1 : -1)) / 10.0).to_i # * (self.mirror ? 1 : -1)
    @turnback_z = ((@battler.base_z - @battler.target[0].z_pos) / 10.0).to_i #* (@battler.base_z > @battler.z_pos ? -1 : 1)
    
    # 如果攻擊者沒目標方動畫
    if @battler.anime2 == 0
      # 設定影格停留時間
      @frame_duration = 14 + 10
    else
      # 設定影格停留時間
      @frame_duration = 14 + ($data_animations[@battler.anime2].frame_max * 2)
    end
    
    @battler.wait = 14
    @next_frame = :"start_turnback"
 
    camera_set(0)  #####
  end
  
  #-------------------------------------------------------------------------------
  # ○ 泛用：普攻 處理
  #-------------------------------------------------------------------------------
  def weapon_basic
    
    # 接近目標
    if @frame_time < 10
      @battler.x_pos -= @turnback_x
      @battler.z_pos -= @turnback_z 
    end
    # 移動完畢時，微調位置
    if @frame_time == 10
      @battler.x_pos = @battler.target[0].x_pos + @width/2 * (self.mirror ? -1 : 1)
      @battler.z_pos = @battler.target[0].z_pos + 1
    end
  
  end
  
  #-------------------------------------------------------------------------------
  # ○ 泛用：技能 起始
  #-------------------------------------------------------------------------------
  def skill_basic_start
    @action_name = :"skill_basic"
    @action_time = 0
    @frame_duration = -1  # <= 不觸發update_motion
    @battler.action_flag = true
  
   # 使用方動畫時間
   @anime1_time = (@battler.anime1 == 0 ? 14 : $data_animations[@battler.anime1].frame_max * 2)
   # 目標方動畫時間
   @anime2_time = (@battler.anime2 == 0 ? 10 : $data_animations[@battler.anime2].frame_max * 2)

    # 記憶出招時間
    @animeAll_time = @anime1_time + @anime2_time + 1
    @battler.wait = @anime1_time
  end
  #-------------------------------------------------------------------------------
  # ○ 泛用：技能 處理
  #-------------------------------------------------------------------------------
  def skill_basic
    # 減少出招時間
    @animeAll_time -= 1
    # 設定鏡頭
    if @action_time == @anime1_time
      camera_set(0)  #####
    end
    # 如果出招結束(使用方和目標方動畫閃完)
    if @animeAll_time == 0
      @action_name = nil # 結束行動
      @battler.action_flag = false
      @action_time = 0
      @frame_time = 0
      @frame_number = 0
      @anime1_time = 0
      @anime2_time = 0
    end 
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 泛用：道具 起始
  #-------------------------------------------------------------------------------
  def item_basic_start
    # 什麼也不做
  end
  #-------------------------------------------------------------------------------
  # ○ 泛用：詠唱 起始
  #-------------------------------------------------------------------------------
  def start_spelling
    # 什麼也不做
  end
  
  #--------------------------------------------------------------------------
  # ○ 泛用：瞬移到目標 起始
  #      x, y：瞬移後的x, y位置補正
  #--------------------------------------------------------------------------
  def start_transfer(x,y)
    @transfer_x = x
    @transfer_y = y
    @transfer_time = 20
  end
  #--------------------------------------------------------------------------
  # ○ 泛用：瞬移到目標 處理
  #--------------------------------------------------------------------------
  def update_transfer
    
    # 防錯
    if @transfer_time > 0
      if @battler.target.size > 1
        p "泛用的瞬間移動對全體招無效！"
        @transfer_time = 0
        return 
      end
    end
    
    if @transfer_time > 0
      # 淡出
      @transfer_time -= 1
      if @transfer_time > 12
        self.opacity = 32 * (@transfer_time - 13)
      end
      # 瞬移
      if @transfer_time == 12
        @battler.x_pos = @battler.target[0].x_pos + @width/2 * (self.mirror ? -1 : 1) + @transfer_x * (self.mirror ? -1 : 1)
        @battler.y_pos = @transfer_y
        @battler.z_pos = @battler.target[0].z_pos + 1
        @transfer_x = @transfer_y = 0
      end
      # 淡入
      if @transfer_time < 11 
        self.opacity = 26 * (10 - @transfer_time)
      end
      
      self.opacity = 255  if @transfer_time == 0 
      
    end
    
  end
  
  
  #--------------------------------------------------------------------------
  # ● 泛用：回歸原位 起始
  #--------------------------------------------------------------------------
  def start_turnback

    @action_name = :"turn_back"
    @frame_duration = -1  # <= 不觸發update_motion
    
    # 重設運動能力
    reset_athletic_ability
    
    @turnback_time = [18, 14]
    @turnback_x = ((@battler.x_pos - @battler.base_x + 0.0)  / @turnback_time[1]).to_i # * (self.mirror ? 1 : -1)
    @turnback_z = ((@battler.base_z - @battler.z_pos + 0.0)  / @turnback_time[1]).to_i #* (@battler.base_z > @battler.z_pos ? -1 : 1)
     
    @battler.y_speed = @y_down * ((@turnback_time[1] - 2) / 2) - @y_down
    
    # 變回歸位圖
     change_turnback_picture

    if @battler.is_a?(Game_Enemy)
      self.mirror = true
    else
      self.mirror = false
    end

  end
  
  #--------------------------------------------------------------------------
  # ● 泛用：受傷起始
  #      last_hit：被打最後一下的判定
  #--------------------------------------------------------------------------
  def start_damage(last_hit)
    @action_name = :"damaging"
    @frame_duration = -1  # <= 不觸發update_motion
    @action_time = 0
    @frame_time = 0
    @frame_number = 0
     
    #(170305 新增，不過目前用不到，保留看看)
 #   if last_hit
 #     @damage_wait = 20
 #   else
  #    @damage_wait = -1
  #  end
    
    
  end
  
  #--------------------------------------------------------------------------
  # ● 泛用：受傷後回歸原位 起始
  #--------------------------------------------------------------------------
  def start_damage_turnback

    # 爆炸、在原位不處理
    if ((@battler.x_pos == @battler.base_x) and (@battler.z_pos == @battler.base_z)) || !@battler.exist?
      @action_name = nil
      @battler.action_flag = false
      @frame_duration = 0
      reset_athletic_ability
      return
    end
    

    @action_name = :"turn_back"
    @frame_duration = -1  # <= 不觸發update_motion
  #  @battler.action_flag = true
    
    # 重設運動能力
    reset_athletic_ability
    
    
    @turnback_time = [18, 14]
    @turnback_x = ((@battler.x_pos - @battler.base_x + 0.0)  / @turnback_time[1]).to_i # * (self.mirror ? 1 : -1)
    @turnback_z = ((@battler.base_z - @battler.z_pos + 0.0)  / @turnback_time[1]).to_i #* (@battler.base_z > @battler.z_pos ? -1 : 1)
    
    @battler.y_speed = @y_down * ((@turnback_time[1] - 2) / 2) - @y_down
    
    # 變回歸位圖
    change_turnback_picture
    
    if @battler.is_a?(Game_Enemy)
      self.mirror = true
    else
      self.mirror = false
    end

  end

  #--------------------------------------------------------------------------
  # ● 泛用：變為歸位圖
  #--------------------------------------------------------------------------
  def change_turnback_picture
  end
  
  #--------------------------------------------------------------------------
  # ● 泛用：著地
  #--------------------------------------------------------------------------
  def start_landing
    animation($data_animations[LANDING_ANIME_ID], 1, (self.mirror ? -1 : 1), @battler.x_pos, @battler.z_pos - @battler.y_pos)
    if @landing_action
       @action_name = @landing_action[0]
       update_motion(@landing_action[1]) 
       @landing_action = nil
    elsif [:"turn_back"].include?(@action_name)
       change_landing_picture 
    end
  end
  #--------------------------------------------------------------------------
  # ● 泛用：變為著地圖
  #--------------------------------------------------------------------------
  def change_landing_picture
    #animation($data_animations[LANDING_ANIME_ID], 1, (self.mirror ? -1 : 1), @battler.x_pos, @battler.z_pos - @battler.y_pos)
  end
  
  #--------------------------------------------------------------------------
  # ● 泛用：回歸原位 處理
  #--------------------------------------------------------------------------
  def update_turnback
    
    if @turnback_time[0] > 0
      
      #@y_fixed = true
      
     @battler.x_pos -= ((@battler.x_pos - @battler.base_x + 0.0) / 5)
     @battler.z_pos += ((@battler.base_z - @battler.z_pos + 0.0) / 5)
     
     #@battler.x_pos -= @turnback_x
     # @battler.z_pos += @turnback_z
      @turnback_time[0] -= 1
      
      # 快結束時調整鏡頭
    #  if @turnback_time[0] == 5
     #   $scene.spriteset.screen_target(0, 0, 1.02)
    #  end

      if @turnback_time[0] == 0
      #  @y_fixed = false
       @battler.x_pos = @battler.base_x
       @battler.y_pos = @battler.base_y
       @battler.z_pos = @battler.base_z
       @battler.y_min = 0
       @turnback_x = 0
       @turnback_z = 0
       @action_name = nil
       @action_time = 0
       @battler.action_flag = false
       @frame_number = 0
       @next_frame = 0
       change_picture(1)
      end
    end
  end
  

   
  #--------------------------------------------------------------------------
  # ● 泛用：收招
  #--------------------------------------------------------------------------
  def action_end
    @battler.x_pos = @battler.base_x
    @battler.y_pos = @battler.base_y
    @battler.z_pos = @battler.base_z
    @action_name = nil
    @battler.action_flag = false
    @action_time = 0
    @frame_number = 0
    @next_frame = 0
    @frame_duration = 0
    change_picture(1)
  end
  
  
  #--------------------------------------------------------------------------
  # ● 泛用：陣亡起始
  #--------------------------------------------------------------------------
  def start_dead
    collapse  # 套用預設陣亡效果(閃紅消失)
    @battler_visible = false
    @battler.action_flag = false
    @action_name = nil
  end
  
  #--------------------------------------------------------------------------
  # ● 設定鏡頭
  #       x為0時鏡頭在正中央，正往左、負往右
  #       y正往上、負往下
  #--------------------------------------------------------------------------
  def camera_set(scope, x = 0, y = 0, zoom = 1)
    return if @battler.target.size <= 0 || $scene.command.size > 0
    case scope
    when 0
      $scene.camera_set(@battler)
    when 1 
      $scene.camera_setself(@battler)
    else
      if @battler.target[0].is_a?(Game_Actor)
        x *= -1
      end
      $scene.camera_set2(x, y, zoom)
    end
  end
  
  #--------------------------------------------------------------------------
  # ● 常時監視
  #--------------------------------------------------------------------------
  def respective_update
  end
  
  #--------------------------------------------------------------------------
  # ● 不在原位
  #--------------------------------------------------------------------------
  def not_on_basepos?
    return (@battler.x_pos != @battler.base_x or @battler.z_pos != @battler.base_z or @battler.y_pos != 0)
  end
  
  #--------------------------------------------------------------------------
  # ● 可以歸位判定
  #--------------------------------------------------------------------------
  def can_damage_turnback?
    return if !$game_temp.in_battle
    return (@battler.x_speed == 0 and @battler.y_speed == 0 and @battler.y_pos == 0 and @battler.exist? and @damage_wait == 0 and ($scene.have_in_action_battler?) and @action_name == :"damaging")   #and (@battler.x_pos != @battler.base_x or @battler.z_pos != @battler.base_z)) 
  end
  
  #--------------------------------------------------------------------------
  # ● 移動中
  #--------------------------------------------------------------------------
  def moving?
    return (@battler.x_speed != 0 or @battler.y_speed != 0 or @battler.y_pos != 0)
  end
  
  #--------------------------------------------------------------------------
  # ● 初始化個人專屬的模組參數
  #--------------------------------------------------------------------------
  def set_motion_data
    # ============================== 必須宣告的參數

    # 重設運動能力
    reset_athletic_ability

    # motion內容
    @motion_data = Motion_Data
    # 著地時的動作
    @landing_action = nil
    # 檢查模組內容是否正確
    check_motion
  end
  #--------------------------------------------------------------------------
  # ● 重設運動能力
  #--------------------------------------------------------------------------
  def reset_athletic_ability
    # 摩擦力
    @x_fric = 1  
    # 重力加速度
    @y_down = 2
    # Y 軸固定
    @y_fixed = false 
    # 著地時，若落下速度超過此值會發生反彈效果
    @bounce_speed = -16
  end
  
  #--------------------------------------------------------------------------
  # ◇ 矯正姿勢
  #--------------------------------------------------------------------------
  def do_straighten
    if @action_name != :"damaging"
      @action_name = nil
      change_picture(1)
    end
    
  end
  #--------------------------------------------------------------------------
  # ◇ 檢查Motion_Data設定是否有誤(除錯用)
  #--------------------------------------------------------------------------
  def check_motion
    for motion in @motion_data
      for i in 0...motion[1].size
        for k in motion[1][i].keys
          if k.is_a?(String)
            print("「@battler.name」的模組「#{motion[0]}」 的第 #{i} 格中有個設定項為字串，\n請改成符號，否則無法順利運作")
            exit
          end
        end
      end
    end
  end
  
end
