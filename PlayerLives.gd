extends Label

var livesLeft = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Lives Left: %s" % livesLeft
	

func _on_player_health_life_lost(player, lives):
	livesLeft -= 1
