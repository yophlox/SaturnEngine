package saturn.ui;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import saturn.states.PlayState;

class HUD extends FlxSpriteGroup
{
    private var scoreTxt:FlxText;
    private var timeTxt:FlxText;
    private var scoreSPR:FlxSprite;
    private var timeSPR:FlxSprite;

    var time:Float;

    public function new()
    {
        super();

        scoreSPR = new FlxSprite(85.5, 48.15);
        scoreSPR.loadGraphic(Util.getImage('game/score'));
        scoreSPR.scale.x = 2; 
        scoreSPR.scale.y = 2;
        add(scoreSPR);

        timeSPR = new FlxSprite(85.5, 113.15);
        timeSPR.loadGraphic(Util.getImage('game/time'));
        timeSPR.scale.x = 2; 
        timeSPR.scale.y = 2;
        add(timeSPR);

        scoreTxt = new FlxText(scoreSPR.x + scoreSPR.width * scoreSPR.scale.x + 10, scoreSPR.y + (scoreSPR.height * scoreSPR.scale.y - 37.5) / 2, 200, "0");
        scoreTxt.setFormat("assets/fonts/sonic.ttf", 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(scoreTxt);

        timeTxt = new FlxText(timeSPR.x + timeSPR.width * timeSPR.scale.x + 10, timeSPR.y + (timeSPR.height * timeSPR.scale.y - 37) / 2, 200, "0:00");
        timeTxt.setFormat("assets/fonts/sonic.ttf", 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(timeTxt);
    }

    override public function update(elapsed:Float)
    {
        updateText();
        time += elapsed;

        super.update(elapsed);
    }

    public function updateText()
    {
        scoreTxt.text = "" + PlayState.curScore;
        timeTxt.text = "" + FlxStringUtil.formatTime(time);
    }
}
