extends Node

@export var pickupTemplate: PackedScene
@export var player: PackedScene
@export var enemy_1: PackedScene
@export var wall: PackedScene
var pickupsLeft = 0
const PICKUPS_TO_WIN = 5

var spawnPoints: Array[Marker3D]
var walls: Array[SceneTree]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	spawnPoints = [ $EnemySpawnPoint_1, $EnemySpawnPoint_2, $EnemySpawnPoint_3, $EnemySpawnPoint_4 ]
	$GPTerminal_1.reload.connect($UserInterface/BulletLabel.reload)
	var compass = $CanvasLayer/minimap
	var p = player.instantiate()
	
	#spawn player
	on_player_respawn(p, 0)
	$Camera3D.player = p
	p.camera = $Camera3D
	compass.player = p
	
	#terminal reload signals
	$GPTerminal_1.reload.connect(p._reload)
	$GPTerminal_2.reload.connect(p._reload)
	$GPTerminal_1.reload.connect($UserInterface/BulletLabel.reload)
	$GPTerminal_2.reload.connect($UserInterface/BulletLabel.reload)
	
	#player dying signals
	p.playerHit.connect($UserInterface/PlayerHealth.on_player_hit)
	p.playerShoot.connect($UserInterface/BulletLabel.playerShoot)
	#p.playerLifeLost.connect($UserInterface/PlayerLives.on_life_lost)
	p.playerLifeLost.connect(self.on_player_respawn)
	p.playerDead.connect(self.on_player_dead)
	add_child(p)
	
	#enemy spawn points
	for sp in spawnPoints:
		var e = enemy_1.instantiate()
		e.enemyDead.connect(self.on_enemy_dead)
		e.player = p
		e.position.x = sp.position.x
		e.position.z = sp.position.z
		compass.enemies.append(e)
		add_child(e)
	compass.terminals.append($GPTerminal_1)
	compass.terminals.append($GPTerminal_2)

# not really used any more
func _generate_maze():
	for i in 50:
		var w = wall.instantiate()
		walls.push_back(w)
		add_child(w)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_pickup_caught_pickup():
	$OnPickup.play()
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

func on_enemy_dead(from):
	var rand_index = randf_range(0,4)
	from.position.x = spawnPoints[rand_index].position.x
	from.position.z = spawnPoints[rand_index].position.z
	
func on_player_respawn(player,health):
	player.position.x = $StartPoint.position.x
	player.position.z = $StartPoint.position.z
	
func on_player_dead():
	get_tree().reload_current_scene()
