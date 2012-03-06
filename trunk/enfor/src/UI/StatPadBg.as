package UI
{
	import org.flixel.FlxButton;
	/**
	 * @author Xcheng
	 * button class tuned for Enforcement
	 * status pad background
	 */ 
	public class StatPadBg extends FlxButton
	{
		public var parent:StatPad;
		[Embed(source="pics/statpadbg_btn.png")] protected var ImgSPButton:Class;
		public function StatPadBg(pa:StatPad, X:Number=0, Y:Number=0, Label:String=null, OnClick:Function=null)
		{
			super(X, Y, Label, OnClick);
			loadGraphic(ImgSPButton,true,false,100,100);
			parent = pa;	
			//when press the button, call the parent function
			this.onDown = function():void
			{
				parent.press();
			}
		}
		

	}
}