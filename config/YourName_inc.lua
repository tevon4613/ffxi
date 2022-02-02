-- ------------------------------------------
--	Modes and Hotkeys
-- ------------------------------------------
--	status
--		Reports current modes and re-equips current idle or engaged set
--		hotkey: [Ctrl]+[/]
--	dd_state
--		Controls acc/macc vs. atk/mab
-- 		default: balanced (|| accuracy || potency)
--		hotkeys:
--			balanced	[Alt]+[Backspace]
--			potency		[Alt]+[-]
--			accuracy	[Alt]+[=]
--	dt_state
--		Controls overall Damage Taken
--		default: balanced (|| invincible || squishy)
--		hotkeys:
--			balanced	[Ctrl]+[Backspace]
--			squishy		[Ctrl]+[-]
--			invincible	[Ctrl]+[=]
--	dt_type
--		Cycles through Damage Taken type
--		default: balanced (||-> magic ||-> physical)
--		hotkey:	[Ctrl]+[.]
--	engage_mode
--		Controls TP preservation and blinking
--		default: caster (|| melee)
--		hotkey: [Ctrl]+[Del]
--	nuke_mode
--		Controls raw nuke versus magic bursting
--		default: raw (|| burst)
--		hotkey: [Ctrl]+[n]

windower.raw_register_event('zone change',function()
	windower.send_command('@wait 9; input //gs equip idle') end
)

function startup(jobnum, blinking, defaultmode)
	-- set macro book, page, and lockstyle on load
	if blinking then
		startupcommand = '@input //gs enable all'..
			';wait 1;input /macro book '..tostring(jobnum)..
			';wait 1;input /macro set 1'..
			';wait 4;input /lockstyleset '..tostring(jobnum)..
			';wait 2;input //dressup blinking all always on'
	else
		startupcommand = '@input //gs enable all'..
		';input //dressup blinking all all off'..
		';wait 1;input /macro book '..tostring(jobnum)..
		';wait 1;input /macro set 1'..
		';wait 4;input /lockstyleset '..tostring(jobnum)
	end
	send_command(startupcommand)

	-- bind state-switching hotkeys (^=ctl, !=alt)
	send_command('bind !- gs c ddbias accuracy')
	send_command('bind != gs c ddbias potency')
	send_command('bind !backspace gs c ddbias balanced')
	send_command('bind ^- gs c dtbias squishy')
	send_command('bind ^= gs c dtbias invincible')
	send_command('bind ^backspace gs c dtbias balanced')
	send_command('bind ^. gs c dttype advance')
	send_command('bind ^/ gs c status')
	send_command('bind ^delete gs c engage toggle')
	send_command('bind ^n gs c nuke toggle')

	-- set global states
	_G.dd_state = "balanced"
	_G.dt_state = "balanced"
	_G.dt_type = "balanced"
	_G.nuke_mode = "raw"
	if defaultmode == "melee" then
		_G.engage_mode = "melee"
	else
		_G.engage_mode = "caster"
	end

	-- create empty lists for sets that will have members
	_G.sets.pre = {}
	_G.sets.mid = {}
end

-- unbind hotkeys from get_sets() on unload
function file_unload()
	send_command('@input //dressup blinking all all off')
	send_command('unbind !-')
	send_command('unbind !=')
	send_command('unbind !backspace')
	send_command('unbind ^-')
	send_command('unbind ^=')
	send_command('unbind ^backspace')
	send_command('unbind ^/')
	send_command('unbind ^.')
	send_command('unbind ^delete')
	send_command('unbind ^n')
end

function self_command(cmd)
	-- handle keybound state changes
	if cmd == 'nuke toggle' then
		if _G.nuke_mode == "raw" then
			_G.nuke_mode = "burst"
		else
			_G.nuke_mode = "raw"
		end
	elseif cmd == 'ddbias potency' then
		_G.dd_state = "potency"
	elseif cmd == 'ddbias accuracy' then
		_G.dd_state = "accuracy"
	elseif cmd == 'ddbias balanced' then
		_G.dd_state = "balanced"
	elseif cmd == 'dtbias invincible' then
		_G.dt_state = "invincible"
	elseif cmd == 'dtbias squishy' then
		_G.dt_state = "squishy"
	elseif cmd == 'dtbias balanced' then
		_G.dt_state = "balanced"
	elseif cmd == 'dttype advance' then
		if _G.dt_type == 'balanced' then
			_G.dt_type = "magic"
		elseif _G.dt_type == 'magic' then
			_G.dt_type = "physical"
		elseif _G.dt_type == 'physical' then
			_G.dt_type = "balanced"
		end
	elseif cmd == 'engage toggle' then
		if _G.engage_mode == 'caster' then
			_G.engage_mode = "melee"
			send_command('dressup blinking all all off')
		else
			_G.engage_mode = "caster"
			send_command('gs enable all')
			send_command('dressup blinking all always on')
		end
	end
	send_command('@input /echo === MODE: ' ..
		_G.engage_mode:sub(1,1):upper() .. _G.engage_mode:sub(2) .. ' + ' ..
		_G.nuke_mode:sub(1,1):upper() .. _G.nuke_mode:sub(2) ..
		', DD: ' .. _G.dd_state:sub(1,1):upper() .. _G.dd_state:sub(2) ..
		', DT: ' .. _G.dt_state:sub(1,1):upper() .. _G.dt_state:sub(2) ..
		'/' .. _G.dt_type:sub(1,1):upper() .. _G.dt_type:sub(2)
	)
	variant_sets()
	if player.status == 'Engaged' then
		if sets.tpdw and (player.sub_job == "NIN" or player.sub_job == "DNC") then
			equip(sets.tpdw)
		else
			equip(sets.tp)
		end
	else
		equip(sets.idle)
	end
end

function checktp(spell)
	-- attempt to preserve TP when fighting
	-- optional failsafe for curing low-HP targets
	-- if spell ~= nil then
	-- 	if spell.target.hpp <= 60 and spell.target.type ~= 'MONSTER' and spell.skill == 'Healing Magic' then
	-- 		enable('main','sub','range')
	-- 	else
	-- 		disable('main','sub','range')
	-- 	end
	-- elseif ...
	if player.tp >= 150 then
		disable('main','sub','range')
	else
		enable('main','sub','range')
	end
end

function aftercast(action)
	-- largely mirrors status_change()
	-- automatically swap sets for enaged/idle/resting
	if engage_mode == 'melee' then
		checktp(nil)
	end
	if player.status == 'Engaged' then
		if sets.tpdw and (player.sub_job == "NIN" or player.sub_job == "DNC") then
			equip(sets.tpdw)
		else
			equip(sets.tp)
		end
	elseif player.status == 'Idle' then
		if in_array(player.main_job, fuchojobs) and player.mpp < 51 then
			equip(set_combine(sets.idle,{waist="Fucho-no-obi",}))
		else
			equip(sets.idle)
		end
	end
end

function status_change(new,old)
	-- largely mirrors aftercast()
	-- automatically swap sets for enaged/idle/resting
	if engage_mode == 'melee' then
		checktp(nil)
	end
	if new == 'Engaged' then
		if sets.tpdw and (player.sub_job == "NIN" or player.sub_job == "DNC") then
			equip(sets.tpdw)
		else
			equip(sets.tp)
		end
	elseif new == 'Resting' then
		equip(sets.restMP)
	elseif new == 'Idle' then
		if in_array(player.main_job, fuchojobs) and player.mpp < 51 then
			equip(set_combine(sets.idle,{waist="Fucho-no-obi",}))
		else
			equip(sets.idle)
		end
	end
end

function buff_change(buffname,gain)
	-- this will not preserve TP
	if gain then
		if buffname == 'sleep' or buffname == 'petrification' or buffname == 'terror' or buffname == 'stun' then
			equip(sets.idle)
		end
	else
		if buffname == 'sleep' or buffname == 'petrification' or buffname == 'terror' or buffname == 'stun' then
			if player.status == 'Engaged' then
				if sets.tpdw and (player.sub_job == "NIN" or player.sub_job == "DNC") then
					equip(sets.tpdw)
				else
					equip(sets.tp)
				end
			else
				equip(sets.idle)
			end
		end
	end
end

function checkftpws(action)
	-- automatically equip fotia belt/gorget for appropriate weaponskills
	if action.prefix == '/weaponskill' and in_array(action.name, ftpws) then
		equip({neck="Fotia Gorget",waist="Fotia Belt",})
	end
end

function checktpbonus(ws)
	-- auto-equip TP bonus gear
	-- TODO: add checks for other TP bonus gear, like Mpaca and aeonics?
	if in_array(ws, tpbreakpointws) then
		if ((player.tp >= 1850 and player.tp < 2000) or (player.tp >= 2850 and player.tp < 3000)) then
			equip({left_ear="Moonshade Earring",})
		end
	elseif player.tp < 3000 then
		equip({left_ear="Moonshade Earring",})
	end
end

function checkelement(action, ismidcast)
	-- maybe use debug.getinfo(2, 'n').name instead of ismidcast

	-- overrides weapon/neck/waist slots for weather bonuses when called
	-- skips if:
	--   action is opposite of day and weather intensity is only 1
	--   action is opposite of actual weather AND there's no personal weather
	if (world.day_element == opposing_elements[action.element] and world.weather_intensity == 1) or
	(world.weather_element == opposing_elements[action.element] and world.weather_id == world.real_weather_id) then
		return
	end
	if action.element == world.weather_element or action.element == world.day_element then
		if not ismidcast and action.prefix == '/weaponskill' and in_array(action.name, elemws) then
			sets.weather = {
				neck="Fotia Gorget",
				waist="Hachirin-no-Obi",
			}
			equip(sets.weather)
		elseif ismidcast and action.skill == 'Elemental Magic' then
			sets.weather = {
				waist="Hachirin-no-Obi",
			}
			if action.element ~= 'Dark' and action.element ~= 'Light' then
				sets.weather = set_combine(sets.weather,{left_ring="Zodiac Ring",})
			end
			equip(sets.weather)
		elseif ismidcast and action.skill == 'Healing Magic' and (action.name:contains('Cure') or action.name:contains('Cura')) then
			sets.weather = {
				main="Chatoyant Staff",sub="Enki Strap",
				waist="Hachirin-no-Obi",
			}
			-- override cape if Cura, or not WHM
			if action.name:contains('Cura') or player.main_job ~= 'WHM' then
				sets.weather = {
					main="Chatoyant Staff",sub="Enki Strap",
					back="Twilight Cape",waist="Hachirin-no-Obi",
				}
			end
			equip(sets.weather)
		end
	end
end

function in_array(str, arr)
	-- helper function for determining if a string is within a table
	for _, item in pairs(arr) do
		if str == item then return true end
	end
	return false
end

-- ------------------------------------------
-- Useful Data Structures
-- ------------------------------------------
opposing_elements = {
	["Light"] = "Darkness",
	["Darkness"] = "Light",
	["Earth"] = "Wind",
	["Lightning"] = "Earth",
	["Water"] = "Lightning",
	["Fire"] = "Water",
	["Ice"] = "Fire",
	["Wind"] = "Ice",
}
quickspells = T{
	"Raise","Raise II","Raise III","Arise","Reraise","Reraise II","Reraise III","Reraise IV",
	"Teleport-Mea","Teleport-Dem","Teleport-Holla","Teleport-Altep","Teleport-Yhoat","Teleport-Vahzl","Recall-Meriph","Recall-Jugner","Recall-Pashh",
	"Warp","Warp II","Escape","Tractor","Retrace",
}
enhspells = T{
	"Aquaveil","Haste","Blink","Stoneskin","Invisible","Sneak","Deodorize","Auspice",
	"Phalanx","Phalanx II","Temper","Refresh","Refresh II","Haste II","Flurry","Flurry II",
	"Animus Augeo","Animus Minuo","Adloquium","Embrava",
	"Sandstorm","Rainstorm","Windstorm","Firestorm","Hailstorm","Thunderstorm","Voidstorm","Aurorastorm",
	"Sandstorm II","Rainstorm II","Windstorm II","Firestorm II","Hailstorm II","Thunderstorm II","Voidstorm II","Aurorastorm II",
	"Protect","Protect II","Protect III","Protect IV","Protect V","Shell","Shell II","Shell III","Shell IV","Shell V",
	"Protectra","Protectra II","Protectra III","Protectra IV","Protectra V","Shellra","Shellra II","Shellra III","Shellra IV","Shellra V",
	"Barsleep","Barpoison","Barparalyze","Barblind","Barsilence","Barpetrify","Barvirus",
	"Enfire","Enblizzard","Enaero","Enstone","Enthunder","Enwater",
	"Enfire II","Enblizzard II","Enaero II","Enstone II","Enthunder II","Enwater II",
}
enhskillspells = T{
	"Boost-STR","Boost-DEX","Boost-VIT","Boost-AGI","Boost-INT","Boost-MND","Boost-CHR",
	"Gain-STR","Gain-DEX","Gain-VIT","Gain-AGI","Gain-INT","Gain-MND","Gain-CHR",
	"Baraera","Barstonra","Barthundra","Barwatera","Barfira","Barblizzara",
	"Baraero","Barstone","Barthunder","Barwater","Barfire","Barblizzard",
	"Barsleepra","Barpoisonra","Barparalyzra","Barblindra","Barsilencera","Barpetra","Barvira","Baramnesra",
	"Barsleep","Barpoison","Barparalyze","Barblind","Barsilence","Barpetrify","Barvirus","Baramnesia",
	"Enfire","Enblizzard","Enaero","Enstone","Enthunder","Enwater",
	"Enfire II","Enblizzard II","Enaero II","Enstone II","Enthunder II","Enwater II",
}
enspells = T{
	"Enfire","Enblizzard","Enaero","Enstone","Enthunder","Enwater",
	"Enfire II","Enblizzard II","Enaero II","Enstone II","Enthunder II","Enwater II",
}
gainspells = T{
	"Gain-STR","Gain-DEX","Gain-VIT","Gain-AGI","Gain-INT","Gain-MND","Gain-CHR",
}
barspells = T{
	"Baraera","Barstonra","Barthundra","Barwatera","Barfira","Barblizzara",
	"Baraero","Barstone","Barthunder","Barwater","Barfire","Barblizzard",
	"Barsleepra","Barpoisonra","Barparalyzra","Barblindra","Barsilencera","Barpetra","Barvira","Baramnesra",
	"Barsleep","Barpoison","Barparalyze","Barblind","Barsilence","Barpetrify","Barvirus","Baramnesia",
}
barelemspells = T{
	"Baraera","Barstonra","Barthundra","Barwatera","Barfira","Barblizzara",
	"Baraero","Barstone","Barthunder","Barwater","Barfire","Barblizzard",
}
enhstorms = T{
	"Sandstorm","Rainstorm","Windstorm","Firestorm","Hailstorm","Thunderstorm","Voidstorm","Aurorastorm",
	"Sandstorm II","Rainstorm II","Windstorm II","Firestorm II","Hailstorm II","Thunderstorm II","Voidstorm II","Aurorastorm II",
}
naspells = T{
	"Poisona","Paralyna","Blindna","Silena","Stona","Viruna","Cursna","Erase",
}
mndnukes = T{
	"Banish","Banish II","Banish III","Banishga","Banishga II","Holy","Holy II",
}
mndenfeebles = T{
	"Addle","Addle II","Dia","Dia II","Dia III","Diaga","Distract","Distract II","Distract III",
	"Frazzle","Frazzle II","Frazzle III","Paralyze","Paralyze II","Silence","Slow","Slow II",
}
intenfeebles = T{
	"Bind","Blind","Blind II","Break","Breakga","Dispel","Dispelga",
	"Gravity","Gravity II","Poison","Poison II","Poisonga",
	"Sleep","Sleep II","Sleepga","Sleepga II",
}
accenfeebles = T{
	"Bind","Break","Dispel","Frazzle","Frazzle II","Gravity","Gravity II","Poison","Poison II",
	"Silence","Sleep","Sleep II","Sleepga","Sleepga II",
}
potenfeebles = T{
	"Addle","Addle II","Blind","Blind II","Distract","Distract II","Distract III",
	"Paralyze","Paralyze II","Slow","Slow II",
}
darkenfeebles = T{
	"Bio","Bio II","Bio III","Stun",
	"Absorb-ACC","Absorb-AGI","Absorb-Attri","Absorb-CHR","Absorb-DEX","Absorb-INT","Absorb-MND","Absorb-STR","Absorb-TP","Absorb-VIT",
}
darknukes = T{
	"Aspir","Aspir II","Aspir III","Drain","Drain II","Drain III","Death","Kaustra",
}
darkenhspells = T{
	"Dread Spikes","Endark","Endark II",
}
ftpws = T{
	"Ascetic's Fury","Asuran Fists","Backhand Blow","Blade: Jin","Blade: Ku","Blade: Shun",
	"Chant du Cygne","Combo","Dancing Edge","Decimation","Dragon Kick","Entropy","Evisceration",
	"Extenterator","Hexa Strike","Howling Fist","Jishnu's Radiance","Last Stand","One Inch Punch",
	"Pyrrhic Kleos","Raging Fists","Rampage","Realmrazer","Requiescat","Resolution","Ruinator",
	"Shijin Spiral","Shoulder Tackle","Spinning Attack","Stardiver","Stringing Pummel","Swift Blade",
	"Tornado Kick","Victory Smite","Vorpal Blade",
}
elemws = T{
	"Burning Blade","Red Lotus Blade","Tachi: Kagero","Flaming Arrow","Hot Shot","Wildfire",
	"Blade: Chi","Rock Crusher","Earth Crusher",
	"Blade: Teki","Blade: Yu",
	"Gust Slash","Cyclone","Aeolian Edge","Tachi: Jinpu",
	"Frostbite","Freezebite","Herculean Slash","Blade: To",
	"Cloudsplitter","Thunder Thrust","Raiden Thrust","Tachi: Goten",
	"Shining Blade","Seraph Blade","Primal Rend","Tachi: Koki","Shining Strike","Seraph Strike","Flash Nova","Starburst","Sunburst","Garland of Bliss","Trueflight",
	"Energy Steal","Energy Drain","Sanguine Blade","Dark Harvest","Shadow of Death","Infernal Scythe","Blade: Ei","Cataclysm","Vidohunir","Omniscience","Leaden Salute",
}
-- These aren't 100% known, but extrapolated from WS that don't say "Damage/crit varies by TP"
tpbreakpointws = T{
	"Shoulder Tackle","One Inch Punch","Spinning Attack","Asuran Fists","Shijin Spiral","Final Heaven",
	"Wasp Sting","Shadowstitch","Viper Bite","Energy Steal","Energy Drain","Dancing Edge","Extenterator","Mercy Stroke","Mordant Rime","Pyrrhic Kleos",
	"Flat Blade","Circle Blade","Spirits Within","Swift Blade","Sanguine Blade","Requiescat","Knights of Round","Death Blossom",
	"Shockwave","Herculean Slash",
	"Smash Axe","Gale Axe","Decimation","Bora Axe","Ruinator","Onslaught",
	"Shield Break","Armor Break","Weapon Break","Full Break","Fell Cleave","Metatron Torment",
	"Nightmare Scythe","Spinning Scythe","Guillotine","Infernal Scythe","Quietus",
	"Leg Sweep","Penta Thrust","Wheeling Thrust","Geirskogul","Camlann's Torment",
	"Blade: Retsu","Blade: Ku","Blade: Yu","Blade: Shun","Blade: Metsu",
	"Tachi: Hobaku","Tachi: Ageha","Tachi: Rana",
	"Brainshaker","Starlight","Moonlight","Skullbreaker","True Strike","Flash Nova","Realmrazer","Randgrith","Dagan",
	"Shell Crusher","Shattersoul","Gate of Tartarus","Garland of Bliss","Omniscience","Vidohunir",
	"Piercing Arrow","Sidewinder","Blast Arrow","Apex Arrow",
	"Split Shot","Slug Shot","Blast Shot","Numbing Shot","Wildfire",
}
dncsteps = T{
	"Box Step","Feather Step","Quickstep","Stuter Step",
}
dncwaltzes = T{
	"Curing Waltz","Curing Waltz II","Curing Waltz III","Curing Waltz IV","Curing Waltz V","Divine Waltz","Divine Waltz II",
}
fuchojobs = T{
	"MNK","WHM","BLM","RDM","PLD","BRD","RNG","SMN","BLU","PUP","SCH","GEO","RUN",
}
