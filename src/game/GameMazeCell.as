package game
{
	import game.mazeCells.PlayerPosition;
	import game.mazeCells.WallCell;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMazeCell
	{
		protected var _passable:Boolean = false;
		
		public function GameMazeCell(scale:Number)
		{
		
		}
		
		public static function factory(color:uint, scale:Number):GameMazeCell
		{
			switch (color)
			{
				case 0xff000000: 
					return new WallCell(scale);
					break;
				case 0xffff0000:
					return new PlayerPosition();
					break;
				default: 
					return null;
			}
		}
		
		public function get passable():Boolean
		{
			return _passable;
		}
	}

}