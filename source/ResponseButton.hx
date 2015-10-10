package;

import flixel.FlxSprite;
import flixel.ui.FlxButton;


class ResponseButton extends FlxButton
{
	public var response:Int;
	
	public function new(X:Int, Y:Int, Response:Int, Callback:Int->Void) 
	{
		response = Response;
		super(X, Y, Reg.getResponseName(response), Callback.bind(response));
		
	}
	
}