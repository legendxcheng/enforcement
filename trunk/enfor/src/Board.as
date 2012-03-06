package
{
	import UI.Block;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	//import org.osmf.layout.AbsoluteLayoutFacet;

	/**
	 * @author Xcheng
	 * board class
	 */
	
	public class Board extends FlxGroup
	{
		import Fighters.*;
		
		public var len:int;//must be odd
		public var val:Array;
		public var left:int;
		public var right:int;
		public var up:int;
		public var bottom:int;
		
		public var blocks:Array;
		public var valTxt:Array;
		public var sprBlock:Array;
		public var ofx:int;
		public var ofy:int;
		public var pBlock:Array;
		[Embed(source="pics/pblock.png")] protected var ImgPBlock:Class;
		[Embed(source="pics/blockhl.png")] protected var ImgBlock:Class;
		public var txtRound:FlxText;
		public var txtRoundVal:FlxText;
		
		
		/**
		 * check if the position has a fighter
		 */
		public function isFighter(c:int, r:int):Player
		{
			for (var i:int = 0; i < Enforcement.player.length; ++i)
			{
				var tp:Player = Enforcement.player[i];
				if (tp.fighter != null)
				{
					if (tp.fighter.x == c && tp.fighter.y == r)
					{
						return tp;
					}
				}
			}
			return null;
		}
		

		
		public function init(plen:int):void
		{

			
			len = plen;
			left = 0;
			right = len - 1;
			up = 0;
			bottom = len - 1;
			ofx = (640 - len * 32) / 2;
			ofy = (360 - len * 32) / 2 + 8;
			
			blocks = new Array();
			sprBlock = new Array();
			for (var i:int = 0; i < len; ++i)
			{
				sprBlock[i] = new Array();
				blocks[i] = new Array();
				for (var j:int = 0; j < len; ++j)
				{
					blocks[i][j] = new Block(i, j);
					blocks[i][j].x = i * 32 + ofx;
					blocks[i][j].y = j * 32 + ofy;
					
					sprBlock[i][j] = new FlxSprite(blocks[i][j].x, blocks[i][j].y);
					sprBlock[i][j].loadGraphic(ImgBlock, true, false, 32, 32, false);
					var d:Array = new Array();
					for (var kk:int = 0; kk < 32; ++kk)
					{
						d.push(kk);	
					}
					
					sprBlock[i][j].addAnimation("spr", d, 15, true);
					sprBlock[i][j].play("spr");
					add(blocks[i][j]);
					add(sprBlock[i][j]);
					sprBlock[i][j].visible = false;
				}
			}
			
			pBlock = new Array();
			for (i = 0; i < 4; ++i)
			{
				pBlock.push(new FlxSprite(0, 0));
				pBlock[i].loadGraphic(ImgPBlock, false, false, 32, 32, false);
				pBlock[i].frame = i;
				add(pBlock[i]);
				
				pBlock[i].visible = false;
			}
			
			
			valTxt = new Array();
			for (i = 0; i < len; ++i)
			{
				valTxt[i] = new Array();
				for (j = 0; j < len; ++j)
				{
					valTxt[i][j] = new FlxText(blocks[i][j].x + 5, blocks[i][j].y + 6, 200);
					//var tmp:FlxText = new FlxText(1, 1, 1);
					valTxt[i][j].size = 14;
					add(valTxt[i][j]);					
				}
			}
			
			resetVal();
			
			
			txtRound = new FlxText(260, 0, 100);
			txtRound.color = 0xff444444;
			txtRound.size = 24;
			txtRound.text = "Round ";
			add(txtRound);
			
			txtRoundVal = new FlxText(360, 0, 100);
			txtRoundVal.color = 0xff444444;
			txtRoundVal.size = 24;
			add(txtRoundVal);
			
		}
		

		/**
		 * reset the value in the board
		 */
		public function resetVal():void
		{
			val = new Array();
			for (var i:int = 0; i < len; ++i)
			{
				val[i] = new Array();
				for (var j:int = 0; j < len; ++j)
				{
					val[i][j]= Math.floor(Math.random() * 7) - 3;
					if (val[i][j] > 0)
					{
						valTxt[i][j].text = "+" + val[i][j].toString();
					}
					else if (val[i][j] < 0)
					{
						valTxt[i][j].text = val[i][j].toString();
					}
					else
						valTxt[i][j].text = " 0";
					
				}
			}
			
			for (var k:int = 0; k < Enforcement.player.length; ++k)
			{
				Enforcement.player[k].fighter.updateAttributes();
			}
		}
		
		override public function preUpdate():void
		{
			for (var i:int = 0; i < len; ++i)
			{
				for (var j:int = 0; j < len; ++j)
				{
					if (blocks[i][j].frame != 0)
					{
						valTxt[i][j].color = 0xff333333;
						valTxt[i][j].x = blocks[i][j].x + 6;
						valTxt[i][j].y = blocks[i][j].y + 7;
					}
					else
					{
						valTxt[i][j].x = blocks[i][j].x + 5;
						valTxt[i][j].y = blocks[i][j].y + 6;
						valTxt[i][j].color = 0xff555555;
					}
				}
			}
			
			for (i = 0; i < Enforcement.player.length; ++i)
			{
				var iid:int = Enforcement.player[i].id - 1;
				if (Enforcement.player[i].fighter != null)//there is a fighter
				{
					
					pBlock[iid].visible = true;
					pBlock[iid].x = Enforcement.player[i].fighter.x * 32 + Enforcement.board.ofx;
					pBlock[iid].y = Enforcement.player[i].fighter.y * 32 + Enforcement.board.ofy;
				}
				else pBlock[iid].visible = false;
			}
			
			txtRoundVal.text = Enforcement.round.toString();
			
		}
		public function Board()
		{
			
		}
	}
}