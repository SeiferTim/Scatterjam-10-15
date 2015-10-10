package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	
	
	private var _switchBoard:FlxSprite;
	
	private var _ports:Array<Port>;
	private var _plugs:Array<Plug>;
	private var _responses:Array<ResponseButton>;
	private var _emergency:FlxSpriteButton;
	private var _call:Call;
	
	private var newCallTimer:Float = -100;
	
	override public function create():Void
	{
		
		_switchBoard = new FlxSprite(0, 0);
		_switchBoard.makeGraphic(FlxG.width, FlxG.height, FlxColor.BROWN);
		add(_switchBoard);
		
		_ports = [];
		
		var xPos:Int = 75;
		var yPos:Int = 40;
		var p:Port;
		for (i in 0...2)
		{
			for (j in 0...4)
			{
				p = new Port(xPos + (70 * j), yPos + (70 * i), i * 4 + j, clickPort);
				add(p);
				_ports.push(p);
			}
			
		}
		
		_plugs = [];
		var pl:Plug = new Plug( 50, FlxG.height - 70, 0, clickPlug);
		_plugs.push(pl);
		add(pl);
		
		pl = new Plug( 80, FlxG.height - 70, 1, clickPlug);
		_plugs.push(pl);
		add(pl);
		
		_responses = [];
		
		var r:ResponseButton;
		xPos = 120;
		yPos = FlxG.height -60;
		for (i in 0...2)
		{
			for (j in 0...2)
			{
				r = new ResponseButton(xPos + (80 * i), yPos + (20 * j), i * 2 + j, clickResponse);
				_responses.push(r);
				add(r);
			}
		}
		
		_emergency = new FlxSpriteButton(300, FlxG.height - 60, null, clickEmergency);
		_emergency.makeGraphic(40, 40, FlxColor.RED);
		add(_emergency);
		
		super.create();
		
		
	}

	public function clickEmergency():Void
	{
		
	}
	
	public function clickPlug(PlugNo:Int):Void
	{
		
	}
	
	public function clickPort(PortNo:Int):Void
	{
		
	}
	
	public function clickResponse(ResponseNo:Int):Void
	{
		
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	
	override public function update(elapsed:Float):Void
	{
		if (_call == null)
		{
			if (newCallTimer == -100)
			{
				newCallTimer = FlxG.random.float(1, 3);
			}
			if (newCallTimer <= 0)
			{
				_call = new Call();
				
			}
			else
			{
				newCallTimer -= elapsed;
			}
		}
		else if (_call.timer > 0)
		{
			if (_call.answered)
			{
				// show the caller's mood or destination
				if (health >= 100)
				{
					// show destination
				}
				else
				{
					// show mood
				}
			}
			else
			{
				// blink the incoming light
			}
		}
		else if (_call.timer <= 0)
		{
			// call is DEAD, kill the call
			_call = null;
		}
		
		super.update(elapsed);
	}
}
