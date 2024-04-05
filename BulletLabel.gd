extends Label

var bulletsLeft = 10
const clipSize = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Bullets Left: %s" % bulletsLeft

func playerShoot():
	bulletsLeft -= 1
	
func reload():
	bulletsLeft = clipSize
