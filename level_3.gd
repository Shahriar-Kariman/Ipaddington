extends Node3D

@export var player: PackedScene
#@export var enemy_1: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.bulletsLeft = 500


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
