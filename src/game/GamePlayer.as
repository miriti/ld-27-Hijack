package game
{
	import flash.events.NetStatusEvent;
	import flash.ui.Keyboard;
	import game.weapons.Bullet;
	import game.weapons.ShotgunBullet;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GamePlayer extends Entity
	{
		static public const SPEED:Number = 0.5;
		
		[Embed(source="../assets/entities/player/player.png")]
		private static var _image:Class;
		private var _crosshar:Crosshair;
		static private var _lastPlayer:GamePlayer;
		
		public function GamePlayer(crosshair:Crosshair)
		{
			_crosshar = crosshair;
			
			_lastPlayer = this;
			
			_body = new Body(BodyType.DYNAMIC);
			var c:Circle = new Circle(20);
			//c.filter.collisionGroup = Physix.GROUP_PLAYER;
			c.filter.collisionMask = Physix.GROUP_WALLS | Physix.GROUP_ENEMY;
			_body.shapes.add(c);
			Physix.space.bodies.add(_body);
		}
		
		override protected function init():void
		{
			addImage(new _image());
			
			Input.instance.addMouseDownHook(onMouseDown);
			Input.instance.addMouseUpHook(onMouseUp);
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
			for (var i:int = 0; i < 5; i++)
			{
				var sb:ShotgunBullet = new ShotgunBullet();
				var rndAngle:Number = (rotation - Math.PI) + ((-Math.PI / 32) + (Math.random() * (Math.PI / 16)));
				var v:Vec2 = new Vec2(Math.cos(rndAngle), Math.sin(rndAngle));
				sb.fire(v);
				sb.setPosition(x, y);
				parent.addChild(sb);
			}
		}
		
		protected function fireEnd():void
		{
		
		}
		
		override protected function update(deltaTime:Number):void
		{
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
			
			super.update(deltaTime);
		}
		
		static public function get lastPlayer():GamePlayer
		{
			return _lastPlayer;
		}
	
	}

}