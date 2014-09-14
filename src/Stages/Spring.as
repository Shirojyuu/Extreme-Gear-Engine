package Stages 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class Spring extends FlxSprite
	{
		[Embed(source = "Gimmicks/spings.png")] private var Sprite:Class;
		public function Spring(x:uint, y:uint) 
		{
			super(x, y, Sprite);
		}
		
	}

}