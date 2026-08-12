extends Node2D
@onready var Lives_container: HBoxContainer = $Lives
@onready var life: TextureRect = $Lives/life1
@onready var life_2: TextureRect = $Lives/life2
@onready var life_3: TextureRect = $Lives/life3
@onready var life_4: TextureRect = $Lives/life4
@onready var life_5: TextureRect = $Lives/life5
@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer
@onready var camera:Camera2D = $Camera2D
@onready var crack:AudioStreamPlayer2D = $crack
@onready var broken:Texture2D = load("res://broken.png") as Texture2D


var time

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	await get_tree().process_frame
	match Global.lives: # asks or checks if lives is equal to one of 
#these values, cool hack. by the way this is a horrid way to illustrate the 
#lives visually so later you can always find alternative code. Now, dw abt it.

		4:
			if Global.lost:
				await shake(life)
			else:
				life.texture = broken
		3:
			life.texture = broken
			if Global.lost:
				await shake(life_2)
			else:
				life_2.texture = broken
		2:
			life.texture = broken
			life_2.texture = broken
			if Global.lost:
				await shake(life_3)
			else:
				life_3.texture = broken
		1:
			life.texture = broken
			life_2.texture = broken
			life_3.texture = broken
			if Global.lost:
				await shake(life_4)
			else:
				life_4.texture = broken
		0:
			life.texture = broken
			life_2.texture = broken
			life_3.texture = broken
			life_4.texture = broken
			if Global.lost:
				await shake(life_5)
				
			else:
				life_5.texture = broken
	
	 # make ths text reflect the value of the time variable. this makes names easier. the str() converts the int to a String
	level.text = "Level " + str(Global.minigames_done + 1) # this tells you want minigame you're on using concatenation (google the word yo)
	
	if Global.lives > 0:
		if Global.minigames_done < Global.minigames_doing: # if you havent completed 3 minigames yet 
			await Timer(5.0 / Global.speed) # using the function created
			Global.minigames_done = Global.minigames_done +1
			get_tree().change_scene_to_file("res://scenes/minigame_" + str(rng.randi_range(1, 2)) + ".tscn") # changes your scene by arranging this frankenstein path. 
	# Above, your script is being told to go to the next minigame. If the 
	# current minigame is Level 1, then you would be on minigame 1. If you 
	# complete that level, you have the minigames_done add one, and then you 
	# look for the scene titled `minigame_` and then whatever minigame number 
	# should be next. Make sure you name your minigame saves appropriately.

		else:
			get_tree().change_scene_to_file("res://scenes/win.tscn") # changes your scene


func shake(lives: TextureRect):
	var center =lives.get_global_rect().get_center()
	await camera.zoomin(center)
	await wait(1)
	if !crack.playing && Global.lost:
		crack.play()
	lives.texture = broken
	Global.lost = false
	await wait(0.5)
	await camera.zoomout()
	if Global.lives == 0:
		get_tree().change_scene_to_file("res://scenes/lose.tscn")
	
func Timer(start_time: float): # making a new function for timer countdown!
	# we want the timer to go down, and when it reaches 0 it transitions 
	# to the next scene!
	
	time = roundi(start_time*10)/10 # make the timer, which is reflected through the timer text, start at your desired number
	
	while time > 0.0: # run if timer hasnt reached 0
		await wait(0.1) # asks script to wait on this function. the 'wait' name for the function does nothing here, as await is just telling the scrpit to wait for the function to complete before progressing
		time -= 0.1 # remove 0.1
		timer.text = str(time)
		# progressively get the value smaller and smaller
	
	#when timer reaches 0
	return

func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout # makes u wait, dw abt this being complex '''
