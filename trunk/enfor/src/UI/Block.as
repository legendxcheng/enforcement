package UI
{
	import org.flixel.FlxButton;
	
	public class Block extends FlxButton
	{
		public var rx:int;
		public var ry:int;
		[Embed(source="pics/blockbtn.png")] protected var ImgBlock:Class;
		
		public function Block(tx:int, ty:int, X:Number=0, Y:Number=0, Label:String=null, OnClick:Function=null)
		{
			super(X, Y, Label, OnClick);
			loadGraphic(ImgBlock,true,false, 32, 32);
			rx = tx;
			ry = ty;
			
			this.onUp = function():void
			{
				Enforcement.playState.pressBlock(rx, ry);
			}
		}
	}
}