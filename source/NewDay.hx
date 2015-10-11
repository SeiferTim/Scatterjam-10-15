package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;


class NewDay extends FlxState
{

	private var timer:Float = -100;
	
	override public function create():Void 
	{
		Reg.startDay();
		
		bgColor = 0xff111111;
		
		add(new FlxSprite(0, 0, AssetPaths.back__png));
		
		var txt:FlxText = new FlxText();
		txt.text = "Day " + Std.string(Reg.day);
		txt.setFormat(AssetPaths.NICKELOD__TTF, 60, FlxColor.WHITE, FlxTextAlign.CENTER);
		txt.screenCenter(FlxAxes.XY);
		add(txt);
		
		FlxG.mouse.visible = false;
		
		super.create();
		
		if (FlxG.sound.music!=null)
			FlxG.sound.music.stop();
		
			
		FlxG.camera.fade(0xff111111, 1, true, finishFadeIn);
		
	}
	
	private function finishFadeIn():Void
	{
		#if flash
		FlxG.sound.play(AssetPaths.time_clock__mp3, 1, false, true);
		#else
		FlxG.sound.play(AssetPaths.time_clock__wav, 1, false, true);
		#end
		timer = 2;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (timer > -100 )
		{
			if (timer <= 0)
			{
				timer = -100;
				if (Reg.day < 5)
				{
					#if flash
					FlxG.sound.playMusic(AssetPaths.mozart__mp3, 1, false);
					#else
					FlxG.sound.playMusic(AssetPaths.mozart__ogg, 1, false);
					#end
				}
				else
				{
					#if flash
					FlxG.sound.playMusic(AssetPaths.mars__mp3, 1, false);
					#else
					FlxG.sound.playMusic(AssetPaths.mars__ogg, 1, false);
					#end
					
				}
				FlxG.camera.fade(0xff111111, 1, false, finishFadeOut);
			}
			else
			{
				timer -= elapsed;
			}
		}
		super.update(elapsed);
	}
	
	private function finishFadeOut():Void
	{
		FlxG.switchState(new PlayState());
	}
	
}