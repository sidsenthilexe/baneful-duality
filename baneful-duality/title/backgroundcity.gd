extends Sprite2D

var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(position.x)
	position += -transform.x*speed*delta
	if position.x <= -600:
		position.x = 1907.2294921875
		
