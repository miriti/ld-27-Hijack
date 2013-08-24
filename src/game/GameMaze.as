package game
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMaze
	{
		private var _cells:Vector.<Vector.<GameMazeCell>>;
		private var _scale:Number;
		
		public function GameMaze(bitmap:Bitmap, scale:Number = 20)
		{
			_scale = scale;
			_cells = new Vector.<Vector.<GameMazeCell>>();
			
			for (var i:int = 0; i < bitmap.width; i++)
			{
				_cells[i] = new Vector.<GameMazeCell>();
				
				for (var j:int = 0; j < bitmap.height; j++)
				{
					_cells[i][j] = GameMazeCell.factory(bitmap.bitmapData.getPixel32(i, j), scale);
				}
			}
		}
		
		public function collisionEntity(ent:Entity):void
		{
			/*var minCellX:int = Math.floor((ent.x - ent.radius) / _scale);
			   var minCellY:int = Math.floor((ent.y - ent.radius) / _scale);
			   var maxCallX:int = Math.floor((ent.x + ent.radius) / _scale);
			 var maxCellY:int = Math.floor((ent.y + ent.radius) / _scale);*/
			
			var minCellX:int = Math.floor(ent.x / _scale) - 2;
			var minCellY:int = Math.floor(ent.y / _scale) - 2;
			var maxCallX:int = Math.floor(ent.x / _scale) + 2;
			var maxCellY:int = Math.floor(ent.y / _scale) + 2;
			
			if (minCellX < 0)
				minCellX = 0;
			if (minCellY < 0)
				minCellY = 0;
			if (maxCallX > _cells.length)
				maxCallX = _cells.length;
			if (maxCellY > _cells[0].length)
				maxCellY = _cells[0].length;
			
			for (var i:int = minCellX; i < maxCallX; i++)
			{
				for (var j:int = minCellY; j < maxCellY; j++)
				{
					if ((_cells[i][j] != null) && (!_cells[i][j].passable))
					{
						collisionWithCell(ent, i, j);
					}
				}
			}
		}
		
		private function collisionWithCell(ent:Entity, i:int, j:int):void
		{
			var cellRect:Rectangle = new Rectangle(i * _scale, j * _scale, _scale, _scale);
			var cellCentre:Point = new Point(i * _scale + _scale / 2, j * _scale + _scale / 2);
			
			// ent in LEFT half
			if (ent.x < cellCentre.x)
			{
				// ent in TOP half
				if (ent.y < cellCentre.y)
				{
					if (ent.x >= cellRect.left)
					{
						if (ent.y + ent.radius > cellRect.top)
						{
							ent.y = cellRect.top - ent.radius;
						}
					}
					else
					{
						if (ent.y >= cellRect.top)
						{
							if (ent.x + ent.radius > cellRect.left)
							{
								ent.x = cellRect.left - ent.radius;
							}
						}
						else
						{
							// corner?
						}
					}
				}
				else // ent in BOTTOM half
				{
					if (ent.y < cellRect.bottom)
					{
						if (ent.x + ent.radius > cellRect.left)
						{
							ent.x = cellRect.left - ent.radius;
						}
					}
					else
					{
						if (ent.x >= cellRect.left)
						{
							if (ent.y - ent.radius < cellRect.bottom)
							{
								ent.y = cellRect.bottom + ent.radius;
							}
						}
						else
						{
							// corner?
						}
					}
				}
			}
			else // ent in RIGHT half
			{
				// ent in TOP half
				if (ent.y < cellCentre.y)
				{
					if (ent.x <= cellRect.right)
					{
						if (ent.y + ent.radius > cellRect.top)
						{
							ent.y = cellRect.top - ent.radius;
						}
					}
					else
					{
						if (ent.y >= cellRect.top)
						{
							if (ent.x - ent.radius < cellRect.right)
							{
								ent.x = cellRect.right + ent.radius;
							}
						}
						else
						{
							// corner?
						}
					}
				}
				else // ent in BOTTOM half
				{
					if (ent.y <= cellRect.bottom)
					{
						if (ent.x - ent.radius < cellRect.right)
						{
							ent.x = cellRect.right + ent.radius;
						}
					}
					else
					{
						if (ent.x <= cellRect.right)
						{
							if (ent.y - ent.radius < cellRect.bottom)
							{
								ent.y = cellRect.bottom + ent.radius;
							}
						}
						else
						{
							// corner?
						}
					}
				}
			}
		}
		
		public function getCellAt(atX:Number, atY:Number):GameMazeCell
		{
			var cellX:int = Math.floor(atX / _scale);
			var cellY:int = Math.floor(atY / _scale);
			
			if ((cellX >= 0) && (cellY >= 0) && (cellX < _cells.length) && (cellY < _cells[0].length))
			{
				return _cells[cellX][cellY];
			}
			else
			{
				return null;
			}
		}
	}

}