package game
{
	import nape.callbacks.CbEvent;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Blood extends Entity
	{
		private var _radius:Number;
		private var anyListener:InteractionListener;
		
		public function Blood(vel:Vec2)
		{
			super();
			_radius = 2 + Math.random() * 2;
			
			_body = new Body(BodyType.DYNAMIC);
			var c:Circle = new Circle(_radius);
			c.filter.collisionMask = ~(Physix.GROUP_ENEMY | Physix.GROUP_PLAYER);
			_body.shapes.add(new Circle(_radius));
			_body.cbTypes.add(Physix.TYPE_BLOOD);
			
			anyListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, Physix.TYPE_BLOOD, Physix.TYPE_ANY, onAnyCollision);
			
			var q:Quad = new Quad(_radius, _radius, 0xCC0000);
			q.x = q.y = -_radius / 2;
			addChild(q);
			
			_body.velocity.set(vel);
		}
		
		private function onAnyCollision(cb:InteractionCallback):void
		{
			_body.space = null;
		}
	
	}

}