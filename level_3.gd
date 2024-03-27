extends Node3D

@export var player: PackedScene
#@export var enemy_1: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var p = player.instantiate()
	$Camera3D.player = p
	add_child(p)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
