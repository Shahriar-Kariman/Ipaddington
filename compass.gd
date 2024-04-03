extends Node2D

@export var player: CharacterBody3D
@export var enemies: Array[CharacterBody3D]
@export var terminals: Array[PackedScene]

var enemey_icon
var multi_mesh

# Called when the node enters the scene tree for the first time.
func _ready():
	enemey_icon = $Godot_Icon
	multi_mesh = $MultiMeshInstance2D.multimesh
	multi_mesh.mesh = enemey_icon.mesh
	multi_mesh.instance_count = enemies.size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	multi_mesh.instance_count = enemies.size()
	_place_marker()

func _place_marker():
	#print(enemies.size())
	var screen_size = get_viewport_rect().size
	var center = Vector2(screen_size.x/2,screen_size.y/2)
	var index = 0
	for i in multi_mesh.instance_count:
		#var v = Vector2(randi_range(-3,3),randi_range(-3,3))
		var v = Vector2(enemies[index].global_position.x, enemies[index].global_position.z) - Vector2(player.global_position.x, player.global_position.z)
		index += 1
		v = v.normalized()
		var position = center + v * 260
		var skew = 0.0
		var rotation = 0.0
		var scale = Vector2(0.3,0.3)
		var t = Transform2D(rotation, scale, skew, position)
		multi_mesh.set_instance_transform_2d(i, t)
