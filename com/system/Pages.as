package com.system {

	import flash.display.Sprite;
	import com.greensock.*;
	import com.greensock.easing.*;

	public class Pages {
		public static var main:flash.display.Sprite;
		public static var _pages:Object = {};
		public static var current:String = null;

		public static function add(name:String, page:flash.display.Sprite){
			var container = new PageContainer;
			container.content.addChild(page);
			container.visible = false;
			Pages._pages[name] = page;

			Pages.main.addChild(container);
		}

		public static function get(name:String){
			return Pages._pages[name];
		}

		public static function goto(name:String, direction:String = 'left'){
			var nextPage = Pages.get(name).parent.parent;

			nextPage.visible = true;
			Pages._pages[name].reset();

			if(Pages.current){
				var currentPage = Pages.get(current).parent.parent;

				if(direction === 'left'){
					nextPage.x = Pages.main.stage.stageWidth;

					TweenLite.to(currentPage, 1.2, {x: -currentPage.masker.width, ease:Expo.easeInOut, onComplete: function(){ currentPage.visible = false; }});
					TweenLite.to(nextPage, 1.2, {x: 0, ease:Expo.easeInOut});
				}else if(direction === 'right'){

				}
			}else{
				nextPage.x = nextPage.y = 0;
			}

			Pages.current = name;
		}

	}

}
