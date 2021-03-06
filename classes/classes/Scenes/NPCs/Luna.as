/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.Scenes.SceneLib;
	import classes.internals.*;
	
	use namespace CoC;
	
	public class Luna extends Monster
	{
		public var lunaScene:LunaFollower = SceneLib.lunaFollower;
		
		public function usingClawCombo():void {
			outputText("Luna attempts to rend you with her claws.");
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
		}
		
		public function usingPounce():void {
			outputText("Luna pounces on you, pinning you to the ground as she gets in position, claws at the ready.");
			player.createStatusEffect(StatusEffects.WolfHold,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takePhysDamage(8+rand(10));
			}
		}
		
		public function usingRavage():void {
			outputText("Luna rends you with her claws.");
			eBaseStrengthDamage();
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(5);
			if (choice < 3) usingClawCombo();
			if (choice == 3) {
				if (!player.hasStatusEffect(StatusEffects.WolfHold) && rand(2) == 0) usingPounce();
				else usingRavage();
			}
			if (choice == 4) usingRavage();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.lunaFollower.fullMoonEventResistWin();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.lunaFollower.fullMoonEventResistDefat();
		}
		
		public function Luna() 
		{
			this.a = "";
			this.short = "Luna";
			this.imageName = "luna";
			this.long = "Luna is a werewolf, a shapeshifting hybrid between animal-morph and human capable of altering her form at will. Right now she looks more like a feral beast than the refined maid you are used to. The lust crazed she-wolf circles you as she looks for an opportunity to strike.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 6*12+6;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.skin.growFur({color:"ashen"});
			this.hairColor = "ashen";
			this.hairLength = 8;
			initStrTouSpeInte(40, 60, 40, 50);
			initWisLibSensCor(50, 80, 40, 75);
			this.weaponName = "paws";
			this.weaponVerb="paw-slash";
			this.weaponAttack = 37;
			this.armorName = "fur";
			this.armorDef = 2000;
			this.bonusHP = 800;
			this.bonusLust = 10;
			this.lust = 10;
			this.lustVuln = 0;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 10;
			this.gems = 5 + rand(5);
			this.drop = NO_DROP;
			this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}