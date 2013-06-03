﻿package  {

	import flash.display.Sprite;
	import flash.events.Event;
	import com.system.Engine;
	import com.system.Pages;
	import com.controllers.*;


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

		public function Main() {
			var self = this;

			Pages.main = this;
			Pages.add('game', new PageGame);
			Pages.add('intro', new PageIntro);

			Engine.main = Pages.get('game');
			Engine.paused = false;

			Pages.goto('intro');

			self.addEventListener(Event.ENTER_FRAME, function(){ Engine.process(); Engine.main.process(); });
		}

	}

}
