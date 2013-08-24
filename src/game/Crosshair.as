package game
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Crosshair extends Entity
	{
		
		[Embed(source="../assets/crosshair.png")]
		private static var _image:Class;
		
		public function Crosshair()
		{
			addImage(new _image());
		}
		
		override protected function update(deltaTime:Number):void 
		{
			super.update(deltaTime);
			var p:Point = parent.globalToLocal(Input.instance.mousePosition);
			x = p.x;
			y = p.y;
		}
	
	}

}