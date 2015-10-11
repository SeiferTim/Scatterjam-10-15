package;
import flixel.FlxSprite;

class PortLabel extends FlxSprite
{

	public function new(X:Int, Y:Int, PortNo:Int) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.moods__png, true, 18, 18, true, "mood" + PortNo);
		animation.frameIndex = PortNo;
	}
	
}