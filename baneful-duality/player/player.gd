extends CharacterBody2D

@onready var player_animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var main_reference = load("res://main/main.tscn")
@onready var Bullet : PackedScene = preload("res://bullet/bullet.tscn")
@onready var m2d: Marker2D = $Marker2D
@onready var walk = $AudioStreamPlayer2D
@onready var song1 = $song1
@onready var song2 = $song2
@onready var song3 = $song3
var possession_counter = 0
var slide_check=0
var player_health =5 
var possession_start=false
var move_array = []
var last_moves_array = []
var speed = 150
const JUMP_VELOCITY = -325.0
var double_jump_count = 0
var possession_generator = RandomNumberGenerator.new()


func play_pos_anim():
	player_animations.play("posession")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	
	
	if velocity.x != 0 and is_on_floor():
		if !walk.playing:
			walk.play()
	elif walk.playing:
		walk.stop()
	
	
	if (position.x <= 500 and position.y < 400 and Global.possession_counter == 1):
		position.x = 15700
		position.y = 100
	
	elif (position.x <= 500 and position.y < 400 and Global.possession_counter == 2):
		position.x = 25600
		position.y = 260
	
	Global.player_positionx = position.x
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
	if is_on_floor():
		double_jump_count = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("move_up") and is_on_floor() and Global.possession_bool==false:
		player_animations.play("jumping")
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY*0.95
		move_array.append("2")
	if Input.is_action_just_pressed("move_up") and not is_on_floor() and double_jump_count == 0:
		double_jump_count += 1
		velocity.y = JUMP_VELOCITY*0.95
	#if Input.is_action_just_pressed("attack") and possession_boolean==true:
		#print("shot fired")
		#var bullet_instance = Bullet.instantiate()
		#print(get_parent())
		#get_parent().add_child(bullet_instance)
		#bullet_instance.transform = $Marker2D.transform


	if Input.is_action_just_pressed("attack") and Global.player_positionx >= 36137 and Global.player_positionx <= 36414:
		if Global.score <= 3:
			get_tree().change_scene_to_file("res://win.tscn")
			
	if Input.is_action_just_pressed("attack") and Global.player_positionx >= 36137 and Global.player_positionx <= 36414:
		if Global.score > 3:
			get_tree().change_scene_to_file("res://lose.tscn")
	
	if Global.possession_bool==true:
		speed=150
	if Global.possession_bool==false:
		speed=275

	var direction := Input.get_axis("move_left", "move_right")
	if direction:	
		velocity.x = direction * speed
	if (direction == 1):
		Global.player_direction = 1
		if Global.possession_bool==false:
			player_animations.play("running")
		if Global.possession_bool==true:
			player_animations.play("posessionrunright")
		move_array.append("1")
	elif (direction == -1):
		Global.player_direction = -1
		if Global.possession_bool==false:
			player_animations.play("runningleft")
		if Global.possession_bool==true:
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
		Global.health = player_health
		get_tree().change_scene_to_file("res://posscene.tscn")
		position.x=15700
		position.y=100
		Global.possession_bool=true
		song1.stop()
		song2.play()
	
	if position.x > 15600 and position.x < 15700:
		position.x = 15700
		
	if position.x>=21160 and position.x<=21170:
		position.x=21300
		position.y=238
		Global.possession_bool=false
	#print(position.x)
	#print(position.y)

#cave 2 possession
	if position.x>=25340 and position.x<=25500:
		Global.health=player_health
		get_tree().change_scene_to_file("res://posscene.tscn")
		position.x=25600
		position.y=260
		Global.possession_bool=true
		song2.stop()
		song3.play()
	if position.x > 25500 and position.x < 25600:
		position.x = 25600
		
	if position.x>=34200 and position.x<=34200:
		position.x=34500
		position.y=-11
		Global.possession_bool=false

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
		
	if not is_on_floor() and Input.is_action_pressed("move_up") and Global.possession_bool==false:
		player_animations.play("jumping")
	if is_on_floor() and velocity.x == 0:
		if Global.possession_bool==false:
			player_animations.play("idle")
		if Global.possession_bool==true:
			player_animations.play("posessionidle")
	
	if player_health <= 0:
		get_tree().change_scene_to_file("res://title/title.tscn")

		

	move_and_slide()
	
func _on_area_2d_body_entered(body):
	if body.name.begins_with("mob"):
			player_health -= 1
			speed=0
