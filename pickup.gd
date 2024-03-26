extends Node3D

signal caught_Pickup
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_object_local(Vector3.UP, deg_to_rad(90)*delta)


func _on_pickup_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
		caught_Pickup.emit()
		print("At Pickup")
