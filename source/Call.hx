package;
import flixel.FlxG;


class Call
{

	public var inFrom:Int = -1;
	public var outTo:Int = -1;
	public var timer:Float = -1;
	public var mood:Int = -1;
	public var health:Int = 0;
	public var hungup:Bool = false;
	
	public var isEmergency:Bool = false;
	
	public function new() 
	{
		
		isEmergency = FlxG.random.bool(5 + (2 * Reg.day));
		inFrom = FlxG.random.int(0, 7);
		if (isEmergency)
		{
			timer = FlxG.random.float(1, 4) * (1 - ((Reg.day * (mood == Reg.MOOD_ANGRY || mood == Reg.MOOD_SAD || mood == Reg.MOOD_SCARED ? 2 : 1) ) * .1));
			mood = Reg.MOOD_SCARED;
			outTo = -1;
		}
		else
		{
			timer = FlxG.random.float(1, 10) * (1 - ((Reg.day * (mood == Reg.MOOD_ANGRY || mood == Reg.MOOD_SAD || mood == Reg.MOOD_SCARED ? 2 : 1) ) * .1));
			
			var moodArray:Array<Int> = [];
			for (i in 0...5 - Reg.day)
			{
				moodArray.push(Reg.MOOD_HAPPY);
			}
			for (i in 0...Reg.day)
			{
				moodArray.push(Reg.MOOD_ANGRY);
				moodArray.push(Reg.MOOD_SAD);
				moodArray.push(Reg.MOOD_SCARED);
			}
			for (i in 0...1+Std.int(Reg.day/2))
			{
				moodArray.push(Reg.MOOD_CONFUSED);
			}
			
			mood = FlxG.random.shuffleArray(moodArray, (Reg.day * (mood == Reg.MOOD_ANGRY || mood == Reg.MOOD_SAD || mood == Reg.MOOD_SCARED ? 2 : 1) ) * 5)[0];
			
			
			outTo = FlxG.random.int(0, 7, [inFrom]);
			
			
		}
		
		setHealth();
		
		
	}
	
	private function setHealth():Void
	{
		health = Std.int(FlxG.random.int(10, 90)  * (1 - ((Reg.day * (mood == Reg.MOOD_ANGRY || mood == Reg.MOOD_SAD || mood == Reg.MOOD_SCARED ? 2 : 1) ) * .1)));
		
	}
	
	public function update(elapsed:Float):Void
	{
		timer -= elapsed;
	}
	
	public function hangup():Void
	{
		hungup = true;
		timer = 0;
	}
	
	public function giveHealth():Void
	{
		health += Std.int(FlxG.random.int(10, 30) * (1 - ((Reg.day * (mood == Reg.MOOD_ANGRY || mood == Reg.MOOD_SAD || mood == Reg.MOOD_SCARED ? 2 : 1) ) * .1)));
		if (health >= 100)
		{
			health = 100;
		}
		
		timer = FlxG.random.float(10, 20) * (1 - ((Reg.day * (mood == Reg.MOOD_ANGRY || mood == Reg.MOOD_SAD || mood == Reg.MOOD_SCARED ? 2 : 1) ) * .1));
		
	}
	
	public function takeHealth():Void
	{
		
		health -= Std.int(FlxG.random.int(10, 30) * (1 + ((Reg.day * (mood == Reg.MOOD_ANGRY || mood == Reg.MOOD_SAD || mood == Reg.MOOD_SCARED ? 2 : 1) )) * .1));
		if (health <= 0)
		{

			
			//hangup();
			return;
		}
		timer = FlxG.random.float(10, 20) * (1 - ((Reg.day * (mood == Reg.MOOD_ANGRY || mood == Reg.MOOD_SAD || mood == Reg.MOOD_SCARED ? 2 : 1) ) * .1));
		
	}
	
	
}