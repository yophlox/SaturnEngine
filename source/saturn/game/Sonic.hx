package saturn.game;

import flixel.FlxSprite;
import saturn.game.Sprites;
import flixel.FlxObject;

class Sonic extends Sprites 
{
    private var sonic2ver:Bool = false;
    private var isSpindashing:Bool = false;
    // Thanks Sonic Physics Guide.
    // Basic Movement
    private var jump_force:Float = 6.5;
    private var acceleration_speed:Float = 0.046875; // (12 subpixels)
    private var deceleration_speed:Float = 0.5; // (128 subpixels)
    private var friction_speed:Float = 0.046875; // (12 subpixels)
    private var top_speed:Float = 6;
    private var gravity_force:Float = 0.21875; // (56 subpixels)
    // Slope Factor
    private var slope_factor_normal:Float = 0.125; // (32 subpixels)
    private var slope_factor_rollup:Float =	0.078125; // (20 subpixels)
    private var slope_factor_rolldown:Float = 0.3125; // (80 subpixels)
    // Rolling
    var roll_friction_speed:Float =	0.0234375; // (6 subpixels)
    var roll_deceleration_speed:Float =	0.125; // (32 subpixels)
    // Air State
    var air_acceleration_speed:Float = 0.09375; // (24 subpixels)

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
