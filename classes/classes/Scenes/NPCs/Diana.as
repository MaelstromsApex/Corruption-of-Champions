/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Face;
	import classes.BodyParts.Hips;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.internals.*;
	
	use namespace CoC;
	
	public class Diana extends Monster
	{
		public var dianaScene:DianaFollower = SceneLib.dianaScene;
		
		private function spellCostMultiplier():Number {
			var multiplier:Number = 1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 10) multiplier -= 0.1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 30) multiplier -= 0.1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 70) multiplier -= 0.1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 150) multiplier -= 0.1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 310) multiplier -= 0.1;
			return multiplier;
		}
		public function spellCostHeal():Number {
			var cost:Number = 30;
			cost *= spellCostMultiplier();
			if (findPerk(PerkLib.NaturalHealingMinor) >= 0) cost -= 3;
			if (findPerk(PerkLib.WisenedHealer) >= 0) cost *= 2;
			return cost;
		}
		public function spellCostRegenerate():Number {
			var cost:Number = 50;
			cost *= spellCostMultiplier();
			if (findPerk(PerkLib.NaturalHealingMinor) >= 0) cost -= 5;
			if (findPerk(PerkLib.WisenedHealer) >= 0) cost *= 2;
			return cost;
		}
		public function soulskillCostManyBirds():Number {
			var cost:Number = 10;
			return cost;
		}
		
		public function HealMod():Number {
			var mod1:Number = 1;
			if (findPerk(PerkLib.WizardsFocus) >= 0) mod1 += .4;
			if (findPerk(PerkLib.SpellpowerHealing) >= 0) mod1 += .2;
			if (findPerk(PerkLib.NaturalHealingMinor) >= 0) mod1 += .3;
			return mod1;
		}
		public function SpellMod():Number {
			var mod2:Number = 1;
			//if (findPerk(PerkLib.Channeling) >= 0) mod2 += .1;
			//if (findPerk(PerkLib.JobSorcerer) >= 0) mod2 += .1;
			if (findPerk(PerkLib.WizardsFocus) >= 0) mod2 += .4;
			return mod2;
		}
		
		public function usingHealPill():void {
			var temp:Number = 50;
			temp += this.tou;
			outputText("She pop the small pill into her mouth and swallow. <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.");
			addHP(temp);
		}
		public function usingARC():void {
			outputText("She grab mana potion, pull the cork off and swiftly chug it down.");
			if (flags[kFLAGS.DIANA_LVL_UP] >= 5) mana += 240;
			else mana += 40;
		}
		
		public function usingManyBirdsSoulskill():void {
			outputText("She thrust her hand outwards with deadly intent, and in the blink of an eye a crystal shoots towards you.  Crystal hits you, dealing ");
			var soulforcecost:int = 10;// * soulskillCost() * soulskillcostmulti()
			soulforce -= soulforcecost;
			var damage:Number = inteligencescalingbonus();
			if (damage < 10) damage = 10;
			damage *= SpellMod();
			damage = Math.round(damage);
			player.takeMagicDamage(damage, true);
			outputText(" damage!");
		}
		
		public function usingRegenerateSpell():void {
			outputText("She focus on her body and its desire to end pain, trying to draw on her arousal without enhancing it.\n");
			var hpChange2:int = inte;
			if (findPerk(PerkLib.WisenedHealer) >= 0) hpChange2 += wis;
			createStatusEffect(StatusEffects.MonsterRegen2, 7, hpChange2, 0, 0);
			mana -= spellCostRegenerate();
			flags[kFLAGS.DIANA_SPELLS_CASTED]++;
		}
		
		public function usingHealSpell():void {
			var temp:Number = 0;
			temp += inteligencescalingbonus();
			if (findPerk(PerkLib.WisenedHealer) >= 0) temp += wisdomscalingbonus();
			temp *= HealMod();
			temp = Math.round(temp);
			if (flags[kFLAGS.DIANA_LVL_UP] < 2) outputText("Horse-morph");
			else if (flags[kFLAGS.DIANA_LVL_UP] >= 2 && flags[kFLAGS.DIANA_LVL_UP] < 8) outputText("Unicorn");
			else outputText("Diana");
			outputText(" chant a magical song of healing and recovery and her wounds start knitting themselves shut in response. <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.");
			addHP(temp);
			mana -= spellCostHeal();
			flags[kFLAGS.DIANA_SPELLS_CASTED]++;
		}
		
		override protected function performCombatAction():void
		{
			if (HPRatio() < .2 && (mana >= spellCostHeal())) usingHealSpell();
			else if (flags[kFLAGS.DIANA_LVL_UP] >= 5 && flags[kFLAGS.DIANA_LVL_UP] < 8) {
				var choice3:Number = rand(6);
				if (choice3 < 2) {
					if ((soulforce >= soulskillCostManyBirds()) && rand(2) == 0) usingManyBirdsSoulskill();
					else eAttack();
				}
				if (choice3 > 1 && choice3 < 5) {
					if (HPRatio() < .6 && rand(2) == 0 && (mana >= spellCostHeal())) usingHealSpell();
					else if (HPRatio() < .6 && rand(2) == 0 && !hasStatusEffect(StatusEffects.MonsterRegen2) && (mana >= spellCostRegenerate())) usingRegenerateSpell();
					else if (rand(2) == 0 && (mana < (this.maxMana() - 300))) usingARC();
					else eAttack();
				}
				if (choice3 == 5) {
					if (HPRatio() < .8) usingHealPill();
					else eAttack();
				}
			}
			else if (flags[kFLAGS.DIANA_LVL_UP] >= 2 && flags[kFLAGS.DIANA_LVL_UP] < 5) {
				var choice2:Number = rand(6);
				if (choice2 < 2) {
					if ((soulforce >= soulskillCostManyBirds()) && rand(2) == 0) usingManyBirdsSoulskill();
					else eAttack();
				}
				if (choice2 > 1 && choice2 < 5) {
					if (HPRatio() < .6 && rand(2) == 0 && (mana >= spellCostHeal())) usingHealSpell();
					else if (rand(2) == 0 && (mana < (this.maxMana() - 80))) usingARC();
					else eAttack();
				}
				if (choice2 == 5) {
					if (HPRatio() < .8) usingHealPill();
					else eAttack();
				}
			}
			else {
				var choice1:Number = rand(6);
				if (choice1 == 0) eAttack();
				if (choice1 > 0 && choice1 < 5) {
					if (HPRatio() < .5 && rand(2) == 0 && (mana >= spellCostHeal())) usingHealSpell();
					else if (rand(2) == 0 && (mana < (this.maxMana() - 40))) usingARC();
					else eAttack();
				}
				if (choice1 == 5) {
					if (HPRatio() < .75) usingHealPill();
					else eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.DIANA_AFFECTION] >= 100) {
				if (flags[kFLAGS.DIANA_FOLLOWER] < 3) dianaScene.beMyStallion();
				else dianaScene.beMyStallionRepeat();
			}
			else dianaScene.wonOverDiana();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			dianaScene.lostToDiana();
		}
		
		public function Diana() 
		{
			if (flags[kFLAGS.DIANA_LVL_UP] == 0) {
				initStrTouSpeInte(25, 25, 25, 75);
				initWisLibSensCor(25, 25, 25, 50);
				this.weaponAttack = 3;
				this.armorDef = 6;
				this.level = 3;
				this.bonusHP = 80;
				this.bonusMana = 50;
				this.gems = rand(5) + 5;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.VDARCON,1/5).
					add(consumables.EQUINUM,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 1) {
				initStrTouSpeInte(25, 30, 30, 80);
				initWisLibSensCor(30, 30, 25, 50);
				this.weaponAttack = 3;
				this.armorDef = 6;
				this.level = 6;
				this.bonusHP = 270;
				this.bonusMana = 65;
				this.gems = rand(5) + 5;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.VDARCON,1/5).
					add(consumables.EQUINUM,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 2) {
				initStrTouSpeInte(30, 40, 35, 80);
				initWisLibSensCor(50, 50, 50, 50);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.level = 9;
				this.bonusHP = 485;
				this.bonusMana = 170;
				this.gems = rand(5) + 10;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.VDARCON,1/5).
					add(consumables.UNICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 3) {
				initStrTouSpeInte(30, 50, 40, 80);
				initWisLibSensCor(60, 55, 50, 50);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.level = 12;
				this.bonusHP = 520;
				this.bonusMana = 220;
				this.gems = rand(5) + 10;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.VDARCON,1/5).
					add(consumables.UNICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 4) {
				initStrTouSpeInte(30, 60, 45, 80);
				initWisLibSensCor(70, 60, 50, 50);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.level = 15;
				this.bonusHP = 725;
				this.bonusMana = 265;
				this.gems = rand(5) + 10;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.VDARCON,1/5).
					add(consumables.UNICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 5) {
				initStrTouSpeInte(30, 70, 50, 80);
				initWisLibSensCor(80, 65, 50, 50);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.level = 18;
				this.bonusHP = 725;
				this.bonusMana = 265;
				this.gems = rand(5) + 10;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.D_ARCON,1/5).
					add(consumables.UNICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 6) {
				initStrTouSpeInte(30, 80, 55, 90);
				initWisLibSensCor(80, 70, 50, 50);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.level = 21;
				this.bonusHP = 220;
				this.bonusMana = 120;
				this.gems = rand(5) + 10;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.D_ARCON,1/5).
					add(consumables.UNICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 7) {
				initStrTouSpeInte(30, 90, 60, 90);
				initWisLibSensCor(90, 75, 50, 50);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.level = 24;
				this.bonusHP = 220;
				this.bonusMana = 120;
				this.gems = rand(5) + 10;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.D_ARCON,1/5).
					add(consumables.UNICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 8) {
				initStrTouSpeInte(40, 100, 70, 100);
				initWisLibSensCor(100, 100, 75, 50);
				this.weaponAttack = 9;
				this.armorDef = 12;
				this.level = 27;
				this.bonusHP = 220;
				this.bonusMana = 120;
				this.gems = rand(5) + 15;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.D_ARCON,1/5).
					add(consumables.ALICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] < 2 && flags[kFLAGS.DIANA_FOLLOWER] < 3) {
				this.a = "the ";
				this.short = "horse morph";
				this.imageName = "whitemare";
				this.long = "You are fighting a white furred 6.6 foot tall horse morph with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(true, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_TIGHT);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.tallness = 6*12+6;
				this.hips.type = Hips.RATING_CURVY;
				this.butt.type = Butt.RATING_LARGE;
				this.hairLength = 12;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 1 && flags[kFLAGS.DIANA_FOLLOWER] == 3) {
				this.a = "the ";
				this.short = "horse morph";
				this.imageName = "whitemare";
				this.long = "You are fighting a white furred 6.8 foot tall horse morph with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
				createBreastRow(Appearance.breastCupInverse("H"));
				this.tallness = 6*12+8;
				this.hips.type = Hips.RATING_CURVY+2;
				this.butt.type = Butt.RATING_LARGE+1;
				this.hairLength = 16;
			}
			if ((flags[kFLAGS.DIANA_LVL_UP] >= 2 && flags[kFLAGS.DIANA_LVL_UP] < 8) && flags[kFLAGS.DIANA_FOLLOWER] < 3) {
				this.a = "the ";
				this.short = "unicorn";
				this.imageName = "unicornmare";
				this.long = "You are fighting a white furred 6.8 foot tall unicorn with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(true, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_TIGHT);
				createBreastRow(Appearance.breastCupInverse("H"));
				this.tallness = 6*12+8;
				this.hips.type = Hips.RATING_CURVY+2;
				this.butt.type = Butt.RATING_LARGE+1;
				this.hairLength = 16;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 2 && flags[kFLAGS.DIANA_FOLLOWER] == 4) {
				this.a = "the ";
				this.short = "unicorn";
				this.imageName = "unicornmare";
				this.long = "You are fighting a white furred 7 foot tall unicorn with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
				createBreastRow(Appearance.breastCupInverse("J"));
				this.tallness = 7*12;
				this.hips.type = Hips.RATING_FERTILE+1;
				this.butt.type = Butt.RATING_JIGGLY+1;
				this.hairLength = 26;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 8 && (flags[kFLAGS.DIANA_FOLLOWER] < 3 || flags[kFLAGS.DIANA_FOLLOWER] == 5)) {
				this.a = "";
				this.short = "Diana";
				this.imageName = "diana";
				this.long = "Diana is a white furred 7 foot tall alicorn with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(true, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_TIGHT);
				createBreastRow(Appearance.breastCupInverse("J"));
				this.tallness = 7*12;
				this.hips.type = Hips.RATING_FERTILE+1;
				this.butt.type = Butt.RATING_JIGGLY+1;
				this.hairLength = 26;
			}
			// this.plural = false;
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.lowerBody = LowerBody.HOOFED;
			this.skinTone = "light";
			this.hairColor = "white";
			this.weaponName = "staff";
			this.weaponVerb="smack";
			this.armorName = "fur";
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.bonusLust = 20;
			this.ears.type = Ears.HORSE;
			this.faceType = Face.HORSE;
			this.tailType = Tail.HORSE;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.WizardsFocus, 0, 0, 0, 0);
			if (flags[kFLAGS.DIANA_LVL_UP] >= 1) {
				this.createPerk(PerkLib.JobHealer, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicSpirituality, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
				this.createPerk(PerkLib.SpellpowerHealing, 0, 0, 0, 0);
				this.createPerk(PerkLib.ManaAffinityI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 3) {
				this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
				this.createPerk(PerkLib.WisenedHealer, 0, 0, 0, 0);
				this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 4) {
				this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 5) {
				this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.NaturalHealingMinor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 6) {
				//this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 7) {
				//this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 8) {
				//this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_FOLLOWER] == 3 || flags[kFLAGS.DIANA_FOLLOWER] == 4) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}