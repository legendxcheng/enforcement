package UI
{
	import org.flixel.FlxButton;
	
	public class Ratio extends FlxButton
	{
		[Embed(source="pics/ratio_btn.png")] protected var ImgPlayButton:Class;
		public function Ratio(X:Number=0, Y:Number=0, Label:String=null, OnClick:Function=null)
		{
			super(X, Y, Label, OnClick);
			loadGraphic(ImgPlayButton, true,false, 14,14);
			
		}
	}
}