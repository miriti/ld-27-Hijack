package game
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import game.mazeCells.PlayerPosition;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMaze
	{
		private var _cells:Vector.<Vector.<GameMazeCell>>;
		private var _scale:Number;
		private var _mazeBody:Body;
		
		public function GameMaze(bitmap:Bitmap, scale:Number = 20)
		{
			_scale = scale;
			_cells = new Vector.<Vector.<GameMazeCell>>();
			
			_mazeBody = new Body(BodyType.STATIC);
			
			for (var i:int = 0; i < bitmap.width; i++)
			{
				_cells[i] = new Vector.<GameMazeCell>();
				
				for (var j:int = 0; j < bitmap.height; j++)
				{
					if (bitmap.bitmapData.getPixel32(i, j) == 0xff000000)
					{
						_mazeBody.shapes.add(new Polygon(Polygon.rect(i * scale, j * scale, scale, scale)));
					}
					
					if (bitmap.bitmapData.getPixel32(i, j) == 0xffff0000)
					{
						GamePlayer.lastPlayer.setPosition(i * scale + scale / 2, j * scale + scale / 2);
					}
				}
			}
			
			Physix.space.bodies.add(_mazeBody);
		}
	}

}