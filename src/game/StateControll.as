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
		
		public function StateControll()
		{
			setState(new GameContainer());
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
	}

}