extends CharacterBody3D
signal enemy_shoot
@export var enemyBullet : PackedScene
var shooting : bool
var health = 5
signal enemySniperDead
func _ready():
	pass

func _process(delta):
	if health == 0:
		visible = false
		$"../SniperDeath".play()
		enemySniperDead.emit(self)
		health = -1
		#queue_free()

func _physics_process(delta):
	get_node("Pivot").look_at(Vector3($"../Player".position.x,position.y,$"../Player".position.z))

func shoot():
	var enemyShot = enemyBullet.instantiate()
	enemyShot.position = Vector3(position.x, 2, position.z)
	enemyShot.rotation = get_node("Pivot").rotation
	add_sibling(enemyShot)
	#$GunShotSound.play()
	enemy_shoot.emit()
	$Shoot.play()


func _on_enemy_sniper_area_area_entered(area):
	if area.is_in_group("Projectile"):
		health -= 1
		area.queue_free()
