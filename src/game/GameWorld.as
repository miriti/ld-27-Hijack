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
		
		[Embed(source="../assets/maps/test.png")]
		private static var testMaze:Class;
		private var _maze:GameMaze;
		protected var playerPosition:Point = new Point();
		
		public function GameWorld()
		{
			initMaze(new testMaze());
			initPlayer();
		}
		
		protected function initMaze(mazeImage:Bitmap, mazeScale:Number = 20):void
		{
			_maze = new GameMaze(mazeImage);
			
			for (var i:int = 0; i < mazeImage.width; i++)
			{
				for (var j:int = 0; j < mazeImage.height; j++)
				{
					if (mazeImage.bitmapData.getPixel32(i, j) == 0xff000000)
					{
						var q:Quad = new Quad(mazeScale, mazeScale, 0xcccccc);
						q.x = i * mazeScale;
						q.y = j * mazeScale;
						addChild(q);
					}
					
					if (mazeImage.bitmapData.getPixel32(i, j) == 0xffff0000)
					{
						playerPosition.setTo(i * mazeScale + mazeScale / 2, j * mazeScale + mazeScale / 2);
					}
				}
			}
		}
		
		protected function initPlayer():void
		{
			_crosshair = new Crosshair();
			_player = new GamePlayer(_crosshair);
			_player.x = playerPosition.x;
			_player.y = playerPosition.y;
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