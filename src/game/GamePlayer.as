package game
{
	import flash.ui.Keyboard;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GamePlayer extends Entity
	{
		static public const SPEED:Number = 5;
		
		[Embed(source="../assets/entities/player/player.png")]
		private static var _image:Class;
		private var _crosshar:Crosshair;
		static private var _lastPlayer:GamePlayer;
		
		public function GamePlayer(crosshair:Crosshair)
		{
			_crosshar = crosshair;
			_radius = 20;
			
			_lastPlayer = this;
		}
		
		override protected function init():void
		{
			addImage(new _image());
			
			var centr:Quad = new Quad(_radius, _radius, 0xff0000);
			centr.x = centr.y = -centr.width / 2;
			addChild(centr);
			
			Input.instance.addMouseDownHook(onMouseDown);
			Input.instance.addMouseUpHook(onMouseUp);
		}
		
		protected function onMouseDown():void
		{
			fireStart();
		}
		
		protected function onMouseUp():void
		{
			fireEnd();
		}
		
		protected function fireStart():void
		{
		
		}
		
		protected function fireEnd():void
		{
		
		}
		
		override protected function update(deltaTime:Number):void
		{
			rotation = Math.atan2(y - _crosshar.y, x - _crosshar.x);
			
			if (Input.instance.isUp())
			{
				y -= SPEED;
			}
			
			if (Input.instance.isDown())
			{
				y += SPEED;
			}
			
			if (Input.instance.isRight())
			{
				x += SPEED;
			}
			
			if (Input.instance.isLeft())
			{
				x -= SPEED;
			}
			
			super.update(deltaTime);
		}
		
		static public function get lastPlayer():GamePlayer
		{
			return _lastPlayer;
		}
	
	}

}