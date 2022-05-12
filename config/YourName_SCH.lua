include('organizer-lib')
include('YourName_inc.lua')

function get_sets()
	-- Sets up a lot of stuff: (job number, dressup castmode, default mode)
	-- The job number must match the job's lockstyle and macro book.
	-- See YourName_inc.lua for details.
	startup(4, true, "caster")
	-- Sets that end in "base" are modified in variant_sets() depending on
	-- DT/DD/nuke/etc modes. The sets in this function correspond to the
	-- "balanced" or default setting for each of those modes.

	-- these sets are modified in variant_sets()
	sets.idlebase = {
		main="Malignance Pole",sub="Khonsu",ammo="Homiliary",
		head="Volte Beret",neck="Loricate Torque +1",left_ear="Eabani Earring",right_ear="Etiolation Earring",
		body="Shamash Robe",hands="Nyame Gauntlets",left_ring="Stikini Ring +1",right_ring="Defending Ring",
		back={name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
		waist="Carrier's Sash",legs="Volte Brais",feet="Herald's Gaiters",
	}
	sets.idle = sets.idlebase
	sets.restMP = set_combine(sets.idlebase,{
		main="Contemplator +1",
		neck="Sanctity Necklace",
		body="Jhakri Robe +2",
		hands={name="Chironic Gloves", augments={'Attack+8','DEX+8','"Refresh"+1','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
		waist="Shinjutsu-no-Obi +1",
	})
	sets.tpbase = {
		main="Malignance Pole",sub="Khonsu",ammo="Hasty Pinion +1",
		head="Nyame Helm",neck="Sanctity Necklace",left_ear="Telos Earring",right_ear="Brutal Earring",
		body="Jhakri Robe +2",hands="Nyame Gauntlets",left_ring="Hetairoi Ring",right_ring="Apate Ring",
		back="Kayapa Cape",waist="Windbuffet Belt +1",legs="Jhakri Slops +2",feet="Nyame Sollerets",
	}
	sets.tp = sets.tpbase
	sets.midbase = {
		main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Baetyl Pendant",left_ear="Loquac. Earring",right_ear="Enchntr. Earring +1",
		body="Zendik Robe",hands="Gende. Gages +1",left_ring="Veneficium Ring",right_ring="Prolix Ring",
		back="Fi Follet Cape +1",waist="Witful Belt",legs="Volte Brais",
		feet={name="Telchine Pigaches", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	}
	sets.mid.default = sets.midbase

	-- = 79% FC without weapon swap
	sets.pre.default = {
		main="Grioavolr",sub="Clerisy Strap +1",
		head="Nahtirah Hat",neck="Baetyl Pendant",left_ear="Malignance Earring",right_ear="Enchntr. Earring +1",
		body="Zendik Robe",hands="Gende. Gages +1",left_ring="Kishar Ring",right_ring="Prolix Ring",
		back="Fi Follet Cape +1",waist="Embla Sash",legs="Volte Brais",feet="Merlinic Crackows",
	}
	-- quickening (cap 10%): impatiens 2%, veneficium 1%, witful 3%
	sets.pre.quick = set_combine(sets.pre.default, {
		ammo="Impatiens",
		left_ring="Veneficium Ring",
		back="Perimede Cape",waist="Witful Belt",
	})

	-- Weapon skill bonuses
	-- STR/MND: Judgment, Starburst, Sunburst
	-- MND>STR: Black Halo, Mystic Boon, Retribution
	sets.pre.ws = {
		ammo="Hasty Pinion +1",
		head="Nyame Helm",neck="Argute Stole +2",left_ear="Malignance Earring",right_ear="Regal Earring",
		body="Nyame Mail",hands="Jhakri Cuffs +2",left_ring="Metamor. Ring +1",right_ring="Freke Ring",
		waist="Prosilio Belt +1",legs="Jhakri Slops +2",feet="Nyame Sollerets",
	}
	-- STR: Brainshaker, Heavy Swing, Shell Crusher, Full Swing
	sets.pre.wsstr = set_combine(sets.pre.ws,{
		neck="Caro Necklace",left_ear="Odnowa Earring +1",right_ear="Brutal Earring",
		left_ring="Apate Ring",right_ring="Shukuyu Ring",
		back="Buquwik Cape",
	})
	sets.pre["Heavy Swing"] = sets.pre.wsstr
	sets.pre["Shell Crusher"] = sets.pre.wsstr
	sets.pre["Full Swing"] = sets.pre.wsstr
	sets.pre["Brainshaker"] = sets.pre.wsstr
	-- STR/INT: Rock Crusher, Earth Crusher, Cataclysm
	-- STR/MND: Shining Strike, Seraph Strike, Flash Nova
	sets.pre.wselem = set_combine(sets.pre.ws,{
		ammo="Ghastly Tathlum",
		head="Pixie Hairpin +1",
		back={name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
		waist="Orpheus's Sash",
	})
	sets.pre["Cataclysm"] = sets.pre.wselem
	sets.pre["Rock Crusher"] = sets.pre.wselem
	sets.pre["Earth Crusher"] = sets.pre.wselem
	sets.pre["Shining Strike"] = sets.pre.wselem
	sets.pre["Seraph Strike"] = sets.pre.wselem
	sets.pre["Flash Nova"] = sets.pre.wselem
	-- INT: Shattersoul
	-- INT/MND: Spirit Taker
	sets.pre.wsint = set_combine(sets.pre.wselem,{waist="Acuity Belt +1",})
	sets.pre["Shattersoul"] = sets.pre.wsint
	sets.pre["Spirit Taker"] = sets.pre.wsint
	-- MP: Myrkr
	sets.pre["Myrkr"] = {
		ammo="Ghastly Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",left_ear="Etiolation Earring",right_ear="Loquac. Earring",
		body="Acad. Gown +3",hands="Nyame Gauntlets",left_ring="Mephitas's Ring +1",right_ring="Metamor. Ring +1",
		back="Fi Follet Cape +1",waist="Shinjutsu-no-Obi +1",legs="Peda. Pants +3",feet="Peda. Loafers +3",
	}

	-- Haste/FC + ConsMP
	sets.mid.recast = set_combine(sets.mid.default,{
		right_ear="Calamitous Earring",
		right_ring="Mephitas's Ring +1",
		waist="Shinjutsu-no-Obi +1",legs="Telchine Braconi",feet="Kaykaus Boots +1",
	})
	-- Conserve MP
	sets.mid.conserve = {
		main="Grioavolr",ammo="Pemphredo Tathlum",
		head={name="Telchine Cap", augments={'Mag. Evasion+21','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",left_ear="Mendi. Earring",right_ear="Calamitous Earring",
		body={name="Telchine Chas.", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		hands="Shrieker's Cuffs",right_ring="Mephitas's Ring +1",
		legs={name="Telchine Braconi", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		back="Fi Follet Cape +1",waist="Shinjutsu-no-Obi +1",feet="Kaykaus Boots +1",
	}

	-- Potency II > solace > Potency >=50 > (1heal_skill = 2mnd = 4vit) > enmity > cons. mp > *
	-- 30 daybreak + 11+11+17 kaykaus mitra/cuffs/boots >= 50
	sets.mid.cure = {
		main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra +1",neck="Incanter's Torque",left_ear="Mendi. Earring",right_ear="Calamitous Earring",
		body="Peda. Gown +3",hands="Peda. Bracers +3",left_ring="Janniston Ring",right_ring="Mephitas's Ring +1",
		back="Aurist's Cape +1",waist="Shinjutsu-no-Obi +1",legs="Kaykaus Tights +1",feet="Kaykaus Boots +1",
	}
	-- ~43% http://chiaia.optic-ice.com/Cursna.html
	sets.mid["Cursna"] = set_combine(sets.mid.recast,{
		main="Gada",sub="Ammurapi Shield",
		head="Vanya Hood",neck="Debilis Medallion",left_ear="Beatific Earring",right_ear="Meili Earring",
		body="Peda. Gown +3",hands="Peda. Bracers +3",left_ring="Haoma's Ring",right_ring="Menelaus's Ring",
		waist="Bishop's Sash",legs="Acad. Pants +2",feet="Vanya Clogs",
	})

	--Enhancing default
	sets.mid.enh = set_combine(sets.mid.default,sets.mid.conserve,{
		main="Gada",sub="Ammurapi Shield",
		head={name="Telchine Cap", augments={'Mag. Evasion+21','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		hands={name="Telchine Gloves", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		body="Peda. Gown +3",left_ring="Stikini Ring +1",waist="Embla Sash",
		legs={name="Telchine Braconi", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		feet={name="Telchine Pigaches", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	})
	-- regen potency/duration > duration sec > duration % > enh skill > conserve mp > haste
	sets.mid.regen = set_combine(sets.mid.enh,{
		main="Bolelabunga",
		head="Arbatel Bonnet +1",
		back="Bookworm's Cape",
	})
	sets.mid.storms = set_combine(sets.mid.enh,{
		feet="Peda. Loafers +3",
	})
	sets.mid.enhskill = set_combine(sets.mid.enh,{
		head="Befouled Crown",
		left_ear="Mimir Earring",
		legs="Acad. Pants +2",
	})

	sets.mid.enfeeb = {
		main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Argute Stole +2",left_ear="Regal Earring",right_ear="Malignance Earring",
		body="Cohort Cloak +1",hands="Kaykaus Cuffs +1",left_ring="Kishar Ring",right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Nyame Sollerets",
	}
	sets.mid.mndenfeeb = set_combine(sets.mid.enfeeb,{
		-- right_ring="Levia. Ring +1",
	})
	sets.mid.intenfeeb = set_combine(sets.mid.enfeeb,{
		waist="Eschan Stone",
	})

	-- nuking
	sets.mid.nukebase = set_combine(sets.mid.intenfeeb,{
		main="Bunzi's Rod",sub="Ammurapi Shield",
		head="Peda. M.Board +3",neck="Argute Stole +2",
		body="Peda. Gown +3",hands="Amalric Gages +1",left_ring="Freke Ring",
		back={name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
		waist="Orpheus's Sash",legs="Peda. Pants +3",feet="Amalric Nails +1",
	})
	sets.mid.nuke = sets.mid.nukebase
	-- I (40 cap): 10 bunzi rod, 10 neck, 10 gown, 5 static earring, 6 agwu shoes
	-- II: 4 peda mboard, 6 amalric gages, 5 mujin band
	sets.mid.nukeburst = set_combine(sets.mid.nukebase,{
		left_ear="Static Earring",
		body="Acad. Gown +3",right_ring="Mujin Band",
		feet="Agwu's Pigaches",
	})
	sets.mid.helix = set_combine(sets.mid.nuke, {
		back="Bookworm's Cape",
	})
	sets.mid.macc = set_combine(sets.mid.nukebase,{
		left_ear="Digni. Earring",
		hands="Kaykaus Cuffs +1",left_ring="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",feet="Jhakri Pigaches +2",
	})
	sets.mid.dark = set_combine(sets.mid.intenfeeb,{
		main="Rubicundity",sub="Ammurapi Shield",
		head="Pixie Hairpin +1",neck="Erra Pendant",
		body="Acad. Gown +3",left_ring="Stikini Ring +1",right_ring="Evanescence Ring",
		waist="Fucho-no-Obi",legs="Peda. Pants +3",feet="Agwu's Pigaches",
	})
	sets.mid["Kaustra"] = set_combine(sets.mid.nukebase,{
		head="Pixie Hairpin +1",
		body="Acad. Gown +3",
	})

	-- Job ability bonuses
	sets.mid["Enlightenment"] = {
		body="Peda. Gown +3",
	}
	sets.mid["Tabula Rasa"] = {
		legs="Peda. Pants +3",
	}
end

function variant_sets()
	-- idle augmentations depend on dt_state and dt_type
	-- midcast and engaged/tp augmentation depend on both dd_state and dt_state
	if dt_state == 'balanced' then
		sets.idle = sets.idlebase
		if dd_state == 'balanced' then
			sets.tp = sets.tpbase
		elseif dd_state == 'accuracy' then
			sets.tp = sets.tp_balanced_accuracy
		elseif dd_state == 'potency' then
			sets.tp = sets.tp_balanced_potency
		end
	elseif dt_state == 'squishy' then
		sets.idle = sets.idle_squishy
		if dd_state == 'balanced' then
			sets.tp = sets.tp_squishy_balanced
		elseif dd_state == 'accuracy' then
			sets.tp = sets.tp_squishy_accuracy
		elseif dd_state == 'potency' then
			sets.tp = sets.tp_squishy_potency
		end
	elseif dt_state == 'invincible' then
		if dt_type == 'balanced' then
			sets.idle = sets.idle_invincible_balanced
		elseif dt_type == 'magic' then
			sets.idle = sets.idle_invincible_magic
		elseif dt_type == 'physical' then
			sets.idle = sets.idle_invincible_physical
		end
		if dd_state == 'balanced' then
			sets.tp = sets.tp_invincible_balanced
		elseif dd_state == 'accuracy' then
			sets.tp = sets.tp_invincible_accuracy
		elseif dd_state == 'potency' then
			sets.tp = sets.tp_invincible_potency
		end
	end
	-- nuke mode swaps
	if nuke_mode == 'raw' then
		sets.mid.nuke = sets.mid.nukebase
	else
		sets.mid.nuke = sets.mid.nukeburst
	end
end

function precast(action)
	if engage_mode == 'melee' then
		checktp(action)
	end
	if in_array(action.type, magictypes) then
		if sets.pre[action.name] then
			equip(sets.pre[action.name])
		elseif in_array(action.name, quickspells) then
			equip(sets.pre.quick)
		elseif in_array(action.name, naspells) then
			equip(sets.pre.quick)
		elseif action.name == "Dispelga" then
			equip(set_combine(sets.pre.default,{main="Daybreak",sub="Ammurapi Shield",}))
		elseif action.name == "Impact" then
			equip(set_combine(sets.pre.default,{head=empty,body="Twilight Cloak",}))
		else
			equip(sets.pre.default)
		end
	elseif action.prefix == '/weaponskill' then
		if sets.pre[action.name] then
			equip(sets.pre[action.name])
		else
			equip(sets.pre.ws)
		end
		-- weather and fotia checks
		checkelement(action, false)
		checkftpws(action)
		checktpbonus(action)
	elseif sets.pre[action.name] then
		equip(sets.pre[action.name])
	end
end

function midcast(action)
	if engage_mode == 'melee' then
		checktp(action)
	end
	if in_array(action.type, magictypes) then
		if in_array(action.name, quickspells) then
			equip(sets.mid.recast)
		elseif action.skill == 'Healing Magic' then
			if action.name:contains('Cure') or action.name:contains('Cura') then
				healset = sets.mid.cure
			elseif in_array(action.name, naspells) and not sets.mid[action.name] then
				healset = sets.mid.recast
			elseif sets.mid[action.name] then
				healset = sets.mid[action.name]
			else
				healset = sets.mid.cure
			end
			if buffactive['Rapture'] then
				equip(set_combine(healset,{head="Arbatel Bonnet +1",}))
			else
				equip(healset)
			end
		elseif action.skill == 'Enhancing Magic' then
			if action.name:contains('Regen') then
				enhset = sets.mid.regen
			elseif in_array(action.name, enhstorms) and not sets.mid[action.name] then
				enhset = sets.mid.storms
			elseif in_array(action.name, enhskillspells) and not sets.mid[action.name] then
				enhset = sets.mid.enhskill
			elseif in_array(action.name, naspells) and not sets.mid[action.name] then
				enhset = sets.mid.recast
			elseif sets.mid[action.name] then
				enhset = sets.mid[action.name]
			else
				enhset = sets.mid.enh
			end
			if buffactive['Perpetuance'] then
				enhset = set_combine(enhset, {hands="Arbatel Bracers +1",})
			end
			equip(enhset)
		-- enfeebling magic
		elseif in_array(action.name, mndenfeebles) then
			equip(sets.mid.mndenfeeb)
		elseif in_array(action.name, intenfeebles) then
			if action.name == "Dispelga" then
				equip(set_combine(sets.mid.intenfeeb,{main="Daybreak",sub="Ammurapi Shield",}))
			else
				equip(sets.mid.intenfeeb)
			end
		elseif action.skill == 'Elemental Magic' then
			if action.name == "Impact" then
				nukeset = set_combine(sets.mid.macc,{head=empty,body="Twilight Cloak",})
			elseif action.name:contains('helix') then
				nukeset = sets.mid.helix
			elseif sets.mid[action.name] then
				nukeset = sets.mid[action.name]
			else
				nukeset = sets.mid.nuke
			end
			equip(nukeset)
		elseif action.skill == 'Dark Magic' then
			equip(sets.mid.dark)
		-- anything with a specific set, including JAs
		elseif sets.mid[action.name] then
			equip(sets.mid[action.name])
		-- everything else
		else
			equip(sets.mid.default)
		end
		-- weather check
		checkelement(action, true)
	end
end
