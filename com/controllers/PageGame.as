package com.controllers {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.system.PageBase;
	import com.system.Engine;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	TweenPlugin.activate([VisiblePlugin]);

	/*
	Estatitsicas
	Contador de tempo
	itens
	*/

	public class PageGame extends PageBase {
		public var _sprites:Vector.<Sprite> = new Vector.<Sprite>();

		public var count:int = 0;
		public var maxFrames:int = 4 * 60;

		public function PageGame() {
			super();
			var self = this;

			this.fxDanger.mouseEnabled = false;
			this.screenGameOver.buttonMode = true;
			this.screenGameOver.addEventListener(MouseEvent.CLICK, function(e){
				Engine.reset();
			});

			Engine.bind(Engine.events.LIFE, this.lifeChange);
			Engine.bind(Engine.events.MAX_LIFE, this.maxLifeChange);
			Engine.bind(Engine.events.PROCESS, this.process);
			Engine.bind(Engine.events.GAME_OVER, this.gameOver);
			Engine.bind(Engine.events.RESET, this.reset);
			Engine.bind(Engine.events.SCORE, this.score);
		}

		override public function reset(params = null) {
			var sprite;
			for each(sprite in this._sprites){
				this.remove(sprite);
			}

			this._sprites 				= new Vector.<Sprite>();
			this.fxDanger.visible 		= false;
			this.screenGameOver.visible = false;
		}

		public function score(params) {
			this.txtScore.text = Engine._score.toString();
		}

		public function gameOver(params) {
			Engine.paused = true;
			var sprite;

			for each(sprite in Engine.sprites){
				sprite.die();
			}

			this.screenGameOver.alpha 	= 0;
			this.screenGameOver.visible = true;
			TweenLite.from(this.screenGameOver.title, .6, {y: -this.screenGameOver.title.height, delay: .3, ease: Quad.easeOut});
			TweenLite.from(this.screenGameOver.info, .6, {alpha: 0, delay: .6, ease: Quad.easeOut});
			TweenLite.from(this.screenGameOver.reset, .6, {scaleX: 0, scaleY:0, delay: 1, ease: Back.easeOut});
			TweenLite.to(this.screenGameOver, .6, {alpha: 1, delay: .3, ease: Quad.easeOut});
		}

		public function lifeChange(oldLife) {
			if(oldLife > Engine.life){
			 	this.fxDanger.alpha = 1;
				this.fxDanger.visible = true;
			 	TweenLite.to(this.fxDanger, 1, {alpha: 0, ease: Quad.easeOut, visible: false});
			}

		 	for(var i = 0; i < Engine.maxLife; i++){
				Heart(this.mcLife.getChildAt(i)).active.visible = i < Engine.life;
			}
		}

		public function maxLifeChange(oldMaxLife) {
			var h:Heart;

			while(this.mcLife.numChildren){
				this.mcLife.removeChildAt(0);
			}

		 	for(var i = 1; i <= Engine.maxLife; i++){
		 		h = new Heart;
		 		h.x = -i * (h.width + 10);
				this.mcLife.addChild(h);
			}

			lifeChange(Engine.life);
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
			//this.background.clouds.addChild(sprite);
		}

		public function remove(sprite) {
			this._sprites = this._sprites.filter(function(item){
				return item !== sprite;
			});

			//this.background.clouds.removeChild(sprite);
		}
	}

}
