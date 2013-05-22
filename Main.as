package  {
	
	import flash.display.MovieClip;
	import com.system.Engine;
	import flash.display.Sprite;
	
	
	public class Main extends MovieClip {
		
		
		public function Main() {
			Engine.sprites.push(new Sprite);
			
			Engine.process();
		}
	}
	
}
