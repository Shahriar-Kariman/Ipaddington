extends Node3D
var bossHealth = 4
var sniperArray = ["EnemySniper","EnemySniper2","EnemySniper3","EnemySniper4"]
var EnemyGunToShoot = sniperArray.pick_random() 
var dead = false
var BossDeathSoundPlayed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if EnemyGunToShoot == "EnemySniper":
			$EnemySpotLight.position = Vector3($EnemySniper.position.x, 20, $EnemySniper.position.z)
	elif EnemyGunToShoot == "EnemySniper2" :
			$EnemySpotLight.position = Vector3($EnemySniper2.position.x, 20, $EnemySniper2.position.z)
	elif EnemyGunToShoot == "EnemySniper3":
			$EnemySpotLight.position = Vector3($EnemySniper3.position.x, 20, $EnemySniper3.position.z)
	elif EnemyGunToShoot == "EnemySniper4":
			$EnemySpotLight.position = Vector3($EnemySniper4.position.x, 20, $EnemySniper4.position.z)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sniperArray.is_empty() and !dead:
		$Boss/BossDeath.play()
		dead = true
		$Boss.dead = true
		$Boss/Dying.start()
		$Camera3D.bossDead = true
		$Camera3D.speed = 1

func _on_timer_timeout():
	if !sniperArray.is_empty():
		if EnemyGunToShoot == "EnemySniper" and $EnemySniper.visible:
			$EnemySpotLight.position = Vector3($EnemySniper.position.x, 20, $EnemySniper.position.z)
			$EnemySniper.shoot()
		elif EnemyGunToShoot == "EnemySniper2" and $EnemySniper2.visible:
			$EnemySpotLight.position = Vector3($EnemySniper2.position.x, 20, $EnemySniper2.position.z)
			$EnemySniper2.shoot()
		elif EnemyGunToShoot == "EnemySniper3" and $EnemySniper3.visible:
			$EnemySpotLight.position = Vector3($EnemySniper3.position.x, 20, $EnemySniper3.position.z)
			$EnemySniper3.shoot()
		elif EnemyGunToShoot == "EnemySniper4" and $EnemySniper4.visible:
			$EnemySpotLight.position = Vector3($EnemySniper4.position.x, 20, $EnemySniper4.position.z)
			$EnemySniper4.shoot()
		EnemyGunToShoot = sniperArray.pick_random() 

func on_sniper_dead(sniper):
	var index = sniperArray.find(sniper.name)
	if sniper.name == "EnemySniper":
		sniperArray.remove_at(index)
	elif sniper.name == "EnemySniper2":
		sniperArray.remove_at(index)
	elif sniper.name == "EnemySniper3":
		sniperArray.remove_at(index)
	elif sniper.name == "EnemySniper4":
		sniperArray.remove_at(index)
	bossHealth -= 1

func _on_boss_death_finished():
	$Boss/BossDeath.play()
	if BossDeathSoundPlayed:
		get_tree().change_scene_to_file("res://level_3.tscn")
	BossDeathSoundPlayed = true


func _on_player_player_dead(player):
	get_tree().change_scene_to_file("res://level_1.tscn")
