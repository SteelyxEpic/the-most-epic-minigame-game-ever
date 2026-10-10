extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer 
@onready var sound: AudioStreamPlayer2D = $Collected
@onready var planets: PackedScene = load("res://planets.tscn")
# ^^^ You dragged this in the scene by the way 


var needed = 3
var garlic_collected = 0 # just keeping track of garlic collected
var timer_end = false # boolean (true or false) stating whether the timer ended

func _ready() -> void:
	while Transtition.transtitioning:
		await get_tree().process_frame
	needed = randi_range(3, 3 + Global.minigames_done/2)
	for i in range(needed):
		var instance = planets.instantiate()
		instance.name = str(i)
		add_child(instance)
		instance.position = Vector2(randf_range(0, get_viewport_rect().size.x/1.5), randf_range(0, get_viewport_rect().size.y/1.5))
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
	Global.data["achieve"]["planets_collected"] += 1
	
	sound.play()
	garlic_collected = garlic_collected +1
	if garlic_collected == needed: # the double equals is just an argument asking if it's the same, with "=" it'll give an error
			themed_timer.cont = false
			await wait(1/Global.speed)
			Transtition.trans("level_scene") # go back to the intermission scene
	return
