extends Node2D
@onready var timer: RichTextLabel = $timer #literally just the richlabeltext
@onready var TIMER: Timer = $timer/Timer

var time : float
var cont: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TIMER.timeout.connect(increase)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.text = str(snapped(time, 0.10)) # this makes names easier

func increase():
	if cont:
		time -= 0.1
	
func Timer(start_time: float): # making a new function for timer countdown!
	TIMER.start()
	time = start_time
	while time > 0 && !Transtition.transtitioning:
		await get_tree().process_frame
	TIMER.stop()
	return
