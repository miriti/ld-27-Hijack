package game
{
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class TimedSprite extends Sprite
	{
		
		public function TimedSprite()
		{
			super();
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void
		{
			update(1000 / 60);
		}
		
		protected function update(deltaTime:Number):void
		{
		
		}
	
	}

}