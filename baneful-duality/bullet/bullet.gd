extends Area2D

@onready var timer = $Timer

var speed = 750

var bullet_direction = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	bullet_direction = Global.player_direction
	visible = true
	timer.start()
	position += transform.x*speed*delta*bullet_direction


func _on_body_entered(body):
	if body.name.begins_with("mob"):
		body.queue_free()
		queue_free()
	if body.name.begins_with("Tiles"):
		queue_free()


func _on_timer_timeout():
	print("test")
	visible = false
