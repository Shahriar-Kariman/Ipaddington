extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = randi_range(-150/2,150/2)
	position.z = randi_range(-100/2,100/2)
	var n = randf_range(-1,1)
	if n<0:
		rotate_y(PI/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
