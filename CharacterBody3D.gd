extends CharacterBody3D
signal enemy_shoot
@export var inPlayerRange: bool

func _ready():
	$ShootTimer.autostart = false
	inPlayerRange = false
	

func _process(delta):
	pass

func _physics_process(delta):
	if inPlayerRange:
		$ShootTimer.start()
	else:
		#moveRandomly()
		pass



func _on_shoot_timer_timeout():
	enemy_shoot.emit()


func _on_enemy_sniper_area_area_entered(area):
	if area.name == "SpotlightArea":
		inPlayerRange = true
		
func moveRandomly():
	pass
