package game.missions
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import game.GameContainer;
	import game.GamePlayer;
	import game.GameWorld;
	import game.mobs.PilotTerrorist;
	import game.mobs.Terrorist;
	import game.StateControll;
	import game.WinState;
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
		static private var _planeTexture:Texture;
		private var _win:Boolean = false;
		
		public function NineEleven()
		{
			super();
			
			_manhattanImage = new Image(Texture.fromBitmap(new manhattanBmp()));
			_manhattanImage.scaleX = _manhattanImage.scaleY = (3000 / _manhattanImage.width);
			_manhattanImage.x = (2000 - _manhattanImage.width) / 2;
			_manhattanImage.y = -3000;
			addChild(_manhattanImage);
			
			_cloudsLayer = new Sprite();
			addChild(_cloudsLayer);
			
			if (_planeTexture == null)
			{
				_planeTexture = Texture.fromBitmap(new planeImage());
			}
			addChild(new Image(_planeTexture));
			initMaze(new planeMaze());
			initTerrorists();
			initPlayer();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		override public function win():void
		{
			_win = true;
			StateControll.instance.setState(new WinState());
		}
		
		private function initTerrorists():void
		{
			var t1:Terrorist = new Terrorist();
			t1.setPosition(945, 1480);
			addChild(t1);
			
			var t2:Terrorist = new Terrorist();
			t2.setPosition(1075, 1480);
			addChild(t2);
			
			t1.rotation = t2.rotation = Math.PI / 2;
			
			var t3:Terrorist = new Terrorist();
			t3.setPosition(850, 600);
			addChild(t3);
			
			var t4:Terrorist = new Terrorist();
			t4.setPosition(1160, 600);
			addChild(t4);
			
			var t5:Terrorist = new Terrorist();
			t5.setPosition(880, 380);
			addChild(t5);
			
			var t6:Terrorist = new Terrorist();
			t6.setPosition(1140, 380);
			addChild(t6);
			
			var t7:Terrorist = new Terrorist();
			t7.setPosition(805, 1095);
			addChild(t7);
			
			var t8:Terrorist = new Terrorist();
			t8.setPosition(1200, 1095);
			addChild(t8);
			
			var pilot1:PilotTerrorist = new PilotTerrorist();
			pilot1.setPosition(950, 305);
			addChild(pilot1);
			
			var pilot2:PilotTerrorist = new PilotTerrorist();
			pilot2.setPosition(1080, 305);
			addChild(pilot2);
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
	private static var _texture:Texture = null;
	
	public function Cloud()
	{
		if (_texture == null)
		{
			_texture = Texture.fromBitmap(new _image());
		}
		
		var img:Image = new Image(_texture);
		img.x = -img.width / 2;
		img.y = -img.height / 2;
		addChild(img);
		
		rotation = Math.random() * (Math.PI * 2);
	}
}