package game
{
	import com.greensock.easing.Linear;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameHUD extends Sprite
	{
		private var countDown:TextField;
		private var countTime:int;
		private var count:Boolean;
		
		public function GameHUD()
		{
			countDown = new TextField(Main.sceneWidth, Main.sceneHeight, "10:00", "Verdana", 300);
			countDown.vAlign = VAlign.CENTER;
			countDown.hAlign = HAlign.CENTER;
			addChild(countDown);
			
			//startCount();
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		public function startCount():void
		{
			countTime = 10000;
			var blink:Function = function():void
			{
				countDown.alpha = 0.15;
				TweenLite.to(countDown, 1, {alpha: 0, onComplete: blink, ease: Linear.easeNone});
			};
			blink();
			count = true;
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void
		{
			if (count)
			{
				countTime -= e.passedTime * 1000;
				if (countTime <= 0)
				{
					countTime = 0;
					timesUp();
				}
				
				var secs:String = (Math.ceil(countTime / 1000)).toString();
				var mscs:String = (Math.ceil(countTime % 1000 / 10)).toString();
				
				if (secs.length == 1)
					secs = "0" + secs;
				
				while (mscs.length < 2)
				{
					mscs = "0" + mscs;
				}
				
				if (mscs.length > 2)
				{
					mscs = mscs.substr(1, 2);
				}
				
				countDown.text = secs + ":" + mscs;
			}
		}
		
		private function timesUp():void
		{
			count = false;
		}
	
	}

}