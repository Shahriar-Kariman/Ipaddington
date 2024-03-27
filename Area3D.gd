extends Area3D
@export var inReloadZone: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	inReloadZone = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		inReloadZone = true
		


func _on_body_exited(body):
	if body.name == "Player":
		inReloadZone = false
