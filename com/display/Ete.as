package com.display {

	import com.system.Sprite;
	import com.system.Engine;
	import com.system.Utils;
	import flash.events.MouseEvent;

	public class Ete extends Sprite {
		private var _mode:String;

		public var bubble:Bubble;
		public var direction:int;
		public var color:Number;


		public const SCORE:Object = {
			fall: 50,
			bubble: 20,
			airplane: 70
		}

		public const PHYSICS:Object = {
			fall: {
				velocity: {x: .5, y: 3.5},
				acceleration: {x: .05, y: .1}
			},
			bubble: {
				velocity: {x: 1, y: 1},
				acceleration: {x: 0, y: 0}
			},
			airplane: {
				velocity: {x: 5, y: 3},
				acceleration: {x: .1, y: 0}
			}
		}

		public function Ete(type:String = null, color:Number = 0) {
			this.direction = Math.random() > .5 ? 1 : -1;
			this.scaleX = this.scaleY = .35;
			this.scaleX *= this.direction;

			if (!type) {
				var rand_mode = Math.random();
				type = rand_mode > .6 ? 'airplane': (rand_mode > .3 ? 'bubble': 'fall');
			}

			if (!color) {
				color = Number('0x'+(Math.random() * (255 * 255 * 255)).toString(16));
			}

			this.mode = type;
			this.color = color;

			Utils.colorize(this.bodyColor, this.color);

			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e){
				var self = e.currentTarget;

				self.score(self.SCORE[self.mode]);

				if(self.mode === 'bubble'){
					self.mode = 'fall';
				} else {
					self.die();
				}
			});
		}

		public function score(s:int = 0){
			var p = new Points;
			p.x = this.x;
			p.y = this.y;
			p.scaleY = p.scaleX = Math.abs(this.scaleX);
			p.mc.txt.text = s;
			Engine.score += s;
			Engine.main.addChild(p);
		}

		public function die(){
			if(this.bubble) {
				this.explodeBubble();
			}

			var e = new EteExplode;

			e.x = this.x;
			e.y = this.y;
			e.scaleX = this.scaleX;
			e.scaleY = this.scaleY;

			Utils.colorize(e.bodyColor, this.color);

			this.parent.addChild(e);

			Engine.remove(this);
		}

		public function explodeBubble(){
			var b = new Bubble;

			b.x = this.x;
			b.y = this.y;
			b.scaleX = b.scaleY = this.scaleY;
			b.gotoAndPlay('explode');

			this.parent.addChild(b);
		}

		public function set mode(v):void {
			var intensity_x = Math.random();
			var intensity_y = Math.random();
			var rand_x = Math.random();
			var rand_y = Math.random();
			var sWidth = Engine.main.stage.stageWidth;
			var sHeight = Engine.main.stage.stageHeight;

			this.gotoAndPlay(v);

			switch(v) {
				case 'bubble':
					intensity_x = intensity_x * .4 + .8;
					intensity_y = intensity_x * .6 + .7;

					this.bubble = new Bubble;
					this.bubble.scaleX *= this.direction;
					this.addChild(this.bubble);
					if(this.direction === -1){
						this.x = (rand_x * (sWidth/2 - this.width)) + this.width/2 + sWidth/2;
					}else{
						this.x = (rand_x * (sWidth/2 - this.width)) + this.width/2;
					}
					this.y = -this.height/2;
				break;
				case 'fall':
					intensity_x = intensity_x * .4 + .8;
					intensity_y = intensity_x + .5;

					if(this.bubble) {
						this.explodeBubble();
						this.removeChild(this.bubble);
						this.bubble = null;
					} else {
						if(this.direction === -1){
							this.x = (rand_x * (sWidth/2 - this.width)) + this.width/2 + sWidth/2;
						}else{
							this.x = (rand_x * (sWidth/2 - this.width)) + this.width/2;
						}
						this.y = -this.height/2;
					}
				break;
				case 'airplane':
					intensity_x = intensity_x * .6 + .7;
					intensity_y = 1;

					if(this.direction === -1) {
						this.x = sWidth + this.width/2;
					} else {
						this.x = -this.width/2;
					}

					this.y = Math.random() * (sHeight * .7);
				break;
			}

			this.position.x = this.x;
			this.position.y = this.y;

			this.velocity.x = (this.PHYSICS[v].velocity.x * intensity_x) * this.direction;
			this.velocity.y = this.PHYSICS[v].velocity.y * intensity_y;

			this.acceleration.x = (this.PHYSICS[v].acceleration.x * intensity_x) * this.direction;
			this.acceleration.y = this.PHYSICS[v].acceleration.y * intensity_y;

			this._mode = v;
		}

		public function get mode():String {
			return this._mode;
		}
	}

}
