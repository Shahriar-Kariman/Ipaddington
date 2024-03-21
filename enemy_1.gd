extends CharacterBody3D
var random

var SPEED = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	random = randi_range(1,4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if random == 1:
		velocity.x +=1	
	if random == 2:
		velocity.y -=1	
	if random == 3:
		velocity.z +=1	
	if random == 4:
		velocity.z -=1	

	velocity = velocity.normalized()* SPEED
	position += velocity *delta
		
	move_and_slide()

