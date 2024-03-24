extends CharacterBody3D

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@export var player: CharacterBody3D

var direction = Vector3.ZERO

var SPEED = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	#await get_tree().process_frame
	player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	nav.target_position = player.position
	
	direction = nav.get_next_path_position() - global_position
	print(direction)
	
	velocity += direction

	velocity = velocity.normalized()* SPEED * delta
	
	position += velocity
	
	move_and_slide()

