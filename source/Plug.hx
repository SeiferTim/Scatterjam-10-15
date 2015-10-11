package;

import flixel.FlxSprite;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;

class Plug extends FlxSpriteButton
{
	
	public var whichPlug:Int;
	
	public static inline var PLUG_IN:Int = 0;
	public static inline var PLUG_OUT:Int = 1;
	
	
	public function new(X:Int, Y:Int, WhichPlug:Int, Callback:Int->Void) 
	{
		whichPlug = WhichPlug;
		
		super(X, Y, null, Callback.bind(whichPlug));
		loadGraphic(whichPlug == PLUG_IN ? AssetPaths.plug_black__png : AssetPaths.plug_red__png);
		
	}
	
}