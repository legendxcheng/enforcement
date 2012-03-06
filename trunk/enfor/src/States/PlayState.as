package States
{
	import UI.*;
	
	import flashx.textLayout.conversion.PlainTextExporter;
	
	import org.flixel.*;
	import org.osmf.layout.LayoutMode;
	/**
	 * @author Xcheng
	 * state for test
	 */ 
	public class PlayState extends FlxState
	{
		public var statPad1:StatPad;
		public var statPad2:StatPad;
		public var statPad3:StatPad;
		public var statPad4:StatPad;
		public var fightBtn:FightBtn;
		public var enforcement:Enforcement;
		public var dialog:Dialog;
		public var debugTxt:FlxText;
		public var istate:int;
		public var btnAtk:PlayBtn;
		public var btnDef:PlayBtn;
		public var btnRev:PlayBtn;
		public var btnSkill:PlayBtn;
		public var btnEnd:PlayBtn;
		public var btnBack:MenuButton;
		
		/**
		 * call when block btn is pressed
		 */
		public function pressBlock(c:int, r:int):void
		{
			var tp:Player;
			var cp:Player;
			switch (Enforcement.playState.istate)
			{
				/**
				 * move
				 */ 
				case 2:
					if (Enforcement.board.sprBlock[c][r].visible && Enforcement.board.isFighter(c, r) == null)
					{
						tp = getPlayer(Enforcement.curPlayer);
						if (!tp.fighter.moved)//else do nothing
							tp.fighter.move(c, r);
					}
					break;
					
				case 4:
					tp = Enforcement.board.isFighter(c, r);
					if (tp != null && Enforcement.board.sprBlock[c][r].visible)
					{
						Enforcement.targetPlayer = tp.id;
						if (tp.id != Enforcement.curPlayer)
						//show dialog
							changeIState(5);
						

					}
					
					
					break;
				
			}
import UI.MenuButton;

		}
		
		public function changeIState(istat:int):void
		{
			var i:int;
			var j:int;
			
			this.istate = istat;
			var cp:Player;
			debugTxt.text = this.istate.toString();
			switch (istate)
			{
				case 1:
					//reset block val every round
					Enforcement.nextRound();
					//wait the player to throw dice(click button)
					//do the init;
					cp = this.getPlayer(Enforcement.curPlayer);
					cp.fighter.roundInit();
					break;
				case 2:
					//wait the player to do atk def move or skill
					//show move range
					cp = this.getPlayer(Enforcement.curPlayer);
					for (i = Enforcement.board.left; i <= Enforcement.board.right; ++i)
					{
						for (j = Enforcement.board.up; j <= Enforcement.board.bottom; ++j)
						{
							Enforcement.board.sprBlock[i][j].visible = false;
						}
					}
					
					var movRange:Array = cp.fighter.calcPossibleMoves();
					for (i = 0; i < movRange.length / 2; ++i)
					{
						var tx:int = movRange[i * 2];
						var ty:int = movRange[i * 2 + 1];
						Enforcement.board.sprBlock[tx][ty].visible = true;
					}
					
					break;
				case 3:
					//turn end
					//do the clean
					cp = this.getPlayer(Enforcement.curPlayer);
					cp.fighter.aatk = 0;
					cp.fighter.updateAttributes();
					for (i = Enforcement.board.left; i <= Enforcement.board.right; ++i)
					{
						for (j = Enforcement.board.up; j <= Enforcement.board.bottom; ++j)
						{
							Enforcement.board.sprBlock[i][j].visible = false;
						}
					}
					
					//do the account
					if (!cp.fighter.moved)
					{
						
						cp.fighter.moveEnd();
					}
					
					break;
				case 4:
					//atk is clicked
					//choose opponent
					cp = this.getPlayer(Enforcement.curPlayer);
					cp.fighter.aatk = cp.fighter.curSp - cp.fighter.moveSp;
					cp.fighter.updateAttributes();
					var ar:Array = cp.fighter.atkRange();
					
					for (i = Enforcement.board.left; i <= Enforcement.board.right; ++i)
					{
						for (j = Enforcement.board.up; j <= Enforcement.board.bottom; ++j)
						{
							Enforcement.board.sprBlock[i][j].visible = false;
						}
					}
					
					for (i = 0; i < ar.length; ++i)
					{
						Enforcement.board.sprBlock[ar[i * 2]][ar[i * 2 + 1]].visible = true;
					}
					
					
					break;
				case 5:
					//target player is chosed
					//wait the player to confirm
					dialog.visible = true;
					dialog.title.text = "Warnning";
					dialog.content.text = "Are you sure to attack the player?";
					
					
					break;
				case 6:
					//def is clicked
					//wait the player to confirm
					dialog.visible = true;
					dialog.title.text = "Warnning";
					dialog.content.text = "Are you sure to defend?";					
					break;
				case 7:
					//reverse is clicked
					//wait the player to confirm
					dialog.visible = true;
					dialog.title.text = "Warnning";
					dialog.content.text = "Reverse the nature will comsume 10 SP, are you sure?";
					break;
				case 8:
					//skill is clicked
					//wait the player to confirm
					dialog.visible = true;
					dialog.title.text = "Warnning";
					dialog.content.text = "Unleash a skill will comsume 10 SP, are you sure?";
					break;
			}
			
		}
		
		public function getPlayer(v:int):Player
		{
			var tt:Player;
			for each (var pp:Player in Enforcement.player)
			{
				if (pp.id == v)
				{
					break;
				}
			}
			return pp;
		}
		
		public function diceSet(v:int):void
		{
			var tt:Player = getPlayer(Enforcement.curPlayer);
			tt.fighter.curSp = v;
			changeIState(2);
		}
		
		public function PlayState()
		{
			super();

		}
		
		
		
		override public function create():void
		{

			
			statPad1 = new StatPad();
			statPad2 = new StatPad();
			statPad3 = new StatPad();
			statPad4 = new StatPad();
			
			add(statPad1);
			add(statPad2);
			add(statPad3);
			add(statPad4);
			
			statPad1.setAttr(0, 0, 1);
			statPad2.setAttr(540, 0, 2);
			statPad3.setAttr(0, 260, 3);
			statPad4.setAttr(540, 260, 4);
			
			add(new Dice());
			
			add(Enforcement.board);
			istate = 1;
			
			dialog = new Dialog();
			add(dialog);
			
			debugTxt = new FlxText(100, 100, 100);
			add(debugTxt);
			
			btnAtk = new PlayBtn(85, 140, "ATK");
			btnDef = new PlayBtn(85, 160, "DEF");
			btnRev = new PlayBtn(85, 180, "REV");
			//btnSkill = new PlayBtn(85, 190, "SKILL");
			btnEnd = new PlayBtn(85, 200, "END");
			add(btnAtk);
			add(btnDef);
			add(btnRev);
			add(btnSkill);
			add(btnEnd);
			
			btnBack = new MenuButton(550, 170, "BACK");
			btnBack.onUp = function():void
			{

				FlxG.switchState(Enforcement.menuState);
			}
			add(btnBack);
			
			/**
			 * click def button
			 * goto inner state 6
			 */
			btnDef.onUp = function():void
			{
				var cp:Player = getPlayer(Enforcement.curPlayer);
				if (cp.fighter.curSp == 0)
					return;
				changeIState(6);
			}
			
			/**
			 * click reverse button
			 * goto inner state 7
			 */
			btnRev.onUp = function():void
			{
				var cp:Player = getPlayer(Enforcement.curPlayer);
				if (cp.fighter.sp >= 10)
				{
					changeIState(7);
				}
			}
			
			/**
			 * click atk button
			 * goto inner state 4
			 */
			btnAtk.onUp = function():void
			{
				var cp:Player = getPlayer(Enforcement.curPlayer);
				if (cp.fighter.curSp == 0)
					return;
				changeIState(4);
			}
			
			/**
			 * end this turn
			 * change player
			 */
			btnEnd.onUp = function():void
			{
				var cp:Player = getPlayer(Enforcement.curPlayer);
				if (cp.fighter.curSp == 0)
				{
					return;
				}
				var i:int;

				
				//set new player
				
				//change istate to 3
				//to do the clean
				if (Enforcement.playState.istate != 3)
				{
					changeIState(3);
				}
				

				
				//change istate to 1
				changeIState(1);
			}
			
		}
		
		/**
		 * call by dialog
		 */
		public function confirm():void
		{
			var cp:Player = getPlayer(Enforcement.curPlayer);
			var tp:Player = getPlayer(Enforcement.targetPlayer);
			switch (istate)
			{
				case 5:
					//target player confirmed
					//cp = getPlayer(Enforcement.curPlayer);
					cp.fighter.attck(tp);
					dialog.visible = false;
					btnEnd.onUp();
					
					
					
					break;
				case 6:
					//def confirmed
					cp.fighter.ddef = cp.fighter.curSp - cp.fighter.moveSp;
					cp.fighter.updateAttributes();
					dialog.visible = false;
					btnEnd.onUp();
					break;
				case 7:
					//reverse confirmed
					cp.fighter.atkdefFlag = !cp.fighter.atkdefFlag;
					cp.fighter.updateAttributes();
					cp.fighter.sp -= 10;
					dialog.visible = false;
					changeIState(2);
					break;
				case 8:
					//skill confirmed
					break;
			}
		}
		
		/**
		 * call by dialog
		 */
		public function cancel():void
		{
			var cp:Player = getPlayer(Enforcement.curPlayer);
			dialog.visible = false;
			if (istate == 6)
			{
				cp.fighter.ddef = 0;
				cp.fighter.updateAttributes();
			}
			else if (istate == 5)
			{
				cp.fighter.aatk = 0;
				cp.fighter.updateAttributes();
			}

				
			changeIState(2);
		}
	}
}