package;
import flixel.FlxG;


class Call
{

	public var inFrom:Int = -1;
	public var outTo:Int = -1;
	public var timer:Float = -1;
	public var mood:Int = -1;
	public var answered:Bool = false;
	public var health:Int = 0;
	
	public function new() 
	{
		timer = FlxG.random.float(2, 5);
		mood = FlxG.random.int(0, 4);
		inFrom = FlxG.random.int(0, 7);
		outfrom = FlxG.random.int(0, 7, [inFrom]);
		
	}
	
	public function update(elapsed:Float):Void
	{
		timer -= elapsed;
		if (timer <= 0)
		{
			hangup();
			return;
		}

	}
	
	private function hangup():Void
	{
		
	}
	
}