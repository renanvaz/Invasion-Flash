package com.system {

	import flash.display.MovieClip;
	import com.system.V2;

	public class Sprite extends MovieClip {
		public var acceleration:V2 = new V2(0, 0);
		public var velocity:V2 = new V2(0, 0);
		public var position:V2 = new V2(0, 0);

		public function Sprite() {

		}
	}

}
