package game
{
	import flash.events.NetStatusEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import game.mobs.Terrorist;
	import game.weapons.Bullet;
	import game.weapons.ShotgunBullet;
	import game.weapons.ShotgunBulletPlayer;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GamePlayer extends Entity
	{
		static public const SPEED:Number = 0.5;
		
		[Embed(source="../assets/entities/player/player.png")]
		private static var _image:Class;
		
		[Embed(source="../assets/entities/player/dead.png")]
		private static var _deadBitmap:Class;
		
		private var _crosshar:Crosshair;
		static private var _lastPlayer:GamePlayer;
		private var _playerImage:Image;
		
		private var _winPoints:Array = new Array(new Point(950, 270), new Point(1080, 270));
		private var _winRadius:Number = 35;
		private var _win:Boolean = false;
		
		public function GamePlayer(crosshair:Crosshair)
		{
			_crosshar = crosshair;
			
			_lastPlayer = this;
			
			_body = new Body(BodyType.DYNAMIC);
			_body.cbTypes.add(Physix.TYPE_MOB);
			_body.userData.entity = this;
			var c:Circle = new Circle(20);
			c.filter.collisionMask = ~(Physix.GROUP_BULLETS);
			_body.shapes.add(c);
			Physix.space.bodies.add(_body);
			
			initHealth(250);
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			Input.instance.removeMouseDownHook(onMouseDown);
			Input.instance.removeMouseUpHoop(onMouseUp);
		}
		
		override protected function init():void
		{
			_playerImage = addImage(new _image());
			
			Input.instance.addMouseDownHook(onMouseDown);
			Input.instance.addMouseUpHook(onMouseUp);
			
			super.init();
		}
		
		protected function onMouseDown():void
		{
			fireStart();
		}
		
		protected function onMouseUp():void
		{
			fireEnd();
		}
		
		protected function fireStart():void
		{
			if (!dead)
			{
				GameSound.playSound("shotgunShot");
				if (!Terrorist.knowAboutPlayer)
					Terrorist.knowAboutPlayer = true;
				for (var i:int = 0; i < 5; i++)
				{
					var sb:ShotgunBulletPlayer = new ShotgunBulletPlayer();
					var rndAngle:Number = (rotation - Math.PI) + ((-Math.PI / 32) + (Math.random() * (Math.PI / 16)));
					var v:Vec2 = new Vec2(Math.cos(rndAngle), Math.sin(rndAngle));
					sb.fire(v);
					sb.setPosition(x, y);
					parent.addChild(sb);
				}
			}
		}
		
		protected function fireEnd():void
		{
		
		}
		
		override protected function deathAction():void
		{
			removeChild(_playerImage);
			addImage(new _deadBitmap());
			super.deathAction();
			_body.rotation = rotation;
			
			setTimeout(gameOver, 1000);
		}
		
		private function gameOver():void
		{
			StateControll.instance.setState(new FailState());
		}
		
		override protected function update(deltaTime:Number):void
		{
			if ((!_dead) && (!_win))
			{
				for (var i:int = 0; i < _winPoints.length; i++)
				{
					var mesure:Point = new Point(x - _winPoints[i].x, y - _winPoints[i].y);
					if (mesure.length <= _winRadius)
					{
						win();
					}
				}
				
				rotation = Math.atan2(y - _crosshar.y, x - _crosshar.x);
				
				if (Input.instance.isUp())
				{
					_body.velocity.y = -SPEED;
				}
				else
				{
					if (Input.instance.isDown())
					{
						_body.velocity.y = SPEED;
					}
					else
					{
						_body.velocity.y = 0;
					}
				}
				
				if (Input.instance.isRight())
				{
					_body.velocity.x = SPEED;
				}
				else
				{
					if (Input.instance.isLeft())
					{
						_body.velocity.x = -SPEED;
					}
					else
					{
						_body.velocity.x = 0;
					}
				}
			}
			else
			{
				rotation = _body.rotation;
			}
			
			super.update(deltaTime);
		}
		
		override public function get dead():Boolean
		{
			return super.dead || _win;
		}
		
		private function win():void
		{
			_win = true;
			(parent as GameWorld).win();
		}
		
		static public function get lastPlayer():GamePlayer
		{
			return _lastPlayer;
		}
	
	}

}