extends Area3D
var velocity = Vector3(1,0,1)
var speed = 25


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0,0,-speed)* delta
	if position.z > 10.5 or position.z < -10.5:
		queue_free()
	elif position.x > 15.5 or position.x < -15.5:
		queue_free()
		
func _on_timer_timeout():
	queue_free()

