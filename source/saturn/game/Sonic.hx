package saturn.game;

import flixel.FlxSprite;
import saturn.game.Sprites;
import flixel.FlxObject;

class Sonic extends Sprites 
{

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

        playAnim('idle');
        setFacingFlip(LEFT, false, false);
        setFacingFlip(RIGHT, true, false);
        facing = FlxObject.RIGHT;
        trace('Width: ' + width + ', Height: ' + height);
    }
}