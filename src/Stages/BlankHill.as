package Stages
{
	import adobe.utils.CustomActions;
	import Characters.Jet;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemapExt;
	import org.flixel.FlxG;
	import org.flixel.FlxCamera;
	import Stages.HUDElements.TrickText;
	import org.flixel.plugin.photonstorm.FlxCollision;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class BlankHill extends FlxState
	{
		[Embed(source = "mapCSV_Level_Map.csv", mimeType = "application/octet-stream")] private var Level:Class;
		[Embed(source = "BHBG.png")] private var StaBG:Class;
		[Embed(source = "CyTrSS.png")] private var Tiles:Class;
		[Embed(source = "../Music/testmusic.mp3")] private var Music:Class;
		
		private var background:FlxSprite = new FlxSprite(0, 0, StaBG);
		private var stageSet:FlxTilemapExt = new FlxTilemapExt();
		private var score:int = 0;
		private var scoreLabel:FlxText = new FlxText(0, 10, 400, "", false);
		
		private var player:Jet = new Jet(10, 0);
		public function BlankHill() 
		{
			
		}
		
		override public function create():void
		{
			FlxG.playMusic(Music);
			FlxG.resetCameras(new FlxCamera(0, 0, 320, 240));
			background.scrollFactor.x = 0.1;
			background.scrollFactor.y = 0.1;
			add(background);
			add(stageSet);
			stageSet.loadMap(new Level, Tiles, 32, 32);
			add(player);
			add(player.exhaust);
			add(player.boostAura);
			
			scoreLabel.size = 20;
			scoreLabel.scrollFactor.x = 0;
			scoreLabel.scrollFactor.y = 0;
			scoreLabel.shadow = 0xFF00B000;
			add(scoreLabel);
			
			
		}
		
		override public function update():void
		{
			super.update();
			FlxG.camera.setBounds(0, 0, stageSet.width, stageSet.height, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			FlxG.collide(player, stageSet);
			scoreLabel.text = "Score: " + score.toString();
			
			if (player.y > stageSet.height)
			{
				FlxG.fade(0x00000000, 0.5, restart);
			}
			
			if (player.tricking == true )
			{
				score += 10;
			}
			
			//Trick Names
			if (FlxG.keys.justPressed("X"))
			{
				add(new TrickText(200, 215, 200, "Method", false));
			}
			
			if (FlxG.keys.justPressed("C"))
			{
				add(new TrickText(185, 190, 200, "Jessy", false));
			}
			
			if (player.angle == 360 && player.trickNumber == false)
			{
				add(new TrickText(200, 190, 200, "FS 360 Spin", false));
				player.trickNumber == true;
			}

			if (player.angle == 900 && player.trickNumber == false)
			{
				add(new TrickText(200, 190, 200, "FS 900 Spin", false));
				player.trickNumber == true;
			}
			
			if (player.angle == -360 && player.trickNumber == false)
			{
				add(new TrickText(200, 190, 200, "BS 360 Spin", false));
				player.trickNumber == true;
			}
		}
		
		public function restart():void
		{
			FlxG.resetState();
		}
	}

}