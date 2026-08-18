extends Node2D

@onready var radar: Sprite2D = $Radarin
@onready var timer:Timer = $Timer
@onready var text:RichTextLabel = $Location
@onready var themed_timer:Node2D = $Time
@onready var sound:AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var minigameeight: bool
@export var step: float
var change
var range: float
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while Transtition.transtitioning:
		await get_tree().process_frame
	range = randf_range(0, 360)
	timer.timeout.connect(move)
	if !minigameeight:
		change = 1
		timer.start()
	await themed_timer.Timer(10.0 / Global.speed)
	#after this is compeleted...
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene")
	


func back():
	change = -1
	timer.start()
func after():
	change = 1
	timer.start()
func stop() -> void:
	timer.stop()
func move():
	radar.rotation_degrees += (step + Global.minigames_done)* change
	if int(radar.rotation_degrees) % 360 > range - 55/2 and int(radar.rotation_degrees) % 360 < range + 55/2:
		if minigameeight:
			play()
		else:
			play()
			if !sound.finished.get_connections():
				sound.finished.connect(play)
		text.text = "Earth"
	else:
		text.text = "NULL"
		if sound.finished.get_connections():
			sound.finished.disconnect(play)

func play():
	if(!sound.playing):
		sound.play()
func check():
	if text.text == "Earth":
		if sound.finished.get_connections():
			sound.finished.disconnect(play)
		timer.stop()
		Transtition.trans("level_scene")
		
