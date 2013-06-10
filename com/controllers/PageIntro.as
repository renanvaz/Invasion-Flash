package com.controllers {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.system.PageBase;
	import com.system.Engine;
	import com.system.Pages;
	import com.display.*;

	public class PageIntro extends PageBase {

		public function PageIntro() {
			this.addEventListener(MouseEvent.CLICK, function(){
				Pages.goto('game');
				Engine.reset();

				var item:Item = new Item(new Ad, 100);
				Engine.add(item);
			});
		}

	}

}
