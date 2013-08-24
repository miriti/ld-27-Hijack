package game
{
	import flash.display.Bitmap;
	import nape.phys.Body;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Entity extends TimedSprite
	{
		protected var _body:Body;
		private var _dead:Boolean;
		protected var _health:Number;
		protected var _healthMax:Number;
		
		public function Entity()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		protected function init():void
		{
		
		}
		
		protected function addImage(bmp:Bitmap, center:Boolean = true):void
		{
			var newImage:Image = new Image(Texture.fromBitmap(bmp));
			if (center)
			{
				newImage.x = -newImage.width / 2;
				newImage.y = -newImage.height / 2;
			}
			
			addChild(newImage);
		}
		
		public function hit(hitPoints:Number):void
		{
		
		}
		
		override protected function update(deltaTime:Number):void
		{
			if (_body != null)
			{
				x = _body.position.x;
				y = _body.position.y;
			}
		}
		
		protected function setHealth(newHealth:Number):void
		{
			_health = newHealth;
			if (_health <= 0)
			{
				_health = 0;
				if (!_dead)
				{
					_dead = true;
					death();
				}
			}
		}
		
		public function setPosition(newX:Number, newY:Number):void
		{
			x = _body.position.x = newX;
			y = _body.position.y = newY;
		}
		
		protected function death():void
		{
			deathAction();
		}
		
		protected function deathAction():void
		{
		
		}
		
		protected function initHealth(newHealth:Number):void
		{
			_healthMax = _health = newHealth;
		}
	}

}