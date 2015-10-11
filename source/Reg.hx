package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Array<Int>> = [];
	
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
	
	public static var day:Int = 0;
	
	public static inline var SCORE_CALLS:Int = 0;
	public static inline var SCORE_BAD:Int = 1;
	public static inline var SCORE_GOOD:Int = 2;
	public static inline var SCORE_LETTER:Int = 3;
	
	
	public static inline var RESP_HAPPY:Int = 0;
	public static inline var RESP_SAD:Int = 1;
	public static inline var RESP_ANGRY:Int = 2;
	public static inline var RESP_SCARED:Int = 3;
	
	public static inline var MOOD_HAPPY:Int = 0;
	public static inline var MOOD_SAD:Int = 1;
	public static inline var MOOD_ANGRY:Int = 2;
	public static inline var MOOD_SCARED:Int = 3;
	public static inline var MOOD_CONFUSED:Int = 4;
	
	public static function startDay():Void
	{
		day++;
		scores[day] = [];
		scores[day][SCORE_CALLS] = 0;
		scores[day][SCORE_BAD] = 0;
		scores[day][SCORE_GOOD] = 0;
		scores[day][SCORE_LETTER] = -1;
	}
	
	public static function addCall():Void
	{
		scores[day][SCORE_CALLS]++;
	}
	public static function addGood():Void
	{
		scores[day][SCORE_GOOD]++;
	}
	public static function addBad():Void
	{
		scores[day][SCORE_BAD]++;
	}
		
	public static function getResponseImage(Response:Int):Null<FlxSprite>
	{
		var s:FlxSprite;
		switch (Response) 
		{
			case RESP_HAPPY:
				s = new FlxSprite(0, 0, AssetPaths.happy__png);
				return s;
			case RESP_SAD:
				s = new FlxSprite(0, 0, AssetPaths.cry__png);
				return s;
			case RESP_ANGRY:
				s = new FlxSprite(0, 0, AssetPaths.angry__png);
				return s;
			case RESP_SCARED:
				s = new FlxSprite(0, 0, AssetPaths.shocked__png);
				return s;
		}
		return null;
	}
	
}
