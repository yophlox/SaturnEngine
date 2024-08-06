package saturn.states;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxState;
import saturn.game.Sonic;
import flixel.util.FlxCollision;
import flixel.group.FlxGroup;
import flixel.FlxCamera;
import saturn.ui.HUD;
import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.FlxObject;

class PlayState extends FlxState
{
	static public var instance:PlayState;
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
    // level :D
    var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	override public function create()
	{
		instance = this;

        FlxG.cameras.bgColor = 0xFF800080;

		map = new FlxOgmo3Loader('assets/data/SaturnEngine.ogmo', 'assets/data/level1.json');
		walls = map.loadTilemap('assets/images/SPGSolidTileHeightMasks.png', 'walls');
		walls.follow();
		walls.setTileProperties(1, FlxObject.ANY);
		walls.setTileProperties(2, FlxObject.NONE);
		add(walls);
		sonicplr = new Sonic();
        add(sonicplr);
        map.loadEntities(placeEntities, 'entities');

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


		super.create();
	}

	function placeEntities(entity:EntityData):Void
	{
		if (entity.name == "player")
		{
			sonicplr.setPosition(entity.x, entity.y);
		}
	}

	override public function update(elapsed:Float)
	{
		FlxG.camera.follow(sonicplr, PLATFORMER);
		super.update(elapsed);
	}
}
