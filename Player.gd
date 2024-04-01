extends CharacterBody3D

@export var projectile: PackedScene
var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var bulletSpeed = 25
const clipSize = 10
var bulletsLeft = 0
var health = 3
signal playerHit
signal playerDead
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var camera: Camera3D
var rayOrigin = Vector3()
var rayEnd = Vector3()

func _ready():
	bulletsLeft = clipSize
	
func _physics_process(delta):
	if health == 0:
		playerDead.emit()
		
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("move_run"):
		SPEED = 10
	if Input.is_action_just_released("move_run"):
		SPEED = 5
	if Input.is_action_just_pressed("gun_shoot"):
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
		look_at(pos)
	
	move_and_slide()

func shoot():
	var bullet = projectile.instantiate()
	add_sibling(bullet)
	bullet.position = position
	bullet.rotation = $pivot.rotation

func _on_area_3d_area_entered(area):
	if area.name == "Enemy":
		health -= 1
		playerHit.emit()
