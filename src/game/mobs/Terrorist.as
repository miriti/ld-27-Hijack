package game.mobs
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import game.Entity;
	import game.GamePlayer;
	import game.GameSound;
	import game.Physix;
	import game.weapons.ShotgunBulletTerrorist;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Terrorist extends Entity
	{
		[Embed(source="../../assets/entities/terrorist/atack.png")]
		private static var _atackImage:Class;
		
		[Embed(source="../../assets/entities/terrorist/dead.png")]
		private static var _deadImage:Class;
		
		[Embed(source="../../assets/entities/terrorist/dead_head_shot.png")]
		private static var _deadHeadshotImage:Class;
		
		public static var knowAboutPlayer:Boolean = false;
		
		protected var _imageAtack:Image;
		private var fireDelay:Number = 0;
		private var _rotationTween:TweenLite;
		protected var _radiusToPlayer:Number = 300;
		
		public function Terrorist()
		{
			super();
			
			if (knowAboutPlayer)
				knowAboutPlayer = false;
			
			_body = new Body(BodyType.DYNAMIC);
			var c:Circle = new Circle(20);
			c.filter.collisionGroup = Physix.GROUP_ENEMY;
			_body.shapes.add(c);
			_body.cbTypes.add(Physix.TYPE_MOB);
			_body.userData.entity = this;
			
			initHealth(100);
		}
		
		override protected function init():void
		{
			_imageAtack = addImage(new _atackImage());
			super.init();
		}
		
		override protected function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if (!dead)
			{
				if (!GamePlayer.lastPlayer.dead)
				{
					var playerVector:Point = new Point(x - GamePlayer.lastPlayer.x, y - GamePlayer.lastPlayer.y);
					var angleToPlayer:Number = Math.atan2(playerVector.y, playerVector.x);
					if (playerVector.length < _radiusToPlayer)
					{
						if (knowAboutPlayer)
						{
							/*if ((_rotationTween == null) || (!_rotationTween.active))
							 _rotationTween = TweenLite.to(this, (Math.random() * 0.3) + 0.1, {rotation: angleToPlayer, ease: Linear.easeNone});*/
							rotation = angleToPlayer;
							
							if (fireDelay <= 0)
							{
								fire();
								fireDelay = 2000;
							}
							else
							{
								fireDelay -= deltaTime;
							}
						}
						else
						{
							if (((rotation - angleToPlayer) < 1) && ((rotation - angleToPlayer) > -1))
							{
								knowAboutPlayer = true;
							}
						}
					}
				}
			}
			else
			{
				rotation = _body.rotation;
			}
		}
		
		override public function get rotation():Number
		{
			return super.rotation;
		}
		
		override public function set rotation(value:Number):void
		{
			if (!dead)
			{
				_body.rotation = value;
			}
			super.rotation = value;
		}
		
		protected function fire():void
		{
			GameSound.playSound("shotgunShot");
			for (var i:int = 0; i < 5; i++)
			{
				var sb:ShotgunBulletTerrorist = new ShotgunBulletTerrorist();
				var rndAngle:Number = (rotation - Math.PI) + ((-Math.PI / 32) + (Math.random() * (Math.PI / 16)));
				var v:Vec2 = new Vec2(Math.cos(rndAngle), Math.sin(rndAngle));
				sb.fire(v);
				sb.setPosition(x, y);
				parent.addChild(sb);
			}
		}
		
		override protected function deathAction():void
		{
			super.deathAction();
			removeChild(_imageAtack);
			if (Math.random() > 0.5)
			{
				addImage(new _deadImage());
			}
			else
			{
				addImage(new _deadHeadshotImage());
			}
		}
	
	}

}