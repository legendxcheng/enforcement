package States
{
	import UI.MenuButton;
	
	import org.flixel.*;
	import org.flixel.FlxState;
	
	public class TutorialState extends FlxState
	{
		public var tutor:FlxSprite;
		[Embed(source="pics/tutorial.png")] protected var ImgTutor:Class;
		public var next:MenuButton;
		public var prev:MenuButton;
		public var back:MenuButton;
		
		public function TutorialState()
		{
			super();
		}
		
		override public function create():void
		{
			tutor = new FlxSprite(130, 0);
			tutor.loadGraphic(ImgTutor, false, false, 640, 360, false);
			add(tutor);
			tutor.frame = 0;
			
			back = new MenuButton(680, 340, "Back");
			next = new MenuButton(580, 340, "Next");
			prev = new MenuButton(480, 340, "Prev");
			
			back.onUp = function():void
			{
				Enforcement.menuState = new MenuState();
				FlxG.switchState(Enforcement.menuState);
			}
			
			next.onUp = function():void
			{
				Enforcement.tutorialState.tutor.frame += 1;
				if (Enforcement.tutorialState.tutor.frame > 4)
					Enforcement.tutorialState.tutor.frame = 0;
			}
				
			prev.onUp = function():void
			{
				if (Enforcement.tutorialState.tutor.frame == 0)
					Enforcement.tutorialState.tutor.frame = 4;
				else Enforcement.tutorialState.tutor.frame -= 1;
			}
			add(next);
			add(prev);
			add(back);
		}
	}
}