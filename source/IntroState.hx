package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextAlign;
import flixel.util.FlxAxes;


class IntroState extends FlxState
{

	override public function create():Void 
	{
		
		bgColor = 0xff111111;
		
		add(new FlxSprite(0, 0, AssetPaths.back__png));
		
		var txt:FlxText = new FlxText();
		txt.font = AssetPaths.NICKELOD__TTF;
		txt.text = "Operators didn't just connect people's\ncalls, they connected with people.\nAngry people. Frightened people.\nFriendly people. Sometimes, people who got\ntoo friendly.";
		txt.size = 22;
		txt.alignment = FlxTextAlign.CENTER;
		txt.screenCenter(FlxAxes.XY);
		add(txt);
		
		var txt2:FlxText = new FlxText();
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.text = "~ George Kupczak";
		txt2.size = 22;
		txt2.alignment = FlxTextAlign.RIGHT;
		txt2.x = txt.x + txt.width - txt2.width;
		txt2.y = txt.y + txt.height + 2;
		add(txt2);
		
		
		FlxG.mouse.visible = false;
		super.create();
		
		FlxG.camera.fade(0xff111111, 1, true, finishFadeIn);
	}
		
	private function finishFadeIn():Void
	{
		#if flash
		FlxG.sound.play(AssetPaths.connections__mp3, 1, false, true, finishIntro);
		#else
		FlxG.sound.play(AssetPaths.connections__ogg, 1, false, true, finishIntro);
		#end
	}
	
	private function finishIntro():Void
	{
		FlxG.camera.fade(0xff111111, 1, false, finishFadeOut);
	}
	
	private function finishFadeOut():Void
	{
		FlxG.switchState(new NewDay());
	}
	
}