package com.system {
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;

	public class Utils {

		public static function colorize(sprite:DisplayObject, c:Number){
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = c;
			sprite.transform.colorTransform = colorTransform;
		}

	}

}
