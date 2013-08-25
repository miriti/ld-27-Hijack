package game
{
	import flash.display.Bitmap;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMaze
	{
		private var _scale:Number;
		private var _mazeBody:Body;
		
		public function GameMaze(world:GameWorld, bitmap:Bitmap, scale:Number = 20)
		{
			_scale = scale;
			
			_mazeBody = new Body(BodyType.STATIC);
			
			for (var i:int = 0; i < bitmap.width; i++)
			{
				for (var j:int = 0; j < bitmap.height; j++)
				{
					var nx:Number = i * scale + scale / 2;
					var ny:Number = j * scale + scale / 2;
					var col:uint = bitmap.bitmapData.getPixel32(i, j);
					
					if ((col == 0xff000000) || (col == 0xff404040))
					{
						var p:Polygon = new Polygon(Polygon.rect(i * scale, j * scale, scale, scale));
						if (col == 0xff404040)
						{
							p.filter.collisionGroup = Physix.GROUP_SEATS;
						}
						else
						{
							p.filter.collisionGroup = Physix.GROUP_WALLS;
							p.cbTypes.add(Physix.TYPE_WALL);
						}
						_mazeBody.shapes.add(p);
					}
					
					if (col == 0xffff0000)
					{
						GamePlayer.lastPlayer.setPosition(nx, ny);
					}					
				}
			}
			
			Physix.space.bodies.add(_mazeBody);
		}
	}

}