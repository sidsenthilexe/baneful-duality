extends CharacterBody2D

@onready var check_ground = $checkGround
@onready var check_left = $checkLeft
@onready var check_right = $checkRight

@onready var mob_animations: AnimatedSprite2D = $AnimatedSprite2D




var mob_health = 5

var direction = 1

func _process(delta):
	if check_left.is_colliding():
		direction = 1
		mob_animations.play("walk")
	if check_right.is_colliding():
		direction = -1
		mob_animations.play("walk_left")
	
	await get_tree().create_timer(2).timeout
	velocity.y = position.y + 200 * delta
	position.x = position.x + direction * 75 * delta
	

	move_and_slide()
