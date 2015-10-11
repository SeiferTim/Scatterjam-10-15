package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var leaving:Bool;
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
	
		bgColor = 0xff111111;
		
		add(new FlxSprite(0, 0, AssetPaths.back__png));
		
		var txt:FlxText = new FlxText();
		txt.text = "Operator!";
		txt.size = 60;
		txt.font = AssetPaths.NICKELOD__TTF;
		txt.alignment = FlxTextAlign.CENTER;
		txt.color = FlxColor.WHITE;
		txt.y = 20;
		txt.screenCenter(FlxAxes.X);
		add(txt);
		
		var txt2:FlxText = new FlxText();
		txt2.text = "Telephone Operator Simulator 2015";
		txt2.size = 28;
		txt2.font = AssetPaths.NICKELOD__TTF;
		txt2.alignment = FlxTextAlign.CENTER;
		txt2.color = FlxColor.WHITE;
		txt2.y = txt.y + txt.height + 4;
		txt2.screenCenter(FlxAxes.X);
		add(txt2);
		
		var btn:FlxButton = new FlxButton(0, FlxG.height - 40, "Begin", clickPlay);
		btn.loadGraphic(AssetPaths.big_light_blue_button__png, true, 80, 32);
		btn.label.size = 20;
		btn.labelOffsets[FlxButton.NORMAL].y = 0;
		btn.labelOffsets[FlxButton.HIGHLIGHT].y = 0;
		btn.labelOffsets[FlxButton.PRESSED].y = 3;
		btn.screenCenter(FlxAxes.X);
		#if flash
		btn.onUp.sound = new FlxSound().loadEmbedded(AssetPaths.switch25__mp3);
		#else
		btn.onUp.sound = new FlxSound().loadEmbedded(AssetPaths.switch25__wav);
		#end
		add(btn);
		
		FlxG.mouse.visible = false;
		
		#if flash
		FlxG.sound.playMusic(AssetPaths.Morning_Mood_by_Grieg__mp3, 1, true);
		#else
		FlxG.sound.playMusic(AssetPaths.Morning_Mood_by_Grieg__mp3, 1, true);
		#end
		
		super.create();
		
			
		FlxG.camera.fade(0xff111111, 1, true, finishFadeIn);
	}

	private function finishFadeIn():Void
	{
		FlxG.mouse.visible 	= true;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function clickPlay():Void
	{
		if (leaving)
			return;
		leaving = true;
		FlxG.mouse.visible = false;
		FlxG.camera.fade(0xff111111, 1, false, finishFadeOut);
		
	}
	
	private function finishFadeOut():Void
	{
		FlxG.switchState(new IntroState());
	}
}
