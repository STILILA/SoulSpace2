#==============================================================================
# ■ 雪嵐的僕人阿鎮先生
#------------------------------------------------------------------------------
# 　
#==============================================================================
class Char2 < Sprite_Battler
  #-------------------------------------------------------------------------------
  # ○ 宣告所有模組
  #-------------------------------------------------------------------------------
  Motion_Data = {
  :"spelling" => [],
  :"skill_154" => [],
  :"skill_155" => [],
  :"skill_156" => [],
  :"skill_158" => [],
  :"skill_181" => [],
  :"skill_166" => [],
  :"skill_167" => [],
  :"skill_163" => [],
        #純元素合技
    :"skill_22" => [],:"skill_23" => [],:"skill_26" => [],:"skill_27" => [],
    :"skill_133" => [],:"skill_134" => [],:"skill_137" => [],:"skill_138" => [],
    :"skill_41" => [],:"skill_42" => [],:"skill_45" => [],:"skill_46" => [],
    :"skill_61" => [],:"skill_62" => [],:"skill_65" => [],:"skill_66" => [],
    :"skill_71" => [],:"skill_72" => [],:"skill_75" => [],:"skill_76" => [],
    :"skill_81" => [],:"skill_82" => [],:"skill_85" => [],:"skill_86" => [],
    :"skill_91" => [],:"skill_92" => [],:"skill_95" => [],:"skill_96" => [],
    :"skill_146" => [],:"skill_147" => [],:"skill_150" => [],:"skill_151" => [],
        # 元素拳
    :"skill_226" => [],
    :"skill_227" => [],
    :"skill_228" => [],
    :"skill_229" => [],
    :"skill_230" => [],
    :"skill_231" => [],
    #元素爪合技
    :"skill_191" => [],
    :"skill_192" => [],
    :"skill_193" => [],
    :"skill_194" => [],
    :"skill_195" => [],
    :"skill_196" => [],
    #元素劍合技
    :"skill_201" => [],
    :"skill_202" => [],
    :"skill_203" => [],
    :"skill_204" => [],
    :"skill_205" => [],
    :"skill_206" => [],
    :"skill_207" => [],
    :"skill_208" => [],
    :"skill_209" => [],
    :"skill_210" => [],
    :"skill_211" => [],
    :"skill_212" => [],
    #專技合技
    :"skill_187" => [],
    :"skill_188" => [],
    :"skill_215" => [],
    :"skill_186" => [],
    :"skill_185" => [],
    :"skill_183" => [],
    :"skill_184" => [],
    :"skill_290" => [],
  }
    #-------------------------------------------------------------------------------
  # ○ 詠唱
  #-------------------------------------------------------------------------------
  Motion_Data[:"spelling"][0] = {:"pic"=> 22, :"wait" => 6, :"next" => 1}
  Motion_Data[:"spelling"][1] = {:"pic"=> 23, :"wait" => 6, :"next" => 2}
  Motion_Data[:"spelling"][2] = {:"pic"=> 24, :"wait" => 6, :"next" => 3}
  Motion_Data[:"spelling"][3] = {:"pic"=> 25, :"wait" => 6, :"next" => 0}
    #-------------------------------------------------------------------------------
  # ○ 純元素系列
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_22"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_22"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_23"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_23"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_26"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_26"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_27"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_27"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_133"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_133"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_134"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_134"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_137"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_137"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_138"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_138"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_41"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_41"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_42"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_42"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_45"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_45"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_46"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_46"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_61"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_61"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_62"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_62"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_65"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_65"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_66"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_66"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_71"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_71"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_72"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_72"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_75"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_75"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_76"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_76"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_81"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_81"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_82"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_82"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_85"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_85"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_86"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_86"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_91"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_91"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_92"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_92"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_95"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_95"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_96"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_96"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_146"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_146"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_147"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_147"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_150"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_150"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_151"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_151"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  
  #-------------------------------------------------------------------------------
  # ○ 154：灰夜‧狼爪  , :"turn" => true
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_154"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"x_speed" => -15, :"transfer" => [0,0], :"battler_wait" => 25, :"camera" => 0}
  Motion_Data[:"skill_154"][1] = {:"pic"=> 12, :"wait" => 27, :"next" => :"start_turnback", :"x_speed" => 20, :"shake" => [10,5,14,0] }
  #-------------------------------------------------------------------------------
  # ○ 155：灰幕‧三爪痕
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_155"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"x_speed" => -15, :"transfer" => [0,0], :"battler_wait" => 25, :"camera" => 0}
  Motion_Data[:"skill_155"][1] = {:"pic"=> 12, :"wait" => 20, :"next" => 2, :"x_speed" => 20, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_155"][2] = {:"pic"=> 13, :"wait" => 10, :"next" => 3, :"x_speed" => 20, :"shake" => [10,5,14,0] , :"turn" => true}
  Motion_Data[:"skill_155"][3] = {:"pic"=> 16, :"wait" => 10, :"next" => 4, :"y_speed" => 25, :"turn"=>false}
  Motion_Data[:"skill_155"][4] = {:"pic"=> 17, :"wait" => 30, :"next" => :"start_turnback", :"x_speed" => 13, :"y_speed" =>-25, :"shake" => [10,5,14,0] }
  #-------------------------------------------------------------------------------
  # ○ 155：灰幕‧三爪痕 (舊版)
  #-------------------------------------------------------------------------------
    # Motion_Data[:"skill_155"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"transfer" => [0,0], :"battler_wait" => 25, :"camera" => 0}
    # Motion_Data[:"skill_155"][1] = {:"pic"=> 12, :"wait" => 15, :"next" => 2, :"x_speed" => 6 , :"anime" => [518, 1, 11, 0, 1]}
    # Motion_Data[:"skill_155"][2] = {:"pic"=> 13, :"wait" => 15, :"next" => 3, :"x_speed" => 15, :"shake" => [10,5,14,0] , :"anime" => [519, 1, 5, 0, 1]}
    # Motion_Data[:"skill_155"][3] = {:"pic"=> 14, :"wait" => 20, :"next" => 4, :"x_speed" => -5, :"turn"=>true, :"anime" => [424, 1, 0, 0, 0]}
    # Motion_Data[:"skill_155"][4] = {:"pic"=> 15, :"wait" => 30, :"next" => :"start_turnback", :"x_speed" => 26, :"shake" => [20,8,14,0] , :"anime" => [520, 1, 5, 0, 1],  :"target_y_speed" => 20,  :"target_x_speed" => 10}
  #-------------------------------------------------------------------------------
  # ○ 156：灰滅‧牙狼舞月
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_156"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"x_speed" => -15, :"transfer" => [0,0], :"battler_wait" => 25, :"camera" => 0}   #到敵人前
  Motion_Data[:"skill_156"][1] = {:"pic"=> 12, :"wait" => 30, :"next" => 2, :"x_speed" => 19 , :"shake" => [10,5,14,0], :"anime" => [526, 1, 100, 0, 1]}    #攻擊到敵人身後
  Motion_Data[:"skill_156"][2] = {:"pic"=> 13, :"wait" => 14, :"next" => 3, :"x_speed" => 20, :"y_speed" => 20, :"shake" => [10,5,14,0], :"turn"=>true , :"anime" =>  [524, 1,90, -50, 1]}  #斜爪攻擊
  Motion_Data[:"skill_156"][3] = {:"pic"=> 18, :"wait" => 20, :"next" => 4, :"y_speed" => -18, :"bounce_speed" => 0}   #到地面
  Motion_Data[:"skill_156"][4] = {:"pic"=> 15, :"wait" => 20, :"next" => 5, :"x_speed" => 20, :"turn"=>true , :"shake" => [10,5,14,0], :"anime" =>  [526, 1, 100, 0, 1]}  #攻擊到敵人後面
  Motion_Data[:"skill_156"][5] = {:"pic"=> 18, :"wait" => 15, :"next" => 6, :"turn"=>true, :"anime" => [424, 1, 0, 0, 0]}   #集氣
  Motion_Data[:"skill_156"][6] = {:"pic"=> 16, :"wait" => 8, :"next" => 7, :"x_speed" => 16, :"y_speed" => 30}  #撲到空中
  
  Motion_Data[:"skill_156"][7] = {:"pic"=> 16, :"wait" => 7, :"next" => 8, :"y_fixed" => true, :"x_speed" => 0}  # 補充：定在空中
  
  Motion_Data[:"skill_156"][8] = {:"pic"=> 16, :"wait" => 35, :"next" => 9, :"anime" => [527, 1, 0, -320, 0]}   #月亮
  Motion_Data[:"skill_156"][9] = {:"pic"=> 16, :"wait" => 15, :"next" => 10, :"anime" => [424, 1, 0, -360, 0]}   #集氣
  Motion_Data[:"skill_156"][10] = {:"pic"=> 19, :"wait" => 12, :"next" => 11, :"y_speed" => -20, :"shake" => [10,5,14,0], :"anime" => [525, 1, 0, -110, 0], :"y_fixed" => false}   #垂直下刺
  Motion_Data[:"skill_156"][11] = {:"pic"=> 21, :"wait" => 3, :"next" => 12, :"shake" => [15,5,14,0], :"anime" => [523, 1, 0, 0, 1],  :"target_y_speed" => 20}   #地面亂舞
  Motion_Data[:"skill_156"][12] = {:"pic"=> 20, :"wait" => 3, :"next" => 13, :"shake" => [15,5,45,0]}   #地面亂舞2
  Motion_Data[:"skill_156"][13] = {:"pic"=> 21, :"wait" => 3, :"next" => 14}   #地面亂舞3
  Motion_Data[:"skill_156"][14] = {:"pic"=> 19, :"wait" => 3, :"next" => 15}   #地面亂舞4
  Motion_Data[:"skill_156"][15] = {:"pic"=> 21, :"wait" => 3, :"next" => 16}   #地面亂舞5
  Motion_Data[:"skill_156"][16] = {:"pic"=> 20, :"wait" => 3, :"next" => 17}   #地面亂舞6
  Motion_Data[:"skill_156"][17] = {:"pic"=> 21, :"wait" => 3, :"next" => 18}   #地面亂舞7
  Motion_Data[:"skill_156"][18] = {:"pic"=> 19, :"wait" => 3, :"next" => 19}   #地面亂舞8
  Motion_Data[:"skill_156"][19] = {:"pic"=> 21, :"wait" => 3, :"next" => 20}   #地面亂舞9
  Motion_Data[:"skill_156"][20] = {:"pic"=> 20, :"wait" => 3, :"next" => 21}   #地面亂舞10
  Motion_Data[:"skill_156"][21] = {:"pic"=> 21, :"wait" => 3, :"next" => 22}   #地面亂舞11
  Motion_Data[:"skill_156"][22] = {:"pic"=> 19, :"wait" => 3, :"next" => 23}   #地面亂舞12
  Motion_Data[:"skill_156"][23] = {:"pic"=> 21, :"wait" => 3, :"next" => 24}   #地面亂舞13
  Motion_Data[:"skill_156"][24] = {:"pic"=> 20, :"wait" => 3, :"next" => 25}   #地面亂舞14
  Motion_Data[:"skill_156"][25] = {:"pic"=> 19, :"wait" => 3, :"next" => 26}   #地面亂舞15
  Motion_Data[:"skill_156"][26] = {:"pic"=> 21, :"wait" => 10, :"next" => :"start_turnback"}   #地面亂舞16

  #-------------------------------------------------------------------------------
  # ○ 168：灰夜‧群狼舞爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_158"][0] = {:"pic"=> 16, :"wait" => 12, :"next" => 1, :"battler_wait" => 40, :"camera" => 0}
  Motion_Data[:"skill_158"][1] = {:"pic"=> 16, :"wait" => 1, :"next" => 2, :"x_speed" => -150}
  Motion_Data[:"skill_158"][2] = {:"pic"=> 16, :"wait" => 1, :"next" => 3, :"x_speed" => 0}
  Motion_Data[:"skill_158"][3] = {:"pic"=> 16, :"wait" => 19, :"next" => 4, :"x_speed" => 16, :"y_speed" => 25, :"bounce_speed" => 0}
  Motion_Data[:"skill_158"][4] = {:"pic"=> 17, :"wait" => 15, :"next" => 5, :"x_speed" => 25, :"shake" => [10,5,14,0]  , :"anime" => [528, 1, 78, -105, 1]}
  Motion_Data[:"skill_158"][5] = {:"pic"=> 18, :"wait" => 20, :"next" => :"start_turnback", :"x_speed" => 5}
  
   
  #-------------------------------------------------------------------------------
  # ○ 163：灰擊‧扭曲
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_163"][0] = {:"pic"=> 1, :"wait" => 25, :"next" => 1, :"transfer" => [0,0], :"battler_wait" => 25, :"camera" => 0}
  Motion_Data[:"skill_163"][1] = {:"pic"=> 16, :"wait" => 10, :"next" => 2, :"y_speed" => 25 , :"battler_wait" => 10}
  Motion_Data[:"skill_163"][2] = {:"pic"=> 18, :"wait" => 50, :"next" => :"start_turnback", :"x_speed" => 13, :"y_speed" =>-25, :"shake" => [10,5,14,0]  , :"anime" => [556, 1, 65, -150, 1]}

  
  #-------------------------------------------------------------------------------
  # ○ 166：白晝‧撕裂
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_166"][0] = {:"pic"=> 15, :"wait" => 9, :"next" => 1, :"battler_wait" => 25, :"transfer" => [0,0], :"camera" => 0}
  Motion_Data[:"skill_166"][1] = {:"pic"=> 15, :"wait" => 1, :"next" => 2, :"x_speed" => -150}
  Motion_Data[:"skill_166"][2] = {:"pic"=> 15, :"wait" => 1, :"next" => 3, :"x_speed" => 0}
  Motion_Data[:"skill_166"][3] = {:"pic"=> 16, :"wait" => 15, :"next" => 4, :"x_speed" => 15, :"y_speed" => 20, :"bounce_speed" => 0}
  Motion_Data[:"skill_166"][4] = {:"pic"=> 17, :"wait" => 10, :"next" => 5, :"x_speed" => 20, :"shake" => [10,5,14,0]  , :"anime" => [528, 1, 78, -105, 1]}
  Motion_Data[:"skill_166"][5] = {:"pic"=> 17, :"wait" => 20, :"next" => :"start_turnback", :"x_speed" => 5}

  #-------------------------------------------------------------------------------
  # ○ 167：白晝‧時間撕裂
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_167"][0] = {:"pic"=> 15, :"wait" => 25, :"next" => 1, :"transfer" => [0,0], :"battler_wait" => 25, :"camera" => 0}
  Motion_Data[:"skill_167"][1] = {:"pic"=> 14, :"wait" => 8, :"next" => 2}
  Motion_Data[:"skill_167"][2] = {:"pic"=> 15, :"wait" => 35, :"next" => :"start_turnback", :"x_speed" => 20, :"shake" => [10,5,14,0]  , :"anime" => [526, 1, 11, 0, 1]}
 
  #-------------------------------------------------------------------------------
  # ○ 181：銀魂。碎星鐵爪 
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_181"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"transfer" => [0,0]}
  Motion_Data[:"skill_181"][1] = {:"pic"=> 12, :"wait" => 15, :"next" => 2, :"x_speed" => 6 , :"anime" => [518, 1, 11, 0, 1]}
  Motion_Data[:"skill_181"][2] = {:"pic"=> 13, :"wait" => 15, :"next" => 3, :"x_speed" => 15, :"shake" => [10,5,14,0] , :"anime" => [519, 1, 5, 0, 1]}
  Motion_Data[:"skill_181"][3] = {:"pic"=> 14, :"wait" => 22, :"next" => 4, :"x_speed" => -5, :"turn"=>true, :"anime" => [424, 1, 0, 0, 0]}
  Motion_Data[:"skill_181"][4] = {:"pic"=> 17, :"wait" => 1, :"next" => 5, :"anime" => [303, 1, 100, 0, 0]}
  Motion_Data[:"skill_181"][5] = {:"pic"=> 17, :"wait" => 30, :"next" => :"start_turnback", :"x_speed" => 26, :"shake" => [20,8,14,0] , :"anime" => [520, 1, 5, 0, 1]}
 #-------------------------------------------------------------------------------
  Motion_Data[:"skill_187"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_187"][1] = {:"pic"=> 27, :"wait" => 70, :"next" => :"action_end"}
  Motion_Data[:"skill_188"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_188"][1] = {:"pic"=> 27, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 191：炎魂。烈焰爪  
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_191"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"transfer" => [0,0]}
  Motion_Data[:"skill_191"][1] = {:"pic"=> 12, :"wait" => 15, :"next" => 2, :"x_speed" => 6 , :"anime" => [507, 1, 15, 0, 1]}
  Motion_Data[:"skill_191"][2] = {:"pic"=> 13, :"wait" => 15, :"next" => 3, :"x_speed" => 15, :"shake" => [10,5,14,0] , :"anime" => [507, 0,35, 0, 1]}
  Motion_Data[:"skill_191"][3] = {:"pic"=> 14, :"wait" => 22, :"next" => 4, :"x_speed" => -5, :"turn"=>true, :"anime" => [424, 1, 0, 0, 0]}
  Motion_Data[:"skill_191"][4] = {:"pic"=> 17, :"wait" => 1, :"next" => 5, :"anime" => [535, 0, 100, 0, 1]}
  Motion_Data[:"skill_191"][5] = {:"pic"=> 17, :"wait" => 30, :"next" => :"start_turnback", :"x_speed" => 26, :"shake" => [20,8,14,0] , :"anime" => [507, 1, 55, 0, 1]}
   #-------------------------------------------------------------------------------
  # ○ 192：凍魂。寒冰爪 
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_192"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"transfer" => [0,0]}
  Motion_Data[:"skill_192"][1] = {:"pic"=> 12, :"wait" => 15, :"next" => 2, :"x_speed" => 6 , :"anime" => [508, 1, 15, 0, 1]}
  Motion_Data[:"skill_192"][2] = {:"pic"=> 13, :"wait" => 15, :"next" => 3, :"x_speed" => 15, :"shake" => [10,5,14,0] , :"anime" => [508, 0,35, 0, 1]}
  Motion_Data[:"skill_192"][3] = {:"pic"=> 14, :"wait" => 22, :"next" => 4, :"x_speed" => -5, :"turn"=>true, :"anime" => [424, 1, 0, 0, 0]}
  Motion_Data[:"skill_192"][4] = {:"pic"=> 17, :"wait" => 1, :"next" => 5, :"anime" => [534, 0, 100, 0, 1]}
  Motion_Data[:"skill_192"][5] = {:"pic"=> 17, :"wait" => 30, :"next" => :"start_turnback", :"x_speed" => 26, :"shake" => [20,8,14,0] , :"anime" => [508, 1, 55, 0, 1]}
    #-------------------------------------------------------------------------------
  # ○ 193：電魂。閃雷爪 
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_193"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"transfer" => [0,0]}
  Motion_Data[:"skill_193"][1] = {:"pic"=> 12, :"wait" => 15, :"next" => 2, :"x_speed" => 6 , :"anime" => [509, 1, 15, 0, 1]}
  Motion_Data[:"skill_193"][2] = {:"pic"=> 13, :"wait" => 15, :"next" => 3, :"x_speed" => 15, :"shake" => [10,5,14,0] , :"anime" => [509, 0,35, 0, 1]}
  Motion_Data[:"skill_193"][3] = {:"pic"=> 14, :"wait" => 22, :"next" => 4, :"x_speed" => -5, :"turn"=>true, :"anime" => [424, 1, 0, 0, 0]}
  Motion_Data[:"skill_193"][4] = {:"pic"=> 17, :"wait" => 1, :"next" => 5, :"anime" => [535, 0, 100, 0, 1]}
  Motion_Data[:"skill_193"][5] = {:"pic"=> 17, :"wait" => 30, :"next" => :"start_turnback", :"x_speed" => 26, :"shake" => [20,8,14,0] , :"anime" => [509, 1, 55, 0, 1]}
    #-------------------------------------------------------------------------------
  # ○ 194：地魂。裂石爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_194"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"transfer" => [0,0]}
  Motion_Data[:"skill_194"][1] = {:"pic"=> 12, :"wait" => 15, :"next" => 2, :"x_speed" => 6 , :"anime" => [511, 1, 15, 0, 1], :"anime" => [39, 1, 15, 0, 1]}
  Motion_Data[:"skill_194"][2] = {:"pic"=> 13, :"wait" => 15, :"next" => 3, :"x_speed" => 15, :"shake" => [10,5,14,0] , :"anime" => [511, 0,35, 0, 1], :"anime" => [39, 1, 15, 0, 1]}
  Motion_Data[:"skill_194"][3] = {:"pic"=> 14, :"wait" => 22, :"next" => 4, :"x_speed" => -5, :"turn"=>true, :"anime" => [424, 1, 0, 0, 0]}
  Motion_Data[:"skill_194"][4] = {:"pic"=> 17, :"wait" => 1, :"next" => 5, :"anime" => [40, 0, 100, 0, 1]}
  Motion_Data[:"skill_194"][5] = {:"pic"=> 17, :"wait" => 30, :"next" => :"start_turnback", :"x_speed" => 26, :"shake" => [20,8,14,0] , :"anime" => [511, 1, 55, 0, 1], :"anime" => [39, 1, 15, 0, 1]}
    #-------------------------------------------------------------------------------
  # ○ 195：水魂。浪潮爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_195"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"transfer" => [0,0]}
  Motion_Data[:"skill_195"][1] = {:"pic"=> 12, :"wait" => 15, :"next" => 2, :"x_speed" => 6 , :"anime" => [511, 1, 15, 0, 1], :"anime" => [36, 1, 15, 0, 1]}
  Motion_Data[:"skill_195"][2] = {:"pic"=> 13, :"wait" => 15, :"next" => 3, :"x_speed" => 15, :"shake" => [10,5,14,0] , :"anime" => [511, 0,35, 0, 1], :"anime" => [36, 1, 15, 0, 1]}
  Motion_Data[:"skill_195"][3] = {:"pic"=> 14, :"wait" => 22, :"next" => 4, :"x_speed" => -5, :"turn"=>true, :"anime" => [424, 1, 0, 0, 0]}
  Motion_Data[:"skill_195"][4] = {:"pic"=> 17, :"wait" => 1, :"next" => 5, :"anime" => [37, 0, 100, 0, 1]}
  Motion_Data[:"skill_195"][5] = {:"pic"=> 17, :"wait" => 30, :"next" => :"start_turnback", :"x_speed" => 26, :"shake" => [20,8,14,0] , :"anime" => [511, 1, 55, 0, 1], :"anime" => [36, 1, 15, 0, 1]}
    #-------------------------------------------------------------------------------
  # ○ 196：風魂。疾風爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_196"][0] = {:"pic"=> 11, :"wait" => 25, :"next" => 1, :"transfer" => [0,0]}
  Motion_Data[:"skill_196"][1] = {:"pic"=> 12, :"wait" => 15, :"next" => 2, :"x_speed" => 6 , :"anime" => [511, 1, 15, 0, 1], :"anime" => [42, 1, 15, 0, 1]}
  Motion_Data[:"skill_196"][2] = {:"pic"=> 13, :"wait" => 15, :"next" => 3, :"x_speed" => 15, :"shake" => [10,5,14,0] , :"anime" => [511, 0,35, 0, 1], :"anime" => [42, 1, 15, 0, 1]}
  Motion_Data[:"skill_196"][3] = {:"pic"=> 14, :"wait" => 22, :"next" => 4, :"x_speed" => -5, :"turn"=>true, :"anime" => [424, 1, 0, 0, 0]}
  Motion_Data[:"skill_196"][4] = {:"pic"=> 17, :"wait" => 1, :"next" => 5, :"anime" => [43, 0, 100, 0, 1]}
  Motion_Data[:"skill_196"][5] = {:"pic"=> 17, :"wait" => 30, :"next" => :"start_turnback", :"x_speed" => 26, :"shake" => [20,8,14,0] , :"anime" => [511, 1, 55, 0, 1], :"anime" => [42, 1, 15, 0, 1]}
     #-------------------------------------------------------------------------------
  # ○ 226：元素拳 火 冰 雷 土 水 風
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_226"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_226"][1] = {:"pic"=> 27, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_227"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_227"][1] = {:"pic"=> 27, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_228"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_228"][1] = {:"pic"=> 27, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_229"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_229"][1] = {:"pic"=> 27, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_230"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_230"][1] = {:"pic"=> 27, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_231"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_231"][1] = {:"pic"=> 27, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  #-------------------------------------------------------------------------------
  # ○ 201：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_201"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_201"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
    #-------------------------------------------------------------------------------
  # ○ 202：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_202"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_202"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
      #-------------------------------------------------------------------------------
  # ○ 203：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_203"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_203"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
      #-------------------------------------------------------------------------------
  # ○ 204：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_204"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_204"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 205：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_205"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_205"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 206：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_206"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_206"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 207：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_207"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_207"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 208：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_208"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_208"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 209：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_209"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_209"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 210：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_210"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_210"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 211：元素劍合技 
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_211"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_211"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 212：元素劍合技 
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_212"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_212"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
     #-------------------------------------------------------------------------------
  # ○ 215：時劍‧空破斬
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_215"][0] = {:"pic"=> 26, :"wait" => 15, :"next" => 1}
  Motion_Data[:"skill_215"][1] = {:"pic"=> 27, :"wait" => 125, :"next" => :"action_end"}
  Motion_Data[:"skill_186"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_186"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_185"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_185"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_184"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_184"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_183"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_183"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_290"][0] = {:"pic"=> 26, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_290"][1] = {:"pic"=> 27, :"wait" => 40, :"next" => :"action_end"}
  #--------------------------------------------------------------------------
  # ● 初始化個人專屬的模組參數
  #--------------------------------------------------------------------------
  def set_motion_data
    # 變暗
   @moon_dark = Tone.new(-255,-255,-255)
    # 變回正常亮度
   @moon_bright = $game_screen.tone.clone
    super
    # 取得自己的Motion_Data
    @motion_data = Motion_Data
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
  
    #-------------------------------------------------------------------------------
  # ○ 泛用：詠唱 起始
  #-------------------------------------------------------------------------------
  def start_spelling
    @action_name = :"spelling"
    @action_time = 0
    @frame_time = 0
    @frame_number = 0
    update_motion(0)
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 泛用：普攻起始
  #-------------------------------------------------------------------------------
  def weapon_basic_start
    super
    @battler.y_speed = @y_down * 5# - @y_down
  end
  #-------------------------------------------------------------------------------
  # ○ 泛用：普攻 處理
  #-------------------------------------------------------------------------------
  def weapon_basic
    
    # 切換 11 號圖片
    if @action_time == 1 
      change_picture(11)
    end
    
    # 切換12 號圖片
    if @action_time == 15
      change_picture(12)
    end
    
    # 接近目標
    if @frame_time < 10
      @battler.x_pos -= @turnback_x
      @battler.z_pos -= @turnback_z 
      change_picture(51)
    end
    # 移動完畢時，微調位置
    if @frame_time == 10
      @battler.x_pos = @battler.target[0].x_pos + @width/2 * (self.mirror ? -1 : 1)
      @battler.z_pos = @battler.target[0].z_pos + 1
    end
    
  #  if @frame_duration == 4
   #   @battler.target[0].x_speed = -5 * (self.mirror ? -1 : 1)
   # end
    
    
  end
  
   #-------------------------------------------------------------------------------
  # ○ 泛用：技能 起始
  #-------------------------------------------------------------------------------
  def skill_basic_start
    @action_name = :"skill_basic"
    @action_time = 0
    @frame_time = 0
    @frame_number = 0
  #  update_motion(0)
    @frame_duration = -1  # <= 不觸發update_motion
    @battler.action_flag = true
    
  
   # 使用方動畫時間
   @anime1_time = (@battler.anime1 == 0 ? 14 : $data_animations[@battler.anime1].frame_max * 2 - 5)
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

    # 變換圖片
    if @action_time == 1
      change_picture(26)
    end
    # 變換圖片
    if @action_time == @anime1_time
      change_picture(27)
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
      change_picture(1) # 恢復原始圖片
    end 
    
  end
  
  #--------------------------------------------------------------------------
  # ● 泛用：受傷 起始
  #--------------------------------------------------------------------------
  def start_damage(last_hit)
    super(last_hit)
    change_picture(1) # <= 變成受傷圖片
  end
  
  #--------------------------------------------------------------------------
  # ● 泛用：變為歸位圖
  #--------------------------------------------------------------------------
  def change_turnback_picture
    if @battler.x_pos - @battler.base_x > 0
      @battler.is_a?(Game_Actor) ? change_picture(51) : change_picture(52)
    else
      @battler.is_a?(Game_Actor) ? change_picture(52) : change_picture(51)
    end
  end
  #--------------------------------------------------------------------------
  # ● 泛用：變為著地圖
  #--------------------------------------------------------------------------
  def change_landing_picture
    super
    change_picture(53)
  end

  #-------------------------------------------------------------------------------
  # ○ 定期更新－－其他招
  #-------------------------------------------------------------------------------
    def skill_156
    if @action_time == 135
      $game_screen.start_tone_change(@moon_dark, 15)
    end
    if @action_time == 180
      $game_screen.start_tone_change(@moon_bright, 40)
    end
end
  
  #-------------------------------------------------------------------------------
  # ○ 定期更新－－其他招
  #-------------------------------------------------------------------------------
    def skill_154
    end
    #-------------------------------------------------------------------------------
  # ○ 定期更新－－群狼舞爪
  #-------------------------------------------------------------------------------
    def skill_158
   # 消失
    if @action_time <= 8
     self.opacity = 32 * (8 - @action_time)
   end
   if @action_time == 8
       @battler.x_pos = 200
       @battler.z_pos = 280
     end
     # 出現
      if (9...20) === @action_time
       self.opacity = 26 * (@action_time - 9)
    end
  end
  #--------------------------------------------------------------------------
  # ● 常時監視
  #--------------------------------------------------------------------------
  def respective_update
    
    # 戰鬥結束時取消詠唱
    if $scene.fin? and @action_name == :"spelling"
      @action_name = nil
      @action_time = 0
      @frame_time = 0
      @frame_number = 0
      change_picture(1) # 恢復原始圖片
    end
    
    $scene.test_windows[1].refresh(@battler.rtp)
    
  end
  
  #--------------------------------------------------------------------------
  # ● 詠唱中
  #--------------------------------------------------------------------------
  def spelling
    if @battler.rtp == 0
      action_end
    end
  end
  
end
