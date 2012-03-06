package UI
{
	import org.flixel.*;
	//import org.osmf.layout.AbsoluteLayoutFacet;
	/**
	 * @author Xcheng
	 */
	
	public class Dialog extends FlxGroup
	{
		public var bg:FlxSprite;
		[Embed(source="pics/dialogBg.png")] protected var ImgBg:Class;
		public var title:FlxText;
		public var content:FlxText;
		public var confirmBtn:DialogBtn;
		public var cancelBtn:DialogBtn;
		
		public var ret:Boolean;
		
		public function Dialog(MaxSize:uint=0)
		{
			super(MaxSize);
			bg = new FlxSprite();
			bg.loadGraphic(ImgBg, false, false, 200, 100, false);
			bg.x = 220;
			bg.y = 130;
			add(bg);
			
			title = new FlxText(230, 135, 100, "Title");//will set when used
			add(title);
			
			
			
			confirmBtn = new DialogBtn(240, 200, "Confirm");
			confirmBtn.label.color = 0xffeeeeee;
			add(confirmBtn);
			
			cancelBtn = new DialogBtn(340, 200, "Cancel");
			cancelBtn.label.color = 0xffeeeeee;
			add(cancelBtn);
			
			confirmBtn.onUp = function():void
			{
				ret = true;
				if (FlxG.state == Enforcement.playState)
					Enforcement.playState.confirm();
				else
					if (FlxG.state == Enforcement.selectState)
					{
						Enforcement.selectState.funcDialog();
					}
			}
			
			cancelBtn.onUp = function():void
			{
				ret = false;
				if (FlxG.state == Enforcement.playState)
					Enforcement.playState.cancel();
				else
				{
					Enforcement.selectState.funcDialog();
				}
			}
			
			content = new FlxText(235, 160, 180, "content..........");
			add(content);
			content.color = 0xff444444;
				
			this.visible = false;
		}
		

		
	}
}