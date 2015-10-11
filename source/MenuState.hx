package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxAxes;

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
		
		var btn:FlxButton = new FlxButton(0, FlxG.height - 24, "Play", clickPlay);
		btn.screenCenter(FlxAxes.X);
		add(btn);
		
		super.create();
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
