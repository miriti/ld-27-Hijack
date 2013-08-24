package game
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
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
		private var _debugDraw:ShapeDebug;
		
		public function GameWorld()
		{
			Physix.init();
			
			_crosshair = new Crosshair();
			_player = new GamePlayer(_crosshair);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_debugDraw = new ShapeDebug(Main.sceneWidth, Main.sceneHeight, 0x0);
			Starling.current.nativeOverlay.addChild(_debugDraw.display);
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
			
			Physix.update(deltaTime);
		}
	
	}

}