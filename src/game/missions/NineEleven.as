package game.missions
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import game.GamePlayer;
	import game.GameWorld;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class NineEleven extends GameWorld
	{
		[Embed(source="../../assets/maps/manhattan.jpg")]
		private static var manhattanBmp:Class;
		
		[Embed(source="../../assets/maps/plane.png")]
		private static var planeImage:Class;
		
		[Embed(source="../../assets/maps/plane_maze.png")]
		private static var planeMaze:Class;
		private var _manhattanImage:Image;
		private var timer:Timer;
		private var _cloudsLayer:Sprite;
		
		public function NineEleven()
		{
			super();
			
			_manhattanImage = new Image(Texture.fromBitmap(new manhattanBmp()));
			_manhattanImage.scaleX = _manhattanImage.scaleY = (3000 / _manhattanImage.width);
			_manhattanImage.x = (2000 - _manhattanImage.width) / 2;
			_manhattanImage.y = -3500;
			addChild(_manhattanImage);
			
			_cloudsLayer = new Sprite();
			addChild(_cloudsLayer);
			
			addChild(new Image(Texture.fromBitmap(new planeImage())));
			initMaze(new planeMaze());
			initPlayer();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			timer.stop();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			var cloud:Cloud = new Cloud();
			cloud.x = 1000 + (-500 + Math.random() * 1000);
			cloud.y = GamePlayer.lastPlayer.y - 1000;
			_cloudsLayer.addChild(cloud);
			
			TweenLite.to(cloud, 1 + Math.random(), {y: GamePlayer.lastPlayer.y + 1000, ease: Linear.easeNone, onComplete: function():void
				{
					_cloudsLayer.removeChild(cloud);
				}});
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			timer = new Timer(500);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		override protected function update(deltaTime:Number):void
		{
			_manhattanImage.y += 1;
			super.update(deltaTime);
		}
	
	}

}

import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

class Cloud extends Sprite
{
	[Embed(source="../../assets/cloud.png")]
	private static var _image:Class;
	
	public function Cloud()
	{
		var img:Image = new Image(Texture.fromBitmap(new _image()));
		img.x = -img.width / 2;
		img.y = -img.height / 2;
		addChild(img);
		
		rotation = Math.random() * (Math.PI * 2);
	}
}