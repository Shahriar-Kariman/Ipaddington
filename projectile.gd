extends Area3D
var velocity = Vector3(1,0,1)
var speed = 25


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0,0,-speed)* delta

func _on_timer_timeout():
	queue_free()



func _on_body_entered(body):
	if body.is_in_group("Wall"):
		queue_free()
	
