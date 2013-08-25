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
		private var prevSecs:String;
		private var blinkTween:TweenLite;
		
		public function GameHUD()
		{
			countDown = new TextField(Main.sceneWidth, Main.sceneHeight, "0", "Verdana", 500);
			countDown.vAlign = VAlign.CENTER;
			countDown.hAlign = HAlign.CENTER;
			countDown.autoScale = true;
			addChild(countDown);
			
			startCount();
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		public function startCount():void
		{
			prevSecs = "11";
			countTime = 10000;
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
				
				if (secs.length == 1)
					secs = "0" + secs;
				
				if (secs != prevSecs)
				{
					countDown.text = secs;
					countDown.alpha = 0.15 * (1 - (countTime / 10000));
					if (blinkTween != null)
					{
						blinkTween.kill();
					}
					
					blinkTween = TweenLite.to(countDown, 1, {alpha: 0, ease: Linear.easeNone});
				}
				
				prevSecs = secs;
			}
		}
		
		private function timesUp():void
		{
			count = false;
		}
	
	}

}