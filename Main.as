package  {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import com.system.Engine;
	import com.controllers.*;
	import com.greensock.*;
	import com.greensock.easing.*;

	/*
	* Game Mode:
	* Classic: 60 seconds
	* Itens to found: seconds (3, 5, 10), Bomb, multyply score (2X)
	* Itens to buy: amplyfy frequency of itens,
	* Unlock itens: Fall, bubble, airplane, hero, airplanes, stages
	*
	* Challenge: 3 lifes
	* Itens to found: Life, Bomb, multyply score (2X)
	* Itens to buy:
	*/

	public class Main extends Sprite {
		public var pages:Object = {};
		public var current:String = null;

		public function Main() {
			var self = this;

			self.add('game', new PageGame);

			Engine.main = self.pages['game'];
			Engine.paused = false;

			self.goto('game');

			self.addEventListener(Event.ENTER_FRAME, function(){ Engine.process(); self.pages['game'].process(); });
		}

		public function add(name:String, page:Sprite){
			var container = new PageContainer;
			container.content.addChild(page);
			container.visible = false;
			pages[name] = page;

			addChild(container);
		}

		public function get(name:String){
			return this.pages[name];
		}

		public function goto(name:String, direction:String = 'left'){
			var self = this;
			var nextPage = self.get(name).parent.parent;

			if(self.current){
				var currentPage = self.get(current).parent.parent;

				if(direction === 'left'){
					//nextPage.x = self.stage.stageWidth;

					//TweenLite.to(currentPage, .6, {x: -currentPage.masker.width, ease:Expo.easeInOut});
					//TweenLite.to(nextPage, .6, {x: 0, ease:Expo.easeInOut});
				}else if(direction === 'right'){

				}
			}else{
				nextPage.x = nextPage.y = 0;
				nextPage.visible = true;
			}

			self.pages[name].reset();
			self.current = name;
		}

	}

}
