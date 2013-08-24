package game.weapons
{
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ShotgunBullet extends Bullet
	{
		
		public function ShotgunBullet()
		{
			super();
			
			_speed = 1.5 + Math.random() * 0.5;
			
			var q:Quad = new Quad(3, 3, 0x0);
			q.x = -q.width / 2;
			q.y = -q.height / 2;
			addChild(q);
		}
	
	}

}