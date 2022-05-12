include('organizer-lib')
include('Temas_inc.lua')

function get_sets()
	-- Sets up a lot of stuff: (job number, dressup castmode, default mode)
	-- The job number must match the job's lockstyle and macro book.
	-- See Temas_inc.lua for details.
	startup(1, true, "caster")
	send_command('bind ^g gs c gambanteinn toggle')
	-- Sets that end in "base" are modified in variant_sets() depending on
	-- DT/DD/nuke/etc modes. The sets in this function correspond to the
	-- "balanced" or default setting for each of those modes.

	-- 50% DT, 8 refresh
	sets.idlebase = {
		main="Malignance Pole",sub="Umbra Strap",ammo="Homiliary",
		head="Volte Beret",neck="Loricate Torque +1",left_ear="Eabani Earring",right_ear="Etiolation Earring",
		body="Shamash Robe",hands="Bunzi's Gloves",left_ring="Stikini Ring +1",right_ring="Defending Ring",
		back={name="Alaunus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Damage taken-5%',}},
		waist="Carrier's Sash",legs="Volte Brais",feet="Herald's Gaiters",
	}
	-- 48% DT/10% PDT/3% MDT, 1366 def, 830 eva, 730-745 meva, 3-4 refresh (with fucho)
	sets.idle_invincible_balanced = set_combine(sets.idlebase,{
		main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		body="Nyame Mail",hands="Nyame Gauntlets",left_ring="Inyanga Ring",
		legs="Nyame Flanchard",feet="Inyan. Crackows +2",
	})
	-- no refresh, pure defense
	sets.idle_invincible_magic = set_combine(sets.idle_invincible_balanced,{
		head="Nyame Helm",neck="Warder's Charm +1",
		feet="Nyame Sollerets",
	})
	sets.idle_invincible_physical = set_combine(sets.idle_invincible_balanced,{
		left_ring="Ilabrat Ring",
		waist="Chaac Belt",
	})
	-- minimal DT/meva, but 11 refresh
	sets.idle_squishy = set_combine(sets.idlebase,{
		main="Daybreak",sub="Genmei Shield",
		hands="Inyan. Dastanas +2",right_ring="Inyanga Ring",
	})
	sets.idle = sets.idlebase
	-- HMP/refresh
	sets.restMP = set_combine(sets.idlebase,{
		main="Mpaca's Staff",
		neck="Sanctity Necklace",
		hands={name="Chironic Gloves", augments={'Attack+8','DEX+8','"Refresh"+1','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
		right_ring="Inyanga Ring",
		waist="Shinjutsu-no-Obi +1",feet="Inyan. Crackows +2",
	})
	-- mix of acc/matk/stp and DT
	sets.tpbase = {
		--main="Marin Staff +1",sub="Enki Strap",ammo="Staunch Tathlum +1",
		main="Yagrush",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",neck="Lissome Necklace",left_ear="Telos Earring",right_ear="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Bunzi's Gloves",left_ring="Petrov Ring",right_ring="Defending Ring",
		back={name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2",
	}
	sets.tp = sets.tpbase
	sets.tp_balanced_accuracy = set_combine(sets.tpbase,{
		neck="Combatant's Torque",right_ear="Mache Earring +1",
		left_ring="Chirich Ring +1",
		waist="Grunfeld Rope",
	})
	sets.tp_balanced_potency = set_combine(sets.tpbase,{
		neck="Asperity Necklace",
		left_ring="Hetairoi Ring",
		waist="Grunfeld Rope",
	})
	-- invincible sets
	sets.tp_invincible_balanced = set_combine(sets.tpbase,{
		head="Nyame Helm",
		body="Nyame Mail",hands="Nyame Gauntlets",
		legs="Nyame Flanchard",feet="Nyame Sollerets",
	})
	sets.tp_invincible_accuracy = set_combine(sets.tp_invincible_balanced,{
		neck="Combatant's Torque",right_ear="Mache Earring +1",
		left_ring="Chirich Ring +1",
		waist="Grunfeld Rope",
	})
	sets.tp_invincible_potency = set_combine(sets.tp_invincible_balanced,{
		neck="Asperity Necklace",
		left_ring="Hetairoi Ring",
		waist="Grunfeld Rope",
	})
	-- squishy sets
	sets.tp_squishy_balanced = set_combine(sets.tpbase,{
		ammo="Amar Cluster",
		right_ring="Hetairoi Ring",
		waist="Grunfeld Rope",
	})
	sets.tp_squishy_accuracy = set_combine(sets.tp_squishy_balanced,{
		left_ring="Chirich Ring +1",right_ring="Chirich Ring +1",
		waist="Grunfeld Rope",
	})
	sets.tp_squishy_potency = set_combine(sets.tp_squishy_balanced,{
		neck="Asperity Necklace",
		waist="Grunfeld Rope",
	})

	-- Fast cast (cap 80% || 78% with /sch || 65% with /rdm):
	-- = 91% FC, or 77% with no weapon swap
	sets.pre.default = {
		main="Grioavolr",sub="Clerisy Strap +1",ammo=empty,
		head="Nahtirah Hat",neck="Clr. Torque +2",left_ear="Malignance Earring",right_ear="Enchntr. Earring +1",
		body="Zendik Robe",hands="Gende. Gages +1",left_ring="Kishar Ring",right_ring="Prolix Ring",
		back="Fi Follet Cape +1",waist="Embla Sash",legs="Volte Brais",feet="Regal Pumps +1",
	}
	sets.pre.na = set_combine(sets.pre.default, {
		main="Yagrush",sub="Thuellaic Ecu +1",
	})
	-- quickening (cap 10%): impatiens 2%, veneficium 1%, witful 3%
	-- some minor FC pieces get replaced with conserve mp
	sets.pre.quick = set_combine(sets.pre.default, {
		ammo="Impatiens",
		right_ear="Calamitous Earring",
		left_ring="Veneficium Ring",right_ring="Mephitas's Ring +1",
		legs={name="Telchine Braconi", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		back="Perimede Cape",waist="Shinjutsu-no-Obi +1",feet="Kaykaus Boots +1",
	})

	-- Weapon skill bonuses
	-- MND>STR: Black Halo, Mystic Boon, Retribution
	sets.pre.ws = {
		ammo="Amar Cluster",
		head="Nyame Helm",neck="Clr. Torque +2",left_ear="Malignance Earring",right_ear="Regal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",left_ring="Shukuyu Ring",right_ring="Metamor. Ring +1",
		back={name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Grunfeld Rope",legs="Nyame Flanchard",feet="Nyame Sollerets",
	}
	sets.pre["Mystic Boon"] = sets.pre.ws
	sets.pre["Black Halo"] = sets.pre.ws
	sets.pre["Retribution"] = sets.pre.ws
	-- STR/MND: Judgment, Starburst, Sunburst
	-- STR: Brainshaker, Heavy Swing, Shell Crusher, Full Swing
	sets.pre.wsstr = set_combine(sets.pre.ws, {
		neck="Caro Necklace",left_ear="Telos Earring",right_ear="Brutal Earring",
		right_ring="Ilabrat Ring",
		waist="Prosilio Belt +1",
	})
	sets.pre["Judgment"] = sets.pre.wsstr
	sets.pre["Brainshaker"] = sets.pre.wsstr
	sets.pre["Heavy Swing"] = sets.pre.wsstr
	sets.pre["Shell Crusher"] = sets.pre.wsstr
	sets.pre["Starburst"] = sets.pre.wsstr
	sets.pre["Sunburst"] = sets.pre.wsstr
	sets.pre["Full Swing"] = sets.pre.wsstr
	-- multihit: Hexa Strike (STR), Realmrazer (MND)
	sets.pre.wsmulti = set_combine(sets.pre.ws, {
		head="Piety Cap +3",
		body="Piety Bliaut +3",hands="Piety Mitts +3",left_ring="Rufescent Ring",
		legs="Piety Pantaln. +3",feet="Piety Duckbills +3",
	})
	sets.pre["Realmrazer"] = set_combine(sets.pre.wsmulti,{
		waist="Luminary Sash",
	})
	sets.pre["Hexa Strike"] = set_combine(sets.pre.wsmulti,{
		left_ear="Telos Earring",
		right_ring="Ilabrat Ring",
	})
	-- elemental WS
	-- STR/MND: Shining Strike, Seraph Strike, Flash Nova
	-- STR/INT: Rock Crusher, Earth Crusher, Cataclysm
	sets.pre.wselem = set_combine(sets.pre.ws,{
		ammo="Pemphredo Tathlum",
		left_ring="Freke Ring",
		waist="Orpheus's Sash",
	})
	sets.pre["Shining Strike"] = sets.pre.wselem
	sets.pre["Seraph Strike"] = sets.pre.wselem
	sets.pre["Flash Nova"] = sets.pre.wselem
	sets.pre["Rock Crusher"] = sets.pre.wselem
	sets.pre["Earth Crusher"] = sets.pre.wselem
	sets.pre["Cataclysm"] = set_combine(sets.pre.wselem,{
		head="Pixie Hairpin +1",
	})
	-- INT: Shattersoul
	-- INT/MND: Spirit Taker
	sets.pre.wsint = set_combine(sets.pre.wselem,{
		ammo="Ghastly Tathlum",
		waist="Acuity Belt +1",
	})
	sets.pre["Shattersoul"] = sets.pre.wsint
	sets.pre["Spirit Taker"] = sets.pre.wsint

	-- "base" midcast sets
	-- purely haste/fc, except for stikini
	sets.mid.default = {
		main="Grioavolr",sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Clr. Torque +2",left_ear="Loquac. Earring",right_ear="Enchntr. Earring +1",
		body="Zendik Robe",hands="Fanatic Gloves",left_ring="Stikini Ring +1",right_ring="Prolix Ring",
		back={name="Alaunus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Damage taken-5%',}},
		waist="Witful Belt",legs="Volte Brais",feet="Regal Pumps +1",
	}
	-- Conserve MP (77+1%)
	sets.mid.conserve = set_combine(sets.mid.default,{
		ammo="Pemphredo Tathlum",
		head={name="Telchine Cap", augments={'Mag. Evasion+21','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",left_ear="Mendi. Earring",right_ear="Calamitous Earring",
		body={name="Telchine Chas.", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		hands="Shrieker's Cuffs",right_ring="Mephitas's Ring +1",
		legs={name="Telchine Braconi", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		back="Fi Follet Cape +1",waist="Shinjutsu-no-Obi +1",feet="Kaykaus Boots +1",
	})
	-- haste/FC plus some ConsMP
	sets.mid.recast = set_combine(sets.mid.default,{
		right_ear="Calamitous Earring",
		right_ring="Mephitas's Ring +1",
		legs={name="Telchine Braconi", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		waist="Shinjutsu-no-Obi +1",feet="Kaykaus Boots +1",
	})

	-- Potency II > solace > Potency >=50 > (1heal_skill = 2mnd = 4vit) > enmity > cons. mp > *
	-- 11 kaykaus mitra + 17 kaykaus boots + 10 torque + 5 menelaus + 10 cape == 53 CPI
	-- 4 kaykaus + 10 theo+3 + 2 glorious + 5 janniston + 2 queller = 23(-8) CPII
	-- 10 queller + 25 neck + 5 glorious + 6 Tbody + 7 Thands + 6 kboots + 7 janniston = 66(-16) enmity
	sets.mid.cure = {
		main="Queller Rod",sub="Thuellaic Ecu +1",ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra +1",neck="Clr. Torque +2",left_ear="Glorious Earring",right_ear="Meili Earring",
		body="Theo. Bliaut +3",hands="Theophany Mitts +3",left_ring="Janniston Ring",right_ring="Menelaus's Ring",
		back={name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
		waist="Shinjutsu-no-Obi +1",legs="Ebers Pant. +1",feet="Kaykaus Boots +1",
	}
	sets.mid.affsolcure = set_combine(sets.mid.cure,{
		body="Ebers Bliaut +1",
	})
	-- for the cura/ga lines
	-- potency II > potency (50%) > (1mnd = 3vit = 5heal_skill) > enmity > consmp > *
	sets.mid.cura = set_combine(sets.mid.cure, {
		sub="Ammurapi Shield",
		right_ear="Regal Earring",
	})

	-- Status removals
	sets.mid.na = set_combine(sets.mid.recast, {
		main="Yagrush",sub="Thuellaic Ecu +1",
	})
	sets.mid["Erase"] = set_combine(sets.mid.recast,{
		main="Yagrush",sub="Thuellaic Ecu +1",neck="Cleric's Torque +2",
	})
	-- ~66% success rate: http://chiaia.optic-ice.com/Cursna.html
	sets.mid["Cursna"] = {
		main="Yagrush",sub="Thuellaic Ecu +1",ammo="Hasty Pinion +1",
		head="Vanya Hood",neck="Debilis Medallion",left_ear="Beatific Earring",right_ear="Meili Earring",
		body="Ebers Bliaut +1",hands="Fanatic Gloves",left_ring="Haoma's Ring",right_ring="Menelaus's Ring",
		back={name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
		waist="Bishop's Sash",legs="Th. Pant. +3",feet="Vanya Clogs",
	}

	--Enhancing default
	sets.mid.enh = set_combine(sets.mid.conserve,{
		main="Gada",sub="Ammurapi Shield",
		hands={name="Telchine Gloves", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		left_ring="Stikini Ring +1",waist="Embla Sash",
		legs={name="Telchine Braconi", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		feet={name="Telchine Pigaches", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	})
	-- Regen IV 63/tick, ~3.5min
	-- potency/duration > duration sec > duration % > conserve mp > haste
	sets.mid.regen = set_combine(sets.mid.enh,{
		main="Bolelabunga",
		head="Inyanga Tiara +2",
		body="Piety Bliaut +3",hands="Ebers Mitts +1",
		legs="Th. Pant. +3",feet="Theo. Duckbills +3",
	})
	sets.mid["Auspice"] = set_combine(sets.mid.enh,{
		feet="Ebers Duckbills +1",
	})
	sets.mid["Aquaveil"] = set_combine(sets.mid.enh,{
		head="Chironic Hat",
	})
	-- 500 cap for boost spells and barspells
	-- current: 507 (414 naked, or 440 naked + Light Arts)
	sets.mid.enhskill = set_combine(sets.mid.enh,{
		right_ear="Mimir Earring",
	})
	-- potency > enh_skill/duration > conserve mp > haste
	sets.mid.barelement = set_combine(sets.mid.enhskill,{
		legs="Piety Pantaln. +3",
	})
	sets.mid.affsolbar = set_combine(sets.mid.barelement,{
		body="Ebers Bliaut +1",
		back={name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
	})

	-- enfeebles: skill/macc > stats > etc
	sets.mid.enfeeb = {
		main="Yagrush",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Theophany Cap +3",neck="Erra Pendant",left_ear="Regal Earring",right_ear="Malignance Earring",
		body="Theo. Bliaut +3",hands="Kaykaus Cuffs +1",left_ring="Kishar Ring",right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Theo. Duckbills +3",
	}
	sets.mid.mndenfeeb = sets.mid.enfeeb
	sets.mid.intenfeeb = set_combine(sets.mid.enfeeb,{
		hands="Inyan. Dastanas +2",
		waist="Eschan Stone",
	})
	-- Repose: macc/divine
	sets.mid.divine = set_combine(sets.mid.enfeeb,{
		hands="Piety Mitts +3",
		left_ring="Stikini Ring +1",
		legs="Th. Pant. +3",
	})
	sets.mid["Repose"] = sets.mid.divine
	sets.mid["Flash"] = sets.mid.divine

	-- nukes
	-- Banish/holy: MAB/burst > MND > macc/divine
	sets.mid.mndnuke_balanced = set_combine(sets.mid.mndenfeeb,{
		main="Daybreak",
		neck="Clr. Torque +2",
		hands={name="Chironic Gloves", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Spell interruption rate down -7%','CHR+4','Mag. Acc.+5','"Mag.Atk.Bns."+15',}},
		left_ring="Stikini Ring +1",
		waist="Orpheus's Sash",legs="Bunzi's Pants",feet="Chironic Slippers",
	})
	sets.mid.mndnuke_potency = set_combine(sets.mid.mndnuke_balanced,{
		neck="Saevus Pendant +1",
		left_ring="Levia. Ring +1",
		legs="Kaykaus Tights +1",
	})
	sets.mid.mndnuke_accuracy = set_combine(sets.mid.mndnuke_balanced,{
		head="Theophany Cap +3",
		body="Theo. Bliaut +3",
		legs="Chironic Hose",
	})
	sets.mid.mndnukeburst = set_combine(sets.mid.mndnuke_balanced,{
		head="Bunzi's Hat",
		body="Bunzi's Robe",hands="Bunzi's Gloves",
		legs="Bunzi's Pants",feet="Bunzi's Sabots",
	})
	sets.mid.mndnuke = sets.mid.mndnuke_balanced
	sets.mid.intnuke_balanced = set_combine(sets.mid.intenfeeb,{
		main="Bunzi's Rod",sub="Ammurapi Shield",
		neck="Sanctity Necklace",
		hands={name="Chironic Gloves", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Spell interruption rate down -7%','CHR+4','Mag. Acc.+5','"Mag.Atk.Bns."+15',}},
		left_ring="Freke Ring",
		waist="Orpheus's Sash",legs="Volte Brais",feet="Chironic Slippers",
	})
	sets.mid.intnuke_potency = set_combine(sets.mid.intnuke_balanced,{
		neck="Saevus Pendant +1",
		legs="Kaykaus Tights +1",
	})
	sets.mid.intnuke_accuracy = set_combine(sets.mid.intnuke_balanced,{
		head="Theophany Cap +3",
		body="Theo. Bliaut +3",
		legs="Chironic Hose",
	})
	sets.mid.intnukeburst = set_combine(sets.mid.intnuke_balanced,{
		head="Bunzi's Hat",
		body="Bunzi's Robe",hands="Bunzi's Gloves",
		legs="Bunzi's Pants",feet="Bunzi's Sabots",
	})
	sets.mid.intnuke = sets.mid.intnukedefault
	sets.mid.impact = set_combine(sets.mid.enfeeb,{
		head=empty,body="Twilight Cloak",left_ring="Stikini Ring +1",
	})

	sets.mid.dark = set_combine(sets.mid.intenfeeb,{
		main="Rubicundity",sub="Ammurapi Shield",
		head="Pixie Hairpin +1",neck="Erra Pendant",
		body="Theo. Bliaut +3",hands="Inyan. Dastanas +2",left_ring="Stikini Ring +1",right_ring="Evanescence Ring",
		waist="Fucho-no-Obi",
	})

	-- Job ability bonuses
	sets.mid["Benediction"] = {
		body="Piety Bliaut +3",
	}
	sets.mid["Devotion"] = {
		body="Piety Cap +3",
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
		sets.mid.mndnuke = sets.mid.mndnuke_balanced
		sets.mid.intnuke = sets.mid.intnuke_balanced
	else
		sets.mid.mndnuke = sets.mid.mndnukeburst
		sets.mid.intnuke = sets.mid.intnukeburst
	end
	-- cursna
	if cursna_mode == 'gambanteinn' then
		sets.mid["Cursna"] = set_combine(sets.mid["Cursna"],{main="Gambanteinn",})
	else
		sets.mid["Cursna"] = set_combine(sets.mid["Cursna"],{main="Yagrush",})
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
			equip(sets.pre.na)
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
		-- weather, fotia, and TP bonus checks
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
		if action.name:contains('Cure') then
			-- cures need afflatus solace handling
			if buffactive['Afflatus Solace'] then
				equip(sets.mid.affsolcure)
			else
				equip(sets.mid.cure)
			end
		elseif action.name:contains('Cura') then
			equip(sets.mid.cura)
		elseif in_array(action.name, naspells) then
			-- na spells need divine caress handling
			if buffactive['Divine Caress'] then
				if action.name == "Cursna" then
					equip(set_combine(sets.mid["Cursna"],{hands="Ebers Mitts +1",}))
				elseif action.name == "Erase" then
					equip(set_combine(sets.mid["Erase"],{hands="Ebers Mitts +1",}))
				else
					equip(set_combine(sets.mid.na,{hands="Ebers Mitts +1",}))
				end
			else
				if sets.mid[action.name] then
					equip(sets.mid[action.name])
				else
					equip(sets.mid.na)
				end
			end
		elseif in_array(action.name, quickspells) then
			equip(sets.mid.recast)
		-- enhancing magic
		elseif action.name:contains('Regen') then
			equip(sets.mid.regen)
		elseif in_array(action.name, barelemspells) and not sets.mid[action.name] then
			-- barspells need afflatus solace handling
			if buffactive['Afflatus Solace'] then
				equip(sets.mid.affsolbar)
			else
				equip(sets.mid.barelement)
			end
		elseif in_array(action.name, enhskillspells) and not sets.mid[action.name] then
			equip(sets.mid.enhskill)
		elseif in_array(action.name, enhspells) and not sets.mid[action.name] then
			equip(sets.mid.enh)
		-- enfeebling magic
		elseif in_array(action.name, mndenfeebles) then
			equip(sets.mid.mndenfeeb)
		elseif in_array(action.name, intenfeebles) then
			if action.name == "Dispelga" then
				equip(set_combine(sets.mid.intenfeeb,{main="Daybreak",sub="Ammurapi Shield",}))
			else
				equip(sets.mid.intenfeeb)
			end
		-- divine magic
		elseif in_array(action.name, mndnukes) then
			equip(sets.mid.mndnuke)
		-- elemental magic
		elseif action.skill == 'Elemental Magic' then
			if action.name == "Impact" then
				equip(sets.mid.impact)
			else
				equip(sets.mid.intnuke)
			end
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
