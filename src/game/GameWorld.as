package game
{
	import flash.display.Bitmap;
	import nape.geom.Mat23;
	import nape.util.BitmapDebug;
	import nape.util.Debug;
	import nape.util.ShapeDebug;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameWorld extends TimedSprite
	{
		private var _player:GamePlayer;
		private var _crosshair:Crosshair;
		private var _maze:GameMaze;
		private var _debugDraw:Debug;
		
		private var _time:Number = 0;
		
		private static const DEBUG_DRAW:Boolean = false;
		
		public function GameWorld()
		{
			Physix.init();
			
			_crosshair = new Crosshair();
			_player = new GamePlayer(_crosshair);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function win():void 
		{
			
		}
		
		private function onAddedToStage(e:Event):void
		{
			if (DEBUG_DRAW)
			{
				_debugDraw = new ShapeDebug(Main.sceneWidth, Main.sceneHeight);
				_debugDraw.drawConstraints = true;
				Starling.current.nativeOverlay.addChild(_debugDraw.display);
			}
		}
		
		protected function initMaze(mazeImage:Bitmap, mazeScale:Number = 20):void
		{
			_maze = new GameMaze(this, mazeImage);
		}
		
		protected function initPlayer():void
		{
			addChild(_player);
			addChild(_crosshair);
		}
		
		override protected function update(deltaTime:Number):void
		{
			x = (Main.sceneWidth / 2) - _player.x;
			y = (Main.sceneHeight / 2) - _player.y;
			
			if (DEBUG_DRAW)
			{
				_debugDraw.transform = Mat23.translation((Main.sceneWidth / 2) - _player.x, (Main.sceneHeight / 2) - _player.y);
				_debugDraw.clear();
				_debugDraw.draw(Physix.space);
				_debugDraw.flush();
			}
			
			Physix.update(deltaTime);
			
			_time += deltaTime;
			
			if (_time >= 10000)
			{
				gameOver();
			}
		}
		
		private function gameOver():void
		{
			StateControll.instance.setState(new FailState());
		}
	
	}

}