package Characters
{
	import flash.events.TimerEvent;
	import org.flixel.FlxSprite;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxCamera;
	import org.flixel.FlxParticle;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxExtendedSprite;
	import Characters.JetFX;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Alec Day
	 */
	public class Jet extends FlxExtendedSprite
	{
		[Embed(source = "sprites/jetss.png")] private var Sprite:Class
		[Embed(source = "sprites/exhaust.png")] private var Part:Class
		[Embed(source = "sprites/boost.png")] private var Aura:Class
		
		//Instance Vars
		public var exhaust:FlxEmitter;
		public var numParticles:int = 10;
		public var prePoints:int = 0;
		public var tricking:Boolean = false;
		public var trickNumber:Boolean = false;
		private var jumpHoldTime:uint = 0;
		
		public var boostAura:FlxSprite;
		private var boostTimer:Timer = new Timer(1000, 3);
		public function Jet(x:uint, y:uint) 
		{
			super(x, y);
			loadGraphic(Sprite, true, true, 50, 45, true);
			
			addAnimation("move", [0], 60, false);
			addAnimation("jump", [1], 60, false);
			addAnimation("jessy", [2], 60, false);
			addAnimation("method", [4], 60, false);
			
			resetPhysics();
			
			
			exhaust = new FlxEmitter(x, y, numParticles);
			exhaust.setSize(5, 4);
			exhaust.setXSpeed( -5, 5);
			exhaust.setYSpeed(0, 0);
			exhaust.lifespan = 0.1;
			
			boostAura = new FlxSprite(x, y, Aura);
			boostAura.visible = false;
			
			for (var b:int = 0; b < numParticles; b++)
			{	
				var particle:FlxParticle = new FlxParticle()
				particle.loadGraphic(Part);
				particle.blend = "add";
				exhaust.add(particle);
			}	
			exhaust.start(false, 0.3, 0.1, 0);
			boostTimer.addEventListener(TimerEvent.TIMER_COMPLETE,endBoost);
			facing = RIGHT;
		}
		
		public function resetPhysics():void
		{
			acceleration.x = 25;
			acceleration.y = 200;
			drag.y = 200;
		}
		
		override public function update():void
		{
			super.update();
			
			boostAura.x = x;
			boostAura.y = y;
			
			if(facing == RIGHT)
				exhaust.x = x;
				
			if (facing == LEFT)
				exhaust.x = x + 50;
				
			exhaust.y = y + 42;
			
			if (touching == FLOOR)
			{
				tricking = false;
				angle = 0;
				play("move");
				FlxG.shake(1, 0.03, null, false, 1);				
			}
			
			if (touching != FLOOR)
			{
				//Trick Options
				if (FlxG.keys.UP)
						{
							tricking = true;
							angle += 5;
						}
						
					if (FlxG.keys.DOWN)
						{
							tricking = true;
							angle -= 5;
						}

				if (FlxG.keys.X)
				{
					tricking = true;
					play("method");					
				}
				
				if (FlxG.keys.C && FlxG.keys.X )
				{
					tricking = true;
					play("jessy");					
				}
				else
					play("jump");
					
			}
			//Control
			if (FlxG.keys.RIGHT && velocity.x < 200)
			{
				velocity.x += 10;
			}
			
			if (FlxG.keys.LEFT && velocity.x > 0)
			{
				velocity.x -= 10;
			}
			
			//Jumping
			if (FlxG.keys.Z && velocity.x > 0)
			{
				acceleration.x = 3;
				velocity.x -= 2;
				jumpHoldTime += 1;
			}
			
			if (FlxG.keys.justReleased("Z")&& isTouching(FLOOR))
			{
				randomJump();
				velocity.y -= 100 + jumpHoldTime;
				jumpHoldTime = 0;
				resetPhysics();
			}
			
			//Boosting
			if (FlxG.keys.justPressed("SPACE"))
			{
				boostTimer.start();
				FlxG.play(JetFX.boostSnd);
				boostAura.visible = true;
				FlxG.shake(0.02, 0.5, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
				velocity.x = 400;
			}
		
		}
		
		private function randomJump():void
		{
			var a:uint = Math.random() * 6;
			if (a % 2 == 0)
			{
				FlxG.play(JetFX.jumpSnd2);
			}
			
			else
			{
				FlxG.play(JetFX.jumpSnd);
			}
		}
		
		public function endBoost(e:TimerEvent):void
		{
			boostAura.visible = false;
		}
	}

}