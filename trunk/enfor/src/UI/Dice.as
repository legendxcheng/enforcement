package UI
{
	import org.flixel.*;
	
	/**
	 * @author Xcheng
	 */
	
	public class Dice extends FlxGroup
	{
		public var sprDice:FlxSprite;
		[Embed(source="pics/dice_all.png")] protected var ImgDice:Class;
		public var btn:DiceBtn;
		public var dTimer:FlxTimer;
		public var timerStarted:Boolean;
		
		public function Dice(MaxSize:uint=0)
		{
			super(MaxSize);
			sprDice = new FlxSprite();
			sprDice.loadGraphic(ImgDice, false, false, 64, 64, false);
			this.add(sprDice);
			sprDice.x = 17;
			sprDice.y = 148;
			
			btn = new DiceBtn(17, 148);
			btn.onUp = function():void
			{
				
				//can update only when inner state == 1
				if (Enforcement.playState.istate == 1 && !timerStarted)
				{
					timerStarted = true;
					dTimer = new FlxTimer();
					dTimer.start(1, 1);
					Enforcement.timerManager.add(dTimer);
				}
			}
			add(btn);
		}
		
		/**
		 * mod for the change the frame of sprDice
		 */
		override public function preUpdate():void
		{
			if (timerStarted)
			{
				if (!dTimer.finished)
				{
					sprDice.frame = Math.floor(Math.random() * 6);
				}
				else//finished 
				{
					timerStarted = false;
					Enforcement.playState.diceSet(sprDice.frame + 1);
				}
			}
		}
	}
}