package game.mobs
{
	import flash.geom.Point;
	import game.GamePlayer;
	import game.Physix;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class PilotTerrorist extends Terrorist
	{
		
		[Embed(source="../../assets/entities/terrorist/pilot.png")]
		private static var _pilot:Class;
		
		private var attackPlayer:Boolean = false;
		private var _imageSeat:Image;
		
		public function PilotTerrorist()
		{
			super();
			rotation = Math.PI / 2;
		}
		
		override protected function init():void
		{
			_imageSeat = addImage(new _pilot());
			if (_body != null)
			{
				_body.cbTypes.add(Physix.TYPE_ANY);
				_body.space = Physix.space;
			}
		}
		
		override protected function update(deltaTime:Number):void
		{
			if (attackPlayer)
			{
				super.update(deltaTime);
			}
			else
			{
				var playerVector:Point = new Point(x - GamePlayer.lastPlayer.x, y - GamePlayer.lastPlayer.y);
				if (playerVector.length <= 150)
				{
					attackPlayer = true;
					removeChild(_imageSeat);
					super.init();
				}
			}
		}
	}

}