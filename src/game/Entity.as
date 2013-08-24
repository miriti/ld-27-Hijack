package game
{
	import flash.display.Bitmap;
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
		private var _dead:Boolean;
		private var _maze:GameMaze = null;
		protected var _health:Number;
		protected var _healthMax:Number;
		protected var _radius:Number = 10;
		
		public function Entity()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function attachMaze(maze:GameMaze):void
		{
			_maze = maze;
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
			if (_maze != null)
			{
				_maze.collisionEntity(this);
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
		
		public function get radius():Number 
		{
			return _radius;
		}
	
	}

}