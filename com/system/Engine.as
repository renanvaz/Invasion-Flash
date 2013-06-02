package com.system {

	import com.system.Sprite;
	import com.display.Ete;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;

	public class Engine {
		public static var sprites:Vector.<com.system.Sprite> = new Vector.<com.system.Sprite>();
		public static var paused:Boolean = true;
		public static var _score:int = 0;
		public static var count:int = 0;
		public static var maxFrames:int = 3 * 60;
		public static var main;

		public static function process() {
			if(!paused){
				var sprite;
				for each(sprite in Engine.sprites){
					sprite.velocity.x += sprite.acceleration.x;
					sprite.velocity.y += sprite.acceleration.y;

					sprite.position.x += sprite.velocity.x;
					sprite.position.y += sprite.velocity.y;

					sprite.x = Math.round(sprite.position.x);
					sprite.y = Math.round(sprite.position.y);

					if(
						sprite.y > Engine.main.stage.stageHeight
						|| (sprite.direction === -1 && sprite.x < (-sprite.width))
						|| (sprite.direction === 1 && sprite.x > (Engine.main.stage.stageWidth + sprite.width))
					 ){
					 	//trace('LOSE LIFE')
						Engine.remove(sprite);
					}
				}

				if(++Engine.count%maxFrames == 0){
					Engine.add(new Ete());
					var max = (5 - (time/15));
					var min = (5 - (time/15));
					max = max < 2 ? 2 : max;
					min = min < .5 ? .5 : min;
					maxFrames = Engine.count + Math.round(Math.random() * (60 * max) + (min * 60));
				}
			}
		}

		public static function add(sprite) {
			Engine.sprites.push(sprite);
			Engine.main.sprites.addChild(sprite);
		}

		public static function remove(sprite) {
			Engine.sprites = Engine.sprites.filter(function(item){
				return item !== sprite;
			});

			Engine.main.sprites.removeChild(sprite);
		}

		public static function get time():int {
			return Math.round(Engine.count/60);
		}

		public static function get score():int {
			return Engine._score;
		}

		public static function set score(v) {
			Engine._score = v;
			Engine.main.txtScore.text = v;
		}

		public static function colorize(sprite:DisplayObject, c:Number){
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = c;
			sprite.transform.colorTransform = colorTransform;
		}
	}

}
