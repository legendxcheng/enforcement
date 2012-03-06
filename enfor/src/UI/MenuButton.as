package UI
{
	import org.flixel.FlxButton;
	/**
	 * @author Xcheng
	 * button class tuned for Enforcement
	 */ 
	
	public class MenuButton extends FlxButton
	{
		[Embed(source="pics/menubutton.png")] protected var ImgMenuButton:Class;
		public function MenuButton(X:Number=0, Y:Number=0, Label:String=null, OnClick:Function=null)
		{
			super(X, Y, Label, OnClick);
			loadGraphic(ImgMenuButton,true,false,80,20);
		}

	}
}