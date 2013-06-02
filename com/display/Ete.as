package com.display {

	import com.system.Sprite;
	import com.system.Engine;
	import flash.events.MouseEvent;

	public class Ete extends Sprite {
		public var _mode:String;

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

			Engine.colorize(this.bodyColor, this.color);

			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e){
				var self = e.currentTarget;
				var p = new Points;
				p.x = self.x;
				p.y = self.y;
				p.scaleX = Math.abs(self.scaleX);
				p.scaleY = self.scaleY;
				p.mc.txt.text = self.SCORE[self.mode];
				Engine.score += self.SCORE[self.mode];

				if(self.mode === 'bubble'){
					var b = new Bubble;

					b.x = self.x;
					b.y = self.y;
					b.scaleX = self.scaleX;
					b.scaleY = self.scaleY;
					b.gotoAndPlay('explode');

					Engine.main.addChild(b);
					self.mode = 'fall';
				} else {
					var e = new EteExplode;

					e.x = self.x;
					e.y = self.y;
					e.scaleX = self.scaleX;
					e.scaleY = self.scaleY;

					Engine.colorize(e.bodyColor, self.color);

					Engine.main.addChild(e);

					Engine.remove(self);
				}

				Engine.main.addChild(p);
			});
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
						this.removeChild(this.bubble);
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
