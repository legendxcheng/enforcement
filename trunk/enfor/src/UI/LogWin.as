package UI
{
	import org.flixel.*;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class LogWin extends FlxGroup
	{
		[Embed(source="pics/logwin.png")] protected var ImgSpPlus:Class;
		public var bg:FlxSprite;
		public var title:FlxText;
		public var log:Array;
		public var content:FlxText;
		
		public function LogWin(MaxSize:uint=0)
		{
			super(MaxSize);
			bg = new FlxSprite(650, 0, ImgSpPlus);
			add(bg);
			
			title = new FlxText(660, 2, 100, "Log");
			title.color = 0xffeeeeee;
			add(title);
			
			log = new Array();
			//log[0] = "adslkfjsl;dkjfl;skjf\nl;kasdjf;lsdfj";
			content = new FlxText(655, 25, 240);
			content.color = 0x44444444;
			//content.text = log[0];
			add(content);
		}
		
		
		public function updateContent():void
		{
			var st:int = log.length - 11;
			if (st < 0) st = 0;
			content.text = "";
			for (var i:int  = st; i < log.length; ++i)
			{
				content.text += log[i] + "\n";
			}
		}
		
		
	}
}