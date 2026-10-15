extends Node2D
@onready var Lives_container: HBoxContainer = $Lives
@onready var lives: HBoxContainer = $Lives
@onready var level: RichTextLabel = $Level
@onready var camera:Camera2D = $Camera2D
@onready var crack:AudioStreamPlayer2D = $crack
@onready var particles:CPUParticles2D = $CPUParticles2D
@onready var broken:Texture2D = load("res://broken.png") as Texture2D
@onready var bg: TextureRect = $bg
@onready var coin: Node2D = $coin
@onready var slide: TextureRect = $slide


var time

func _ready() -> void:
	Global.save()
	coin.get_node("RichTextLabel").text = "x"+str(Global.data["coins"])
	bg.texture = Global.backgrounds[Global.gamemode]
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	await get_tree().process_frame
	level.text = "Level " + str(Global.minigames_done + 1) 
	for i in range(4 - Global.lives if Global.lost else 5 - Global.lives):
		lives.get_child(i).texture = broken
	if Global.lost:
		await shake(lives.get_child(4 - Global.lives))
	if Global.lives > 0:
		Global.minigames_done = Global.minigames_done + 1
		if Global.minigames_done > Global.minigames_doing and Global.gamemode != "infinity":
			get_tree().change_scene_to_file("res://scenes/win.tscn")
			return
		Global.speed += 0.05
		Global.save()
		var next = 0
		if Global.gamemode == "infinity":
			next = randi_range(1, 15)
		else:
			var range: Vector2 = Global.levels[Global.gamemode]
			next = randi_range(range.x, range.y)
		
		$mini.text = (Global.minigamesinfo[next - 1]["name"])
		await Timer(5.0 / Global.speed) # using the function created
		Global.data["achieve"]["minigames_played"] += 1
		Global.data["coins"] += 1
		Transtition.trans("minigame_" + str(next))


func shake(lives: TextureRect):
	var center = lives.get_global_rect().get_center()
	particles.position = center
	await camera.zoomin(center)
	await wait(1) 
	await camera.shake(0.5)
	if !crack.playing && Global.lost:
		crack.play()
		particles.emitting = true
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
		await wait(0.05) # asks script to wait on this function. the 'wait' name for the function does nothing here, as await is just telling the scrpit to wait for the function to complete before progressing
		time -= 0.05 # remove 0.1
		slide.scale.x = remap(time, 0, start_time, 0, 0.4)
		# progressively get the value smaller and smaller
	slide.scale.x = 0
	#when timer reaches 0
	return

func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout # makes u wait, dw abt this being complex '''
