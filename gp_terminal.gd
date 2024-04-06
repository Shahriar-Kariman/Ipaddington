extends Node3D
signal reload
var inReloadZone = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("reload"):
		if inReloadZone:
			reload.emit()


func _on_terminal_area_body_entered(body):
	if body.name == "Player":
		inReloadZone = true


func _on_terminal_area_body_exited(body):
	if body.name == "Player":
		inReloadZone = false
