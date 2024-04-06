extends Control
#My Test _Sara
# Called when the node enters the scene tree for the first time.
func _ready():
	# One-time steps.
	# Pick a voice. Here, we arbitrarily pick the first English voice.
	var long_message = "In the year 3024, you find yourself waking up in a dark maze in Ipaddington, 
	feeling puzzled about where your iPad went. As you walk through the maze, you hear the whirring of mechanical footsteps approaching. 
	Godot bots, robot enemies programmed to destroy you, emerge from the shadows. 
	They're relentless, and you know you'll have to fight to survive. But there's a surprising twist, a friendly yellow robot offers you chicken nuggets.You decide to munch on the chicken nuggets to keep your energy up. 
	With each nugget you eat, you feel more determined to find your iPad. To move on to the next level and locate your lost device, you need to eat five nuggets. 
	The maze stays the same, but the chicken nuggets pickables move around, making it tricky to find them. 
	Meanwhile, the Godot bots keep coming back, even after you've defeated them. But you're not deterred. With your trusty gun in hand and the memory of those tasty chicken nuggets driving you forward, you're determined to succeed. 
	As you navigate the maze, you stumble upon GPT terminals scattered around. 
	These terminals help you reload your gun ammo, ensuring you're always ready to face the Godot bots. 
	With each reload, you feel more prepared to tackle the challenges ahead.Armed with your gun, fueled by chicken nuggets, and supported by the GPT terminals, you press on. 
	You're ready to face whatever challenges come your way and reclaim your missing iPad in level two."
	$Narration.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("skip"):
		$Narration.stop()
		$Narration2.stop()
		$Narration3.stop()
		$Narration4.stop()
		$Narration5.stop()
		$Narration6.stop()
		$Narration7.stop()
		$NarrationControl.visible = false
		$StartMenu.visible = true
		
func _on_exit_button_pressed():
	get_tree().quit()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn")

func _on_narration_finished():
	$Narration2.play()

func _on_narration_2_finished():
	$Narration3.play()

func _on_narration_3_finished():
	$Narration4.play()

func _on_narration_4_finished():
	$Narration5.play()

func _on_narration_5_finished():
	$Narration6.play()

func _on_narration_6_finished():
	$Narration7.play()
