# Towards Effectiveness: A WHM Guide

> _tri·age (n): the sorting of and allocation of treatment to patients and especially battle and disaster victims according to a system of priorities designed to maximize the number of survivors_

This guide explains how to gear up and play a White Mage to acceptable levels with the goal of eventually acquiring at least a few Best-In-Slot (BiS) pieces. It does not list [comprehensive gear sets](https://ffxiah.com/forum/topic/55005/on-healing-hands-a-comprehensive-whm-guide-v3/) or [specific end-game fight strategies](https://bg-wiki.com/). This guide is to help you get started.

## Table of Contents

[Expectations and Assumptions](#expectations-and-assumptions)
<br/>[The Very Basics](#the-very-basics)
<br/>[Responsible & Ethical Healing Practices](#responsible--ethical-healing-practices)
<br/>[Gear](#gear)
<br/>[Lua Example](#lua-example)

## Expectations and Assumptions

You should know and understand the following concepts:

* `buff` and `debuff` are positive (Enhancing Magic) and negative (Enfeebling Magic) status effects
* `cureskin` is the temporary stoneskin effect applied when you heal with Afflatus Solace active
* `-na spells` remove debuffs; they include Cursna, Stona, Erase, and Esuna among others
* `Bar- spells` include buffs that reduce elemental damage (like Barfira) and the chance of status debuffs (like Barpetra)

You should have also already:

* Reached WHM level 99 and learned all WHM spells, including Arise
* Reached SCH and RDM level 49, and learned all of their spells
* Finished the main story quests for all expansions and Rhapsodies

Install, enable, and configure the following addons:
* [Battlemod](https://docs.windower.net/addons/battlemod/)
<br/>Battlemod is required so you can be more likely to notice incoming Bad Stuff.
<br/>See a [sample configuration](config/battlemod.xml).
* [DressUp](https://docs.windower.net/addons/dressup/)
<br/>DressUp is required to prevent losing your target when trying to cast on other players.
<br/>You should set your GearSwap lua to activate DressUp automatically when you switch to WHM:
<br/>`send_command('@input //dressup blinking all always on')`
* [GearSwap](https://docs.windower.net/addons/gearswap/)
<br/>GearSwap is required for automatically equipping appropriate gear in various situations.
<br/>Feel free to use any lua file that works for you, as long as it supports all the sets mentioned in this guide.
* [Shortcuts](https://docs.windower.net/addons/shortcuts/)
<br/>Shortcuts is optional, but strongly recommended, as a way to cast spells quickly.
<br/>See this [sample configuration](config/aliases.xml) for some ideas.
* [Timers](https://docs.windower.net/plugins/timers/)
<br/>Technically a plugin, rather than an addon.
<br/>Timers is optional, but strongly recommended, for awareness on party buffs that will expire soon as well as your own recast timers.
<br/>You may want to [customize the default timers](config/timers.xml) shown to remove several common buffs.
* [XIVParty](https://github.com/Tylas11/XivParty)
<br/>Not an official addon, but it is worth manually downloading and installing.
<br/>XIVParty is required for effective triage, and shows your party's buffs and debuffs at a glance.
<br/>You should customize the settings to reduce the visual noise: it shows all possible buffs by default.
<br/>See this [sample configuration](config/xivparty-settings.xml) for a recommended setup.

Separate your chat log into two windows:
* The left window MUST be battle content (in order for Battlemod to work), such as damage taken, spells cast, etc.
* The right window MUST NOT have battle content, and SHOULD be mostly party/linkshell chat.


## The Very Basics

You should have the following consumables on you at all times:

* 24x [Echo Drops](https://www.bg-wiki.com/ffxi/Echo_Drops), for the many monsters that silence you repeatedly
* 1x [Vile Elixir +1](https://www.bg-wiki.com/ffxi/Vile_Elixir_+1), for emergencies
* 1x [Reraiser](https://www.bg-wiki.com/ffxi/Reraiser), for when the sixth Odin appears during a Dynamis Wave 3 boss

Food buffs are mostly optional, but they can be useful:

* [Rolanberry Daifuku](https://www.bg-wiki.com/ffxi/Rolan._Daifuku) has 50 Magic Accuracy, and can be purchased for 5000g from any [Curio Vendor Moogle](https://www.bg-wiki.com/ffxi/Curio_Vendor_Moogle). The high-quality version is not generally worth making or buying.
* [Tropical Crepe](https://www.bg-wiki.com/ffxi/Tropical_Crepe) has 90 Magic Accuracy, but must be crafted by a Culinarian.
* [Miso Ramen](https://www.bg-wiki.com/ffxi/Miso_Ramen) offers 50 Magic Evasion and up to 170 DEF. It is also crafted.

Use SCH as your subjob most of the time:

* [Light Arts](https://www.bg-wiki.com/ffxi/Light_Arts) gives 10% Fast Cast and recast for healing and enhancing spells
* [Accession](https://www.bg-wiki.com/ffxi/Accession) lets you spread a spell every two minutes to your group
* Other stratagems can speed up casting, reduce costs, and more.
* [Aurorastorm](https://www.bg-wiki.com/ffxi/Aurorastorm) gives you 15% to your healing potency, and other -storm spells are useful too
* [Sublimation](https://www.bg-wiki.com/ffxi/Sublimation) gives you MP refresh without needing to beg a RDM, BRD, or SMN

A RDM subjob can also be useful:

* 15% [Fast Cast](https://www.bg-wiki.com/ffxi/Fast_Cast) on all spells
* [Refresh](https://www.bg-wiki.com/ffxi/Refresh) is not very potent, but you can cast it on yourself consistently
* [Convert](https://www.bg-wiki.com/ffxi/Convert) is a full MP restore every 10 minutes
* [Phalanx](https://www.bg-wiki.com/ffxi/Phalanx) further reduces your damage taken and pairs well with Stoneskin
* Access to more debuffs/Enfeebling spells

There are five WHM job abilities you should care about:

* [Afflatus Solace](https://www.bg-wiki.com/ffxi/Afflatus_Solace) should be your default option. Make sure Solace is active before you start fights. This job ability applies cureskin when you use a Cure spell, and is a critical tool for mitigating tank damage over time. Cureskin will not occur if your target is already at full health.
* [Afflatus Misery](https://www.bg-wiki.com/ffxi/Afflatus_Misery) is essential for rapidly removing debuffs. While Misery is active, you can use Esuna to remove debuffs from your entire group when you also have the same debuffs on yourself. This is especially useful for Amnesia, as well as fights where a monster uses multiple debuffs at the same time. For example, you should switch to Misery just before fighting RDM and BLU monsters in Dynamis, because these monsters tend to debuff your entire party rapidly. Switch back to Solace when you no longer need Misery.
* [Devotion](https://www.bg-wiki.com/ffxi/Devotion) helps your tanks (and less often, other mage jobs) avoid downtime by restoring their MP. Remember to heal yourself after you use it.
* [Sacrosanctity](https://www.bg-wiki.com/ffxi/Sacrosanctity) helps prevent deaths from monsters' Mijin Gakure, Astral Flow, and other major damage abilities. The buff is removed by the next magic damage hit, even if that damage would have been -1 HP from Ice Spikes, so time your use carefully.
* Use [Asylum](https://www.bg-wiki.com/ffxi/Asylum) for bosses that have nasty debuffs. It only lasts 30 seconds.

And three WHM job abilities that are still useful, but less so:

* [Divine Seal](https://www.bg-wiki.com/ffxi/Divine_Seal) can double a heal or, like Accession, turn a status removal spell into an area effect. However, being able to heal big numbers is rarely needed after you reach 40+ Cure Potency, and Accession is almost always available.
* [Divine Caress](https://www.bg-wiki.com/ffxi/Divine_Caress) can prevent a monster from reapplying a debuff after you remove it. In practice, most boss monsters have high enough magic accuracy that they reapply it anyway. Consider using it for nastier debuffs, like Petrification.
* Save [Benediction](https://www.bg-wiki.com/ffxi/Benediction) for when you are completely out of MP, or when your party has a lot of debuffs that need _immediate_ removal.


## Responsible & Ethical Healing Practices

### Rule 1: Pay Attention
The first rule for WHM is to pay attention. If you cannot:
* Notify your party if you need to go away from your keyboard or "AFK" during fights
* Focus on your party's health, rather than damage dealing
* Watch monster animations and the chat log to maintain basic situational awareness
* Triage by making educated decisions about what to do next, from moment to moment

... then you should play a different job. A healer trust is better than a real player who can't do these things.

That said, you can't always heal through everything, and there will be times you need to choose between bad and worse outcomes. Your party members will die in one hit, go AFK without warning, forget to buff you, run away when you cast buff spells, run away when you try to heal them, and stand in the Firaga V. You yourself will press the wrong macro keys, heal the wrong person, die in one hit, and stand in the Firaga V. Your job is to do your best to keep everyone alive despite inevitable mistakes.

Focus your attention and efforts on essential party members first (tank jobs and yourself), then other support jobs, and finally damage dealers. Similarly, you should also take care of your party first and then help alliance members if you're able. 


### Rule 2: Be Prepared
There are always exceptions to these rules, and that's why the second rule is to be prepared. Are you fighting a new boss, or jumping into content you've never healed before? Do a little research. As a WHM, you want to know:
* Which monster abilities do lots of damage?
* Which monster abilities result in debuffs?
* Which monster abilities can be avoided by staying out of range?

Sometimes, this knowledge can be the difference between a successful fight and a wipe. Most of the time, it just makes your job a lot less stressful. If you're not convinced already, see the section "Sweat the Small Things" below for why you should care.


### Rule 3: Triage Smartly
The third and final rule for WHM is to triage smartly. Prevent imminent death, _then_ fix problems, and _last_ do improvements. Or, in more detail:

1. Heal party members with 25%/critical/red HP
2. Remove bad debuffs, like Doom, Petrify, Sleep, and Defense Down
3. Heal party members with 50%/low/orange HP
4. Remove annoying debuffs, like Dia, Paralyze, and Slow
5. Raise dead people
6. Heal party members with 75%/medium/yellow HP
7. Rebuff yourself with important buffs like Reraise and Aurorastorm
8. Remove minor debuffs, like Threnody, Blind, and Stat Downs
9. Prepare for incoming Bad Stuff™ by mitigating or preventing attacks
10. Rebuff yourself and party members

... and finally, if you are confident that you can avoid priorities 1-5 for the next few seconds:

11. Debuff monsters
12. Damage monsters with spells or your weapon

Even in the very best groups with the most ridiculously geared party members, this should be enough to keep you busy all the time. If you find yourself not doing anything for a minute or more, you're probably overlooking something that could help you and your party.


### When and How to Debuff
When you do not have a Red Mage available:
* Silence helps against monsters that can cast spells
* Addle gives you more time to react when a monster is no longer silenced
* Dia II reduce monster defense
* Paralyze and Slow reduce monster attack speed

Banish spells are not very potent for damage dealing, but they are very useful when fighting undead bosses and monsters. They reduce defense on all skeletons, ghosts, Fomor, and several other monster families. (Sadly, they have no effect on Dynamis monsters.) You should avoid casting Banishga unless you know that your tank has gained enmity on all nearby monsters.

As a WHM, you also have one crowd control spell: [Repose](https://www.bg-wiki.com/ffxi/Repose). This is a single-target, Light-elemental sleep spell with a long recast time. Repose is difficult to cast on higher-level monsters, but it can easily keep a Charmed player from causing more problems.


### Sweat the Small Things

Why you should bother? It sounds like a lot of work to look up fight mechanics, worry about Bar- spells, remove minor debuffs, and "try hard" in general. This is where we appeal to the selfish loot whore that we know lurks deep inside you. Even if you don't care about your party members—_isn't Raise in the game for a reason?_—paying a little attention to mechanics will make your life easier in the long run.

As an example, let's say your entire party gets hit by Drown. No big deal, it's just a tiny bit of damage plus STR Down. But a minute later, the monster uses Def Down + Magic Def Down on your entire party, and then it starts casting Meteor. Your tank is taking 20-50% more damage, you can't guarantee that your next Erase will remove the Magic Def Down debuff, and you've got 500+ damage coming in two seconds. This is not a situation you want to be in.

So, before your next fight:

1. Use your favorite search engine to look up the monster, battlefield, or zone name.
2. Note the interesting attacks it has, including attacks inherited from its monster family.
3. Cross-reference the attacks against the table below, and prepare to run away from the attack if you can.
4. Cast buffs that will mitigate or prevent the attack, and refresh them as necessary.

| Preventable Debuffs               | Barspells to use             |
|-----------------------------------|------------------------------|
| Addle, Amnesia, Disease/Plague    | Barfira + Baramnesra/Barvira |
| Bind, Paralyze		    | Barblizzara + Barparalyzra   |
| Gravity, Silence		    | Baraera + Barsilencera       |
| Petrify, Slow	   		    | Barstonra + Barpetra         |
| Stun				    | Barthundra                   |
| Poison			    | Barwatera + Barpoisonra      |
| Lullaby			    | Barsleepra                   |
| Blind, Sleep			    | Barblindra/Barsleepra        |

_This should only take a minute at the most._ You don't have to memorize all the monster's mechanics (or this debuff list), just look through and look for things you can prepare for ahead of time. Consider making a browser bookmark, post-it on your monitor, or similar note for yourself so that you can refer to common boss details quickly.

When a debuff has both an associated element and a bar-status spell, use both. For example, either Barparalyzra or Barblizzara will help reduce the chance that a monster can Paralyze you, while both together have an even higher chance of preventing Paralyze. Combine this with Divine Caress when people do get hit, and tough situations can become much less frantic.

For situations where a monster has lots of potential attacks, you should prevent the worst debuffs:
1. [Sleep](https://www.bg-wiki.com/ffxi/Sleep_(Status)), [Stun](https://www.bg-wiki.com/ffxi/Stun_(Status)), and [Amnesia](https://www.bg-wiki.com/ffxi/Amnesia) can prevent a player from doing most things.
2. [Paralyze](https://www.bg-wiki.com/ffxi/Paralyze_(Status)) can waste job abilities and interrupt many other actions.
3. [Silence](https://www.bg-wiki.com/ffxi/Silence_(Status)), [Bind](https://www.bg-wiki.com/ffxi/Bind_(Status)), and [Gravity](https://www.bg-wiki.com/ffxi/Gravity) make it harder for your party to attack new targets or react to threats.
4. [Disease](https://www.bg-wiki.com/ffxi/Disease)/[Plague](https://www.bg-wiki.com/ffxi/Plague), [Blind](https://www.bg-wiki.com/ffxi/Blind_(Status)), [Addle](https://www.bg-wiki.com/ffxi/Addle_(Status)), and [Slow](https://www.bg-wiki.com/ffxi/Slow_(Status)) reduce your party's damage and healing output.
5. [Poison](https://www.bg-wiki.com/ffxi/Poison_(Status)) and other damage over time effects make you have to heal more.

Some fights will change the priority of debuffs. For example, a monster may have a poison Area of Effect (AoE) aura that does 300 damage every 3 seconds, in addition to another attack that can Paralyze a single target. Barwatera + Barpoisonra would reduce the number of people you have to remove Poison from, saving you both time and MP. In this case, preventing the Poison would be more useful than preventing an occasional Paralyze.

Beyond Bar- spells, use Stoneskin and Regen IV to prevent or mitigate pure damage. Try to cast these before the attack happens.
* [Stoneskin](https://www.bg-wiki.com/ffxi/Stoneskin) requires Accession to cast on party members. Blue Mages and Summoners can cast Diamondhide or Earthen Ward instead; they can cast those spells more often, but your Stoneskin will likely absorb more damage. Stoneskin is also one of the few ways to "heal" a player that has the ["Super Curse" debuff](https://www.bg-wiki.com/ffxi/Curse_(HP_Recovery)).
* [Regen IV](https://www.bg-wiki.com/ffxi/Regen_IV) can be cast on party members one at a time, but it also works well with Accession. You should keep Regen on your tank almost all the time. If you have a Scholar that can cast Regen V, let them do that instead. You should feel free to overwrite Regen IV from a RUN tank as soon as you have a Regen set with at least one potency improvement.
* The primary advantage of these spells is they give you a temporary reprieve from healing so you can focus on incoming debuffs or other, bigger problems. However, these spells also save you MP.


### Buffs

White Mages have many useful buffs, both for yourself and others. This list is in rough order of priority.

1. Keep Reraise on yourself at all times.
	* This includes right after you get up from KO and are still Weakened.
	* You may want to cast Haste on yourself first, if you think you may die again soon, to reduce the Reraise recast timer.
2. Keep Aurorastorm on yourself at all times for up to +15% heal potency.
	* The full potency requires a Korin Obi or Hachirin-no-Obi (see "Notable Gear", below).
	* This starts to matter less when you have absurd levels of Cure Potency II, but 15% is still 15%.
	* Ask other players if they want -storm spells before casting them automatically.
3. As mentioned before, keep Afflatus Solace active unless you have a reason to use Afflatus Misery.
4. Keep both Haste and Aquaveil on yourself to reduce your spell recast timers and spell interruption chance.
	* Consider using Accession + Aquaveil if you have lots of casters in your party, even if it's just five melee jobs all with /NIN.
	* Haste doesn't work with Accession, unfortunately. Get a BRD or GEO to help.
5. Maintain Protectra V and Shellra V on your party at all times.
	* Paladins' Shield Barrier trait means they can cast a better Protect. Let them do it.
	* Recast these as soon as possible on people you Raise.
6. Maintain appropriate Bar-element and Bar-status spells for the current fight.
7. Maintain Boost-STR for most groups.
	* Use Boost-DEX if your group is missing lots of attacks, or if your group's biggest damage dealers are THF, DNC, NIN, and BLU.
	* Use Boost-AGI if your group's biggest damage dealers are RNG and COR.
	* Use Boost-INT if your group has a majority of BLM, GEO, RDM, and SCH.
	* Use Boost-MND if you are away from the rest of your group, or if you desperately need to avoid Silence/Slow/Paralyze resists.
	* Boost-CHR is useful when feeding junk buffs to monsters that absorb buffs.
	* Boost-VIT is generally useless.
8. Maintain Auspice for most groups.
	* Auspice adds 10-25 Subtle Blow (cap 50) to everyone nearby.
	* Most damage dealers do not have much Subtle Blow in their TP sets, so monsters gain TP very rapidly from being hit.
	* Auspice will overwrite most RDM En-spells, but will not overwrite Enlight (PLD) or Endark (DRK).
9. Maintain Sublimation on yourself.
	* Sublimation gets less essential as your gear gets better. But even with +6 Refresh or more in your idle set, it is useful both as backup MP and for negating Sleep/Lullaby.
	* Sublimation is useless while Weakened, and stops charging when you take significant damage.
	* It will not stack with Refresh or Refresh II, will be overwritten by Refresh III, and stacks with Ballads. Make friends with your BRD!

### Merits and Job Points

Initially, you should invest WHM merit points as follows:
```
5	Cure Cast Time
5	Bar Spell Effect
5	Devotion
5	Afflatus Solace
```

As your Precast set (see the next section) reaches 40-80 Fast Cast, move points from Cure Cast Time to Regen Effect so that your merits are instead:
```
0	Cure Cast Time
5	Regen Effect
```

As you gain job points, spend them in this order:
1. Afflatus Solace Effect
2. Regen Duration
3. Bar Spell Effect
4. Magic Accuracy Bonus
5. Asylum Effect
6. Sacrosanctity Effect
7. (all others)

From your Job Point gifts, Reraise IV is excellent. Full Cure can be very useful, but it requires you to have Refresh, Ballad, or Sublimation available to restore your MP afterward.

## Gear

This guide focuses mostly on beginning gear, with notes on a few key pieces and job-specific equipment (JSE) that you should upgrade. For complete gear recommendations and sets, see [the FFXIAH WHM guide, v3](https://ffxiah.com/forum/topic/55005/on-healing-hands-a-comprehensive-whm-guide-v3/).


### Basic Sets and Their Priorities

Your immediate goal is to start building three basic sets, and reach some minimum stat values with each one:

1. **Precast**: 30 Fast Cast
	* This set should be automatically equipped before you cast spells. Other sets are also referred to as "midcast" sets.
	* For now, you'll also use this set for -na spells and Raise spells to minimize their recast times.
2. **Healing**: 30 Cure Potency
	* Your biggest goal is to get 30 Cure Potency by any combination of gear possible.
	* Equip items with -Enmity or Conserve MP in other slots.
3. **Idle**: -20 Damage Taken and +2 Refresh
	* Yes, you want a [Defending Ring](https://www.bg-wiki.com/ffxi/Defending_Ring) eventually, just like every other job.
	* Consider purchasing a pair of [Herald's Gaiters](https://www.bg-wiki.com/ffxi/Herald%27s_Gaiters) for idle movement speed. Running away is great for avoiding damage!
	* Your GearSwap lua file should automatically equip this set after finishing any other action.
	* Equip items with high DEF or Magic Evasion in other slots.

When you have at least those three sets ready, start building a few more:

4. **Enhancing**: +20% Enhancing Duration
	* Acquire a full set of [Telchine gear](https://www.bg-wiki.com/ffxi/Category:Alluvion_Skirmish_Armor#Telchine_Armor_Set), and [augment it](https://www.bg-wiki.com/ffxi/Alluvion_Skirmish_Armor) with [Divainy-Gamainy](https://www.bg-wiki.com/ffxi/Divainy-Gamainy).
	* You will need Snowslit/Snowdim normal quality or +1 stones for Magic Evasion, Leafdim +1 and +2 stones for Conserve MP, and Duskdim +1 and +2 stones for Enhancing Magic Duration.
5. **Cursna**: +20 Cursna success rate
	* Purchase at least one [Ephedra Ring](https://www.bg-wiki.com/ffxi/Ephedra_Ring) and a [Malison Medallion](https://www.bg-wiki.com/ffxi/Malison_Medallion) to get started, and build at least one WHM Ambuscade cape.
	* Equip items with Healing Magic skill and Haste/Fast Cast in slots that do not have "Cursna +XX" potency.
6. **Enfeebling**: +50 Magic Accuracy
	* MND, Magic Accuracy, and Enfeebling Skill items are all helpful.
	* Equip items with Conserve MP, Haste, and Fast Cast in other slots.


### Long-Term Set Goals

At this point, you are making your existing sets better, or making very specific sets for more niche purposes. Note that many of these sets have Conserve MP as a preferred stat. You don't need to build a Conserve MP set specifically, but filling gaps in each set with Conserve MP will make you much more self-sufficient.

**Idle Set**: -50% Damage Taken (DT) -> Refresh -> Magic Evasion
<br />You will eventually want three different idle sets that individually maximize refresh, -Damage Taken, or magic evasion.

**Precast Set**: 80 Fast Cast
* 80 is a hard cap for most content. You only need ~70 with a /SCH subjob, or ~65 for a /RDM subjob.
* Do not include Quick Magic ("Occ. Quickens Spellcasting") gear in this set.
* Gear in this set can be useful for reducing recast timers, when included in other sets.

**Quick Set**: 10 Quick Magic -> Conserve MP -> (Haste/Fast Cast)
* Use this set for casting Raise/Reraise/Arise, teleport spells, and all -na spells (except for Cursna).
* If you use this for Erase, make sure your set includes a [Cleric's Torque](https://www.bg-wiki.com/ffxi/Cleric's_Torque).

**Healing Set**
<br />You should eventually have separate sets for Cura/Curaga spells, because they do not benefit from Afflatus Solace. The stat priorities are, in this order:
1. 30 Cure Potency II (hard cap)
2. Afflatus Solace potency (as much as you can get; not for Curaga)
3. 50 Cure Potency (hard cap)
4. -50 Enmity (hard cap)
5. Conserve MP
6. (1 healing skill == 2 MND == 4 VIT) for additional Cure healing, or (5 healing skill == 1 MND == 3 VIT) for Curaga

Initially, you will not have many options for Cure Potency II or Afflatus Solace potency, and it'll be a struggle to even get 50 Cure Potency. You will have more gear options to mix and match eventually.

**Cursna Set**: Cursna +xx -> Healing Magic skill -> (Haste/Fast Cast) -> Conserve MP
<br />When starting out, you should expect to cast Cursna 3-4 times per Doom. See [Chiaia's wonderful Cursna calculator](http://chiaia.optic-ice.com/Cursna.html) for more information on how these stats translate to % success rate.

**Enhancing Set**: Enhancing Magic Duration -> Conserve MP
<br />You should eventually use separate sets for Regen, Bar- spells, and Enhancing Skill (Boost- spells), each of which have equipment that boosts their potencies. However, all of those sets can use this set as their base.

**Enfeebling**: (Magic Accuracy/Enfeebling Magic skill) -> MND -> Conserve MP
<br />If you regularly use a /RDM subjob, consider making a separate INT-based enfeebling set.


### Damage Sets

Most parties will not be structured to give you damage-dealing buffs. Still, you can solo your own Apex monsters with trusts if you are prepared to make the appropriate sets.

**Nuking Set**: (Magic Atk. Bonus/Magic damage) -> MND -> (Magic Accuracy/Divine Magic skill) -> Haste
* Initially, your nuke set will look very similar to your enfeebling set.
* Healing with Afflatus Solace active will increase your Holy/Holy II spell damage.
* Consider a separate set with the Magic Burst Damage stat.

**TP Set**: Accuracy -> (Double/Triple/Quad Attack) -> Store TP -> DEX
* When in doubt, aim for 1200 accuracy without food buffs. Use `/checkparam` to see your current accuracy.
* Consider separate sets for content that requires high, medium, and low accuracy.

**Weaponskill Sets**: Attack -> Weapon Skill Damage -> (varies)
* Each weapon skill has its own stat priorities, but in general, you need as much Attack as you can get.
* Consider building sets for Hexa Strike, Black Halo, and Realmrazer specifically.
* You will still need some accuracy in this set, especially for multi-hit weapon skills like Hexa Strike.
* Mystic Boon is excellent for restoring MP, but will take some extra work to acquire.


### The JSE Gear Journey

Collect ilvl 109 versions of your Artifact (Theophany), [Relic (Piety)](https://www.bg-wiki.com/ffxi/Piety_Attire_Set), and [Empyrean (Ebers)](https://www.bg-wiki.com/ffxi/Ebers_Attire_Set) gear in this order:

1. [Ebers Pantaloons](https://www.bg-wiki.com/ffxi/Ebers_Pantaloons) (E legs)
2. [Ebers Bliaut](https://www.bg-wiki.com/ffxi/Ebers_Briault) (E body)
3. [Ebers Cap](https://www.bg-wiki.com/ffxi/Ebers_Cap) (E head)
4. [Piety Bliaut](https://www.bg-wiki.com/ffxi/Piety_Briault) (R body)
5. [Piety Pantaloons](https://www.bg-wiki.com/ffxi/Piety_Pantaloons) (R legs)
6. [Ebers Mitts](https://www.bg-wiki.com/ffxi/Ebers_Mitts) (E hands)
7. [Theophany Pantaloons](https://www.bg-wiki.com/ffxi/Theophany_Attire_Set) (A legs)
8. [Theophany Mitts](https://www.bg-wiki.com/ffxi/Theophany_Mitts) (A hands)
9. [Theophany Bliault](https://www.bg-wiki.com/ffxi/Theophany_Briault) (A body)

The Ebers Pantaloons should be the very first thing you upgrade. The general priority for other upgrades is similar:

* Artifact/Theophany: hands -> legs -> body -> (head/feet optional)
* Relic/Piety: body -> legs -> (head/hands/feet optional)
* Empyrean/Ebers: legs -> body -> head -> hands -> (feet optional)

You should work towards maximum (+3/+3/+1) upgrades for these non-optional pieces. You should also collect the [Inyanga Tiara](https://www.bg-wiki.com/ffxi/Inyanga_Tiara) for a Regen set and [Inyanga Jubbah](https://www.bg-wiki.com/ffxi/Inyanga_Jubbah) for your Precast set. Both are from Ambuscade, and you should upgrade both of them to +2 when possible.


### Other JSE Gear

Most WHM job-specific equipment is useful in some situations, but the optional pieces not required for a WHM's core purposes: healing, erasing, and buffing.

* Artifact: [Theophany Duckbills +3](https://www.bg-wiki.com/ffxi/Theophany_Duckbills_%2B3) are useful for enfeebling.
* Relic: [Piety Mitts +3](https://www.bg-wiki.com/ffxi/Piety_Mitts_%2B3) are good for divine magic. You may also want to acquire the 109 [Piety Cap](https://www.bg-wiki.com/ffxi/Piety_Cap) for augmenting Devotion, and the 109 [Piety Duckbills](https://www.bg-wiki.com/ffxi/Piety_Duckbills) for Afflatus Solace, but they are only worth upgrading to +3 if you plan to melee.
* Empyrean: [Ebers Duckbills +1](https://www.bg-wiki.com/ffxi/Ebers_Duckbills_%2B1) are useful for Auspice and Bar-spells.
* Ambuscade: [Inyanga Dastanas +2](https://www.bg-wiki.com/ffxi/Inyanga_Dastanas_%2B2) are good for INT-based enfeebling. Other Inyanga pieces are useful for idle magic evasion and defense.
* Ambuscade: Ayanmo items can fill in gaps in your idle set for overall -DT (reducing Damage Taken). [Ayanmo Corazza +2](https://www.bg-wiki.com/ffxi/Ayanmo_Corazza_%2B2) is notable for its Double Attack +7% for melee sets.


### Notable Gear

If you're just starting out:

* Purchase a [Light Staff](https://www.bg-wiki.com/ffxi/Light_Staff), [Apollo's Staff](https://www.bg-wiki.com/ffxi/Apollo%27s_Staff), [Iridal Staff](https://www.bg-wiki.com/ffxi/Iridal_Staff), or [Chatoyant Staff](https://www.bg-wiki.com/ffxi/Chatoyant_Staff) as soon as possible.
* Pair the staff with a [Korin Obi](https://www.bg-wiki.com/ffxi/Korin_Obi) or [Hachirin-no-Obi](https://www.bg-wiki.com/ffxi/Hachirin-no-Obi) in your healing set, and you're all set to use Aurorastorm for +15% healing.
* [Homiliary](https://www.bg-wiki.com/ffxi/Homiliary) comes from an easy Adoulin quest and offers +1 Refresh for your idle set.
* [Glorious Earring](https://www.bg-wiki.com/ffxi/Glorious_Earring) is also easily questable, gives Cure Potency II, and is best in slot eventually.
* The [Telchine set](https://www.bg-wiki.com/ffxi/Category:Alluvion_Skirmish_Armor#Telchine_Armor_Set) can be augmented with up to (combined) +50% Enhancing Duration and +25 Conserve MP.
* [Sanctity Necklace](https://www.bg-wiki.com/ffxi/Sanctity_Necklace) is available for one day's worth of Domain Incursion points and can help fill gaps in multiple sets.

Medium effort, big reward:

* [Malignance Pole](https://www.bg-wiki.com/ffxi/Malignance_Pole) has 20% -DT, which is a very large chunk (20/50 cap) for one item.
* [Kaja Rod](https://www.bg-wiki.com/ffxi/Kaja_Rod) offers a lot of enfeebling and nuking stats. The Black Halo damage is nice, too.
* [Embla Sash](https://www.bg-wiki.com/ffxi/Embla_Sash) is 1000 Domain Incursion points, but it's best-in-slot for your Enhancing set and the other stats are useful too.
* [Lengo Pants](https://www.bg-wiki.com/ffxi/Lengo_Pants), [Fanatic Gloves](https://www.bg-wiki.com/ffxi/Fanatic_Gloves), and [Serenity](https://www.bg-wiki.com/ffxi/Serenity) are all useful pieces from Sinister Reign, with and without augments.
* [Cleric's Torque](https://www.bg-wiki.com/ffxi/Cleric's_Torque) lets you Erase two debuffs at once. The high-quality versions have nice augments, but are entirely optional.


### Ambuscade Capes

I recommend at [making least two Ambuscade capes](https://www.bg-wiki.com/ffxi/Category:JSE_Capes#Ambuscade_Capes). You will have to give up a major source of either Fast Cast or Cure Potency if you only make one. 

**Cape 1: Idle and Precast sets**
* Thread: HP +60
* Dust: Evasion +20/Magic Evasion +20
* Sap: Fast Cast +10%
* Resin: Damage Taken -5%
* Dye: Magic Evasion +10

**Cape 2: Healing, Cursna, and Enfeebling sets**
* Thread: MND +20
* Dust: Magic Accuracy +20/Magic Damage +20
* Sap: "Cure" Potency +10%
* Resin: Damage Taken -5%
* Dye: Magic Accuracy +10

If you choose to build melee sets, you should also build one cape for TP gain (Accuracy + Double Attack) and at least one cape for weaponskills (MND, Attack, and Weapon Skill Damage).

### Should I Make an Ultimate Weapon?

This is a personal decision that only you can make. I recommend that you avoid building any until you are sure that you want to play WHM at its highest level.

* [Yagrush](https://www.bg-wiki.com/ffxi/Yagrush), our Mythic weapon, has clear value in most circumstances. Even at lv75 with no upgrades, you will rarely need to touch Afflatus Misery, and when fully upgraded it offers a stunning +70 Magic Accuracy. Its weaponskill, [Mystic Boon](https://www.bg-wiki.com/ffxi/Mystic_Boon), outclasses most other MP restore weaponskills, and is worth unlocking separately if you choose to melee with WHM.
* [Gambanteinn](https://www.bg-wiki.com/ffxi/Gambanteinn), the Empyrean weapon, is best-in-slot for Cursna. It effectively doubles your chance of successfully removing Curse or Doom. However, the Cursna stat is not present until its nearly final form, so it is a major investment. Its weaponskill, [Dagan](https://www.bg-wiki.com/ffxi/Dagan), is also useful because you can restore HP/MP without an enemy target.
* [Tishtrya](https://www.bg-wiki.com/ffxi/Tishtrya), the Aeonic weapon, is best-in-slot for melee damage but is of little use outside that niche. Its TP Bonus outclasses nearly every other combination of weapon and weaponskill. It augments [Realmrazer](https://www.bg-wiki.com/ffxi/Realmrazer), but you can unlock that with merit points.
* [Mjollnir](https://www.bg-wiki.com/ffxi/Mjollnir), our Relic weapon, is not really worth making at all. It is outclassed by Tishtrya for melee, and its other stats are not particularly special. [Randgrith](https://www.bg-wiki.com/ffxi/Randgrith) is also not particularly special.


## Lua Example

These files are provided _without support_. Do not contact the author to request help. There are plenty of lua tutorials online, including FFXI-specific tutorials.

* [WHM specific](config/YourName_WHM.lua)
* [Include file](config/YourName_inc.lua)

To use these files:
1. Download and copy both files to your `/Windower4/addons/GearSwap/data/` folder.
2. Rename both files so that `YourName` is instead your character's name.
3. Rename the references on lines 2 and 7 in the _WHM.lua file so that the filenames match.
4. Start the game. If you are already in game, switch to your WHM job or type `//gs reload`.
