extends Area2D

var speed = 750

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x*speed*delta
	


func _on_body_entered(body):
	if body.name.begins_with("mob"):
		body.queue_free()
	queue_free()
