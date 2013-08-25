package game
{
	import flash.ui.Keyboard;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class FailState extends Sprite
	{
		
		public function FailState()
		{
			super();
			
			addChild(new Quad(Main.sceneWidth, Main.sceneHeight, 0x000000));
			
			var failText:TextField = new TextField(Main.sceneWidth, Main.sceneHeight / 2, "You failed to prevent a disaster", "Verdana", 80, 0xcc0000, true);
			addChild(failText);
			
			var reText:TextField = new TextField(Main.sceneWidth, Main.sceneHeight / 4, "Press R to restart", "Verdana", 60, 0x880000, false);
			reText.y = failText.height;
			addChild(reText);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.R)
			{
				StateControll.instance.setState(new GameContainer());
			}
		}
	
	}

}