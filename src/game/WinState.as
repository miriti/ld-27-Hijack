package game
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class WinState extends Sprite
	{
		
		public function WinState()
		{
			addChild(new Quad(Main.sceneWidth, Main.sceneHeight, 0x000000));
			addChild(new TextField(Main.sceneWidth, Main.sceneHeight, "You did it!", "Verdana", 100, 0xcc0000, true));
		}
	
	}

}