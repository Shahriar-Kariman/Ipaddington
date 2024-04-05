extends CharacterBody3D

@onready var nav: NavigationAgent3D = $NavigationAgent3D

const speed = 5
var current_state = NEW_DIR
var direction = Vector3.RIGHT
var start_pos
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

enum { 
	IDLE,
	NEW_DIR,
	MOVE
}
	
func ready():
	randomize()
	start_pos = position

func _process(delta):
	match current_state:
		IDLE:
			pass
		NEW_DIR:
			var target = Vector3(randf_range(-100,100),2,randf_range(-100,100))
			nav.target_position = target
			current_state = NEW_DIR
		MOVE:
			move(delta)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -=gravity *delta

func move (delta):
	direction = nav.get_next_path_position() - global_position
	look_at(direction)
	rotation.x = 0
	rotation.z = 0
	
	velocity += direction

	velocity = velocity.normalized() * delta * speed
	
	position += velocity
	
	move_and_slide()

func choose (array):
	array.shuffle()
	return array.front()

func _on_timer_timeout():
	$Timer.wait_time = choose ([0.5,1,1.5]) 
	current_state = choose([IDLE,NEW_DIR,MOVE])

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		$NPCAdvice.play()
