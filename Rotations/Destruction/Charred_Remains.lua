
local lib = function()
	
---------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLES
---------------------------------------------------------------------------------------------------------------------------------------

	ProbablyEngine.toggle.create(
	'survival', 
	'Interface\\Icons\\achievement_pvp_o_h', 
	'PvP', 
	'Toggle the usage of Survival Abilities.')

---------------------------------------------------------------------------------------------------------------------------------------
-- LIB FUNCTION ENDS
---------------------------------------------------------------------------------------------------------------------------------------

end



local Buffs = {

---------------------------------------------------------------------------------------------------------------------------------------
-- BUFFING UP!
---------------------------------------------------------------------------------------------------------------------------------------

	{ '109773', '!player.buff(109773)' }, -- Dark Intent

---------------------------------------------------------------------------------------------------------------------------------------
-- BUFFING UP ENDS
---------------------------------------------------------------------------------------------------------------------------------------

}



local inCombat = {
---------------------------------------------------------------------------------------------------------------------------------------
-- IN-COMBAT INTERRUPTING --
---------------------------------------------------------------------------------------------------------------------------------------

-- Auto-Target --
  { '/targetenemy [noexists]', { 'toggle.autotarget', '!target.exists' }},
  { '/targetenemy [dead]', { 'toggle.autotarget', 'target.exists', 'target.dead' }},	

  
{{-- Interrupts --
  { '103135', { -- Felhunter: Spell Lock
	  'player.spell(103135).exists',
	  'target.interruptAt(50)',
	  '!target.immune.fear' }},
	  
	  
  { '5484', { -- Howl of Terror
	  'player.spell(5484).exists',
	  'target.range < 5',
	  '!target.immune.fear' }},
	  
	  
  { '6789', { -- Mortal Coil
	  'player.spell(6789).exists',
	  '!target.immune.fear' }},
}, 'modifier.interrupts' },	  

---------------------------------------------------------------------------------------------------------------------------------------
-- MY SURVIVAL -- Toggle.survival -- --------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------			
		
-- Healing In-Combat --
  {'#5512', 'player.health < 50'}, -- Healthstone

	  
  {'114635', { -- Ember Tap 2 or more Embers
	  'player.embers >= 20',
	  'player.health < 85' }},
	
{ -- I Must Live! --
  {
	  { '108416', 'player.health <= 30' }, -- Sacrificial Pact
	  { '#5512', 'player.health <= 45'}, -- Healthstone
	  { '104773', 'player.health <= 50' }, -- Unending Resolve
}, 'toggle.survival' },	

---------------------------------------------------------------------------------------------------------------------------------------
-- PVP / RACIAL ABILITIES --
---------------------------------------------------------------------------------------------------------------------------------------	
	
{  -- Human Racial
	{
  { 'Every Man for Himself', 'player.state.charm' },											-- Free From Charm
  { 'Every Man for Himself', 'player.state.disorient' },										-- Free From Disorient
  { 'Every Man for Himself', 'player.state.fear' },												-- Free From Fear
  { 'Every Man for Himself', 'player.state.incapacitate' },										-- Free From Incapacitate
  { 'Every Man for Himself', 'player.state.misc' },												-- Free From Misc
  { 'Every Man for Himself', 'player.state.root' },												-- Free From Root
  { 'Every Man for Himself', 'player.state.sleep' },											-- Free From Sleep
  { 'Every Man for Himself', 'player.state.snare' },											-- Free From Snare
  { 'Every Man for Himself', 'player.state.stun' },												-- Free From Stun
},{ 'toggle.survival' }},

---------------------------------------------------------------------------------------------------------------------------------------
-- MODIFIER KEYS - PET KEYS
---------------------------------------------------------------------------------------------------------------------------------------

-- Modified Keys
  { '104232', 'modifier.lshift', 'ground' }, -- Rain of Fire
  { '80240', 'modifier.lalt', 'mouseover'}, -- Mouseover Havoc
  { '30283', 'modifier.lcontrol', 'ground'}, -- Shadowfury
  
-- Havoc on Focus 
  { '80240', { -- Havoc on Focus
	  'focus.alive',
	  'focus.enemy',
	  'focus.spell(80240).range',
	  '@siphon.targNotfocus'	
	}, 'focus' },
	
-- Revive Pet QUICK! --
	{ '120451', { 'pet.dead', 'player.embers >= 10' }}, -- Flames of Xoroth
	--{ '17767', 'pet.health < 35' },
	
---------------------------------------------------------------------------------------------------------------------------------------
-- MULTI-TARGET ROTATION
---------------------------------------------------------------------------------------------------------------------------------------	

	{ '!/cancelaura Fire and Brimstone', { '!modifier.multitarget', 'player.buff(108683)' }},
	{ '108683', {'modifier.multitarget','player.embers >= 10'}},
  
	{ '!/cast immolate', {
		'player.buff(108683)',
		'!player.moving',
		'!modifier.last(Immolate) > 2', 
		'player.embers > 20',
		'target.debuff(Immolate).duration <= 5',
		'@cutie.interrupts("target")',
		'modifier.multitarget' }},
  
	{ '!/cast conflagrate', {
		'player.buff(108683)',
		'player.embers >= 15',
		'player.spell(Conflagrate).charges >= 1',
		'modifier.multitarget' }},

	{ '!/cast incinerate', { -- Incinerate
		'player.buff(108683)',
		'player.embers >= 10',
		'@cutie.interrupts("target")',
		'modifier.multitarget' }},
 
	{ '29722', { -- Incinerate
		'!player.buff(108683)',
		'player.embers < 10',
		'@cutie.interrupts("target")',
		'modifier.multitarget' }},

---------------------------------------------------------------------------------------------------------------------------------------
-- SINGLE TARGET ROTATION
---------------------------------------------------------------------------------------------------------------------------------------
	


	{ '348', { 'target.debuff(157736).duration <= 4', '!modifier.last' }}, --Immolate


	-- Burn Them Down!
	{ 'Chaos Bolt', { '!modifier.multitarget','player.buff(Havoc).count >= 3','!player.moving','!modifier.last(Chaos Bolt)', 'player.embers >= 10','@cutie.interrupts("target")'}},
	{ 'Chaos Bolt', { '!modifier.multitarget','!player.moving','!modifier.last(Chaos Bolt)','@cutie.interrupts("target")','player.embers >= 32'}},
	{ 'Chaos Bolt', { '!modifier.multitarget','!player.moving','!modifier.last(Chaos Bolt)', 'player.buff(Skull Banner).duration > 2.7','@cutie.interrupts("target")','target.health >= 20'}},
	{ 'Chaos Bolt', { '!modifier.multitarget','!player.moving','!modifier.last(Chaos Bolt)', 'player.buff(Dark Soul: Instability).duration > 2.7','@cutie.interrupts("target")','target.health >= 20'}},
	{ 'Chaos Bolt', { '!modifier.multitarget','!player.moving','!modifier.last(Chaos Bolt)', 'player.buff(Extravagant Visions).duration > 2.7','@cutie.interrupts("target")','target.health >= 20'}},
	{ 'Chaos Bolt', { '!modifier.multitarget','!player.moving','!modifier.last(Chaos Bolt)', 'player.buff(Expanded Mind).duration > 2.7','@cutie.interrupts("target")','target.health >= 20'}},

	-- End Them All!
	{ '!Shadowburn', { 'player.buff(Dark Soul: Instability).duration > 2.7', 'target.health <= 20', 'player.moving','!modifier.multitarget' }},
	{ '!Shadowburn', { 'player.embers >= 32', 'player.moving','target.health <= 20', '!modifier.multitarget' }},
	{ '!Shadowburn', { 'player.buff(Havoc).count >= 1', 'target.health <= 20', '!modifier.multitarget' }},
	{ '!Shadowburn', { 'player.buff(Skull Banner).duration > 2.7', 'player.moving','target.health <= 20', '!modifier.multitarget' }},
	{ '!Shadowburn', { 'target.deathin < 20', 'target.health <= 20', '!modifier.multitarget' }},
	{ '!Shadowburn', { 'player.buff(Extravagant Visions).duration > 2.7', 'player.moving','target.health <= 20', '!modifier.multitarget' }},
	{ '!Shadowburn', { 'player.buff(Expanded Mind).duration > 2.7', 'player.moving','target.health <= 20', '!modifier.multitarget' }},
	

		
	{ '!/cast [@mouseover] shadowburn', { -- Mouseover Shadowburn
		'player.embers >= 10',
		'mouseover.alive',
		'mouseover.enemy',
		'mouseover.spell(shadowburn).range',
		'mouseover.deathin < 5',
		(function()
			if UnitIsUnit("target", 'mouseover') ~= 1 then
			return true end
		end)
	}, 'mouseover' },
	
	
	-- Build Those Embers!
	{ 'conflagrate', 'player.spell(Conflagrate).charges >= 1' }, -- Conflagrate
	{ '29722', 'player.buff(108563)' },	-- Incinerate with Proc
	{ '29722' }, -- Incinerate (filler)

---------------------------------------------------------------------------------------------------------------------------------------
-- IN-COMBAT ENDS
---------------------------------------------------------------------------------------------------------------------------------------
  
} 



local outCombat = {

---------------------------------------------------------------------------------------------------------------------------------------
-- OUT-OF-COMBAT
---------------------------------------------------------------------------------------------------------------------------------------

	-- Modifier Keys
	{ '30283', 'modifier.lcontrol', 'ground'}, -- Shadowfury

	-- Summon Healthstone
	{ '6201', { '@siphon.Healthstone', '!modifier.last' }}, 
	
	-- Unending Breath Swimming --
	{'5697', { 'player.swimming', '!modifier.last' }},
	
---------------------------------------------------------------------------------------------------------------------------------------
-- OUT-OF-COMBAT ENDS
---------------------------------------------------------------------------------------------------------------------------------------

}


for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end


ProbablyEngine.rotation.register_custom(267, ' |cff9966ffCharred Remains|r ', inCombat, outCombat, lib)