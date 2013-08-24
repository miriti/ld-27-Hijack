package game.missions
{
	import game.GameWorld;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class NineEleven extends GameWorld
	{
		[Embed(source = "../../assets/maps/plane.png")]
		private static var planeImage:Class;
		
		[Embed(source = "../../assets/maps/plane_maze.png")]
		private static var planeMaze:Class;
		
		public function NineEleven()
		{
			super();
			addChild(new Image(Texture.fromBitmap(new planeImage())));
			initMaze(new planeMaze());
			initPlayer();
		}
	
	}

}