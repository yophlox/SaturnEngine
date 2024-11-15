package states;

import flixel.FlxState;
import game.Sonic;
import flixel.FlxG;
import flixel.math.FlxRect;

class PlayState extends FlxState
{
	var sonic:Sonic;
	override public function create()
	{
		sonic = new Sonic(100, 100);
		add(sonic);
		
		FlxG.camera.follow(sonic, PLATFORMER, 0.04);
		FlxG.camera.deadzone = new FlxRect(
			(FlxG.width / 2) - 288,  // 96 * 3 = 288
			(FlxG.height / 2) - 32,  // top
			128,                     // width
			64                       // height
		);
		FlxG.camera.setScrollBoundsRect(0, 0, 3200, 240);
		FlxG.camera.zoom = 2;
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
