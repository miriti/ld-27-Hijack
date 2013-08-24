package game.weapons
{
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
		protected var _radius:Number = 3;
		protected var _speed:Number = 2;
		
		public function Bullet()
		{
			super();
			initBody();
		}
		
		protected function initBody():void
		{
			_body = new Body(BodyType.DYNAMIC);
			
			var c:Circle = new Circle(_radius);
			c.filter.collisionGroup = Physix.GROUP_BULLETS;
			c.filter.collisionMask = Physix.GROUP_WALLS;
			c.cbTypes.add(Physix.TYPE_BULLET);
			wallListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, Physix.TYPE_BULLET, Physix.TYPE_WALL, onWallCollision);
			wallListener.space = Physix.space;
			
			_body.shapes.add(c);
		}
		
		private function onWallCollision(cb:InteractionCallback):void
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