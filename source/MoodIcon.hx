package;

import flixel.addons.effects.FlxGlitchSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.system.FlxAssets.FlxGraphicAsset;

class MoodIcon extends FlxGlitchSprite
{
	private var _varietyCount:Int = 8;
	
	public var mood(default, set):Int = -1;
	
	private var _icon:FlxSprite;
	private var _timer:Float = 0;
	private var _dir:Int = 1;
	private var _tmpStr:Float = 0;
	
	public function new(X:Int, Y:Int) 
	{
		_icon = new FlxSprite(X, Y);
		_icon.loadGraphic(AssetPaths.moods__png, true, 18, 18);
		super(_icon, 0, 1, .2, FlxGlitchDirection.HORIZONTAL);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (_timer <= 0)
		{
			
			if ((_dir == -1 && strength <= 0) || (_dir == 1 && strength >= Reg.day))
			{
				_timer = 5 - Reg.day;
				_dir *= -1;
			}
			else
			{
				_tmpStr += elapsed * _dir; 
				_tmpStr = FlxMath.bound(_tmpStr, 0, Reg.day);
				strength = Std.int(_tmpStr);
			}
		}
		else
		{
			_timer -= elapsed * 2;
		}
		
		super.update(elapsed);
	}
	
	private function set_mood(Value:Int):Int
	{
		if (mood != Value)
		{
			mood = Value;
			newFace();
		}
		return mood;
	}
	
	public function newFace():Void
	{
		_icon.animation.frameIndex = FlxG.random.int((mood + 1) * _varietyCount, (mood + 1) * _varietyCount + _varietyCount -1);
	}
	
	public function showDestination(DestID:Int):Void
	{
		_icon.animation.frameIndex = DestID;
	}
	
}