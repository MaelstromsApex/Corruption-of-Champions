package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.Items.Undergarments.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class UndergarmentLib 
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const TYPE_UPPERWEAR:int = 0;
		public static const TYPE_LOWERWEAR:int = 1;
		public static const TYPE_FULLWEAR:int  = 2;
		
		//public static const COMFORTABLE_UNDERCLOTHES:Undergarment = new ComfortableUnderclothes();
		public static const NOTHING:Undergarment = new Nothing();
		
		//Upper
		public const C_BRA  :Undergarment = new Undergarment("C. Bra ", "C. Bra", "comfortable bra", "a pair of comfortable bra", TYPE_UPPERWEAR, DEFAULT_VALUE, "A generic pair of bra. \n\nType: Undergarment (Upper)");
		public const C_SHIRT:Undergarment = new Undergarment("C.Shirt", "C. Shirt", "comfortable shirt", "a comfortable shirt", TYPE_UPPERWEAR, DEFAULT_VALUE, "A generic pair of shirt. \n\nType: Undergarment (Upper)");
		public const DS_BRA :Undergarment = new Undergarment("DS. Bra", "D.Scale Bra", "dragonscale bra", "a pair of dragonscale bra", TYPE_UPPERWEAR, 600, "This bra appears to be made of dragon scale. It's held together with leather straps for flexibility. Great for those on the primal side! \n\nType: Undergarment (Upper)");
		public const DS_VEST:Undergarment = new Undergarment("DS.Vest", "D.Scale Vest", "dragonscale vest", "a dragonscale vest", TYPE_UPPERWEAR, 600, "This sleeveless vest is made of dragonscale, treated until it is as light and comfortable as cloth.  However, these treatments have reduced the defensive properties of the dragonscale. \n\nType: Undergarment (Upper)");
		public const EW_CORS:Undergarment = new Undergarment("EW.Cors", "E.W. Corset", "ebonweave corset", "an ebonweave corset", TYPE_UPPERWEAR, 900, "This corset is ebonweave, created using refined ebonbloom petals. The ebonweave is elastic, making the corset surprisingly comfortable to wear, while displaying your bust down to the most subtle curves. \n\nType: Undergarment (Upper)");
		public const EW_VEST:Undergarment = new Undergarment("EW.Vest", "E.W. Vest", "ebonweave vest", "an ebonweave vest", TYPE_UPPERWEAR, 900, "This vest is ebonweave, created using refined ebonbloom petals. Elastic, form-fitting and somewhat transparent, this comfortable vest will display your curves, masculine or feminine. \n\nType: Undergarment (Upper)");
		public const LTX_BRA:Undergarment = new Undergarment("Ltx.Bra", "Latex Bra", "latex bra", "a pair of latex bra", TYPE_UPPERWEAR, 250, "This bra is black and shiny, obviously made of latex. It's designed to fit snugly against your breasts. \n\nType: Undergarment (Upper)");
		public const SS_BRA :Undergarment = new Undergarment("SS. Bra", "S.Silk Bra", "spider-silk bra", "a pair of spider-silk bra", TYPE_UPPERWEAR, 1000, "This bra looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk. \n\nType: Undergarment (Upper)");
		public const SSSHIRT:Undergarment = new Undergarment("SSShirt", "S.Silk Shirt", "spider-silk shirt", "a spider-silk shirt", TYPE_UPPERWEAR, 1000, "A comfortable undershirt.  It's as white as snow and woven with hundreds of strands of fine spider silk. \n\nType: Undergarment (Upper)");
		
		//Lower
		public const C_LOIN :Undergarment = new Undergarment("C. Loin", "C. Loin", "comfortable loincloth", "a pair of comfortable loincloth", TYPE_LOWERWEAR, DEFAULT_VALUE, "A generic pair of loincloth. \n\nType: Undergarment (Lower)", "NagaWearable");
		public const C_PANTY:Undergarment = new Undergarment("C.Panty", "C. Panties", "comfortable panties", "a pair of comfortable panties", TYPE_LOWERWEAR, DEFAULT_VALUE, "A generic pair of panties. \n\nType: Undergarment (Lower)");
		public const DS_LOIN:Undergarment = new Undergarment("DS.Loin", "D.Scale Loin", "dragonscale loincloth", "a pair of dragonscale loincloth", TYPE_LOWERWEAR, 600, "This loincloth appears to be made of dragonscale and held together with a leather strap that goes around your waist. Great for those on the wild side! \n\nType: Undergarment (Lower)", "NagaWearable");
		public const DSTHONG:Undergarment = new Undergarment("DSPanty", "D.Scale Thong", "dragonscale thong", "a pair of dragonscale thong", TYPE_LOWERWEAR, 600, "This thong appears to be made of dragonscale and held together with a leather strap that goes around your waist. Great for those on the wild side! \n\nType: Undergarment (Lower)");
		public const EW_JOCK:Undergarment = new Undergarment("EW.Jock", "E.W. Jock", "ebonweave jockstrap", "an ebonweave jockstrap", TYPE_LOWERWEAR, 900, "This jock is ebonweave, made from refined ebonbloom petals. This jock is comfortable and elastic, providing support while comfortably containing assets of any size. \n\nType: Undergarment (Lower)");
		public const EWTHONG:Undergarment = new Undergarment("EWPanty", "E.W. Thong", "ebonweave thong", "a pair of ebonweave thong", TYPE_LOWERWEAR, 900, "This thong is ebonweave, designed to fit snugly around your form. Thanks to the alchemical treatments, this thong is elastic enough to comfortably hold assets of any size. \n\nType: Undergarment (Lower)");
		public const FURLOIN:Undergarment = new Undergarment("FurLoin", "FurLoin", "fur loincloth", "a front and back set of loincloths", TYPE_LOWERWEAR, DEFAULT_VALUE, "A pair of loincloths to cover your crotch and butt.  Typically worn by people named 'Conan'. \n\nType: Undergarment (Lower) ", "NagaWearable");
		public const GARTERS:Undergarment = new Undergarment("Garters", "Garters", "stockings and garters", "a pair of stockings and garters", TYPE_LOWERWEAR, DEFAULT_VALUE, "These pairs of stockings, garters and lingerie are perfect for seducing your partner! \n\nType: Undergarment (Lower)");
		public const LTXSHRT:Undergarment = new Undergarment("LtxShrt", "LatexShorts", "latex shorts", "a pair of latex shorts", TYPE_LOWERWEAR, 300, "These shorts are black and shiny, obviously made of latex. It's designed to fit snugly against your form. \n\nType: Undergarment (Lower)");
		public const LTXTHNG:Undergarment = new Undergarment("LtxThng", "LatexThong", "latex thong", "a pair of latex thong", TYPE_LOWERWEAR, 300, "This thong is black and shiny, obviously made of latex. It's designed to fit snugly against your form. \n\nType: Undergarment (Lower)");
		public const R_JOCK :RunedEbonweaveJock = new RunedEbonweaveJock();
		public const R_THONG:RunedEbonweaveThong = new RunedEbonweaveThong();
		public const SS_LOIN:Undergarment = new Undergarment("SS.Loin", "S.Silk Loin", "spider-silk loincloth", "a spider-silk loincloth", TYPE_LOWERWEAR, 1000, "This loincloth looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk.  \n\nType: Undergarment (Lower)", "NagaWearable");
		public const SSPANTY:Undergarment = new Undergarment("SSPanty", "S.Silk Panty", "spider-silk panties", "a pair of spider-silk panties", TYPE_LOWERWEAR, 1000, "These panties look incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk. \n\nType: Undergarment (Lower)");
		
		public function UndergarmentLib() 
		{
		}
		
	}

}