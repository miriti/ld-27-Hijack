package game
{
	import flash.ui.Mouse;
	import game.missions.NineEleven;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameContainer extends Sprite
	{
		private static var _instance:GameContainer;
		private var _input:Input;
		
		public function GameContainer()
		{
			addChild(new NineEleven());
			addChild(new GameHUD());
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			_instance = this;
		}
		
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			Mouse.show();
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			Mouse.hide();
			_input = new Input(stage);
		}
		
		static public function get instance():GameContainer
		{
			return _instance;
		}
	
	}

}