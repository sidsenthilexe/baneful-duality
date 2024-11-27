extends Node2D
@onready var player = $CharacterBody2D
@onready var bullet = $Bullet
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack") and Global.possession_bool == true:
		bullet.position = player.position
