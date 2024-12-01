extends Node2D

@onready var possessionplayer = $possessionbecome
@onready var timer = $animtimer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	possessionplayer.play()


func _on_timer_timeout():
	Global.possession_counter += 1
	get_tree().change_scene_to_file("res://main/main.tscn")
	
