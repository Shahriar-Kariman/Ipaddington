extends CharacterBody3D

@export var projectile: PackedScene
var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var bulletSpeed = 25
const clipSize = 10
var bulletsLeft = 10
var health = 3
var lives = 3
signal playerHit
signal playerDead
signal playerLifeLost
signal playerShoot
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var camera: Camera3D
var rayOrigin = Vector3()
var rayEnd = Vector3()

func _ready():
	pass#bulletsLeft = clipSize
	
func _physics_process(delta):
	if health == 0:
		health = 3
		lives -= 1
		playerLifeLost.emit(self, lives)
		$PlayerDeath.play()
	if lives == 0:
		playerDead.emit(self)
		lives = -1
		
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("move_run"):
		SPEED = 10
	if Input.is_action_just_released("move_run"):
		SPEED = 5
	if Input.is_action_just_pressed("gun_shoot") and bulletsLeft>0:
		shoot()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	#func _physics_process(delta):
	#...

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node.
		#$pivot.basis = Basis.looking_at(direction)
	
	# Ray casting stuff
	var space_state = get_world_3d().direct_space_state
	
	# position of the mouse
	var mouse_position = get_viewport().get_mouse_position()
	
	rayOrigin = camera.project_ray_origin(mouse_position)
	rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 1000
	
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	
	var intersection = space_state.intersect_ray(query)
	
	if not intersection.is_empty():
		var pos = intersection.position
		$pivot.look_at(Vector3(pos.x, position.y, pos.z))
		rotation.x = 0
		rotation.z = 0
	
	move_and_slide()
	handleCollisions()

func shoot():
	var bullet = projectile.instantiate()
	bullet.position = position
	bullet.rotation = get_node("pivot").rotation
	add_sibling(bullet)
	$GunShotSound.play()
	bulletsLeft -= 1
	playerShoot.emit()

#Immunity frames, handle enemy collisions
func handleCollisions():
	if $Immunity.is_stopped() or $Immunity.time_left == 0 :
		for index in range(get_slide_collision_count()):
			var collision = get_slide_collision(index)
			if collision.get_collider() == null:
				continue
			if collision.get_collider().is_in_group("Enemy"):
				health -= 1
				$PlayerHit.play()
				playerHit.emit(health)
				$Immunity.start()
				break
func _reload():
	bulletsLeft = clipSize
	$Reload.play()



func _on_player_area_entered(area):
	if area.is_in_group("EnemyBullet"):
		health -= 1
		area.queue_free()
		$PlayerHit.play()
		playerHit.emit(health)
