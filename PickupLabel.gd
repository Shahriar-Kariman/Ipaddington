extends Label

var pickupsCaught = 0
const PICKUPS_TO_WIN = 3
signal level1Won
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Pickups Left: %s" % (PICKUPS_TO_WIN-pickupsCaught)
	if pickupsCaught == PICKUPS_TO_WIN:
		level1Won.emit()
		get_tree().change_scene_to_file("res://level_2.tscn")


func _on_pickup_caught_pickup():
	pickupsCaught += 1
