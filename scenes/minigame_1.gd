extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer 
@onready var sound: AudioStreamPlayer2D = $Collected
@onready var planets: PackedScene = load("res://planets.tscn")
# ^^^ You dragged this in the scene by the way 

signal collected
signal collectedbad

var needed = 3
var garlic_collected = 0 # just keeping track of garlic collected
var timer_end = false # boolean (true or false) stating whether the timer ended

func _ready() -> void:
	collected.connect(_on_planets_collected)
	collectedbad.connect(_on_planets_collectedbad)
	needed = randi_range(3, 3 + Global.minigames_done/2)
	needed = round(needed * (2 if Global.difficulty == "Hell" else (1.5 if Global.difficulty == "Hard" else 1)))
	$remainder.text = str(needed) + " remaining"
	for i in range(needed):
		var instance = planets.instantiate()
		instance.name = str(i)
		instance.main = self
		add_child(instance)
		instance.position = Vector2(randf_range(0, get_viewport_rect().size.x/6.3)*4, randf_range(0, get_viewport_rect().size.y/6.3)*4)
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
	Global.data["achieve"]["planets_collected"] += 1
	
	sound.play()
	sound.pitch_scale += 0.25
	garlic_collected = garlic_collected +1
	$remainder.text = str(needed - garlic_collected) + " remaining"
	if garlic_collected == needed: # the double equals is just an argument asking if it's the same, with "=" it'll give an error
			themed_timer.cont = false
			await wait(1/Global.speed)
			Transtition.trans("level_scene") # go back to the intermission scene
	return

func _on_planets_collectedbad() -> void:
	print("collected the bad ones!")
	var temp = sound.pitch_scale
	sound.pitch_scale = 0.5
	sound.play()
	sound.pitch_scale = temp
	$Player.SPEED *= 0.75
	return
