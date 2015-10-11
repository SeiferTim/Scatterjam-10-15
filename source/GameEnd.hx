package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;

class GameEnd extends FlxState
{
	
	private var _next:FlxButton;
	
	override public function create():Void 
	{
		
		bgColor = 0xff111111;
		
		add(new FlxSprite(0, 0, AssetPaths.back__png));
		
		_next = new FlxButton(FlxG.width - 84, FlxG.height - 36, "End", gotoMenu);
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
		
		var txt1:FlxText = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = "Final Progress Report";
		txt1.size = 38;
		txt1.alignment = FlxTextAlign.CENTER;
		txt1.y = 8;
		txt1.screenCenter(FlxAxes.X);
		add(txt1);
		
		var txt2:FlxText = new FlxText();
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.text = "Day 1:";
		txt2.size = 28;
		txt2.alignment = FlxTextAlign.RIGHT;
		txt2.y = txt1.y + txt1.height + 4;
		txt2.x = (FlxG.width / 2) - txt2.width + 30;
		add(txt2);
		
		txt1 = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = LetterFromCode(Reg.scores[1][Reg.SCORE_LETTER]);
		txt1.size = 28;
		txt1.alignment = FlxTextAlign.LEFT;
		txt1.y = txt2.y;
		txt1.x = (FlxG.width / 2) + 40;
		add(txt1);
		
		txt1 = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = "Day 2:";
		txt1.size = 28;
		txt1.alignment = FlxTextAlign.RIGHT;
		txt1.y = txt2.y + txt2.height + 2;
		txt1.x = (FlxG.width / 2) - txt1.width  + 30;
		add(txt1);
		
		txt2 = new FlxText();
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.text = LetterFromCode(Reg.scores[2][Reg.SCORE_LETTER]);
		txt2.size = 28;
		txt2.alignment = FlxTextAlign.LEFT;
		txt2.y = txt1.y;
		txt2.x = (FlxG.width / 2) + 40;
		add(txt2);
		
		txt2 = new FlxText();
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.text = "Day 3:";
		txt2.size = 28;
		txt2.alignment = FlxTextAlign.RIGHT;
		txt2.y = txt1.y + txt1.height + 4;
		txt2.x = (FlxG.width / 2) - txt2.width  + 30;
		add(txt2);
		
		txt1 = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = LetterFromCode(Reg.scores[3][Reg.SCORE_LETTER]);
		txt1.size = 28;
		txt1.alignment = FlxTextAlign.LEFT;
		txt1.y = txt2.y;
		txt1.x = (FlxG.width / 2) + 40;
		add(txt1);
		
		txt1 = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = "Day 4:";
		txt1.size = 28;
		txt1.alignment = FlxTextAlign.RIGHT;
		txt1.y = txt2.y + txt2.height + 2;
		txt1.x = (FlxG.width / 2) - txt1.width  + 30;
		add(txt1);
		
		txt2 = new FlxText();
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.text = LetterFromCode(Reg.scores[4][Reg.SCORE_LETTER]);
		txt2.size = 28;
		txt2.alignment = FlxTextAlign.LEFT;
		txt2.y = txt1.y;
		txt2.x = (FlxG.width / 2) + 40;
		add(txt2);
		
		txt2 = new FlxText();
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.text = "Day 5:";
		txt2.size = 28;
		txt2.alignment = FlxTextAlign.RIGHT;
		txt2.y = txt1.y + txt1.height + 4;
		txt2.x = (FlxG.width / 2) - txt2.width  + 30;
		add(txt2);
		
		txt1 = new FlxText();
		txt1.font = AssetPaths.NICKELOD__TTF;
		txt1.text = LetterFromCode(Reg.scores[5][Reg.SCORE_LETTER]);
		txt1.size = 28;
		txt1.alignment = FlxTextAlign.LEFT;
		txt1.y = txt2.y;
		txt1.x = (FlxG.width / 2) + 40;
		add(txt1);
		
		Reg.clearSave();
		super.create();
		
		FlxG.camera.fade(0xff111111, 1, true, finishFadeIn);
		
	}
	
	private function LetterFromCode(Code:Int):String
	{
		switch (Code)
		{
			case 1:
				return "A";
			case 2:
				return "B";
			case 3:
				return "C";
			case 4:
				return "D";
			case 5:
				return "F";
			
		}
		return "";
	}
	
	private function finishFadeIn():Void
	{
		_next.visible = true;
		FlxG.mouse.visible = true;
	}
	
	private function gotoMenu():Void
	{
		_next.visible = false;
		FlxG.camera.fade(0xff111111, 1, false, finishFadeOut);
	}
	
	private function finishFadeOut():Void
	{
		FlxG.switchState(new MenuState());
		
	}
}