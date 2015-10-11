package;

import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;


class ResponseButton extends FlxSpriteButton
{
	public var response:Int;
	
	public function new(X:Int, Y:Int, Response:Int, Callback:Int->Void) 
	{
		response = Response;
		super(X, Y, Reg.getResponseImage(response), Callback.bind(response));
		label.x = X + 31;
		label.y = Y + 1;
		labelOffsets[FlxButton.HIGHLIGHT].x = 31;
		labelOffsets[FlxButton.PRESSED].x = 31;
		labelOffsets[FlxButton.NORMAL].x = 31;
		labelOffsets[FlxButton.HIGHLIGHT].y = 1;
		labelOffsets[FlxButton.PRESSED].y = 1;
		labelOffsets[FlxButton.NORMAL].y = 1;
		
	}
	
}