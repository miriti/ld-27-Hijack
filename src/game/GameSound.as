package game
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameSound
	{
		[Embed(source="../assets/snd/shotgun1.mp3")]
		private static var shotgunShot:Class;
		
		private static var sounds:Dictionary = new Dictionary();
		
		public static function playSound(name:String):void
		{
			if (sounds[name] == undefined)
			{
				sounds[name] = new GameSound[name]();
			}
			
			(sounds[name] as Sound).play(0, 0);
		}
		
		public static function init():void
		{
			sounds["shotgunShot"] = new shotgunShot();
		}
	}

}