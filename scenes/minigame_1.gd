extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer 
@onready var sound: AudioStreamPlayer2D = $Collected
# ^^^ You dragged this in the scene by the way 



var garlic_collected = 0 # just keeping track of garlic collected
var timer_end = false # boolean (true or false) stating whether the timer ended

func _ready() -> void:

		#Below you can see that I have a function that I named. I grab a 
		#function from it that was created in it's script and use `await` to 
		# tell the script to wait for a signal, or for when a function finshes


	await themed_timer.Timer(10.0) #accessing a function from this node
	#after this is compeleted...
	timer_end = true # now we're saying "oh ye you ran out of time"

func _process(delta: float) -> void: # running every frame brochacho
	
	if garlic_collected == 3: # the double equals is just an argument asking if it's the same, with "=" it'll give an error
			get_tree().change_scene_to_file("res://scenes/level_scene.tscn") # go back to the intermission scene
	
	if timer_end: # if the timer does end...
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		get_tree().change_scene_to_file("res://scenes/level_scene.tscn") # back to intermission
		



func _on_planets_collected() -> void:
	print("collected!")
	sound.play()
	garlic_collected = garlic_collected +1
	return
