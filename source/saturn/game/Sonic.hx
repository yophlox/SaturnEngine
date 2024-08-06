package saturn.game;

import flixel.FlxSprite;
import saturn.game.Sprites;
import flixel.FlxObject;

class Sonic extends Sprites 
{
    private var sonic2ver:Bool = false;
    private var isSpindashing:Bool = false;
    private var jump_force:Float = 6.5; // Thanks Sonic Physics Guide.

    public function new(xPos:Int = 0, yPos:Int = 0) {
        super(xPos, yPos);
        
        frames = Util.getSparrow('char/SonicPlayer');
        animation.addByPrefix('idle', 'idle', 24);
        animation.addByPrefix('walk', 'walk', 24);
        animation.addByPrefix('jump', 'roll', 24);
        animation.addByPrefix('uplol', 'up', 24, false);
        animation.addByPrefix('downlol', 'down', 24, false);
        animation.addByPrefix('run', 'run', 24, true);
        animation.addByPrefix('roll', 'roll', 24, true);
        animation.addByPrefix('skidding', 'skid', 24, true);
        animation.addByPrefix('death', 'death', 24, true);
        animation.addByPrefix('pushing', 'push', 24, true);
        if (sonic2ver)
        {
            animation.addByPrefix('spindashing', 'spindash', 24, true);
        }
        playAnim('idle');
        width = 19; // Thanks Sonic Physics Guide.
        height = 39; // Thanks Sonic Physics Guide.
        setFacingFlip(LEFT, false, false);
        setFacingFlip(RIGHT, true, false);
        facing = FlxObject.RIGHT;

        trace('Width: ' + width + ', Height: ' + height);
    }

    override function update(elapsed:Float) {
        if (isSpindashing) {
            width = 15; // Thanks Sonic Physics Guide.
            height = 29; // Thanks Sonic Physics Guide.
        }
        super.update(elapsed);
    }
}
