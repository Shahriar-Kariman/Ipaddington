extends Label

var healthLeft = "♡ ♡ ♡"
signal lifeLost
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "%s" % healthLeft
	
func on_player_hit(health):
	if health == 3:
		healthLeft = "♡ ♡ ♡"
	elif health == 2:
		healthLeft = "♡ ♡"
	elif health == 1:
		healthLeft = "♡"
	elif health == 0:
		healthLeft = "♡ ♡ ♡"
		lifeLost.emit()
	
	
