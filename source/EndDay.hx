package;

import flixel.addons.display.FlxSpriteAniRot;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class EndDay extends FlxState
{

	
	private var _score:FlxText;
	private var _next:FlxButton;
	private var timer:Float = -100;
	
	override public function create():Void 
	{
		
		bgColor = 0xff111111;
		
		add(new FlxSprite(0, 0, AssetPaths.back__png));
		
		var txt1:FlxText = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = "Day " + Std.string(Reg.day) + " Progress Report";
		txt1.size = 38;
		txt1.alignment = FlxTextAlign.CENTER;
		txt1.y = 8;
		txt1.screenCenter(FlxAxes.X);
		add(txt1);
		
		var txt2:FlxText = new FlxText();
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.text = "Calls:";
		txt2.size = 30;
		txt2.alignment = FlxTextAlign.RIGHT;
		txt2.y = txt1.y + txt1.height + 4;
		txt2.x = (FlxG.width / 2) - txt2.width + 30;
		add(txt2);
		
		txt1 = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = Std.string(Reg.scores[Reg.day][Reg.SCORE_CALLS]);
		txt1.size = 30;
		txt1.alignment = FlxTextAlign.LEFT;
		txt1.y = txt2.y;
		txt1.x = (FlxG.width / 2) + 40;
		add(txt1);
		
		txt1 = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = "Connections Made:";
		txt1.size = 30;
		txt1.alignment = FlxTextAlign.RIGHT;
		txt1.y = txt2.y + txt2.height + 2;
		txt1.x = (FlxG.width / 2) - txt1.width  + 30;
		add(txt1);
		
		txt2 = new FlxText();
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.text = Std.string(Reg.scores[Reg.day][Reg.SCORE_GOOD]);
		txt2.size = 30;
		txt2.alignment = FlxTextAlign.LEFT;
		txt2.y = txt1.y;
		txt2.x = (FlxG.width / 2) + 40;
		add(txt2);
		
		txt2 = new FlxText();
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.text = "Calls Dropped:";
		txt2.size = 30;
		txt2.alignment = FlxTextAlign.RIGHT;
		txt2.y = txt1.y + txt1.height + 4;
		txt2.x = (FlxG.width / 2) - txt2.width  + 30;
		add(txt2);
		
		txt1 = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = Std.string(Reg.scores[Reg.day][Reg.SCORE_BAD]);
		txt1.size = 30;
		txt1.alignment = FlxTextAlign.LEFT;
		txt1.y = txt2.y;
		txt1.x = (FlxG.width / 2) + 40;
		add(txt1);

		_score = new FlxText();
		_score.font = AssetPaths.NICKELOD__TTF;
		var per:Float = Reg.scores[Reg.day][Reg.SCORE_GOOD] / Reg.scores[Reg.day][Reg.SCORE_CALLS];
		if (per >= .9)
		{
			_score.text = "A";
			Reg.scores[Reg.day][Reg.SCORE_LETTER] = 1;
		}
		else if (per >= .8)
		{
			_score.text = "B";
			Reg.scores[Reg.day][Reg.SCORE_LETTER] = 2;
		}
		else if (per >= .7)
		{
			_score.text = "C";
			Reg.scores[Reg.day][Reg.SCORE_LETTER] = 3;
		}
		else if (per >= .6)
		{
			_score.text = "D";
			Reg.scores[Reg.day][Reg.SCORE_LETTER] = 4;
		}
		else
		{
			_score.text = "F";
			Reg.scores[Reg.day][Reg.SCORE_LETTER] = 5;
		}
		
		_score.bold = true;
		_score.size = 80;
		_score.alpha = 0;
		_score.angle = -14;
		_score.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xff111111, 2, 2);
		_score.x =  60;
		_score.y =  FlxG.height - _score.height - 22;
		_score.scale.set(2, 2);
		add(_score);
		
		_next = new FlxButton(FlxG.width - 84, FlxG.height - 36, Reg.day == 5 ? "Finish" : "Next Day", gotoNextDay);
		_next.loadGraphic(AssetPaths.big_light_blue_button__png, true, 80, 32);
		_next.label.size = 20;
		_next.labelOffsets[FlxButton.NORMAL].y = 0;
		_next.labelOffsets[FlxButton.HIGHLIGHT].y = 0;
		_next.labelOffsets[FlxButton.PRESSED].y = 3;
		_next.visible = false;
		#if flash
		_next.onUp.sound = new FlxSound().loadEmbedded(AssetPaths.switch25__mp3);
		#else
		_next.onUp.sound = new FlxSound().loadEmbedded(AssetPaths.switch25__wav);
		#end
		add(_next);
		
		FlxG.mouse.visible = false;
		
		super.create();
		
		FlxG.camera.fade(0xff111111, 1, true, finishFadeIn);
		
		
	}
	
	private function finishFadeIn():Void
	{
		timer = .66;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (timer > -100 )
		{
			if (timer <= 0)
			{
				timer = -100;
				showScore();
			}
			else
			{
				timer -= elapsed;
			}
		}
		super.update(elapsed);
	}
	
	private function showScore():Void
	{
		FlxTween.num(0, 1, .33, { ease:FlxEase.expoIn, onComplete:finishScoreIn }, scoreUpdate);
	}
	
	private function scoreUpdate(Value:Float):Void
	{
		_score.alpha = Value;
		_score.scale.set(1 + (1 - Value), 1 + (1 - Value));
	}
	
	//
	private function finishScoreIn(_):Void
	{
		_next.visible = true;
		FlxG.mouse.visible = true;
	}
	
	private function gotoNextDay():Void
	{
		_next.visible = false;
		FlxG.camera.fade(0xff111111, 1, false, finishFadeOut);
	}
	
	private function finishFadeOut():Void
	{
		if (Reg.day == 5)
		{
			FlxG.switchState(new GameEnd());
		}
		else
		{
			FlxG.switchState(new NewDay());
		}
		
	}
	
}