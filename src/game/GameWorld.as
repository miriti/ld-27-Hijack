package game
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameWorld extends TimedSprite
	{
		private var _player:GamePlayer;
		private var _crosshair:Crosshair;
		private var _maze:GameMaze;		
		
		public function GameWorld()
		{
			_crosshair = new Crosshair();
			_player = new GamePlayer(_crosshair);
		}
		
		protected function initMaze(mazeImage:Bitmap, mazeScale:Number = 20):void
		{
			_maze = new GameMaze(mazeImage);
		}
		
		protected function initPlayer():void
		{
			_player.attachMaze(_maze);
			
			addChild(_player);
			addChild(_crosshair);
		}
		
		override protected function update(deltaTime:Number):void
		{
			x = (Main.sceneWidth / 2) - _player.x;
			y = (Main.sceneHeight / 2) - _player.y;
		}
	
	}

}