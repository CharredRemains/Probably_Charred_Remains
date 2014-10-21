
local siphon = { }
--[[ ToC
	Pet stuff
	Buff checks
	Debuff checks
	Mechanics checks
	Item checks
	]]
-- **** Pet func	
function siphon.petNotfighting(unit)
	if (UnitAffectingCombat("pet")) 
		then return false end
		return true 
end	

-- **** Buff checks **** @
function siphon.targNotfocus()
		if (UnitIsUnit("target", "focus")) then
		return false end
	return true
end

function siphon.flySerpentT(unit)
local _, _, flying1 = GetSpellInfo(101545)
local _, _, flying2 = GetSpellInfo(115057)
    return flying1 == flying2
  end


function siphon.fiveCrit(thresholdfc)
	local temp_buffsfc = {17007,1459,61316,116781,24604,90309,126373,126309}
	local timerfc = thresholdfc or 3
	for i=1,#temp_buffsfc do
		if UnitBuff("player",GetSpellInfo(temp_buffsfc[i])) then
			if select(7,UnitBuff("player",GetSpellInfo(temp_buffsfc[i]))) - GetTime() >= timerfc then return false end
		end
	end
	return true
end


function siphon.fiveMainstats(thresholdfms)
	local temp_buffsfms = {1126,115921,20217,90363,117666}
	local timerfms = 3
	for i=1,#temp_buffsfms do
		if UnitBuff("player",GetSpellInfo(temp_buffsfms[i])) then
			if select(7,UnitBuff("player",GetSpellInfo(temp_buffsfms[i]))) - GetTime() >= timerfms then return false end
		end
	end
	return true
end


function siphon.tenSpellpower(thresholdtsp)
	local temp_buffstsp = {1459,61316,77747,109773,126309}
	local timertsp = thresholdtsp or 3
	for i=1,#temp_buffstsp do
		if UnitBuff("player",GetSpellInfo(temp_buffstsp[i])) then
			if select(7,UnitBuff("player",GetSpellInfo(temp_buffstsp[i]))) - GetTime() >= timertsp then return false end
		end
	end
	return true
end


function siphon.tenStam(thresholdtenstam)
	local temp_buffstenstam = {21562,109773,469,90364}
	local timertenstam = 3
	for i=1,#temp_buffstenstam do
		if UnitBuff("player",GetSpellInfo(temp_buffstenstam[i])) then
			if select(7,UnitBuff("player",GetSpellInfo(temp_buffstenstam[i]))) - GetTime() >= 3 then return false end
		end
	end
	return true
end


function siphon.tempBuffs(threshold)
	local temp_buffs = {104509,104510,128985,33702,126577,126478,125487,136082,126605,126734,126476,138898,139133,138786,138703,104993,105702,148897,148906,146184,146046,137590,113858,114207,146218,138963,}
	local timerTB = 3
	for i=1,#temp_buffs do
		if UnitBuff("player",GetSpellInfo(temp_buffs[i])) then
			if select(7,UnitBuff("player",GetSpellInfo(temp_buffs[i]))) - GetTime() >= timerTB then return true end
		end
	end
	return false
end


function siphon.fiveMagicdam(threshold)
	local temp_fmd = {1490,34889,24844,93068}
	local timerfmd = 3
	for i=1,#temp_fmd do
		if UnitDebuff("target",GetSpellInfo(temp_fmd[i])) then
			if select(7,UnitDebuff("target",GetSpellInfo(temp_fmd[i]))) - GetTime() >= timerfmd then return false end
		end
	end
	return true
end


function siphon.garroshMC(unit)
        if UnitExists(unit) then
                if UnitDebuff(unit,GetSpellInfo(145832))
                        or UnitDebuff(unit,GetSpellInfo(145171))
                        or UnitDebuff(unit,GetSpellInfo(145065))
                        or UnitDebuff(unit,GetSpellInfo(145071))
                then return false else return true end
        else return false end
end


function siphon.interruptEvents(unit)
  if UnitBuff("player", 31821) then return true end -- Devo
  if not unit then unit = "boss1" end
  local spell = UnitCastingInfo(unit)
  local stop = false
  if spell == GetSpellInfo(138763) then stop = true end
  if spell == GetSpellInfo(137457) then stop = true end
  if spell == GetSpellInfo(143343) then stop = true end -- Thok
  if stop then
    if UnitCastingInfo("player") or UnitChannelInfo("player") then
      RunMacroText("/stopcasting")
      return false
    end
  end
  return true
end


function siphon.Boss(target)
  if UnitLevel("target") == -1 then 
    return true 
    end
  return false
end


function siphon.Doomguard(unit)
  if not (UnitBuff("player", 2825) or
			UnitBuff("player", 32182) or 
			UnitBuff("player", 80353) or
			UnitBuff("player", 90355)) then
		return false
	end
	if not ProbablyEngine.condition["modifier.cooldowns"] then return false end
	if UnitLevel(target) ~= -1 then return false end
	return true 
end


function siphon.Healthstone(target)
  if GetItemCount(5512, nil, true) == 3 then return false end
  return true
end


function siphon.dagCheck(weaptype)
local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(GetInventoryItemID("player", GetInventorySlotInfo("MainHandSlot")))
	local dCwt = weaptype or "Daggers"
 if sSubType == dCwt then return true else return false end
end

function siphon.debug(step)
  UIErrorsFrame:AddMessage(step, 1.0, 0.5, 0.0, 3)  
return true
end


function siphon.PlayerHasLust()
	if UnitBuff("player", "Rapid Fire")
	or UnitBuff("player", "Bloodlust")
	or UnitBuff("player", "Heroism")
	or UnitBuff("player", "Time Warp")
	or UnitBuff("player", "Ancient Hysteria")
	then 
		return true 
	else 
		return false
	end
end


function siphon.usePot(target)
   -- Check for hero/bloodlust/etc
   if not (UnitBuff("player", 2825) or
         UnitBuff("player", 32182) or
         UnitBuff("player", 80353) or
         UnitBuff("player", 90355)) then
      return false
   end
   -- 76089 = Virmen's Bite
   if GetItemCount(76089) < 1 then return false end
   if GetItemCooldown(76089) ~= 0 then return false end
   if not ProbablyEngine.condition["modifier.cooldowns"] then return false end
   return true
end

--bbLib origaly
function siphon.PlayerHasLust() 
	if UnitBuff("player", "Rapid Fire")
	or UnitBuff("player", "Bloodlust")
	or UnitBuff("player", "Heroism")
	or UnitBuff("player", "Time Warp")
	or UnitBuff("player", "Ancient Hysteria")
	then 
		return true 
	else 
		return false
	end
end

--bbLib origaly
function siphon.BGFlag()
	if GetBattlefieldStatus(1)=='active' 
	  or GetBattlefieldStatus(2)=='active' then
		InteractUnit('Horde flag')
		InteractUnit('Alliance flag')
	end
	return false
end
function siphon.Chase()
		InteractUnit("target")
	return true
end
function siphon.cdrCheck() --Thanks Mavmin

  local EB_START, EB_DURATION = GetSpellCooldown(117014) --Elemental Blast
  local EB_CD = EB_START + EB_DURATION - GetTime()
  local UE_START, UE_DURATION = GetSpellCooldown(73680)  --Unleash Elements
  local UE_CD = UE_START + UE_DURATION - GetTime()
  local FS_START, FS_DURATION = GetSpellCooldown(51533)  --Feral Spirits
  local FS_CD = FS_START + FS_DURATION - GetTime()
  local SS_START, SS_DURATION = GetSpellCooldown(77364)  --Stormstrike
  local SS_CD = SS_START + SS_DURATION - GetTime()
  local ES_START, ES_DURATION = GetSpellCooldown(8042)  --Earth Shock
  local ES_CD = ES_START + ES_DURATION - GetTime()
  local LL_START, LL_DURATION = GetSpellCooldown(60103)  --Lava Lash
  local LL_CD = LL_START + LL_DURATION - GetTime()
  local PS_START, PS_DURATION = GetSpellCooldown(73899)  --Primal Strike
  local PS_CD = PS_START + PS_DURATION - GetTime()
  local unit = "target"
  local ES_RC = IsSpellInRange("earth shock","target")
  
  if (IsPlayerSpell(117014) == true and IsSpellInRange("elemental blast","target") == 1 and EB_CD <= 2)
    or (IsPlayerSpell(73680) == true and IsSpellInRange("unleash elements","target") == 1 and UE_CD <= 2)
    or (IsPlayerSpell(51533) == true and IsSpellInRange("feral spirits","target") == 1 and FS_CD <= 2)
    or (IsPlayerSpell(77364) == true and IsSpellInRange("stormstrike","target") == 1 and SS_CD <= 2)
    or (IsPlayerSpell(8042) == true and IsSpellInRange("earth shock","target") == 1 and ES_CD <= 2) 
    or (IsPlayerSpell(60103) == true and IsSpellInRange("lava lash","target") == 1 and LL_CD <= 2)
    or (IsPlayerSpell(73899) == true and IsSpellInRange("primal strike","target") == 1 and PS_CD <= 2) then
      return false
  else
       return true
  end

end


ProbablyEngine.library.register("siphon", siphon)