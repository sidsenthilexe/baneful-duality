extends CharacterBody2D

@onready var player_animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var main_reference = load("res://main/main.tscn")
@onready var Bullet = preload("res://bullet/bullet.tscn")
var possession_boolean = false

var slide_check=0
var player_health = 0
var possession_start=false
var move_array = []
var last_moves_array = []
var speed = 275.0
const JUMP_VELOCITY = -400.0
var double_jump_count = 0
var possession_generator = RandomNumberGenerator.new()
var possession_chances = 0;

func play_pos_anim():
	player_animations.play("posession")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack") and possession_boolean==true:
		var bullet_instance = Bullet.instantiate()
		add_child(bullet_instance)
		bullet_instance.transform = $Marker2D.transform
	

func _physics_process(delta: float) -> void:
	if player_health == 5:
		$Camera2D/Control/health_bar.texture = ResourceLoader.load("res://art/health_full.png")
	if player_health == 4:
		$Camera2D/Control/health_bar.texture = ResourceLoader.load("res://art/health_80.png")
	if player_health == 3:
		$Camera2D/Control/health_bar.texture = ResourceLoader.load("res://art/health_60.png")
	if player_health == 2:
		$Camera2D/Control/health_bar.texture = ResourceLoader.load("res://art/health_40.png")
	if player_health == 1:
		$Camera2D/Control/health_bar.texture = ResourceLoader.load("res://art/health_20.png")
	if player_health == 0:
		$Camera2D/Control/health_bar.texture = ResourceLoader.load("res://art/health_0.png")
	
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
	if Input.is_action_pressed("move_up") and is_on_floor() and possession_boolean==false:
		player_animations.play("jumping")
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY*0.95
		move_array.append("2")
	if Input.is_action_just_pressed("move_up") and not is_on_floor() and double_jump_count == 0:
		double_jump_count += 1
		velocity.y = JUMP_VELOCITY*0.95

	
	

	if possession_boolean==true:
		speed=175.00
	if possession_boolean==false:
		speed=270.00

	var direction := Input.get_axis("move_left", "move_right")
	if direction:	
		velocity.x = direction * speed
	if (direction == 1):
		if possession_boolean==false:
			player_animations.play("running")
		if possession_boolean==true:
			player_animations.play("posessionrunright")
		move_array.append("1")
	elif (direction == -1):
		if possession_boolean==false:
			player_animations.play("runningleft")
		if possession_boolean==true:
			player_animations.play("posessionrunleft")
		move_array.append("-1")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# if Input.is_action_pressed("move_down"):
	# 	print(slide_check)
	# 	if slide_check == 0:
	# 		if direction == 1:
	# 			player_animations.play("sliding")
	# 		elif direction == -1:
	# 			player_animations.play("slidingleft")
	# 		velocity.x = 1.5 * direction * SPEED
	# 		# wait(10000)
	# 		# slide_check=1
	# 	if slide_check == 1:	
	# 		pass
			
			
#cave 1 possession
	if position.x>=15460 and position.x<=15600:
		position.x=15700
		position.y=100
		possession_boolean=true
		
		play_pos_anim()
	if position.x>=21160 and position.x<=21170:
		position.x=21300
		position.y=238
		possession_boolean=false
	print(position.x)
	print(position.y)

#cave 2 possession
	if position.x>=25340 and position.x<=25600:
		position.x=25600
		position.y=260
		possession_boolean=true
		
		play_pos_anim()
	if position.x>=34200 and position.x<=34200:
		position.x=34500
		position.y=-11
		possession_boolean=false

	#if possession_chances > 9900 and possession_chances < 9975:
		#for e in last_moves_array:
			#if e == "1":
				#player_animations.play("running")
				#velocity.x = 7 * SPEED
			#elif e == "-1":
				#player_animations.play("runningleft")
				#velocity.x = -7 * SPEED
			#elif e == "2":
				#velocity.y = 1.12 * JUMP_VELOCITY
		# move_array.clear()
		# last_moves_array.clear()
		
	if not is_on_floor() and Input.is_action_pressed("move_up") and possession_boolean==false:
		player_animations.play("jumping")
	if is_on_floor() and velocity.x == 0:
		if possession_boolean==false:
			player_animations.play("idle")
		if possession_boolean==true:
			player_animations.play("posessionidle")
	
	if player_health <= 0:
		player_health = 5
		position.x = 255
		position.y = 189

		

	move_and_slide()
	
func _on_area_2d_body_entered(body):
	if body.name.begins_with("mob"):
			player_health -= 1
