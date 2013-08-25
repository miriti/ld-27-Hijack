package game
{
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.space.Space;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Physix
	{
		private static var _space:Space;
		
		public static const GROUP_PLAYER:int = 0;
		public static const GROUP_BULLETS:int = 2;
		public static const GROUP_ENEMY:int = 4;
		public static const GROUP_WALLS:int = 8;
		public static const GROUP_ENEMY_BULLETS:int = 16;
		static public const GROUP_SEATS:int = 32;
		
		static public const TYPE_WALL:CbType = new CbType();
		static public const TYPE_BULLET:CbType = new CbType();
		static public const TYPE_ENEMY:CbType = new CbType();
		static public const TYPE_MOB:CbType = new CbType();
		static public const TYPE_BLOOD:CbType = new CbType();
		static public const TYPE_ANY:CbType = new CbType();
		
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
				_space.worldLinearDrag = 0;
			}
		}
		
		static public function get space():Space
		{
			return _space;
		}
	}

}