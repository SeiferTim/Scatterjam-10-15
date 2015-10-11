package;

import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;


class ResponseButton extends FlxSpriteButton
{
	public var response:Int;
	
	public function new(X:Int, Y:Int, Response:Int, Callback:Int->Void) 
	{
		response = Response;
		super(X, Y, Reg.getResponseImage(response), Callback.bind(response));
		loadGraphic(AssetPaths.big_light_blue_button__png, true, 80, 32);
		label.x = X + 31;
		labelOffsets[FlxButton.HIGHLIGHT].x = 31;
		labelOffsets[FlxButton.PRESSED].x = 31;
		labelOffsets[FlxButton.NORMAL].x = 31;
		#if flash
		onUp.sound = new FlxSound().loadEmbedded(AssetPaths.switch25__mp3);
		#else
		onUp.sound = new FlxSound().loadEmbedded(AssetPaths.switch25__wav);
		#end
		/*
		label.y = Y + 1;
		
		labelOffsets[FlxButton.HIGHLIGHT].y = 1;
		labelOffsets[FlxButton.PRESSED].y = 1;
		labelOffsets[FlxButton.NORMAL].y = 1;
		*/
	}
	
}