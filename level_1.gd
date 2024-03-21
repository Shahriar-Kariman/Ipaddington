extends Node3D

@export var pickupTemplate: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_pickup_caught_pickup():
	var pickup = pickupTemplate.instantiate()
	#set position of enemy to randomly on the ground
	var groundSize = Vector3.ZERO
	groundSize.x = 30
	groundSize.y = 1
	groundSize.z = 20
	
	pickup.position.x = (randf() * groundSize.x) - groundSize.x/2
	pickup.position.z = (randf() * groundSize.z) - groundSize.z/2
	print(pickup.position.x )
	print(pickup.position.z)
	add_child(pickup) #adds as a child ourselves
	
