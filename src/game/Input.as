package game
{
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Input
	{
		private var _keys:Vector.<Boolean> = new Vector.<Boolean>(256);
		private var _mousePosition:Point = new Point();
		private var _mouseButton:Boolean = false;
		
		private static var _instance:Input;
		private var _mouseDownHooks:Vector.<Function> = new Vector.<Function>();
		private var _mouseUpHooks:Vector.<Function> = new Vector.<Function>();
		
		public function Input(stage:Stage)
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			
			_instance = this;
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (e.touches[0].phase == TouchPhase.BEGAN)
			{
				if (!_mouseButton)
				{
					onMouseDown();
				}
				_mouseButton = true;
			}
			
			if (e.touches[0].phase == TouchPhase.ENDED)
			{
				if (_mouseButton)
				{
					onMouseUp();
				}
				_mouseButton = false;
			}
			
			if ((e.touches[0].phase == TouchPhase.HOVER) || (e.touches[0].phase == TouchPhase.MOVED))
			{
				_mousePosition.setTo(e.touches[0].globalX, e.touches[0].globalY);
			}
		}
		
		public function addMouseDownHook(hook:Function):void
		{
			_mouseDownHooks.push(hook);
		}
		
		public function addMouseUpHook(hook:Function):void
		{
			_mouseUpHooks.push(hook);
		}
		
		public function removeMouseDownHook(hook:Function):void
		{
			_mouseDownHooks.splice(_mouseDownHooks.indexOf(hook), 1);
		}
		
		public function removeMouseUpHoop(hook:Function):void
		{
			_mouseUpHooks.splice(_mouseUpHooks.indexOf(hook), 1);
		}
		
		private function onMouseUp():void
		{
			for (var i:int = 0; i < _mouseUpHooks.length; i++)
			{
				_mouseUpHooks[i].call();
			}
		}
		
		private function onMouseDown():void
		{
			for (var i:int = 0; i < _mouseDownHooks.length; i++)
			{
				_mouseDownHooks[i].call();
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			_keys[e.keyCode] = false;
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			_keys[e.keyCode] = true;
		}
		
		public function get mousePosition():Point
		{
			return _mousePosition;
		}
		
		static public function get instance():Input
		{
			return _instance;
		}
		
		public function get mouseButton():Boolean
		{
			return _mouseButton;
		}
		
		public function isKey(key:uint):Boolean
		{
			return _keys[key];
		}
		
		public function isUp():Boolean
		{
			return isKey(Keyboard.UP) || isKey(Keyboard.W);
		}
		
		public function isDown():Boolean
		{
			return isKey(Keyboard.DOWN) || isKey(Keyboard.S);
		}
		
		public function isLeft():Boolean
		{
			return isKey(Keyboard.LEFT) || isKey(Keyboard.A);
		}
		
		public function isRight():Boolean
		{
			return isKey(Keyboard.RIGHT) || isKey(Keyboard.D);
		}
	}

}