package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.StateControll;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	[Frame(factoryClass="Preloader")]
	
	public class Main extends Sprite
	{
		private var starlingInstance:Starling;
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			starlingInstance = new Starling(StateControll, stage);
			starlingInstance.start();
		}
	
	}

}