package com.controllers {

	import flash.display.Sprite;
	import com.system.PageBase;
	import com.system.Engine;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	TweenPlugin.activate([VisiblePlugin]);

	public class PageGame extends PageBase {
		public var _sprites:Vector.<Sprite> = new Vector.<Sprite>();
		public var count:int = 0;
		public var maxFrames:int = 4 * 60;

		public function PageGame() {
			this.txtScore.text = '0';
			this.danger.mouseEnabled = false;
			this.danger.visible = false;

			Engine.bind(Engine.events.DAMAGE, this.damage);
			Engine.bind(Engine.events.PROCESS, this.process);
		}

		public function damage(params) {
			this.danger.visible = true;
		 	this.danger.alpha = 1;
		 	TweenLite.to(this.danger, 1, {alpha: 0, ease: Quad.easeOut, visible: false});
		}

		public function process(params) {
			var sprite;
			for each(sprite in this._sprites){
				sprite.position.x += sprite.acceleration.x;
				sprite.x = Math.round(sprite.position.x);

				if(sprite.x > this.stage.stageWidth){
					this.remove(sprite);
				}
			}

			if(++this.count%this.maxFrames == 0){
				var c = new Cloud;
				c.acceleration.x = Math.random() * 2 + .5;
				c.scaleX = c.scaleY = Math.random() * .4 + .6;
				c.alpha = Math.random() * .5 + .5;
				c.x = c.position.x = Math.round(-c.width);
				c.y = Math.round(Math.random() * (this.stage.stageHeight * .5));
				this.add(c);

				this.count = 0;
				this.maxFrames = Math.round(Math.random() * (60 * 5));
			}
		}

		public function add(sprite) {
			this._sprites.push(sprite);
			this.background.clouds.addChild(sprite);
		}

		public function remove(sprite) {
			this._sprites = this._sprites.filter(function(item){
				return item !== sprite;
			});

			this.background.clouds.removeChild(sprite);
		}
	}

}
