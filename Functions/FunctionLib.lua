-----------------------------------------------------------------------------------------------------------------------------
-- Initialize Tables -------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
local cutie = {} 

cutie.queueSpell = nil
cutie.queueTime = 0
-----------------------------------------------------------------------------------------------------------------------------
-- Notify Frame -- (c)xrn overlay for pqr -----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
    local function onUpdate(self,elapsed) 
      if self.time < GetTime() - 2.5 then
        if self:GetAlpha() == 0 then self:Hide() else self:SetAlpha(self:GetAlpha() - .05) end
      end
    end
    ecn = CreateFrame("Frame",nil,ChatFrame1) 
    ecn:SetSize(ChatFrame1:GetWidth(),30)
    ecn:Hide()
    ecn:SetScript("OnUpdate",onUpdate)
    ecn:SetPoint("TOPLEFT",0,150)
    ecn.text = ecn:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
    ecn.text:SetAllPoints()
    ecn.texture = ecn:CreateTexture()
    ecn.texture:SetAllPoints()
    ecn.texture:SetTexture(0,0,0,.50) 
    ecn.time = 0
    function ecn:message(message) 
      self.text:SetText(message)
      self:SetAlpha(1)
      self.time = GetTime() 
      self:Show() 
    end
    
    local function onUpdate(self,elapsed) 
      if self.time < GetTime() - 2.8 then
        if self:GetAlpha() == 0 then self:Hide() else self:SetAlpha(self:GetAlpha() - .05) end
      end
    end
    ecn = CreateFrame("Frame",nil,ChatFrame1) 
    ecn:SetSize(ChatFrame1:GetWidth(),30)
    ecn:Hide()
    ecn:SetScript("OnUpdate",onUpdate)
    ecn:SetPoint("TOP",0,0)
    ecn.text = ecn:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
    ecn.text:SetAllPoints()
    ecn.texture = ecn:CreateTexture()
    ecn.texture:SetAllPoints()
    ecn.texture:SetTexture(0,0,0,.50) 
    ecn.time = 0
    function ecn:message(message) 
      self.text:SetText(message)
      self:SetAlpha(1)
      self.time = GetTime() 
      self:Show() 
    end
-----------------------------------------------------------------------------------------------------------------------------
-- Macros ------------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
if macros == nil then
  -- Macros
  macros = { 
      ["SingleTarget"]      = 1, 
      ["UseCds"]      = 1, 
      ["AoE"]         = 1,
  } 
end

ProbablyEngine.command.register('cutie', function(msg, box)
  local command, text = msg:match("^(%S*)%s*(.-)$")
-- Toggle -------------------------------------------------------------------------------------------------------------------
  if command == 'toggle' then
    if ProbablyEngine.config.read('button_states', 'MasterToggle', false) then
        ProbablyEngine.buttons.toggle('MasterToggle')
        --ProbablyEngine.buttons.buttons['MasterToggle']:Click()
        ecn:message("|cFFB30000Rotation off")
    else
        ProbablyEngine.buttons.toggle('MasterToggle')
        --ProbablyEngine.buttons.buttons['MasterToggle']:Click()
        ecn:message("|cFF00B34ARotation on")
    end
  end
  if command == 'kick' then
    if ProbablyEngine.config.read('button_states', 'interrupt', false) then
      ProbablyEngine.buttons.toggle('interrupt')
      --ProbablyEngine.buttons.buttons['interrupt']:Click()
      ecn:message("|cFFB30000Interrupts off")
    else
      ProbablyEngine.buttons.toggle('interrupt')
      --ProbablyEngine.buttons.buttons['interrupt']:Click()
      ecn:message("|cFF00B34AInterrupts on")
    end
  end

  if command == 'cds' then
    if ProbablyEngine.config.read('button_states', 'cooldowns', false) then
      ProbablyEngine.buttons.toggle('cooldowns')
      --ProbablyEngine.buttons.buttons['cooldowns']:Click()
      ecn:message("|cFFB30000Offensive Cooldowns off")
    else
      ProbablyEngine.buttons.toggle('cooldowns')
      --ProbablyEngine.buttons.buttons['cooldowns']:Click()
      ecn:message("|cFF00B34AOffensive Cooldowns on")
    end
  end

  if command == 'aoe' then
    if ProbablyEngine.config.read('button_states', 'multitarget', false) then
      ProbablyEngine.buttons.toggle('multitarget')
      --ProbablyEngine.buttons.buttons['multitarget']:Click()
      ecn:message("|cFFB30000AoE off")
    else
      ProbablyEngine.buttons.toggle('multitarget')
      --ProbablyEngine.buttons.buttons['multitarget']:Click()
      ecn:message("|cFF00B34AAoE on")
    end
  end
  
  if command == 'autobanner' then
    if ProbablyEngine.config.read('button_states', 'autobanner', false) then
      ProbablyEngine.buttons.toggle('autobanner')
      --ProbablyEngine.buttons.buttons['autobanner']:Click()
      ecn:message("|cFFB30000Auto Skull Banner off")
    else
      ProbablyEngine.buttons.toggle('autobanner')
      --ProbablyEngine.buttons.buttons['autobanner']:Click()
      ecn:message("|cFF00B34AAuto Skull Banner on")
    end
  end

  if command == 'def' then
    if ProbablyEngine.config.read('button_states', 'def', false) then
      ProbablyEngine.buttons.toggle('def')
      --ProbablyEngine.buttons.buttons['def']:Click()
      ecn:message("|cFFB30000Defensive Cooldowns off")
    else
      ProbablyEngine.buttons.toggle('def')
      --ProbablyEngine.buttons.buttons['def']:Click()
      ecn:message("|cFF00B34ADefensive Cooldowns on")
    end
  end

  if command == 'macros' then
    cutie.createAllMacros()
  end

  if command == 'help' then
    cutie.macroHelp()
  end

  if command == "tarplus" then
    if macros["SingleTarget"] == 1 then
      macros["SingleTarget"] = 2
      ecn:message("Two Targets")
    elseif macros["SingleTarget"] == 2 then
      macros["SingleTarget"] = 3
      ecn:message("Three Targets")
    else 
      macros["SingleTarget"] = 1
      ecn:message("Single Target")
    end
  end

  if command == "tarminus" then
    if macros["SingleTarget"] == 3 then
      macros["SingleTarget"] = 2
      ecn:message("Two Targets")
    elseif macros["SingleTarget"] == 2 then
      macros["SingleTarget"] = 1
      ecn:message("Single Target")
    else 
      macros["SingleTarget"] = 3
      ecn:message("Three Targets")
    end
  end

-- Spell Queue -- thank you merq for basic code -----------------------------------------------------------------------------
  if command == "qSkullb" or command == 114207 then
    cutie.queueSpell = 114207
    ecn:message("Skull Banner queued")
  elseif command == "qShieldWall" or command == 871 then
    cutie.queueSpell = 871
    ecn:message("Shield Wall queued")
  elseif command == "qDiebtSw" or command == 118038 then
    cutie.queueSpell = 118038
    ecn:message("Die by the Sword queued")
  elseif command == "qDemob" or command == 114203 then
    cutie.queueSpell = 114203
    ecn:message("Demoralizing Banner queued")
  elseif command == "qRally" or command == 97462 then
    cutie.queueSpell = 97462
    ecn:message("Rallying Cry queued")
  elseif command == "qTfour" then
    if select(2,GetTalentRowSelectionInfo(4)) == 10 then
        cutie.queueSpell = 46924
        ecn:message("Bladestorm queued") 
    elseif select(2,GetTalentRowSelectionInfo(4)) == 11 then
        cutie.queueSpell = 46968
        ecn:message("Shockwave queued") 
    elseif select(2,GetTalentRowSelectionInfo(4)) == 12 then
        cutie.queueSpell = 118000
        ecn:message("Dragon Roar queued") 
    end
  elseif command == "qTfive" then
    if select(2,GetTalentRowSelectionInfo(5)) == 13 then
        cutie.queueSpell = 114028
        ecn:message("Mass Spell Reflection queued") 
    elseif select(2,GetTalentRowSelectionInfo(5)) == 14 then
        cutie.queueSpell = 114029
        ecn:message("Safeguard queued")
    elseif select(2,GetTalentRowSelectionInfo(5)) == 15 then
        cutie.queueSpell = 114030
        ecn:message("Vigilance queued")  
    end
  else
    cutie.queueSpell = nil
  end
  if cutie.queueSpell ~= nil then cutie.queueTime = GetTime() end
end)
-----------------------------------------------------------------------------------------------------------------------------
-- NumTargets - (c) Replikatoren -------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
singletargetrota = nil
function cutie.singletargetrota()
  if macros["SingleTarget"] == 1 then
    return true
  else return false
  end
end

twotargetrota = nil
function cutie.twotargetrota()
  if macros["SingleTarget"] == 2 then
    return true
  else return false
  end
end

threetargetrota = nil
function cutie.threetargetrota()
  if macros["SingleTarget"] == 3 then
    return true
  else return false
  end
end
-----------------------------------------------------------------------------------------------------------------------------
-- Spell Queue Check -- thank you merq for basic code ----------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
cutie.checkQueue = function (spellId)
    if (GetTime() - cutie.queueTime) > 4 then
        cutie.queueTime = 0
        cutie.queueSpell = nil
    return false
    else
    if cutie.queueSpell then
        if cutie.queueSpell == spellId then
            if ProbablyEngine.parser.lastCast == GetSpellName(spellId) then
                cutie.queueSpell = nil
                cutie.queueTime = 0
            end
        return true
        end
    end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------
-- Create All Macros -------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
function cutie.createAllMacros( ... )
  local usedslots = select(2,GetNumMacros())
  if usedslots <= 3 then
    CreateMacro("toggle", "Inv_sword_01", "/cutie toggle", 1, 1)
    CreateMacro("kick", "inv_gauntlets_04", "#showtooltip Pummel\n/cutie kick", 1, 1)
    CreateMacro("cds", "ability_criticalstrike", "/cutie cds", 1, 1)
    CreateMacro("autobanner", "inv_banner_03", "/cutie autobanner", 1, 1)
    CreateMacro("def", "Inv_shield_08", "/cutie def", 1, 1)
    CreateMacro("qSkullb", "warrior_skullbanner", "#showtooltip Skull Banner\n/cutie qSkullb", 1, 1)
    CreateMacro("qShieldWall", "ability_warrior_shieldwall", "#showtooltip Shield Wall\n/cutie qShieldWall", 1, 1)
    CreateMacro("qDiebtSw", "ability_warrior_challange", "#showtooltip Die by the Sword\n/cutie qDiebtSw", 1, 1)
    CreateMacro("qDemob", "demoralizing_banner", "#showtooltip Demoralizing Banner\n/cutie qDemob", 1, 1)
    CreateMacro("qRally", "ability_toughness", "#showtooltip Rallying Cry\n/cutie qRally", 1, 1)
    CreateMacro("qTfour", "ability_parry", "/cutie qTfour", 1, 1)
    CreateMacro("qTfive", "ability_parry", "/cutie qTfive", 1, 1)
    CreateMacro("plus", "spell_chargepositive", "/cutie tarplus", 1, 1)
    CreateMacro("minus", "spell_chargenegative", "/cutie tarminus", 1, 1)
    CreateMacro("aoe", "Ability_warlock_jinx", "/cutie aoe", 1, 1)
  else
    print("You don't have enough free Macroslots")
  end
end  
-----------------------------------------------------------------------------------------------------------------------------
-- Create Help Message ------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
function cutie.macroHelp( ... )
  print("|cFFC79C6EExecutie |rv1.2")
  print("|cFFC79C6ECommands:|r\n/cutie macros - Create all Toggle / Spellqueue Macros")
  print("|cFFC79C6EToggle Macros:|r\n/cutie toggle - Rotation on/off\n/cutie kick - Interrupt & Disarm on/off\n/cutie cds - Offensive Cooldowns on/off\n/cutie aoe - Multitarget-Rotation on/off (4+ for Fury)\n/cutie autobanner - Auto Skull Banner on/off\n/cutie def - Auto Defensive Cooldowns on/off\n/cutie tarplus - Increase Targets(Fury only)\n/cutie tarminus - Decrease Targets (Fury only)")
  print("|cFFC79C6EQueue Macros:|r\n/cutie qSkullb | qShieldWall | qDiebtSw | qDemob | qTfour | qTfive | qRally")
  print("|cFFC79C6EAdditional Help:|r\nhttp://tinyurl.com/pe-executie")
end  
-----------------------------------------------------------------------------------------------------------------------------
-- Healthstone -------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
function cutie.Healthstone(...)
    local PlayerHP = 100 * UnitHealth("player") / UnitHealthMax("player")
    if PlayerHP < 40
    and GetItemCount(5512,false,false) > 0 
    and ( select(2, GetItemCooldown(5512)) == 0 ) then
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------
-- Interrupt -------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
function UnitBuffID(unit, spell, filter)
	if not unit or unit == nil or not UnitExists(unit) then return false end
	if spell then spell = GetSpellInfo(spell) else return false end
	
	if filter then return UnitBuff(unit, spell, nil, filter) else return UnitBuff(unit, spell) end
end
function UnitDebuffID(unit, spell, filter)
	if not unit or unit == nil or not UnitExists(unit) then return false end
	if spell then spell = GetSpellInfo(spell) else return false end
	
	if filter then return UnitDebuff(unit, spell, nil, filter) else return UnitDebuff(unit, spell) end
end

function cutie.interrupts(unit)
	if not unit then return false end
	if UnitCastingInfo(unit) and
		(UnitCastingInfo(unit) == GetSpellInfo(143343) or UnitCastingInfo(unit) == GetSpellInfo(138763) or UnitCastingInfo(unit) == GetSpellInfo(137457)) then
			if UnitCastingInfo("player") or UnitChannelInfo("player") then
				if not UnitBuffID("player",31821) or not UnitBuffID("player",64364) then
					RunMacroText("/stopcasting") return false
				end
			end
			return false
	else return true end
end

function cutie.spellcdcheck(spell)
if select(2, GetSpellCooldown(spell)) == 0 
or ( ( GetSpellCooldown(spell) + select(2, GetSpellCooldown(spell)) - GetTime() ) < 0.5 ) then
return true
end
return false
end
-----------------------------------------------------------------------------------------------------------------------------
-- CD Reduction Evil Eye Trinket -------------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------------------------------------------- 
function cutie.EvilEye()
  if CD_Trinket == nil then
  
    if (GetInventoryItemID("player", 13) == 105491
      or GetInventoryItemID("player", 14) == 105491) then -- heroic warforged 47%
        CD_Trinket_V = (1 / 1.47)
        CD_Trinket = true
        
    elseif (GetInventoryItemID("player", 13) == 104495 -- heroic 44%
      or GetInventoryItemID("player", 14) == 104495) then
        CD_Trinket_V = (1 / 1.44)
        CD_Trinket = true
      
    elseif (GetInventoryItemID("player", 13) == 105242 -- warforged 41%
      or GetInventoryItemID("player", 14) == 105242) then
        CD_Trinket_V = (1 / 1.41)
        CD_Trinket = true
    
    elseif (GetInventoryItemID("player", 13) == 102298  -- normal 39%
      or GetInventoryItemID("player", 14) == 102298) then
        CD_Trinket_V = (1 / 1.39)
        CD_Trinket = true
    
    elseif (GetInventoryItemID("player", 13) == 104744 -- flex 34%
      or GetInventoryItemID("player", 14) == 104744) then
        CD_Trinket_V = (1 / 1.34)
        CD_Trinket = true
    
    elseif (GetInventoryItemID("player", 13) == 104993  -- lfr 31%
      or GetInventoryItemID("player", 14) == 104744) then
        CD_Trinket_V = (1 / 1.31)
        CD_Trinket = true
    end
  
    if CD_Trinket ~= true then
      CD_Trinket = false
      CD_Trinket_V = 1
    end
  end
end
-----------------------------------------------------------------------------------------------------------------------------
-- Time to Die - (c) Mavmins ------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------
function cutie.TimeToDie()
  if UnitExists("Target") then
    if (guid ~= UnitGUID("target")) or (guid == UnitGUID("target") and UnitHealth("target") == _firstLifeMax) then
        guid = UnitGUID("target")
        _firstLife = UnitHealth("target")
        _firstLifeMax = UnitHealthMax("target")
        _firstTime = GetTime()
    end             
        
    _currentLife = UnitHealth("target")
    _currentTime = GetTime()
    timeDiff = _currentTime - _firstTime
    hpDiff = _firstLife - _currentLife
      
    if hpDiff > 0 then
        fullTime = timeDiff*_firstLifeMax/hpDiff
        pastFirstTime = (_firstLifeMax - _firstLife)*timeDiff/hpDiff
        calcTime = _firstTime - pastFirstTime + fullTime - _currentTime
        if calcTime < 1 then
            calcTime = 1
        end
        ttd = calcTime
    end
              
    if hpDiff <= 0 then
        guid = UnitGUID("target")
        _firstLife = UnitHealth("target")
        _firstLifeMax = UnitHealth("target")
        _firstTime = GetTime()
    end
              
    -- Dummy
    if UnitHealthMax("target") == 1 then
        ttd = 99
    end
      
    -- If a new add is below a certain HP you dont want to cast Dots on it: Need to change to reflect your raids DPS            
    if UnitHealthMax("target") <= 1500000 then
        ttd = 1
    end
              
    if not ttd then
        ttd = 1
    end
  end
end
-----------------------------------------------------------------------------------------------------------------------------
-- Register Library --------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
ProbablyEngine.library.register("cutie", cutie)