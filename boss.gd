extends CharacterBody3D
var dead = false
var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(0.0, 0.0, 1.0, 0.0)]
var speed = 4
var spotlightGrowth = 5
func _ready():
	dead = false
	
func _physics_process(delta):
	if !dead:
		get_node("pivot/SpotLight3D2").look_at($"../Player".position)
		get_node("pivot/SpotLight3D").look_at($"../Player".position)
		get_node("pivot").look_at(Vector3($"../Player".position.x, position.y, $"../Player".position.z))
	else:
		rotate_object_local(Vector3.UP, delta*speed)
		$"../SpotLight3D".spot_angle += spotlightGrowth*delta
		

func _on_dying_timeout():
	randomize()
	spotlightGrowth += 1.2
	speed *= 1.5
	var modulate = colors[randi() % colors.size()]
	var randomLook = Vector3(randi_range(-150,150), 0, randi_range(-75,75))
	$pivot/SpotLight3D2.light_color = modulate
	$pivot/SpotLight3D2.light_energy += 2
	$pivot/SpotLight3D.light_color = modulate
	$pivot/SpotLight3D.light_energy += 2
	$pivot/OmniLight3D.light_color = modulate
	$pivot/OmniLight3D.light_energy += 2
	$pivot/OmniLight3D.omni_range += 0.5
	$pivot/OmniLight3D2.light_color = modulate
	$pivot/OmniLight3D2.light_energy += 2
	$pivot/OmniLight3D2.omni_range += 0.5
	get_node("pivot/SpotLight3D2").look_at(randomLook)
	get_node("pivot/SpotLight3D").look_at(randomLook)
	#get_node("pivot").look_at(Vector3(randi_range(-90,90), position.y, randi_range(-60,60)))
	$Dying.start()
