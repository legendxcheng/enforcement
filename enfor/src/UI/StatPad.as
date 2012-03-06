package UI
{
	import Fighters.*;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import org.flixel.*;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	//import org.osmf.layout.AbsoluteLayoutFacet;
	
	/**
	 * @author Xcheng
	 * class for status pad
	 */
	public class StatPad extends FlxGroup
	{
		public var bg:StatPadBg;
		public var ox:int;
		public var oy:int;
		public var txtAtk:FlxText;
		public var txtDef:FlxText;
		public var txtHp:FlxText;
		public var txtId:FlxText;
		public var txtAtkVal:FlxText;
		public var txtDefVal:FlxText;
		public var txtHpVal:FlxText;
		public var adFlag:Boolean;
		public var txtCurSP:FlxText;
		public var txtTotSP:FlxText;
		public var txtMovSP:FlxText;
		
		public var ico:FlxSprite;
		public var sp_plus:FlxSprite;
		public var sp_minus:FlxSprite;
		public var curTag:FlxSprite;
		
		[Embed(source="pics/sp_plus.png")] protected var ImgSpPlus:Class;
		[Embed(source="pics/sp_minus.png")] protected var ImgSpMinus:Class;
		[Embed(source="pics/statpadico.png")] protected var ImgIco:Class;
		[Embed(source="pics/curTag.png")] protected var ImgTag:Class;
	
		public var type:int;
		public var id:int;
		public var set:Boolean;
		
		/**
		 * call when pad botton is clicked
		 */
		public function press():void
		{
			
			if (FlxG.state == Enforcement.selectState)
			{
				/**
				 * select fighter type
				 */
				if (FlxG.mouse.x - this.ox <= 47 && FlxG.mouse.y - this.oy <= 49
					&& FlxG.mouse.x - this.ox >= 7 && FlxG.mouse.y - this.oy >= 9)
				{
					if (type == 4)
					{
						type = 0;
					}
					else type += 1;
					
					if (type == 2)
						type = 3;
					ico.frame = type;
					
					switch (type)
					{
						case Fighter.WARRIOR:
							txtHpVal.text = Fighter.WARRIOR_HP.toString();
							txtAtkVal.text = Fighter.WARRIOR_ATK.toString();
							txtDefVal.text = Fighter.WARRIOR_DEF.toString();
							break;
						case Fighter.THIEF:
							txtHpVal.text = Fighter.THIEF_HP.toString();
							txtAtkVal.text = Fighter.THIEF_ATK.toString();
							txtDefVal.text = Fighter.THIEF_DEF.toString();
							break;
						case Fighter.WIZARD:
							txtHpVal.text = Fighter.WIZARD_HP.toString();
							txtAtkVal.text = Fighter.WIZARD_ATK.toString();
							txtDefVal.text = Fighter.WIZARD_DEF.toString();
							break;
						case Fighter.ARCHER:
							txtHpVal.text = Fighter.ARCHER_HP.toString();
							txtAtkVal.text = Fighter.ARCHER_ATK.toString();
							txtDefVal.text = Fighter.ARCHER_DEF.toString();
							break;
						default:
							txtHpVal.text = "";
							txtAtkVal.text = "";
							txtDefVal.text = "";
							break;
					}
					
					
				}
				/**
				 * set flag
				 */
				if (FlxG.mouse.x - this.ox >= 8 && FlxG.mouse.x - this.ox <= 24
					&& FlxG.mouse.y - this.oy >= 78 && FlxG.mouse.y - this.oy <= 96)
				{
					adFlag = !adFlag;
					if (adFlag)
					{
						sp_plus.visible = true;
						sp_minus.visible = false;
					}
					else
					{
						sp_plus.visible = false;
						sp_minus.visible = true;
					}
				}
			}
			else if (FlxG.state == Enforcement.playState)
			{
					
			}
		}
		
		public function StatPad(MaxSize:uint=0)
		{
			super(MaxSize);
			
			type = 4;
			
			bg = new StatPadBg(this);//set coordinates afterwards
			add(bg);
			
			adFlag = true;
			
			txtHpVal = new FlxText(0, 0, 100, "");
			txtHpVal.color = 0xff444444;
			add(txtHpVal);
			txtAtkVal = new FlxText(0, 0, 100, "");
			txtAtkVal.color = 0xff444444;
			add(txtAtkVal);
			txtDefVal = new FlxText(0, 0, 100, "");
			txtDefVal.color = 0xff444444;
			add(txtDefVal);
			
			txtHp = new FlxText(0, 0, 100, "HP");
			txtHp.color = 0xff444444;
			add(txtHp);
			txtAtk = new FlxText(0, 0, 100, "ATK");
			txtAtk.color = 0xff444444;
			add(txtAtk);
			txtDef = new FlxText(0, 0, 100, "DEF");
			txtDef.color = 0xff444444;
			add(txtDef);
			txtId = new FlxText(0, 0, 200, "");
			txtId.color = 0xff222222;
			add(txtId);
			
			sp_plus = new FlxSprite(8, 78, ImgSpPlus);
			sp_minus = new FlxSprite(8, 78, ImgSpMinus);
			add(sp_plus);
			add(sp_minus);
			sp_minus.visible = false;
			sp_plus.visible = true;
			
			ico = new FlxSprite();
			ico.loadGraphic(ImgIco, false, false, 40, 40, false);
			ico.frame = 4;
			add(ico);
			
			curTag = new FlxSprite();
			curTag.loadGraphic(ImgTag, false, false, 20, 10, false);
			add(curTag);
			curTag.visible = false;
			
			txtCurSP = new FlxText(0, 0, 100);
			txtCurSP.color = 0xff444444;
			txtCurSP.size = 18;
			
			txtTotSP = new FlxText(0, 0, 100);
			txtTotSP.color = 0xff222222;
			txtTotSP.size = 24;
			
			add(txtCurSP);
			add(txtTotSP);
			this.visible = true;
			
			txtMovSP = new FlxText(0, 0, 100)
			txtMovSP.color = 0xff444444;
			txtMovSP.size = 18;
			add(txtMovSP);
		}

		
		public function setAttr(x:int, y:int, pid:int):void
		{
			id = pid;
			ox = x;
			oy = y;
			//TODO: set all objects' XY inside the group
			bg.x = ox;
			bg.y = oy;
			
			txtHp.x = ox + 50;
			txtHp.y = oy + 13;
			
			txtAtk.x = ox + 50;
			txtAtk.y = oy + 23;
			
			txtDef.x = ox + 50;
			txtDef.y = oy + 33;
			
			txtHpVal.x = ox + 75;
			txtHpVal.y = oy + 13;
			
			txtAtkVal.x = ox + 75;
			txtAtkVal.y = oy + 23;
			
			txtDefVal.x = ox + 75;
			txtDefVal.y = oy + 33;
			
			txtId.text = id.toString();
			txtId.x = ox + 82;
			txtId.y = oy + 78;
			
			sp_plus.x = ox + 8;
			sp_minus.x = ox + 8;
			sp_plus.y = oy + 78;
			sp_minus.y = oy + 78;
			
			ico.x = ox + 7;//range 7~47
			ico.y = oy + 9;//range 9~49
			
			curTag.x = ox + 40;
			curTag.y = oy + 80;
			curTag.frame = this.id - 1;
		
			txtCurSP.x = ox + 10;
			txtCurSP.y = oy + 55;
			
			txtTotSP.x = ox + 30;
			txtTotSP.y = oy + 48;
			
			txtMovSP.x = ox + 65;
			txtMovSP.y = oy + 55;
			
		}
		
		public function updateSP(p:Boolean):void
		{
			
		}
		
		public function getFighter(pos:int):Fighter
		{
			for each(var pp:Player in Enforcement.player)
			{
				if (pp.id == pos)
				{
					return pp.fighter;
				}
			}
			return null;
		}
		
		/**
		 * calc the attrs
		 */ 
		override public function preUpdate():void
		{
			if (FlxG.state == Enforcement.playState)
			{
				var pf:Fighter = getFighter(this.id);
				if (pf != null)//there is a player
				{
					this.txtCurSP.text = pf.curSp.toString();
					this.txtTotSP.text = pf.sp.toString();
					this.txtAtkVal.text = pf.atk.toString();
					this.txtHpVal.text = pf.hp.toString();
					this.txtDefVal.text = pf.def.toString();
					this.ico.frame = pf._type;
					this.txtMovSP.text = pf.moveSp.toString();
					
					if (pf.atkdefFlag)
					{
						this.sp_plus.visible = true;
						this.sp_minus.visible = false;
					}
					else
					{
						this.sp_minus.visible = false;
						this.sp_plus.visible = true;
					}
					
					if (Enforcement.curPlayer == this.id)
					{
						this.curTag.visible = true;
					}
					else
						this.curTag.visible = false;
				}
				else this.visible = false;
			}
		}
	}
}