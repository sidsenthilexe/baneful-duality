extends CharacterBody2D

@onready var player_animations: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("move_up") and is_on_floor():
		velocity.y = 0.7 * JUMP_VELOCITY
		
	if (Input.is_action_just_pressed("double_jump")) and is_on_floor():
		velocity.y = 0.7 * JUMP_VELOCITY
		$double_jump_timer.start()

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


func _on_double_jump_timer_timeout():
	velocity.y = 0.5 * JUMP_VELOCITY
	$double_jump_timer.stop()
