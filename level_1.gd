extends Node3D

@export var pickupTemplate: PackedScene
@export var player: PackedScene
@export var enemy_1: PackedScene
@export var wall: PackedScene
var pickupsLeft = 0
const PICKUPS_TO_WIN = 5

var walls: Array[SceneTree]

# Called when the node enters the scene tree for the first time.
func _ready():
	#_generate_maze()
	var p = player.instantiate()
	p.position.x = $StartPoint.position.x
	p.position.z = $StartPoint.position.z
	$Camera3D.player = p
	add_child(p)
	var e = enemy_1.instantiate()
	e.player = p
	e.position.x = $EnemySpawnPoint_1.position.x
	e.position.z = $EnemySpawnPoint_1.position.z
	add_child(e)

func _generate_maze():
	for i in 50:
		var w = wall.instantiate()
		walls.push_back(w)
		add_child(w)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_pickup_caught_pickup():
	var pickup = pickupTemplate.instantiate()
	pickupsLeft += 1
	#set position of pickup to randomly on the ground
	var groundSize = Vector3.ZERO
	groundSize.x = 30
	groundSize.y = 1
	groundSize.z = 20
	
	pickup.position.x = (randf() * groundSize.x) - groundSize.x/2
	pickup.position.z = (randf() * groundSize.z) - groundSize.z/2
	pickup.caught_Pickup.connect(_on_pickup_caught_pickup)
	pickup.caught_Pickup.connect($UserInterface/PickupLabel._on_pickup_caught_pickup)
	print(pickup.position.x)
	print(pickup.position.z)
	add_child(pickup) #adds as a child ourselves
	
