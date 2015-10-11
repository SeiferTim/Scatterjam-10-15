package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.NumTween;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;

class PlayState extends FlxState
{
	
	
	private static inline var MODE_NOCALL:Int = 0;
	private static inline var MODE_NEWCALL:Int = 1;
	private static inline var MODE_HOLDINGIN:Int = 2;
	private static inline var MODE_CALLANSWERED:Int = 3;
	private static inline var MODE_AWAITINGRESPONSE:Int = 4;
	private static inline var MODE_RANDOMSOUND:Int = 5;
	private static inline var MODE_HUNGUP:Int = 6;
	private static inline var MODE_HANGINGUP:Int = 7;
	private static inline var MODE_BROKEN:Int = 8;
	
	private var _switchBoard:FlxSprite;
	
	private var _ports:Array<Port>;
	private var _plugs:Array<Plug>;
	private var _responses:Array<ResponseButton>;
	private var _emergency:FlxSpriteButton;
	private var _repair:FlxSpriteButton;
	private var _call:Call;
	private var _lights:Array<CallLight>;
	private var _labels:Array<PortLabel>;
	
	private var newCallTimer:Float = -100;
	
	private var mode:Int = MODE_NOCALL;
	
	private var _plugCursors:Array<FlxSprite>;
	
	private var _speech:FlxSprite;
	
	private var _moodIcon:MoodIcon;
	
	private var _speechTween:NumTween;
	private var _responsesLocked:Bool = true;
	
	private var _gameTime:Float = 2 * 60;
	
	private var _randomSoundPort:Int = -1;
	private var _holdingPlug:Int = -1;
	
	private var _comingOrGoing:Bool = false;
	
	private var _smoke:Smoke;
	private var _brokenPlug:Int = -1;
	
	
	override public function create():Void
	{
		
		FlxG.mouse.visible = false;
		
		_comingOrGoing = true;
		
		_switchBoard = new FlxSprite(0, 0);
		_switchBoard.makeGraphic(FlxG.width, FlxG.height, FlxColor.BROWN);
		add(_switchBoard);
		
		_ports = [];
		
		var xPos:Int = 75;
		var yPos:Int = 20;
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
		
		_lights = [];
		_labels = [];
		var l:CallLight;
		var pa:PortLabel;
		for (i in _ports)
		{
			l = new CallLight(Std.int(i.x + 15), Std.int(i.y - 2));
			_lights.push(l);
			add(l);
			pa = new PortLabel(Std.int(i.x + 11), Std.int(i.y + i.height - 6), i.portNo);
			_labels.push(pa);
			add(pa);
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
		_emergency.makeGraphic(40, 20, FlxColor.RED);
		add(_emergency);
		_repair = new FlxSpriteButton(300, FlxG.height - 40, null, clickRepair);
		_repair.makeGraphic(40, 20, FlxColor.GREEN);
		add(_repair);
		
		_smoke = new Smoke();
		
		add(_smoke);
		
		
		_plugCursors = [];
		var pc:FlxSprite = new FlxSprite();
		pc.loadGraphic(AssetPaths.plug_black_held__png, true, 20, 50);
		pc.kill();
		_plugCursors.push(pc);
		add(pc);
		pc = new FlxSprite();
		pc.loadGraphic(AssetPaths.plug_red_held__png, true, 20, 50);
		pc.kill();
		_plugCursors.push(pc);
		add(pc);
		
		_speech = new FlxSprite(FlxG.width - 40, FlxG.height - 120);
		_speech.makeGraphic(32, 32, FlxColor.WHITE);
		_speech.kill();
		add(_speech);
		
		_moodIcon = new MoodIcon(Std.int(_speech.x + (_speech.width / 2) - 9), Std.int(_speech.y + (_speech.height / 2) - 9));
		_moodIcon.kill();
		add(_moodIcon);
		
		lockResponses();
		
		super.create();
		
		FlxG.camera.fade(0xff111111, 1, true, finishFadeIn);
		
		
	}

	private function finishFadeIn():Void
	{
		_comingOrGoing = false;
		FlxG.mouse.visible = true;
	}
	
	public function clickRepair():Void
	{
		if (_comingOrGoing)
			return;
		if (mode == MODE_BROKEN)
		{
			fixBreak();
		}
	}
	
	private function fixBreak():Void 
	{
		_smoke.smoking = false;
		FlxG.camera.flash(0x9900ff00, .2);
		_lights[_brokenPlug].status = CallLight.STATE_OFF;
		mode = MODE_NOCALL;
	}
	
	public function clickEmergency():Void
	{
		if (_comingOrGoing)
			return;
			
		if (mode == MODE_AWAITINGRESPONSE)
		{
			if (_call.isEmergency)
			{
				goodCall();
			}
			else
			{
				FlxG.sound.play(AssetPaths.dialtone__mp3, 1, false, true).fadeOut(3);
				badCall();
			}
			
		}
	}
	
	private function finishCall():Void
	{
		_call.hangup();
	}
	
	private function goodCall():Void
	{
		mode = MODE_HANGINGUP;
		Reg.addGood();
		FlxG.camera.flash(0x9900ff00, .2, finishCall);
		
	}
	
	
	public function badCall():Void
	{
		mode = MODE_HANGINGUP;
		Reg.addBad();
		FlxG.camera.shake(0.01, 0.1);
		FlxG.camera.flash(0x99ff0000, .2, finishCall);
	}
	
	public function clickPlug(PlugNo:Int):Void
	{
		if (_comingOrGoing)
			return;
		if (!_plugs[PlugNo].visible || mode == MODE_BROKEN)
			return;
			
		if (PlugNo == Plug.PLUG_IN )
		{
			_plugs[PlugNo].visible = false;
			FlxG.mouse.visible = false;
			_plugCursors[PlugNo].reset(_plugs[PlugNo].x, _plugs[PlugNo].y);
			_plugCursors[PlugNo].animation.frameIndex = 0;
			_holdingPlug = PlugNo;
		}
		else if (PlugNo == Plug.PLUG_OUT && mode == MODE_AWAITINGRESPONSE)
		{
			_plugs[PlugNo].visible = false;
			FlxG.mouse.visible = false;
			_plugCursors[PlugNo].reset(_plugs[PlugNo].x, _plugs[PlugNo].y);
			_plugCursors[PlugNo].animation.frameIndex = 0;
			_holdingPlug = PlugNo;
		}
	}
	
	public function clickPort(PortNo:Int):Void
	{
		if (_comingOrGoing)
			return;
			
		if (_holdingPlug == Plug.PLUG_IN )
		{
			if (mode == MODE_NEWCALL)
			{
				if (_call.inFrom == PortNo)
				{
					mode = MODE_CALLANSWERED;
					_plugCursors[Plug.PLUG_IN].x = _ports[PortNo].x + (_ports[PortNo].width / 2) - (_plugCursors[Plug.PLUG_IN].width / 2);
					_plugCursors[Plug.PLUG_IN].y = _ports[PortNo].y + (_ports[PortNo].height / 2);
					_plugCursors[Plug.PLUG_IN].animation.frameIndex = 1;
					FlxG.mouse.visible = true;
					_lights[PortNo].status = CallLight.STATE_ON;
					_call.timer = FlxG.random.float(10, 20);
					_holdingPlug = -1;
					showSpeech();
					FlxG.sound.play(AssetPaths.plug_in__mp3, 1, false, true);
					
					
				}
				else
				{
					_lights[_call.inFrom].status = CallLight.STATE_OFF;
					badCall();
					mode = MODE_RANDOMSOUND;
					_randomSoundPort = PortNo;
					_plugCursors[Plug.PLUG_IN].x = _ports[PortNo].x + (_ports[PortNo].width / 2) - (_plugCursors[Plug.PLUG_IN].width / 2);
					_plugCursors[Plug.PLUG_IN].y = _ports[PortNo].y + (_ports[PortNo].height / 2) - (_plugCursors[Plug.PLUG_IN].height * .2);
					FlxG.mouse.visible = true;
					_lights[PortNo].status = CallLight.STATE_ON;
					_holdingPlug = -1;
					FlxG.sound.play(AssetPaths.plug_in__mp3, 1, false, true);
				}
			}
			else
			{
				// random sound?
				
				mode = MODE_RANDOMSOUND;
				_randomSoundPort = PortNo;
				_plugCursors[Plug.PLUG_IN].x = _ports[PortNo].x + (_ports[PortNo].width / 2) - (_plugCursors[Plug.PLUG_IN].width / 2);
				_plugCursors[Plug.PLUG_IN].y = _ports[PortNo].y + (_ports[PortNo].height / 2) - (_plugCursors[Plug.PLUG_IN].height * .2);
				FlxG.mouse.visible = true;
				_lights[PortNo].status = CallLight.STATE_ON;
				_holdingPlug = -1;
				FlxG.sound.play(AssetPaths.plug_in__mp3, 1, false, true);
				
			}
		}
		else if (mode == MODE_AWAITINGRESPONSE && _holdingPlug == Plug.PLUG_OUT && PortNo != _call.inFrom)
		{
			FlxG.sound.play(AssetPaths.plug_in__mp3, 1, false, true);
			if (PortNo == _call.outTo)
			{
				// you did it!
				goodCall();
			}
			else
			{
				
				// oops!
				FlxG.sound.play(AssetPaths.dialtone__mp3, 1, false, true).fadeOut(3);
				badCall();
			}
			FlxG.sound.play(AssetPaths.unplug__mp3, 1, false, true);
			
		}
	}
	
	private function showSpeech():Void
	{
		_speech.alpha = 0;
		_moodIcon.alpha = 0;
		_speech.revive();
		if (_call.health >= 100 && !_call.isEmergency)
			_moodIcon.showDestination(_call.outTo);
		else
			_moodIcon.mood = _call.mood;
		_moodIcon.revive();
		if (_speechTween != null)
		{
			_speechTween.cancel();
			_speechTween = FlxDestroyUtil.destroy(_speechTween);
		}
		_speechTween = FlxTween.num(0, 1, .2, { ease: FlxEase.circIn, onComplete: doneSpeechIn }, speechAlpha);
		
	}
	
	private function speechAlpha(Value:Float):Void
	{
		_moodIcon.alpha = _speech.alpha = Value;
	}
	
	private function doneSpeechIn(_):Void
	{
		mode = MODE_AWAITINGRESPONSE;
		_speechTween = FlxDestroyUtil.destroy(_speechTween);
	}
	
	public function clickResponse(ResponseNo:Int):Void
	{
		if (_comingOrGoing || _responsesLocked)
			return;
		if (mode == MODE_AWAITINGRESPONSE)
		{
			mode = MODE_CALLANSWERED;
			lockResponses();
			if (_call.mood == Reg.MOOD_CONFUSED)
			{
				if (FlxG.random.bool())
				{
					_call.giveHealth();
				}
				else
				{
					_call.takeHealth();
				}
			}
			else
			{
				if (_call.isEmergency)
				{
					_call.takeHealth();
				}				
				else if (_call.health < 100)
				{
					if (_call.mood == ResponseNo)
					{
						_call.giveHealth();
					}
					else
					{
						_call.takeHealth();
					}
				}
				else
				{
					_call.takeHealth();
				}
			}
			if (_call.health <= 0)
			{
				FlxG.sound.play(AssetPaths.dialtone__mp3, 1, false, true).fadeOut(3);
				badCall();
			}
			else
				changeSpeech();
		}
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	
	override public function update(elapsed:Float):Void
	{
		if (_comingOrGoing)
		{
			super.update(elapsed);
			return;
		}
		
		if (_gameTime > 0 || (mode != MODE_NOCALL && mode != MODE_NEWCALL)  )
		{
			_gameTime-= elapsed;
		
			if (mode == MODE_BROKEN)
			{
				
			}
			else
			{
				if (mode == MODE_HUNGUP)
				{
					if (!_speech.alive)
						mode = MODE_NOCALL;
				}
				if (mode == MODE_AWAITINGRESPONSE && _responsesLocked)
				{
					unlockResponses();
				}
				else if (mode != MODE_AWAITINGRESPONSE && !_responsesLocked)
				{
					lockResponses();
				}
				
				if (_holdingPlug == Plug.PLUG_IN)
				{
					_plugCursors[Plug.PLUG_IN].x = FlxG.mouse.screenX - (_plugCursors[Plug.PLUG_IN].width  / 2);
					_plugCursors[Plug.PLUG_IN].y = FlxG.mouse.screenY - (_plugCursors[Plug.PLUG_IN].height  *  .2);
					
				}
				if (mode == MODE_RANDOMSOUND)
				{
					// once the sound is finished, then return the plug...
					_lights[_randomSoundPort].status = CallLight.STATE_OFF;
					_plugCursors[Plug.PLUG_IN].kill();
					_plugs[Plug.PLUG_IN].visible = true;
					_holdingPlug = -1;
					FlxG.mouse.visible = true;
					newCallTimer = -100;
					mode = MODE_NOCALL;
					FlxG.sound.play(AssetPaths.unplug__mp3, 1, false, true);
				
				}
				else if (_call == null)
				{
					mode = MODE_NOCALL;
					
					if (newCallTimer == -100)
					{
						newCallTimer = FlxG.random.float(5, 15) * (1 - (Reg.day * .2));
					}
					if (newCallTimer <= 0)
					{
						
						if (Reg.day == 5)
						{
							newCallTimer = -100;
						}
						else
						{
							if (FlxG.random.bool(10 + (5 * Reg.day)))
							{
								breakPort();
							}
							else
							{	
								
								_call = new Call();
								mode = MODE_NEWCALL;
								Reg.addCall();
							
							}
						}
					}
					else
					{
						newCallTimer -= elapsed;
					}
					
				}
				else 
				{
					
					if (!_call.hungup && mode != MODE_HANGINGUP)
					{
						_call.update(elapsed);
						
						if (mode == MODE_CALLANSWERED)
						{
							
						}
						else if (mode == MODE_AWAITINGRESPONSE)
						{
							if (_call.timer <= 0)
							{
								_call.takeHealth();
								
								if (_call.health <= 0)
								{
									FlxG.sound.play(AssetPaths.dialtone__mp3, 1, false, true).fadeOut(3);
									badCall();
								}
							}
							else
							{
								if (_plugCursors[Plug.PLUG_OUT].visible)
								{
									_plugCursors[Plug.PLUG_OUT].x = FlxG.mouse.screenX - (_plugCursors[Plug.PLUG_OUT].width  / 2);
									_plugCursors[Plug.PLUG_OUT].y = FlxG.mouse.screenY - (_plugCursors[Plug.PLUG_OUT].height  *  .2);
								}
							}
						}
						else
						{
							// blink the incoming light
							_lights[_call.inFrom].status = CallLight.STATE_BLINK;
							if (_call.health <= 0)
								badCall();
							
						}
					}
					else if (_call.hungup)
					{
						
						// call is DEAD, kill the call
						mode = MODE_HUNGUP;
						_lights[_call.inFrom].status = CallLight.STATE_OFF;
						newCallTimer = -100;
						_plugCursors[Plug.PLUG_IN].kill();
						_plugs[Plug.PLUG_IN].visible = true;
						_plugCursors[Plug.PLUG_OUT].kill();
						_plugs[Plug.PLUG_OUT].visible = true;
						FlxG.mouse.visible = true;
						hideSpeech();
						_call = null;
							
			
					}
				}
			}
		}
		else
		{
			//day over
			if (mode == MODE_NEWCALL)
			{
				_lights[_call.inFrom].status = CallLight.STATE_OFF;
				badCall();
			}
			_comingOrGoing = true;
			FlxG.camera.fade(0xff111111, 1, false, finishFadeOut);
		}
		
		super.update(elapsed);
	}
	
	private function breakPort():Void
	{
		newCallTimer = -100;
		mode = MODE_BROKEN;
		FlxG.camera.flash(0x99fff200, .2);
		FlxG.camera.shake(0.04, .2);
		_brokenPlug = FlxG.random.int(0, 7);
		if (_randomSoundPort>-1)
			_lights[_randomSoundPort].status = CallLight.STATE_OFF;
		_lights[_brokenPlug].status = CallLight.STATE_BROKEN;
		_smoke.reset(_ports[_brokenPlug].x + 20, _ports[_brokenPlug].y + 20);
		_plugCursors[Plug.PLUG_IN].kill();
		_plugs[Plug.PLUG_IN].visible = true;
		_holdingPlug = -1;
		FlxG.mouse.visible = true;
		
		
	}
	
	private function finishFadeOut():Void
	{
		FlxG.switchState(new EndDay());
	}
	
	private function lockResponses():Void
	{
		for (i in _responses)
		{
			i.active = false;
			i.alpha = .5;
		}
		_responsesLocked = true;
	}
	
	private function unlockResponses():Void
	{
		for (i in _responses)
		{
			i.active = true;
			i.alpha = 1;
		}
		_responsesLocked = false;
	}
	
	public function changeSpeech():Void
	{
		
		if (_speechTween != null)
		{
			_speechTween.cancel();
			_speechTween = FlxDestroyUtil.destroy(_speechTween);
		}
		if (_speech.alive)
		{
			_speechTween = FlxTween.num(_speech.alpha, 0, (1 / _speech.alpha) * .2, { ease:FlxEase.circIn, onComplete:doneChangeSpeechOut }, speechAlpha);
		}
		else
		{
			doneChangeSpeechOut(null);
		}
	}
	
	private function doneChangeSpeechOut(_):Void
	{
		_moodIcon.kill();
		_speech.kill();
		_moodIcon.newFace();
		showSpeech();
	}
	
	private function doneSpeechOut(_):Void
	{
		_moodIcon.kill();
		_speech.kill();
		
	}
	
	private function hideSpeech():Void
	{
		if (_speechTween != null)
		{
			_speechTween.cancel();
			_speechTween = FlxDestroyUtil.destroy(_speechTween);
		}
		if (_speech.alive)
		{
			_speechTween = FlxTween.num(_speech.alpha, 0, (1 / _speech.alpha) * .2, { ease:FlxEase.circIn, onComplete:doneSpeechOut }, speechAlpha);
		}
		else
		{
			doneSpeechOut(null);
		}
	}
	
}
