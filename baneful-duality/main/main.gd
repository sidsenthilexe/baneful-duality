extends Node2D
@onready var player = $CharacterBody2D
const Bullet = preload("res://bullet/bullet.tscn")
var bullet_instance
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Engine.set_physics_ticks_per_second(60)
	if Input.is_action_just_pressed("attack") and Global.possession_bool == true:
		bullet_instance = Bullet.instantiate()
		add_child(bullet_instance)
		bullet_instance.position.x = player.position.x
		bullet_instance.position.y = player.position.y+12
