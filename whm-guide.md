# Temas' Guide to Being an Effective WHM

> _tri·age (n): the sorting of and allocation of treatment to patients and especially battle and disaster victims according to a system of priorities designed to maximize the number of survivors_

This guide explains how to gear up and play a White Mage to acceptable levels with the goal of eventually acquiring at least a few Best-In-Slot (BiS) pieces. It does not list [comprehensive gear sets](https://ffxiah.com/forum/topic/55005/on-healing-hands-a-comprehensive-whm-guide-v3/) or [specific end-game fight strategies](https://bg-wiki.com/). There are already excellent guides for those things; this guide is to help you get started.


## Expectations and Assumptions

You should know and understand the following concepts:

* `buff` and `debuff` are positive (Enhancing Magic) and negative (Enfeebling Magic) status effects
* `cureskin` is the temporary stoneskin effect applied when you heal with Afflatus Solace active
* `-na spells` remove debuffs; they include Cursna, Stona, Erase, and Esuna among others
* `bar- spells` include buffs that reduce elemental damage (e.g., Barfira) and the chance of status debuffs (e.g., Barpetrify)

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

Use SCH as your subjob most of the time:

* [Light Arts](https://www.bg-wiki.com/ffxi/Light_Arts) gives 10% Fast Cast and recast for healing and enhancing spells
* [Accession](https://www.bg-wiki.com/ffxi/Accession) lets you spread a spell every two minutes to your group
* Other stratagems can speed up casting, reduce costs, and more.
* [Aurorastorm](https://www.bg-wiki.com/ffxi/Aurorastorm) gives you 15% to your healing potency, and other -storm spells are useful too
* [Sublimation](https://www.bg-wiki.com/ffxi/Sublimation) gives you MP refresh without needing to beg a RDM, BRD, or SMN

A RDM subjob can also be useful:

* 15% [Fast Cast](https://www.bg-wiki.com/ffxi/Fast_Cast) on all spells, not just your current Light/Dark Arts
* [Refresh](https://www.bg-wiki.com/ffxi/Refresh) is not very potent, but you can cast it on yourself consistently
* [Convert](https://www.bg-wiki.com/ffxi/Convert) is a full MP restore every 10 minutes
* [Phalanx](https://www.bg-wiki.com/ffxi/Phalanx) further reduces your damage taken and pairs well with Stoneskin
* Access to more debuffs/Enfeebling spells

There are five WHM job abilities you should care about:

* [Afflatus Solace](https://www.bg-wiki.com/ffxi/Afflatus_Solace) should be your default option. Make sure it's active before you start fights.
* [Afflatus Misery](https://www.bg-wiki.com/ffxi/Afflatus_Misery) is mostly useful until if and when you get a Yagrush. While Misery is active, you can use Esuna to remove debuffs from your entire group if you also have the same debuff. This is especially useful for Amnesia, as well as fights where a monster uses multiple debuffs at the same time. For example, you should switch to Misery just before fighting RDM and BLU monsters in Dynamis, because these monsters tend to debuff your entire party rapidly. But when you're done fighting those monsters, switch back to Solace.
* [Devotion](https://www.bg-wiki.com/ffxi/Devotion) helps your tanks (and less often, other mage jobs) avoid downtime by restoring their MP. Remember to heal yourself after, though.
* [Sacrosanctity](https://www.bg-wiki.com/ffxi/Sacrosanctity) helps prevent deaths from monsters' Mijin Gakure, Astral Flow, and other major damage abilities.
* Use [Asylum](https://www.bg-wiki.com/ffxi/Asylum) for bosses that have nasty debuffs. It only lasts 30 seconds, though.

And three WHM job abilities that are still useful, but less so:

* [Divine Seal](https://www.bg-wiki.com/ffxi/Divine_Seal) can double a heal or (like Accession) turn a status removal spell into an area effect. However, being able to heal big numbers is rarely an issue after you get 40-50 cure potency, and Accession is almost always available.
* [Divine Caress](https://www.bg-wiki.com/ffxi/Divine_Caress) can prevent a monster from reapplying a debuff after you remove it. In practice, most boss monsters have high enough magic accuracy that they reapply it anyway. Consider using it for nastier debuffs, like Petrification.
* Save [Benediction](https://www.bg-wiki.com/ffxi/Benediction) for when you are out of MP, or when everyone has a lot of debuffs that need immediate removal.


## Responsible & Ethical Healing Practices

The first rule for WHM is to pay attention. If you cannot:
* Notify your party when you are away from your keyboard
* Focus on your party's health bars, rather than damage dealing
* Maintain basic situational awareness from monster animations and the chat log
* Triage and make educated decisions about what to do next, from moment to moment

... then you should play a different job. A healer trust is better than a real player who can't do these things.

That said, you can't always heal through everything, and there will often be times you have to choose between bad and worse outcomes. Your party members will get one-shot, go AFK without warning, forget to buff you, and stand in the Firaga V. You yourself will press the wrong macro key, heal the wrong person, get one-shot, and stand in the Firaga V. Your job is to do your best to keep everyone alive despite inevitable mistakes.

By default, you should focus your efforts on essential party members first (tank jobs and yourself), then support jobs, and finally damage dealers. Similarly, you should also take care of your party first and then help alliance members if you're able. There are always exceptions to these rules, and that's why ...

The second rule is to be prepared. Fighting a new boss, or jumping into content you've never healed before? Do a little research. As a WHM, you want to know:
* Which monster abilities do lots of damage?
* Which monster abilities result in debuffs?
* Which monster abilities can be avoided by staying out of range?

Sometimes, this knowledge can be the difference between a successful fight and a wipe. Most of the time, it just makes your job a lot less stressful. See the section "Sweat the Small Things" below for more.

The third and final rule for WHM is to triage smartly: prevent imminent death, then fix problems, then do improvements. Or, in more detail:

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

... and finally, IF you are confident that you can avoid priorities 1-5 for two seconds:

11. Debuff monsters
12. Damage monsters with spells or your weapon

Even in the very best groups with the most ridiculously geared party members, this should be enough to keep you busy all the time. If you find yourself not doing anything for a minute or more, you're probably overlooking something that could help you and your party.


### Sweat the Small Things

Why you should bother? It sounds like a lot of work to look up fight mechanics, worry about bar-spells, remove the minor debuffs, and "try hard" in general. This is where we appeal to the selfish loot whore that we know lurks deep inside you. Even if you don't care about your party members--isn't Raise in the game for a reason?--paying a little attention to mechanics will 100% make your life easier in the long run.

As an example, let's say your entire party gets hit by Drown. No big deal, it's just a tiny bit of damage. But a minute later, the monster uses Def Down + Magic Def Down on your entire party, and then it starts casting Meteor. Your tank is taking 20-50% more damage, you can't guarantee that your next Erase will remove the Magic Def Down debuff, and you've got 500+ damage coming in two seconds. This is not a situation you want to be in.

So, before your next fight:

1. Use your favorite search engine to look up the monster, battlefield, or zone name.
2. Make a note of all the interesting attacks it has, including attacks inherited from its monster family.
3. Cross-reference the attacks against the table here.
4. Cast buffs that will mitigate or prevent the attack and refresh them as necessary.

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

This should only take a minute or two at the most. You don't have to memorize all the monster's mechanics (or this debuff list), but you should strongly consider making a bookmark, post-it on your monitor, or similar note for yourself. If you have a second monitor, move Netflix off to the side and keep a browser window handy as your cheat sheet.

When a debuff has both an associated element and a bar-status spell, use both. For example, either Barparalyzra or Barblizzara will help reduce the chance that a monster can Paralyze you, while both together have an even higher chance of preventing Paralyze.

For situations where a monster has lots of potential attacks, prevent the worst ones first. By default:
1. [Sleep](https://www.bg-wiki.com/ffxi/Sleep_(Status)), [Stun](https://www.bg-wiki.com/ffxi/Stun_(Status)), and [Amnesia](https://www.bg-wiki.com/ffxi/Amnesia) can prevent a player from doing most things.
2. [Paralyze](https://www.bg-wiki.com/ffxi/Paralyze_(Status)) can waste job abilities and interrupt many other actions.
3. [Silence](https://www.bg-wiki.com/ffxi/Silence_(Status)), [Bind](https://www.bg-wiki.com/ffxi/Bind_(Status)), and [Gravity](https://www.bg-wiki.com/ffxi/Gravity) make it harder for your party to attack new targets or react to threats.
4. [Disease](https://www.bg-wiki.com/ffxi/Disease)/[Plague](https://www.bg-wiki.com/ffxi/Plague), [Blind](https://www.bg-wiki.com/ffxi/Blind_(Status)), [Addle](https://www.bg-wiki.com/ffxi/Addle_(Status)), and [Slow](https://www.bg-wiki.com/ffxi/Slow_(Status)) reduce your party's damage and healing output.
5. [Poison](https://www.bg-wiki.com/ffxi/Poison_(Status)) and other damage over time effects make you have to heal more.

Remember that some fights will change the priority of debuffs. For example, a monster may have a poison Area of Effect (AoE) attack that does 300 damage every 3 seconds, as well as be able to cast Paralyze on a single target. Barwatera + Barpoisonra would reduce the number of people you have to remove Poison from, and save you time and MP curing the people who got hit. In this case, preventing the Poison would be more useful than preventing the occasional Paralyze.

Beyond bar-spells, use Stoneskin and Regen IV to prevent or mitigate pure damage. Try to cast these before the attack happens.
* [Stoneskin](https://www.bg-wiki.com/ffxi/Stoneskin) requires Accession to cast on party members. While a Blue Mage or Summoner can cast Diamondhide or Earthen Ward instead, your Stoneskin will probably absorb more damage than theirs.
* [Regen IV](https://www.bg-wiki.com/ffxi/Regen_IV) can be cast on party members by default, but it also works with Accession. You should keep Regen on your tank almost all the time. If you have a Scholar that can cast Regen V, let them do that instead. You should feel free to overwrite Regen IV from a RUN tank as soon as you have a Regen set with at least one potency improvement.
* The primary advantage of these spells is they give you a temporary reprieve from healing so you can focus on incoming debuffs or other, bigger problems. However, these spells also save you MP.


### Buffs

White Mages have many useful buffs, both for yourself and others. This list is in rough order of priority.

1. Keep Reraise on yourself at all times.
    * This includes right after you get up and are still Weakened.
    * You may want to cast Haste on yourself first, if you think you may die again soon, to reduce the recast.
2. Keep Aurorastorm on yourself at all times for +15% heal potency.
	* This starts to matter less at absurd levels of Cure Potency II, but 15% is still 15%.
	* Ask other players if they want -storm spells before giving them out automatically.
3. As mentioned before, keep Afflatus Solace active unless you have a reason to use Afflatus Misery.
4. Keep Haste and Aquaveil on yourself to reduce your spell recast timers and interruption chance.
	* Consider using Accession + Aquaveil if you have lots of casters in your party, even if it's just five melee jobs all with /NIN.
	* Haste doesn't work with Accession, unfortunately. Get a BRD or GEO to help.
5. Maintain Protectra V and Shellra V on your party at all times.
    * Paladins' Shield Barrier trait means they can cast a better Protect. Let them do it.
    * Recast these as soon as possible on people you Raise.
6. Maintain Boost-STR for most groups.
	* Use Boost-DEX if your group is missing lots of attacks, or if your group's biggest damage dealers are THF, DNC, NIN, and BLU.
	* Use Boost-AGI if your group has a majority of RNG and COR.
	* Use Boost-INT if your group has a majority of BLM, GEO, RDM, and SCH.
	* Use Boost-MND if it's just you, or if you desperately need to avoid Silence/Slow/Paralyze resists.
	* Boost-VIT and CHR are only useful for feeding junk buffs to monsters that absorb them.
7. Maintain Auspice for most groups.
	* Auspice adds 10-25 Subtle Blow (cap 50) to everyone nearby.
	* Most damage dealers do not have much Subtle Blow in their TP sets, so monsters gain TP very rapidly from being hit.
	* Auspice will overwrite most RDM En-spells, but will not overwrite Enlight (PLD) or Endark (DRK).
8. Maintain Sublimation on yourself.
	* Remember that it's useless while Weakened, and stops charging when you take significant damage.
	* Sublimation gets less essential as your gear gets better. But even with +6 Refresh or more in your idle set, it is useful both as backup MP and for negating Sleep/Lullaby.
	* It will not stack with Refresh or Refresh II, will be overwritten by Refresh III, and stacks with Ballads. Make friends with your BRD!

### Merits and Job Points

Initially, you should invest WHM merit points as follows:
```
5	Cure Cast Time
5	Bar Spell Effect
5	Devotion
5	Animus Solace
```

As your Precast set reaches 40-80 Fast Cast, move points from Cure Cast Time to Regen Effect so that your merits are instead:
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

## Gear

### Basic Sets and Their Priorities

Your immediate goal is to start building three basic sets, and aim for some minimum stats with each one:

1. Precast (30 Fast Cast)
	* This set should be automatically equipped before you cast spells. Other sets are also referred to as "midcast" sets.
	* For now, you'll also use this set for -na spells and Raises to minimize their recast times.
2. Healing (30 Cure Potency)
	* Your biggest goal is to get 30 Cure Potency.
	* Equip items with -Enmity or Conserve MP in other slots
3. Idle (-20 Damage Taken, 2 Refresh)
	* Yes, you want a Defending Ring eventually, just like every other job.
	* Equip items with high DEF or Magic Evasion in other slots.
	* Consider purchasing a pair of Herald's Gaiters for idle movement speed. Running away is great for avoiding damage!

When you have at least those three sets ready, start building a few more:

4. Enhancing
	* Acquire a full set of Telchine gear, and [augment it](https://www.bg-wiki.com/ffxi/Alluvion_Skirmish_Armor) with [Divainy-Gamainy](https://www.bg-wiki.com/ffxi/Divainy-Gamainy).
	* To augment Telchine, get Snowslit and Snowdim NQ or +1 stones for Magic Evasion, Leafdim +1 and +2 stones for Conserve MP, and Duskdim +1 and +2 stones for Enhancing Magic Duration.
5. Cursna
	* Purchase at least one Ephedra Ring and a Malison Medallion to get started, and build at least one WHM Ambuscade cape.
	* Equip items with Healing Magic skill and Haste/Fast Cast in slots that do not have "Cursna +XX" potency.
6. Enfeebling
	* MND, Magic Accuracy, and Enfeebling Skill items are all helpful.
	* Fill in the gaps with Conserve MP, Haste, and Fast Cast.


### Long-Term Set Goals

At this point, you are making your existing sets better, or making very specific sets for more niche purposes. Note that many of these sets have Conserve MP as a preferred stat. You don't need to build a Conserve MP set specifically, but filling gaps in each set with Conserve MP will make you much more self-sufficient.

**Idle Set**: -50 Damage Taken -> Refresh
<br />You will eventually want three idle sets: maximum refresh, maximum DT, and maximum magic evasion.

**Precast Set**: 80 Fast Cast (hard cap)
* SCH subjob with Light Arts active gives you 10 Fast Cast for healing spells.
* RDM subjob has 15 Fast Cast.

**Quick Set**: 10 Quick Magic -> Conserve MP -> Haste/Fast Cast
* Use this set for casting Raise/Reraise, Arise, teleport spells, and all -na spells (except for Cursna).
* If you use this for Erase, make sure your set includes the WHM necklace with Erase +1.

**Healing Set**
<br />You should eventually have separate sets for Cure and Cura/Curaga spells, because they do not benefit from Afflatus Solace. The stat priorities for healing are, in this order:
  1. Cure Potency II 30 (hard cap, but you won't reach this)
  2. Afflatus Solace potency (as much as you can get)
  3. Cure Potency 50 (hard cap)
  4. -50 Enmity (hard cap)
  5. Conserve MP
  6. (1 healing skill = 2 MND = 5 VIT) for additional healing output

Initially, you will not have many options for Cure Potency II or Afflatus Solace, and it'll be a struggle to get 50 Cure Potency. Eventually you'll get more gear options to mix and match.

**Cursna Set**: Cursna +xx -> Healing Magic skill -> (Haste/Fast Cast) -> Conserve MP
<br />When starting out, you should expect to cast Cursna 3-4 times per Doom. See [Chiaia's wonderful Cursna calculator](http://chiaia.optic-ice.com/Cursna.html) for more information on how these stats translate to % success rate.

**Enhancing Set**: Duration -> Conserve MP
<br />You should eventually use separate sets for Regen, Bar- spells, and Enhancing Skill (Boost- spells), each of which have equipment that boosts their potencies. However, all of those sets can use this set as their base.

**Enfeebling**: (MND/Magic Accuracy/Enfeebling Magic skill) -> Conserve MP
<br />If you regularly use a /RDM subjob, consider making a separate INT-based enfeebling set.

### Damage Sets

Most parties will not be structured to give you damage-dealing buffs. Still, you can solo your own Apex monsters with trusts if you are prepared to make the appropriate sets.

**Nuking Set**: (Magic Atk. Bonus/Magic damage) -> (MND/Magic Accuracy/Divine Magic skill) -> Haste
* Initially, your nuke set will look very similar to your enfeebling set.
* Healing with Afflatus Solace active will increase your Holy/Holy II spell damage.
* Consider a separate set with Magic Burst damage.

**TP Set**: Accuracy -> Double/Triple/Quad Attack -> Store TP -> DEX
* When in doubt, aim for 1200 accuracy without food buffs. Use `/checkparam` to see your current accuracy.
* Consider separate sets for content that requires high, medium, and low accuracy.

**Weaponskill Sets**: Attack -> Weapon Skill Damage -> (varies)
* Each weapon skill has its own stat priorities, but in general, you need as much Attack as you can get.
* Consider building sets for Hexa Strike, Black Halo, and Realmrazer specifically.
* Mystic Boon is excellent for restoring MP but involves more than other quests.


## The JSE Gear Journey

Collect ilvl 109 versions of your Artifact (Theophany), [Relic (Piety)](https://www.bg-wiki.com/ffxi/Piety_Attire_Set), and [Empyrean (Ebers)](https://www.bg-wiki.com/ffxi/Ebers_Attire_Set) gear in this order:

1. [Ebers Pantaloons](https://www.bg-wiki.com/ffxi/Ebers_Pantaloons) (E legs)
2. [Ebers Bliaut](https://www.bg-wiki.com/ffxi/Ebers_Briault) (E body)
3. [Ebers Cap](https://www.bg-wiki.com/ffxi/Ebers_Cap) (E head)
4. [Piety Briault](https://www.bg-wiki.com/ffxi/Piety_Briault) (R body)
5. [Piety Pantaloons](https://www.bg-wiki.com/ffxi/Piety_Pantaloons) (R legs)
6. [Ebers Mitts](https://www.bg-wiki.com/ffxi/Ebers_Mitts) (E hands)
7. [Theophany Pantaloons](https://www.bg-wiki.com/ffxi/Theophany_Attire_Set) (A legs)
8. [Theophany Mitts](https://www.bg-wiki.com/ffxi/Theophany_Mitts) (A hands)
9. [Theophany Briault](https://www.bg-wiki.com/ffxi/Theophany_Briault) (A body)

The Ebers Pantaloons should be the very first thing you upgrade. The general priority for other upgrades is similar:

* Artifact/Theophany: hands -> legs -> body -> (head/feet optional)
* Relic/Piety: body -> legs -> (head/hands/feet optional)
* Empyrean/Ebers: legs -> body -> head -> hands -> (feet optional)

... such that you work towards maximum (+3/+3/+1) upgrades for the non-optional pieces. You should also collect the Inyanga Tiara (head) and Inyanga Jubbah (body) from Ambuscade, and +2 both of them when possible.


### Notable Gear

If you're just starting out:

* Purchase a [Light Staff](https://www.bg-wiki.com/ffxi/Light_Staff), [Apollo's Staff](https://www.bg-wiki.com/ffxi/Apollo%27s_Staff), [Iridal Staff](https://www.bg-wiki.com/ffxi/Iridal_Staff), or [Chatoyant Staff](https://www.bg-wiki.com/ffxi/Chatoyant_Staff) as soon as possible.
* Pair the staff with a [Korin Obi](https://www.bg-wiki.com/ffxi/Korin_Obi) or [Hachirin-no-Obi](https://www.bg-wiki.com/ffxi/Hachirin-no-Obi) in your healing set, and you're all set to use Aurorastorm for +15% healing.
* [Homiliary](https://www.bg-wiki.com/ffxi/Homiliary) comes from an easy Adoulin quest and offers +1 Refresh for your idle set.
* [Glorious Earring](https://www.bg-wiki.com/ffxi/Glorious_Earring) is also easily questable, gives Cure Potency II, and is best in slot eventually.
* The [Telchine set](https://www.bg-wiki.com/ffxi/Category:Alluvion_Skirmish_Armor#Telchine_Armor_Set) can be augmented with up to (combined) +50% Enhancing Duration and 25 Conserve MP.
* [Sanctity Necklace](https://www.bg-wiki.com/ffxi/Sanctity_Necklace) is available for one day's worth of Domain Incursion points and can help fill gaps in multiple sets.

Medium effort, big reward:

* [Malignance Pole](https://www.bg-wiki.com/ffxi/Malignance_Pole) has 20% -DT, which is a very large chunk (20/50 cap) for one item.
* [Kaja Rod](https://www.bg-wiki.com/ffxi/Kaja_Rod) offers a lot of enfeebling and nuking stats, and significantly boosts your Black Halo damage.
* [Embla Sash](https://www.bg-wiki.com/ffxi/Embla_Sash) is 1000 Domain Incursion points, but it's best-in-slot for your Enhancing set and the other stats are useful too.
* [Lengo Pants](https://www.bg-wiki.com/ffxi/Lengo_Pants), [Fanatic Gloves](https://www.bg-wiki.com/ffxi/Fanatic_Gloves), and [Serenity](https://www.bg-wiki.com/ffxi/Serenity) are all useful pieces from Sinister Reign, with and without augments.
* [Cleric's Torque](https://www.bg-wiki.com/ffxi/Cleric's_Torque) lets you Erase two debuffs at once. The high-quality versions are nice, but entirely optional.


### Ambuscade Capes

I recommend at making least two capes. You will have to give up a major source of either Fast Cast or Cure Potency if you only make one.

Cape 1, Idle & Precast sets
* Thread: HP +60
* Dust: Evasion +20/Magic Evasion +20
* Sap: Fast Cast +10%
* Resin: Damage Taken -5%
* Dye: Magic Evasion +10

Cape 2, Healing & Enfeebling sets
* Thread: MND +20
* Dust: Magic Accuracy +20/Magic Damage +20
* Sap: "Cure" Potency +10%
* Resin: Damage Taken -5%
* Dye: Magic Accuracy +10

If you intend to melee, you'll also need at least two more:

Cape 3, TP set
* Thread: DEX +20
* Dust: Accuracy +20/Attack+20
* Sap: Double Attack +10%
* Resin: Damage Taken -5%
* Dye: Accuracy +10

Cape 4, Weapon Skill sets
* Thread: MND +20
* Dust: Accuracy +20/Attack+20
* Sap: Weapon Skill Damage +10%
* Resin: Damage Taken -5%
* Dye: Attack +10 --OR-- MND +10

### Other Gear

Most WHM job-specific equipment is useful, but not required for a WHM's core purposes: healing, erasing, and buffing. Also, this isn't a comprehensive gear guide.

* Artifact/Theophany Duckbills +3 are useful for enfeebling.
* Relic/Piety Mitts +3 is good for divine magic. Other Relic/Piety pieces are only useful for TP or weapon skill sets.
* Empyrean/Ebers Duckbills +1 are useful for Auspice and barspells.
* Ambuscade/Inyanga Dastanas +2 are good for INT-based enfeebling. Other Ambuscade/Inyanga pieces are useful for idle magic evasion and defense.
* Ambuscade/Ayanmo items can fill in gaps in your idle set for overall -DT (reducing Damage Taken).

For more gear recommendations and sets, see [the FFXIAH WHM guide, v3](https://ffxiah.com/forum/topic/55005/on-healing-hands-a-comprehensive-whm-guide-v3/).
