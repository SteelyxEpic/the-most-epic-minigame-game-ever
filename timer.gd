extends Node2D
@onready var TIMER: Timer = $Timer
@onready var clock: TextureProgressBar = $TextureProgressBar

var time : float
var initialtime : float
var cont: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TIMER.timeout.connect(increase)


func increase():
	if cont:
		time -= 0.1
		var temp = remap(time, 0, initialtime, 360, 0)
		clock.value = temp
		clock.get_node("TextureRect").rotation_degrees = temp
		
	
func Timer(start_time: float): # making a new function for timer countdown!
	TIMER.start()
	initialtime = start_time
	time = start_time
	while time > 0 && !Transtition.transtitioning:
		await get_tree().process_frame
	TIMER.stop()
	return
