extends Node2D
const title_scene = preload("res://title/title.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_audio_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://title/title.tscn")



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://title/title.tscn")
