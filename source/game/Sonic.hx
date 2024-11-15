package game;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;

class Sonic extends FlxSprite
{
	// Movement constants
	private static inline var ACCELERATION_SPEED:Float = 0.046875;
	private static inline var DECELERATION_SPEED:Float = 0.5;
	private static inline var FRICTION_SPEED:Float = 0.046875;
	private static inline var TOP_SPEED:Float = 6;
	private static inline var AIR_ACCELERATION_SPEED:Float = 0.09375;
	private static inline var GRAVITY_FORCE:Float = 0.21875;
	private static inline var MAX_Y_SPEED:Float = 16;
	private static inline var JUMP_FORCE:Float = 6.5;

	// Physics & size constants
	private static inline var STANDING_WIDTH_RADIUS:Float = 9;
	private static inline var STANDING_HEIGHT_RADIUS:Float = 19;
	private static inline var ROLLING_WIDTH_RADIUS:Float = 7;
	private static inline var ROLLING_HEIGHT_RADIUS:Float = 14;
	private static inline var PUSH_RADIUS:Float = 10;

	// Hitbox constants
	private static inline var HITBOX_WIDTH_RADIUS:Float = 8;
	private static inline var HITBOX_HEIGHT_OFFSET:Float = 3; // Always 3 less than height radius
	private static inline var CROUCH_HITBOX_Y_OFFSET:Float = 12;
	private static inline var CROUCH_HITBOX_HEIGHT_RADIUS:Float = 10;

	// Animation speed thresholds
	private static inline var WALK_SPEED_THRESHOLD:Float = 0.5;
	private static inline var RUN_SPEED_THRESHOLD:Float = 4.0;
	// State tracking
	private var isRolling:Bool = false;
	private var isCrouching:Bool = false;

	// Movement variables
	private var groundSpeed:Float = 0;
	private var controlLockTimer:Float = 0;
	private var xSpeed:Float = 0;
	private var ySpeed:Float = 0;
	private var isAirborne:Bool = false;

	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		
		loadGraphic("assets/images/Sonic.png", true); 
		frames = FlxAtlasFrames.fromSparrow("assets/images/Sonic.png", "assets/images/Sonic.xml");
		
		animation.addByPrefix("idle", "idle", 24, true);
		animation.addByPrefix("walk", "walk", 24, true);
		animation.addByPrefix("run", "run", 24, true);
        animation.addByPrefix("jump", "roll", 24, true);
		
		animation.play("idle");
		
		updateDimensions(false);
	}

	private function updateDimensions(rolling:Bool):Void 
	{
		var widthRadius = rolling ? ROLLING_WIDTH_RADIUS : STANDING_WIDTH_RADIUS;
		var heightRadius = rolling ? ROLLING_HEIGHT_RADIUS : STANDING_HEIGHT_RADIUS;
		
		width = widthRadius * 2 + 1;
		height = heightRadius * 2 + 1;
		
		if (isCrouching && !rolling) 
		{
			var hitboxHeight = CROUCH_HITBOX_HEIGHT_RADIUS * 2 + 1;
			setSize(HITBOX_WIDTH_RADIUS * 2 + 1, hitboxHeight);
			offset.set(
				(width - (HITBOX_WIDTH_RADIUS * 2 + 1)) / 2,
				CROUCH_HITBOX_Y_OFFSET
			);
		} 
		else 
		{
			var hitboxHeight = (heightRadius - HITBOX_HEIGHT_OFFSET) * 2 + 1;
			setSize(HITBOX_WIDTH_RADIUS * 2 + 1, hitboxHeight);
			offset.set(
				(width - (HITBOX_WIDTH_RADIUS * 2 + 1)) / 2,
				(height - hitboxHeight) / 2
			);
		}
	}

	override function update(elapsed:Float)
	{
		handleMovement();
		super.update(elapsed);
	}

	private function handleMovement():Void
	{
		// Handle jumping from ground
		if (!isAirborne && FlxG.keys.justPressed.Z)
		{
			animation.play("jump");
			isAirborne = true;
			ySpeed = -JUMP_FORCE;
			xSpeed = groundSpeed;
		}

		if (isAirborne)
		{
			handleAirMovement();
			x += xSpeed;
			y += ySpeed;
		}
		else 
		{
			if (controlLockTimer > 0 && isTouchingFloor())
			{
				controlLockTimer--;
				if (!FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT)
				{
					applyFriction();
				}
				return;
			}

			if (FlxG.keys.pressed.LEFT)
			{
				if (groundSpeed > 0)
				{
					groundSpeed -= DECELERATION_SPEED;
					if (groundSpeed <= 0)
						groundSpeed = -0.5;
				}
				else if (groundSpeed > -TOP_SPEED)
				{
					groundSpeed -= ACCELERATION_SPEED;
					if (groundSpeed <= -TOP_SPEED)
						groundSpeed = -TOP_SPEED;
				}
			}

			if (FlxG.keys.pressed.RIGHT)
			{
				if (groundSpeed < 0)
				{
					groundSpeed += DECELERATION_SPEED;
					if (groundSpeed >= 0)
						groundSpeed = 0.5;
				}
				else if (groundSpeed < TOP_SPEED)
				{
					groundSpeed += ACCELERATION_SPEED;
					if (groundSpeed >= TOP_SPEED)
						groundSpeed = TOP_SPEED;
				}
			}

			if (!FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT)
			{
				applyFriction();
			}

			if (groundSpeed != 0)
			{
				var absSpeed = Math.abs(groundSpeed);
				if (absSpeed >= RUN_SPEED_THRESHOLD)
				{
					animation.play("run");
				}
				else if (absSpeed > 0)
				{
					animation.play("walk");
				}
				
				flipX = (groundSpeed < 0);
			}
			else
			{
				animation.play("idle");
			}
			
			x += groundSpeed;
		}
		
		xSpeed = groundSpeed;
		ySpeed = 0;
	}

	private function handleAirMovement():Void
	{
		// Air acceleration
		if (FlxG.keys.pressed.LEFT && xSpeed > -TOP_SPEED)
		{
			xSpeed -= AIR_ACCELERATION_SPEED;
			if (xSpeed < -TOP_SPEED) xSpeed = -TOP_SPEED;
		}
		
		if (FlxG.keys.pressed.RIGHT && xSpeed < TOP_SPEED)
		{
			xSpeed += AIR_ACCELERATION_SPEED;
			if (xSpeed > TOP_SPEED) xSpeed = TOP_SPEED;
		}
		
		if (ySpeed < 0 && ySpeed > -4)
		{
			xSpeed -= ((Math.floor(xSpeed / 0.125)) / 256);
		}
		
		ySpeed += GRAVITY_FORCE;
		if (ySpeed > MAX_Y_SPEED) ySpeed = MAX_Y_SPEED; // Y speed cap (remove if you want, idc lol, only here because Sonic can possible move so fast that he passes through the ground.)
		
		if (xSpeed != 0)
		{
			flipX = (xSpeed < 0);
		}

		if (isTouchingFloor())
		{
			isAirborne = false;
			groundSpeed = xSpeed;
			y = FlxG.height - height;
		}
	}

	private function applyFriction():Void
	{
		if (Math.abs(groundSpeed) <= FRICTION_SPEED)
		{
			groundSpeed = 0;
			return;
		}

		var frictionToApply = FRICTION_SPEED * (groundSpeed > 0 ? -1 : 1);
		groundSpeed += frictionToApply;
	}

	private function isTouchingFloor():Bool
	{
		return y >= FlxG.height - height;
	}
}