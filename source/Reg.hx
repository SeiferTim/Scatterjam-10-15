package;

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
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
	
	public static inline var RESP_FRIENDLY:Int = 0;
	public static inline var RESP_NEUTRAL:Int = 1;
	public static inline var RESP_SYMP:Int = 2;
	public static inline var RESP_ANGRY:Int = 3;
	
	public static inline var MOOD_HAPPY:Int = 0;
	public static inline var MOOD_NEUTRAL:Int = 1;
	public static inline var MOOD_SAD:Int = 2;
	public static inline var MOOD_ANGRY:Int = 3;
	public static inline var MOOD_SCARED:Int = 4;
		
	public static function getResponseName(Response:Int):String
	{
		switch (Response) 
		{
			case RESP_FRIENDLY:
				return "Friendly";
			case RESP_NEUTRAL:
				return "Neutral";
			case RESP_SYMP:
				return "Sympathetic";
			case RESP_ANGRY:
				return "Angry";
		}
		return "";
	}
	
}
