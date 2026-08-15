extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer 
@onready var sound: AudioStreamPlayer2D = $Collected
# ^^^ You dragged this in the scene by the way 



var garlic_collected = 0 # just keeping track of garlic collected
var timer_end = false # boolean (true or false) stating whether the timer ended

func _ready() -> void:
	while Transtition.transtitioning:
		await get_tree().process_frame
	await themed_timer.Timer(10.0 / Global.speed) #accessing a function from this node
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene") # back to intermission

		


func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout # makes u wait
func _on_planets_collected() -> void:
	print("collected!")
	sound.play()
	garlic_collected = garlic_collected +1
	if garlic_collected == 3: # the double equals is just an argument asking if it's the same, with "=" it'll give an error
			themed_timer.cont = false
			await wait(1/Global.speed)
			Transtition.trans("level_scene") # go back to the intermission scene
	return
