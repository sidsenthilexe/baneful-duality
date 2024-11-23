extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	if (direction == 1):
		anim.play("running")
	elif (direction == -1):
			anim.play("runningleft")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")

	move_and_slide()
