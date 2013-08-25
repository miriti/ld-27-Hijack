package game
{
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class StateControll extends Sprite
	{
		private var _currentState:Sprite;
		static private var _instance:StateControll;
		
		public function StateControll()
		{
			_instance = this;
			setState(new InstructionState());
		}
		
		public function setState(state:Sprite):void
		{
			if (_currentState != null)
			{
				removeChild(_currentState);
			}
			
			_currentState = state;
			
			addChild(_currentState);
		}
		
		static public function get instance():StateControll 
		{
			return _instance;
		}
	}

}