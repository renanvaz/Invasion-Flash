package  {

	import flash.display.Sprite;
	import starling.core.Starling;

	[SWF(width="640", height="960", frameRate="60", backgroundColor="#009999")]
	public class Startup extends Sprite {
		private var _starling:Starling;

		public function Startup()
		{
			_starling = new Starling(Game, stage);
			_starling.start();
		}
	}

}
