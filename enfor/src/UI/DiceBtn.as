package UI
{
	import org.flixel.FlxButton;
	
	public class DiceBtn extends FlxButton
	{
		[Embed(source="pics/dice_btn.png")] protected var ImgDiceButton:Class;
		public function DiceBtn(X:Number=0, Y:Number=0, Label:String=null, OnClick:Function=null)
		{
			super(X, Y, Label, OnClick);
			loadGraphic(ImgDiceButton,true,false,64,64);
			this.alpha = 0;
		}
	}
}