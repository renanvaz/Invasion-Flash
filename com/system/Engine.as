package com.system {
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;

	public class Engine {
		public static var sprites:Vector.<Sprite> = new Vector.<Sprite>();
		public static var paused:Boolean = true;
		public static var stage:DisplayObject;
		
		public static function process() {
			if(!paused){
				for each(var sprite in Engine.sprites){
					trace(sprite.x);
				}
			}
		}
		
		public static function add(sprite) {
			Engine.sprites.push(sprite);
			Engine.stage.addChild(sprite);
		}
		
		public static function remove(sprite) {
			Engine.sprites = Engine.sprites.filter(function(item){
				return item !== sprite;
			});
			
			Engine.stage.removeChild(sprite);
		}
	}
	
}
