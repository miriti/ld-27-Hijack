package game.weapons
{
	import game.Blood;
	import game.Entity;
	import game.Physix;
	import nape.callbacks.CbEvent;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Bullet extends Entity
	{
		private var _vector:Vec2;
		private var wallListener:InteractionListener;
		private var mobListener:InteractionListener;
		protected var _radius:Number = 3;
		protected var _speed:Number = 2;
		protected var _hitPower:Number = 5;
		
		public function Bullet()
		{
			super();
			initBody();
		}
		
		protected function initBody():void
		{
			_body = new Body(BodyType.DYNAMIC);
			_body.cbTypes.add(Physix.TYPE_BULLET);
			
			initShape();
			
			wallListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, Physix.TYPE_BULLET, Physix.TYPE_WALL, onWallCollision);
			mobListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, Physix.TYPE_BULLET, Physix.TYPE_MOB, onMobCollision);
			
			wallListener.space = Physix.space;
			mobListener.space = Physix.space;
		}
		
		protected function initShape():void
		{
			var c:Circle = new Circle(_radius);
			_body.shapes.add(c);
		}
		
		private function onMobCollision(cb:InteractionCallback):void
		{
			(cb.int2.castBody.userData.entity as Entity).hit(_hitPower);
			
			if (parent != null)
			{
				var cnt:int = 1; // Math.floor(2 + Math.random() * 3);
				
				for (var i:int = 0; i < cnt; i++)
				{
					var bl:Blood = new Blood(_body.velocity.rotate(-(Math.PI / 8) + Math.random() * (Math.PI / 4)));
					bl.setPosition(x, y);
					parent.addChild(bl);
				}
			}
			endFly();
		}
		
		private function onWallCollision(cb:InteractionCallback):void
		{
			endFly();
		}
		
		private function endFly():void
		{
			_body.space = null;
			removeFromParent(true);
		}
		
		public function fire(v:Vec2):void
		{
			v = v.normalise();
			_body.velocity.setxy(v.x * _speed, v.y * _speed);
		}
		
		override protected function init():void
		{
			Physix.space.bodies.add(_body);
		}
	
	}

}