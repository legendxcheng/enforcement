package States
{

	
	import States.*;
	
	import UI.*;
	
	import org.flixel.*;
	import org.flixel.plugin.TimerManager;
	/**
	 * @author Xcheng
	 * State for menu
	 * 
	 * fight
	 * 		2 players
	 * 		3 players
	 * 		4 players
	 * 
	 * exit
	 */
	
	public class MenuState extends FlxState
	{
		public var btnsp:MenuButton;
		public var btnmp:MenuButton;
		public var btnExit:MenuButton;
		public var btnTutor:MenuButton;
		
		public var credit:FlxText;
		public var copyright:FlxText;
		
		public var logo:FlxSprite; 
		
		public var enforcement:Enforcement;
		
		[Embed(source="pics/logo.png")] protected var ImgLogo:Class;
		
		
		public function MenuState()
		{
			super();
			

			
		}
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xffdddddd;
			btnmp = new MenuButton(280, 225, "Play");
			btnTutor = new MenuButton(280, 250, "Tutorial");
			btnExit = new MenuButton(280, 275, "Exit");
			credit = new FlxText(795, 330, 100, "A game by Xcheng");
			copyright = new FlxText(795, 340, 100, "All rights reserved.");
			credit.color = 0xff444444;
			copyright.color = 0xff444444;
			logo = new FlxSprite(95, 20, ImgLogo);
			
			this.add(btnTutor);
			this.add(btnsp);
			this.add(btnmp);
			this.add(btnExit);
			this.add(credit);
			this.add(copyright);
			this.add(logo);
			
			btnTutor.onUp = function():void
			{
				Enforcement.tutorialState = new TutorialState();
				FlxG.switchState(Enforcement.tutorialState);
			}
			
			btnmp.onUp = function():void
			{

				Enforcement.menuState = new MenuState();
				Enforcement.playState = new PlayState();
				Enforcement.selectState = new SelectState();
				
				
				Enforcement.timerManager = new TimerManager();			
				Enforcement.round = 0;
				Enforcement.player = new Array();
				Enforcement.board = new Board();
				Enforcement.board.init(10);
				FlxG.switchState(Enforcement.selectState);
			}
				
		}
	}
}