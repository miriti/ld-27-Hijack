package game
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class InstructionState extends Sprite
	{
		private static var _text:String = "Ok. Listen up! These terrorists.. they hijacked the plane. It's going to be a disaster.. But I can teleport you there.. in the plane. But you will have only 10 seconds. Do you hear me? ONLY 10 seconds! You have to take the control of the plane... well.. at least try to turn this plane away from the city.. and optionaly kill all those terrorists. Are you ready? It is dangerous to go alone - take this shotgun. Make your way form W.C. to cockpit. Good luck! And remember: only TEN seconds.\n\nPress any key when you are really ready...";
		private var textPos:int = 0;
		private var time:Number = 0;
		private var instructionsText:TextField;
		
		public function InstructionState()
		{
			super();
			
			addChild(new Quad(Main.sceneWidth, Main.sceneHeight, 0x0));
			
			instructionsText = new TextField(Main.sceneWidth, Main.sceneHeight, "", "Verdana", 36, 0xcccccc);
			instructionsText.vAlign = VAlign.TOP;
			instructionsText.hAlign = HAlign.LEFT;
			addChild(instructionsText);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoverFromStage);
		}
		
		private function onRemoverFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoverFromStage);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			StateControll.instance.setState(new GameContainer());
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void
		{
			if (textPos < _text.length)
			{
				if (time >= 50)
				{
					textPos++;
					instructionsText.text = _text.substr(0, textPos);
					time = 0;
				}
				time += e.passedTime * 1000;
			}
		}
	
	}

}