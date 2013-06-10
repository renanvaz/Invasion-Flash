package  {

	import starling.display.Sprite;
	import starling.text.TextField;

	public class Game extends Sprite
	{
		[Embed(source = "img/bg.png")]
    	private static const BG:Class;

	    public function Game()
	    {
	    	var texture:Texture = Texture.fromBitmap(new BG);
			var image:Image = new Image(texture);
			addChild(image);
	    }
	}

}
