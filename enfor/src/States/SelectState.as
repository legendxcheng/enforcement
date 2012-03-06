package States
{
	import Fighters.*;
	
	import UI.Block;
	import UI.Dice;
	import UI.FightBtn;
	import UI.StatPad;
	import UI.Dialog;
	
	import org.flixel.*;

	/**
	 * @author Xcheng
	 */ 
	public class SelectState extends FlxState
	{
		public var statPad1:StatPad;
		public var statPad2:StatPad;
		public var statPad3:StatPad;
		public var statPad4:StatPad;
		public var fightBtn:FightBtn;
		public var enforcement:Enforcement;
		public var dialog:Dialog;
		
		public function SelectState()
		{
			super();

		}
		
		public function funcDialog():void
		{
			dialog.visible = false;
		}
		
		override public function create():void
		{
			
			fightBtn = new FightBtn();
			fightBtn.x = 224;
			fightBtn.y = 100;
			add(fightBtn);
			
			statPad1 = new StatPad();
			statPad2 = new StatPad();
			statPad3 = new StatPad();
			statPad4 = new StatPad();
			
			add(statPad1);
			add(statPad2);
			add(statPad3);
			add(statPad4);
			
			
			//test
			dialog = new Dialog();
			add(dialog);
			dialog.visible = false;
			dialog.title.text = "Add player";
			dialog.content.text = "You have to add at least 2 player";
			
			
			statPad1.setAttr(0, 0, 1);
			statPad2.setAttr(540, 0, 2);
			statPad3.setAttr(0, 260, 3);
			statPad4.setAttr(540, 260, 4);	
			
			/**
			 * set players and fighters
			 */ 
			fightBtn.onUp = function():void
			{
				Enforcement.playerNum = 0;
				Enforcement.player.length = 0;//clear the player array
				Enforcement.curPlayer = -1;
				
				Enforcement.player = new Array();
				Enforcement.playerNum = 0;
				
				if (statPad1.type != 4)
				{
					
					Enforcement.addPlayer(statPad1.type, 1);
					if (Enforcement.curPlayer < 0)
						Enforcement.curPlayer = 1;
						
				}
				if (statPad2.type != 4)
				{
					
					Enforcement.addPlayer(statPad2.type, 2);
					if (Enforcement.curPlayer < 0)
						Enforcement.curPlayer = 2;
						
				}
				if (statPad3.type != 4)
				{
					
					Enforcement.addPlayer(statPad3.type, 3);
					if (Enforcement.curPlayer < 0)
						Enforcement.curPlayer = 3;
					
				}
				if (statPad4.type != 4)
				{
					
					Enforcement.addPlayer(statPad4.type, 4);
					if (Enforcement.curPlayer < 0)
						Enforcement.curPlayer = 4;
						
				}
				
				if (Enforcement.player.length < 2)
				{
					//show need to add player
					dialog.visible = true;
					
				}
				else
					FlxG.switchState(Enforcement.playState);
			}
		

		}
	}
}