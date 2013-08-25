package game.weapons
{
	import game.Physix;
	import nape.shape.Circle;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ShotgunBulletTerrorist extends ShotgunBullet
	{
		
		public function ShotgunBulletTerrorist()
		{
			super();
		}
		
		override protected function initShape():void
		{
			var c:Circle = new Circle(_radius);
			c.filter.collisionGroup = Physix.GROUP_ENEMY_BULLETS;
			c.filter.collisionMask = ~(Physix.GROUP_ENEMY | Physix.GROUP_SEATS);
			_body.shapes.add(c);
		}
	
	}

}