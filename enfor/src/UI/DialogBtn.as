package UI
{
	import org.flixel.FlxButton;
	
	public class DialogBtn extends FlxButton
	{
		[Embed(source="pics/dbtn.png")] protected var ImgDBtn:Class;
		public function DialogBtn(X:Number=0, Y:Number=0, Label:String=null, OnClick:Function=null)
		{
			super(X, Y, Label, OnClick);
			loadGraphic(ImgDBtn,true,false,60,20);
		}
	}
}