#==============================================================================
# ■ 靈界的偶像☆雪嵐醬
#------------------------------------------------------------------------------
# 　
#==============================================================================


class Char1 < Sprite_Battler
  #-------------------------------------------------------------------------------
  # ○ 宣告所有模組
  #-------------------------------------------------------------------------------
  Motion_Data = {
  :"spelling" => [],
  :"skill_181" => [],
  :"skill_141" => [],
  :"skill_142" => [],
      #純元素合技
    :"skill_22" => [],:"skill_23" => [],:"skill_26" => [],:"skill_27" => [],
    :"skill_133" => [],:"skill_134" => [],:"skill_137" => [],:"skill_138" => [],
    :"skill_41" => [],:"skill_42" => [],:"skill_45" => [],:"skill_46" => [],
    :"skill_61" => [],:"skill_62" => [],:"skill_65" => [],:"skill_66" => [],
    :"skill_71" => [],:"skill_72" => [],:"skill_75" => [],:"skill_76" => [],
    :"skill_81" => [],:"skill_82" => [],:"skill_85" => [],:"skill_86" => [],
    :"skill_91" => [],:"skill_92" => [],:"skill_95" => [],:"skill_96" => [],
    :"skill_146" => [],:"skill_147" => [],:"skill_150" => [],:"skill_151" => [],
    #音樂系列
    :"skill_223" => [],
    :"skill_224" => [],
    :"skill_225" => [],
    :"skill_288" => [],
    :"skill_290" => [],
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
          # 元素拳
    :"skill_226" => [],
    :"skill_227" => [],
    :"skill_228" => [],
    :"skill_229" => [],
    :"skill_230" => [],
    :"skill_231" => [],
        #專技合技
    :"skill_213" => [],
    :"skill_214" => [],
    :"skill_345" => [],
    :"skill_185" => [],
    :"skill_187" => [],
    :"skill_188" => [],
    :"skill_186" => [],
    :"skill_183" => [],
    :"skill_184" => [],
  }
  #-------------------------------------------------------------------------------
  # ○ 詠唱
  #-------------------------------------------------------------------------------
  Motion_Data[:"spelling"][0] = {:"pic"=> 7, :"wait" => 6, :"next" => 1}
  Motion_Data[:"spelling"][1] = {:"pic"=> 8, :"wait" => 6, :"next" => 2}
  Motion_Data[:"spelling"][2] = {:"pic"=> 9, :"wait" => 6, :"next" => 0}
  #-------------------------------------------------------------------------------
  # ○ 純元素系列
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_22"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_22"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_23"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_23"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_26"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_26"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_27"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_27"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_133"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_133"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_134"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_134"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_137"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_137"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_138"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_138"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_41"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_41"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_42"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_42"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_45"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_45"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_46"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_46"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_61"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_61"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_62"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_62"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_65"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_65"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_66"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_66"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_71"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_71"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_72"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_72"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_75"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_75"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_76"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_76"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_81"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_81"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_82"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_82"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_85"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_85"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_86"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_86"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_91"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_91"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_92"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_92"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_95"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_95"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_96"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_96"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_146"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_146"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_147"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_147"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_150"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_150"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  Motion_Data[:"skill_151"][0] = {:"pic"=> 10, :"wait" => 25, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_151"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○223：音樂系列
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_223"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_223"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  Motion_Data[:"skill_224"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_224"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  Motion_Data[:"skill_225"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_225"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  Motion_Data[:"skill_288"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_288"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  Motion_Data[:"skill_290"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_290"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
    #-------------------------------------------------------------------------------
   #-------------------------------------------------------------------------------
  # ○ 141：猛砸
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_141"][0] = {:"pic"=> 1, :"wait" => 25, :"next" => 1, :"transfer" => [0,0], :"battler_wait" => 25, :"camera" => 0}
  Motion_Data[:"skill_141"][1] = {:"pic"=> 15, :"wait" => 3, :"next" => 2, :"x_speed" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][2] = {:"pic"=> 16, :"wait" => 3, :"next" => 3, :"x_speed" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][3] = {:"pic"=> 15, :"wait" => 3, :"next" => 4, :"x_speed" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][4] = {:"pic"=> 16, :"wait" => 3, :"next" => 5, :"x_speed" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][5] = {:"pic"=> 15, :"wait" => 3, :"next" => 6, :"x_speed" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][6] = {:"pic"=> 16, :"wait" => 3, :"next" => 7, :"x_speed" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][7] = {:"pic"=> 15, :"wait" => 3, :"next" => 8, :"x_speed" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][8] = {:"pic"=> 16, :"wait" => 3, :"next" => 9, :"x_speed" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][9] = {:"pic"=> 15, :"wait" => 3, :"next" => 10, :"battler_wait" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][10] = {:"pic"=> 16, :"wait" => 3, :"next" => 11, :"battler_wait" => 2, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_141"][11] = {:"pic"=> 17, :"wait" => 20, :"next" => :"start_turnback"}
    #-------------------------------------------------------------------------------
  # ○ 142：靈屬性猛砸
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_142"][0] = {:"pic"=> 1, :"wait" => 30, :"next" => 1, :"transfer" => [50,0], :"battler_wait" => 30, :"camera" => 0}
  Motion_Data[:"skill_142"][1] = {:"pic"=> 15, :"wait" => 25, :"next" => 2, :"battler_wait" => 25, :"anime" => [561, 1, -10, 0, 0]}
  Motion_Data[:"skill_142"][2] = {:"pic"=> 15, :"wait" => 2, :"next" => 3, :"x_speed" => 4, :"shake" => [10,5,14,0] }
  Motion_Data[:"skill_142"][3] = {:"pic"=> 16, :"wait" => 7, :"next" => 4 }
  Motion_Data[:"skill_142"][4] = {:"pic"=> 17, :"wait" => 30, :"next" => :"start_turnback"}  
  #-------------------------------------------------------------------------------
  # ○ 181：灰魂。碎星鐵爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_181"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_181"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_187"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_187"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
  Motion_Data[:"skill_188"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_188"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
  #-------------------------------------------------------------------------------
  # ○ 226：元素拳 火 冰 雷 土 水 風
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_226"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_226"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_227"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_227"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_228"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_228"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_229"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_229"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_230"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_230"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_231"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_231"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  #-------------------------------------------------------------------------------
  # ○ 191：炎魂。烈焰爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_191"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_191"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
    #-------------------------------------------------------------------------------
  # ○ 192：凍魂。寒冰爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_192"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_192"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
 #-------------------------------------------------------------------------------
  # ○ 193：電魂。閃雷爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_193"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_193"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
   #-------------------------------------------------------------------------------
  # ○ 194：地魂。裂石爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_194"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_194"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
   #-------------------------------------------------------------------------------
  # ○ 195：水魂。浪潮爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_195"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_195"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
   #-------------------------------------------------------------------------------
  # ○ 196：風魂。疾風爪
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_196"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_196"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
    #-------------------------------------------------------------------------------
  # ○ 201：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_201"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_201"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end", :"camera" => 0}
    #-------------------------------------------------------------------------------
  # ○ 202：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_202"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 75}
  Motion_Data[:"skill_202"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
      #-------------------------------------------------------------------------------
  # ○ 203：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_203"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_203"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end", :"camera" => 0}
      #-------------------------------------------------------------------------------
  # ○ 204：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_204"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 75}
  Motion_Data[:"skill_204"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
      #-------------------------------------------------------------------------------
  # ○ 205：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_205"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_205"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end", :"camera" => 0}
    #-------------------------------------------------------------------------------
  # ○ 206：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_206"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 75}
  Motion_Data[:"skill_206"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
    #-------------------------------------------------------------------------------
  # ○ 207：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_207"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_207"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end", :"camera" => 0}
    #-------------------------------------------------------------------------------
  # ○ 208：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_208"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 75}
  Motion_Data[:"skill_208"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
  #-------------------------------------------------------------------------------
  # ○ 209：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_209"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_209"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end", :"camera" => 0}
  #-------------------------------------------------------------------------------
  # ○ 210：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_210"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 75}
  Motion_Data[:"skill_210"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
  #-------------------------------------------------------------------------------
  # ○ 211：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_211"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_211"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end", :"camera" => 0}
  #-------------------------------------------------------------------------------
  # ○ 212：元素劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_212"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 75}
  Motion_Data[:"skill_212"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
  #-------------------------------------------------------------------------------
  # ○ 213：靈劍合技
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_213"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_213"][1] = {:"pic"=> 11, :"wait" => 40, :"next" => :"action_end", :"camera" => 0}
  #-------------------------------------------------------------------------------
  # ○ 214：靈劍合技劍舞
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_214"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 75}
  Motion_Data[:"skill_214"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
  #-------------------------------------------------------------------------------
  # ○ 345：森林浴
  #-------------------------------------------------------------------------------
  Motion_Data[:"skill_345"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 75}
  Motion_Data[:"skill_345"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end", :"camera" => 0}
  Motion_Data[:"skill_186"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_186"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  Motion_Data[:"skill_185"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_185"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  Motion_Data[:"skill_183"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_183"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  Motion_Data[:"skill_184"][0] = {:"pic"=> 10, :"wait" => 15, :"next" => 1, :"battler_wait" => 25}
  Motion_Data[:"skill_184"][1] = {:"pic"=> 11, :"wait" => 70, :"next" => :"action_end"}
  
  #--------------------------------------------------------------------------
  # ● 初始化個人專屬的模組參數
  #--------------------------------------------------------------------------
  def set_motion_data
    # 自己專用變數：使用方動畫時間
    @anime1_time = 0
    # 自己專用變數：目標方動畫時間
    @anime2_time = 0
    # 自己專用變數：總共動畫時間
    @animeAll_time = 0
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
    
    # 切換 2 號圖片
    if @action_time == 10
      change_picture(15)
    end
    
    # 切換3 號圖片
    if @action_time == 15
      change_picture(16)
    end
    
     # 切換4 號圖片
    if @action_time == 20
      change_picture(17)
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
      change_picture(10)
    end
    # 變換圖片
    if @action_time == @anime1_time
      change_picture(11)
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
  # ● 泛用：受傷起始
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
