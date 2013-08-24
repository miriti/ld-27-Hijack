package game
{
	import nape.geom.Vec2;
	import nape.space.Space;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Physix
	{
		private static var _space:Space;
		
		static public function update(deltaTime:Number):void
		{
			_space.step(deltaTime);
		}
		
		static public function init():void
		{
			if (_space != null)
			{
				_space.clear();
			}
			else
			{
				_space = new Space(Vec2.get(0, 0));
			}
		}
		
		static public function get space():Space
		{
			return _space;
		}
	}

}