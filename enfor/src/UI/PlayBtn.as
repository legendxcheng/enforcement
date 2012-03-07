package UI
{
	import org.flixel.FlxButton;
	
	public class PlayBtn extends FlxButton
	{
		[Embed(source="pics/playBtn.png")] protected var ImgRatioButton:Class;
		public function PlayBtn(X:Number=0, Y:Number=0, Label:String=null, OnClick:Function=null)
		{
			super(X, Y, Label, OnClick);
			loadGraphic(ImgRatioButton, true,false, 40,20);
		}
	}
}