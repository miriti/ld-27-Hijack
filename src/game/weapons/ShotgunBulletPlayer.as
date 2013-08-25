package game.weapons
{
	import game.Physix;
	import nape.shape.Circle;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ShotgunBulletPlayer extends ShotgunBullet
	{
		
		public function ShotgunBulletPlayer()
		{
			super();
		}
		
		override protected function initShape():void
		{
			var c:Circle = new Circle(_radius);
			c.filter.collisionGroup = Physix.GROUP_BULLETS;
			c.filter.collisionMask = ~(Physix.GROUP_PLAYER | Physix.GROUP_SEATS);
			_body.shapes.add(c);
		}
	}

}