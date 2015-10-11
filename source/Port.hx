package;

import flixel.FlxSprite;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;

class Port extends FlxSpriteButton
{
	public var portNo:Int;
	
	public function new(X:Int, Y:Int, PortNo:Int, Callback:Int->Void) 
	{
		portNo = PortNo;
		super(X, Y, null, Callback.bind(portNo));
		loadGraphic(AssetPaths.Port__png, false);
		
	}
	
}