package UI
{
	import org.flixel.FlxButton;
	/**
	 * @author Xcheng
	 * button class tuned for Enforcement
	 */ 
	
	public class FightBtn extends FlxButton
	{
		[Embed(source="pics/fightbtn.png")] protected var ImgFightButton:Class;
		public function FightBtn(X:Number=0, Y:Number=0, Label:String=null, OnClick:Function=null)
		{
			super(X, Y, Label, OnClick);
			loadGraphic(ImgFightButton,true,false,196,92);
		}
	}
}