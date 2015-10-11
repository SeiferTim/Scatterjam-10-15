package;
import flixel.addons.display.FlxSpriteAniRot;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class TeamState extends FlxState
{

	
	private var _team:FlxSprite;
	private var _timer:Float;
	private var _text:Array<FlxText>;
	private var _snd:FlxSound;

	override public function create():Void 
	{
		
		bgColor = 0xff112233;
		FlxG.mouse.visible = false;
		
		_text = [];
		
		
		_team = new FlxSprite();
		_team.loadGraphic(AssetPaths.team__png, true, 160, 160);
		_team.screenCenter(FlxAxes.XY);
		_team.y -= 20;
		add(_team);
		
		var t:FlxText = new FlxText();
		t.text = "EMERY";
		t.font = AssetPaths.Skater_Girls_Rock__ttf;
		t.size = 40;
		t.alignment = FlxTextAlign.CENTER;
		t.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.WHITE, 2, 4);
		t.color = FlxColor.BLACK;
		t.screenCenter(FlxAxes.X);
		t.y = FlxG.height - t.height - 10;
		//t.alpha = 0;
		_text.push(t);
		add(t);
		
		t = new FlxText();
		t.text = "ERICA";
		t.font = AssetPaths.Skater_Girls_Rock__ttf;
		t.size = 40;
		t.alignment = FlxTextAlign.CENTER;
		t.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.WHITE, 2, 4);
		t.color = FlxColor.BLACK;
		t.screenCenter(FlxAxes.X);
		t.y = FlxG.height - t.height - 10;
		t.visible = false;
		_text.push(t);
		add(t);
		
		t = new FlxText();
		t.text = "JEVION";
		t.font = AssetPaths.Skater_Girls_Rock__ttf;
		t.size = 40;
		t.alignment = FlxTextAlign.CENTER;
		t.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.WHITE, 2, 4);
		t.color = FlxColor.BLACK;
		t.screenCenter(FlxAxes.X);
		t.y = FlxG.height - t.height - 10;
		t.visible = false;
		_text.push(t);
		add(t);
		
		t = new FlxText();
		t.text = "TIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIM!!!";
		t.font = AssetPaths.Skater_Girls_Rock__ttf;
		t.size = 40;
		t.alignment = FlxTextAlign.CENTER;
		t.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.WHITE, 2, 4);
		t.color = FlxColor.BLACK;
		t.x = FlxG.width;
		t.y = FlxG.height - t.height - 10;
		t.visible = false;
		_text.push(t);
		add(t);
		
		FlxG.camera.fade(FlxColor.BLACK, .2, true, finishFadeIn);
		
		super.create();
		
		
	}
	
	private function finishFadeIn():Void
	{
		#if flash
		FlxG.sound.play(AssetPaths.EMERY__mp3, 1, false, true, afterEmery);
		#else
		FlxG.sound.play(AssetPaths.EMERY__wav, 1, false, true, afterEmery);
		#end
	}
	
	private function afterEmery():Void
	{
		FlxG.camera.flash(FlxColor.WHITE, .2, finishAfterEmery);
		
	}
	
	private function finishAfterEmery():Void
	{
		_text[0].visible = false;
		_text[1].visible = true;
		_team.animation.frameIndex = 1;
		#if flash
		FlxG.sound.play(AssetPaths.ERICA__mp3, 1, false, true, afterErica);
		#else
		FlxG.sound.play(AssetPaths.ERICA__wav, 1, false, true, afterErica);
		#end
	}
	
	private function afterErica():Void
	{
		FlxG.camera.flash(FlxColor.WHITE, .2, finishAfterErica);
	}
	
	private function finishAfterErica():Void
	{
		_text[1].visible = false;
		_text[2].visible = true;
		_team.animation.frameIndex = 2;
		#if flash
		FlxG.sound.play(AssetPaths.JEVION__mp3, 1, false, true, afterJevion);
		#else
		FlxG.sound.play(AssetPaths.JEVION__wav, 1, false, true, afterJevion);
		#end
	}
	
	private function afterJevion():Void
	{
		FlxG.camera.flash(FlxColor.WHITE, .2, finishAfterJevion);
	}
	
	private function finishAfterJevion():Void
	{
		_text[2].visible = false;
		_text[3].visible = true;
		_team.animation.frameIndex = 3;
		#if flash
		_snd = FlxG.sound.play(AssetPaths.TIIIIIIIM__mp3, 1, false, true, afterTim);
		#else
		_snd = FlxG.sound.play(AssetPaths.TIIIIIIIM__wav, 1, false, true, afterTim);
		#end
	}
	
	private function afterTim():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .66, false, finishFadeOut);
		
	}
	
	private function finishFadeOut():Void
	{
		FlxG.switchState(new MenuState());
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (_text[3].visible)
		{
			if (_snd.time > 0)
			{
				// 0% = FlxG.width
				// 100% = -_text[3].width
				
				_text[3].x = ((( -(FlxG.width + _text[3].width)) / 4106 ) * _snd.time) + FlxG.width;
				trace(_text[3].x);
				
				
			}
			//trace(_snd.time);
			
			//_text[3].x -= ;
			//FlxG.width -- -_text[3].width 
			
			
			
		}
		super.update(elapsed);
	}
	
	
}