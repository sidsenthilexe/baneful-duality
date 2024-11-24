extends CharacterBody2D

@onready var player_animations: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var double_jump_count = 0

func _physics_process(delta: float) -> void:
	if is_on_floor():
		double_jump_count = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = 0.85 * JUMP_VELOCITY
	if Input.is_action_just_pressed("move_up") and not is_on_floor() and double_jump_count == 0:
		double_jump_count += 1
		velocity.y = 0.85 * JUMP_VELOCITY
				
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	if (direction == 1):
		player_animations.play("running")
	elif (direction == -1):
		player_animations.play("runningleft")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		player_animations.play("idle")

	move_and_slide()
