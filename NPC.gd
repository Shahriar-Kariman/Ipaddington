extends CharacterBody3D
const speed = 5
var current_state = IDLE
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
	print(position)
		
	match current_state:
		IDLE:
			pass
		NEW_DIR:
			direction = choose([Vector3.RIGHT,Vector3.FORWARD, Vector3.BACK,Vector3.LEFT])
		MOVE:
			move(delta)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -=gravity *delta
		
func move (delta):
	position += direction *speed *delta 
	
	#ADD Boundaries
	#if position.x >= start_pos.x +20:
	#	position.x =  start_pos.x +18
	
func choose (array):
	array.shuffle()
	return array.front()

func _on_timer_timeout():
	$Timer.wait_time = choose ([0.5,1,1.5]) 
	current_state = choose([IDLE,NEW_DIR,MOVE])
