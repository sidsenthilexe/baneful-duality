extends CharacterBody2D

@onready var player_animations: AnimatedSprite2D = $AnimatedSprite2D

var move_array = []
var last_moves_array = []
const SPEED = 275.0
const JUMP_VELOCITY = -400.0
var double_jump_count = 0
var possession_generator = RandomNumberGenerator.new()
var possession_chances = 0;
func _physics_process(delta: float) -> void:
	if move_array.size() > 3:
		move_array.erase(0)
	for i in move_array:
		if not last_moves_array.has(i):
			last_moves_array.append(i)
	last_moves_array.reverse()
	possession_chances = possession_generator.randi_range(1, 10000)
	if is_on_floor():
		double_jump_count = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		move_array.append("2")
	if Input.is_action_just_pressed("move_up") and not is_on_floor() and double_jump_count == 0:
		double_jump_count += 1
		velocity.y = JUMP_VELOCITY
				
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	if (direction == 1):
		player_animations.play("running")
		move_array.append("1")
	elif (direction == -1):
		player_animations.play("runningleft")
		move_array.append("-1")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		player_animations.play("idle")
	if possession_chances > 9900 and possession_chances < 9975:
		for e in last_moves_array:
			if e == "1":
				player_animations.play("running")
				velocity.x = 7 * SPEED
			elif e == "-1":
				player_animations.play("runningleft")
				velocity.x = -7 * SPEED
			elif e == "2":
				velocity.y = 1.12 * JUMP_VELOCITY
		move_array.clear()
		last_moves_array.clear()
		
	move_and_slide()
