package Stages.HUDElements 
{
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class TrickText extends FlxText
	{
		
		public function TrickText(x:uint, y:uint, width:uint,text:String,embed:Boolean) 
		{
			super(x, y, width, text, embed);
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			size = 60;
			
		}
		
		override public function update():void
		{
			super.update();
			fade();
		}
		
		public function fade():void
		{
			if (alpha > 0)
			{
				alpha -= 0.01;
				velocity.x += 1;
			}
			
			if (alpha == 0)
			{
				kill();
			}
		}
		
	}

}