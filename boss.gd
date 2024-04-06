extends CharacterBody3D


func _physics_process(delta):
	get_node("pivot/SpotLight3D2").look_at($"../Player".position)
	get_node("pivot/SpotLight3D").look_at($"../Player".position)
	get_node("pivot").look_at(Vector3($"../Player".position.x, position.y, $"../Player".position.z))
