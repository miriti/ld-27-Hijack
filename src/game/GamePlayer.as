package game
{
	import flash.events.NetStatusEvent;
	import flash.ui.Keyboard;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GamePlayer extends Entity
	{
		static public const SPEED:Number = 0.5;
		
		[Embed(source="../assets/entities/player/player.png")]
		private static var _image:Class;
		private var _crosshar:Crosshair;
		static private var _lastPlayer:GamePlayer;
		private var _body:Body;
		
		public function GamePlayer(crosshair:Crosshair)
		{
			_crosshar = crosshair;
			_radius = 20;
			
			_lastPlayer = this;
			
			_body = new Body(BodyType.DYNAMIC);
			_body.shapes.add(new Circle(_radius));
			Physix.space.bodies.add(_body);
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
		
		public function setPosition(newX:Number, newY:Number):void
		{
			_body.position.setxy(newX, newY);
		}
		
		override protected function update(deltaTime:Number):void
		{
			rotation = Math.atan2(y - _crosshar.y, x - _crosshar.x);
			
			if (Input.instance.isUp())
			{
				_body.velocity.y = -SPEED;
			}
			
			if (Input.instance.isDown())
			{
				_body.velocity.y = SPEED;
			}
			
			if (Input.instance.isRight())
			{
				_body.velocity.x = SPEED;
			}
			
			if (Input.instance.isLeft())
			{
				_body.velocity.x = -SPEED;
			}		
			
			x = _body.position.x;
			y = _body.position.y;
			
			super.update(deltaTime);
		}
		
		static public function get lastPlayer():GamePlayer
		{
			return _lastPlayer;
		}
	
	}

}