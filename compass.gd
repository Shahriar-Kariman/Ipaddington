extends Node2D

@export var player: CharacterBody3D
@export var enemies: Array[CharacterBody3D]
@export var terminals: Array[Node3D]

var enemey_icon
var multi_mesh_enemy
var terminal_icon
var multi_mesh_terminal

var screen_size
var center

# Called when the node enters the scene tree for the first time.
func _ready():
	enemey_icon = $Godot_Icon
	multi_mesh_enemy = $enemies_MultiMeshInstance2D.multimesh
	multi_mesh_enemy.mesh = enemey_icon.mesh
	multi_mesh_enemy.instance_count = enemies.size()
	terminal_icon = $Terminal
	multi_mesh_terminal = $terminals_MultiMeshInstance2D.multimesh
	multi_mesh_terminal.mesh = terminal_icon.mesh
	multi_mesh_terminal.instance_count = terminals.size()
	
	screen_size = get_viewport_rect().size
	center = Vector2(screen_size.x/2,screen_size.y/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	multi_mesh_enemy.instance_count = enemies.size()
	_place_enemy_markers()
	multi_mesh_terminal.instance_count = terminals.size()
	_place_terminal_markers()
	_arrow_rotation()

func _place_enemy_markers():
	var index = 0
	for i in multi_mesh_enemy.instance_count:
		var v = Vector2(enemies[index].global_position.x, enemies[index].global_position.z) - Vector2(player.global_position.x, player.global_position.z)
		index += 1
		v = v.normalized()
		var pos = center + v * 260
		var sk = 0.0
		var rot = 0.0
		var sc = Vector2(0.3,0.3)
		var t = Transform2D(rot, sc, sk, pos)
		multi_mesh_enemy.set_instance_transform_2d(i, t)

func _place_terminal_markers():
	var index = 0
	for i in multi_mesh_terminal.instance_count:
		var v = Vector2(terminals[index].global_position.x, terminals[index].global_position.z) - Vector2(player.global_position.x, player.global_position.z)
		index += 1
		v = v.normalized()
		var pos = center + v * 260
		var sk = 0.0
		var rot = 0.0
		var sc = Vector2(0.5,0.5)
		var t = Transform2D(rot, sc, sk, pos)
		multi_mesh_terminal.set_instance_transform_2d(i, t)

func _arrow_rotation():
	$Arrow.rotation = -player.rotation.y - PI/2
