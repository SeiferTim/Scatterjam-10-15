package;
import flixel.FlxSprite;

class CallLight extends FlxSprite
{

	static public inline var STATE_OFF:Int = 0;
	static public inline var STATE_BLINK:Int = 1;
	static public inline var STATE_ON:Int = 2;
	static public inline var STATE_BROKEN:Int = 3;
	
	public var status(default, set):Int = 0;
	
	public function new(X:Int, Y:Int) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.call_light__png, true, 10, 5);
		animation.add("off", [0]);
		animation.add("blink", [1, 0], 10);
		animation.add("broken", [2, 0], 20);
		animation.add("on", [1]);
		animation.play("off");
	}
	
	private function set_status(Value:Int):Int
	{
		if (status == Value)
			return status;
		status = Value;
		switch (status) 
		{
			case STATE_OFF:
				animation.play("off");
			case STATE_BLINK:
				animation.play("blink");
			case STATE_ON:
				animation.play("on");
			case STATE_BROKEN:
				animation.play("broken");
		}
		return status;
	}
	
}