package
{
	/**
	 * @author Xcheng
	 */
	import States.*;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.flixel.*;
	import org.flixel.plugin.TimerManager;
	
	[SWF(width="640", height="360", backgroundColor="#111111")] //Set the size and color of the Flash file
	
	public class Enforcement extends FlxGame
	{
		static public var tutorialState:TutorialState = null;
		static public var menuState:MenuState = null;
		static public var playState:PlayState = null;
		static public var selectState:SelectState = null;
		static public var timerManager:TimerManager = null;
		static public var board:Board;
		static public var player:Array;
		static public var round:int;
		static public var playerNum:int;
		static public var curPlayer:int;//current player
		static public var targetPlayer:int;//attack target player
		
				
		static public function nextRound():void
		{
			var i:int;
			var k:int;
			round += 1;
			if (round % 5 == 0)
				board.resetVal();
			
			//set next player
			for (k = 0; k < Enforcement.player.length; ++k)
			{
				var tp:Player = Enforcement.player[k];
				if (tp.id == Enforcement.curPlayer)
				{
					break;
				}
			}
			
			if (round % (Enforcement.playerNum * 5) == 0)
			{
				//TODO:trim the board
				
				for (i = Enforcement.board.left; i <= Enforcement.board.right; ++i)
				{
					Enforcement.board.blocks[i][Enforcement.board.up].visible = false;
					Enforcement.board.blocks[i][Enforcement.board.bottom].visible = false;
					Enforcement.board.valTxt[i][Enforcement.board.up].visible = false;
					Enforcement.board.valTxt[i][Enforcement.board.bottom].visible = false;
					
				}
				
				for (i = Enforcement.board.up; i <= Enforcement.board.bottom; ++i)
				{
					Enforcement.board.blocks[Enforcement.board.left][i].visible = false;
					Enforcement.board.blocks[Enforcement.board.right][i].visible = false;
					Enforcement.board.valTxt[Enforcement.board.left][i].visible = false;
					Enforcement.board.valTxt[Enforcement.board.right][i].visible = false;
					
				}
				
				for (i = 0; i < Enforcement.player.length; ++i)
				{
					var tt:Player = Enforcement.player[i];
					if (Enforcement.player[i].fighter != null)
					{
						if (tt.fighter.x == Enforcement.board.left || tt.fighter.x == Enforcement.board.right
							|| tt.fighter.y == Enforcement.board.up || tt.fighter.y == Enforcement.board.bottom)
						{
							tt.fighter = null;
						}
					}
				}
				
				
				
				Enforcement.board.left += 1;
				Enforcement.board.right -= 1;
				Enforcement.board.up += 1;
				Enforcement.board.bottom -= 1;
				
				
			}	

			if (Enforcement.playerNum == 0)
				return;
				
			while (true)
			{
				if (k == Enforcement.player.length - 1)
				{
					k = 0;
				}
				else k += 1;
				if (Enforcement.player[k].fighter != null)
					break;
			}
			Enforcement.curPlayer = Enforcement.player[k].id;
		}
		
		public function Enforcement()
		{
			
			super(640, 360, MenuState, 1, 60, 30, true);
			menuState = new MenuState();
			playState = new PlayState();
			selectState = new SelectState();
			tutorialState = new TutorialState();	
			
			timerManager = new TimerManager();			
			round = 0;
			player = new Array();
			board = new Board();
			board.init(10);
			
				
		}
		
		static public function addPlayer(type:int, pos:int):void
		{
			++playerNum;
			player.push(new Player(pos, 0, type, pos));
			
		}
		
		
	}
}