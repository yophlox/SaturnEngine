package saturn;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxState;
import saturn.game.Sonic;
import flixel.util.FlxCollision;
import flixel.group.FlxGroup;
import flixel.FlxCamera;
import saturn.ui.HUD;
import flixel.FlxG;

class LevelState extends FlxState
{
    static public var instance:LevelState;
    var levelBounds:FlxGroup;
	var sonicplr:Sonic;
    var platformGrp:FlxTypedGroup<FlxSprite>;
	// CAM
	var camHUD:FlxCamera;
    private var camGame:FlxCamera;
    // Score lol
    public static var curScore:Int = 0;
    // HUD
	var hud:HUD;

    override public function create()
    {
        instance = this;

        camGame = new FlxCamera();
        camGame.bgColor = 0xFF333333;
        FlxG.cameras.add(camGame, true);
        FlxG.camera = camGame; 
        FlxG.camera.follow(sonicplr);
        FlxG.camera.followLerp = 0.1;

        camHUD = new FlxCamera();
        camHUD.bgColor = 0;
        camHUD.setPosition(0, 0); 
        FlxG.cameras.add(camHUD, false);

        hud = new HUD();
        hud.cameras = [camHUD];
        add(hud);

        sonicplr = new Sonic(0, 0);
        add(sonicplr);
    }

    override public function update(elapsed:Float)
    {
        FlxG.camera.follow(sonicplr, PLATFORMER);

        super.update(elapsed);
    }
}
