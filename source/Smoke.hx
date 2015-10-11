package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;


class Smoke extends FlxTypedGroup<SmokePart>
{
	private var x:Float;
	private var y:Float;
	public var smoking:Bool = false;
	
	public function new() 
	{
		super(20);
		for (i in 0...20)
		{		
			add(new SmokePart());
		}
		
	}
	
	public function reset(X:Float, Y:Float):Void
	{
		x = X;
		y = Y;
		smoking = true;
		
	}
	
	
	
	override public function update(elapsed:Float):Void 
	{
		if (smoking)
		{
			var s:SmokePart;
			s = recycle();
			s.reset(x-(s.width/2), y-(s.height/2));
			
		}
		
		super.update(elapsed);
	}
	
	
	
}

class SmokePart extends FlxSprite 
{
	public function new()
	{
		super(0, 0, AssetPaths.smoke__png);
		kill();
	}
	
	
	override public function reset(X:Float, Y:Float):Void 
	{
		super.reset(X, Y);
		var scl:Float = FlxG.random.float(.2, 1);
		scale.set(scl, scl);
		alpha = FlxG.random.float(.5, .9);
		velocity.x = FlxG.random.float( -20, 20);
		velocity.y = FlxG.random.float( -50, -200);
	}
	
	override public function update(elapsed:Float):Void 
	{
		scale.x = scale.y += elapsed / 6;
		alpha -= elapsed/4;
		if (alpha <= 0 || !isOnScreen())
			kill();
		super.update(elapsed);
	}
}