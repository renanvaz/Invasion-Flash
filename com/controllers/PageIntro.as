package com.controllers {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.system.PageBase;
	import com.system.Engine;
	import com.system.Pages;

	public class PageIntro extends PageBase {

		public function PageIntro() {
			this.addEventListener(MouseEvent.CLICK, function(){
				Pages.goto('game');
			})
		}

	}

}
