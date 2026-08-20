extends Node2D
@onready var value: TextureRect = $TextureRect
@onready var themed_timer: Node2D = $Time
@onready var ran: Node2D = $slider/range
@onready var range_limit: Node2D = $slider/range/Line2
@export var min: float
@export var max: float
@export var step: float
var VALUE: float
var index: float = 0.05
var amounted: int

@export var times = 1
@export var minigametwelve: bool
var range: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ran.hide()
	while Transtition.transtitioning:
		await get_tree().process_frame
	if !minigametwelve:
		Global.minigame6.connect(change)
	else:
		amounted = randi_range(1, 3 + Global.minigames_done/4)
	rangechange()
	ran.show()
	await themed_timer.Timer(5.0 / Global.speed)
	#after this is compeleted...
	if !Transtition.transtitioning:
		Global.lost = true
		Global.minigames_done -= 1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		Transtition.trans("level_scene")
	
func rangechange():
	range = randf_range(0, 120 + Global.minigames_done)
	range_limit.position.x = -45 - Global.minigames_done
	ran.position.x = range

func changeit():
	if !Transtition.transtitioning:
		if value.scale.x + index * step < min:
			index = abs(index)
			value.scale.x = min
		elif value.scale.x + index * step > max:
			index = -abs(index)
			value.scale.x = max
		else:
			value.scale.x += index * step
		VALUE = remap(value.scale.x, 0, 0.4, 0, 150)
	
func change(amount):
	if !Transtition.transtitioning:
		amount /= 180
		amount -= 0.5
		if value.scale.x + amount * step < min:
			value.scale.x = min
		elif value.scale.x + amount * step > max:
			value.scale.x = max
		else:
			value.scale.x += amount * step
		VALUE = remap(value.scale.x, 0, 0.4, 0, 150)

func check():
	if VALUE > range and VALUE < range + 30 - Global.minigames_done:
		if !Transtition.transtitioning:
			if minigametwelve:
				amounted -= 1
				rangechange()
				themed_timer.time = 5.0 / Global.speed
				if amounted == 0:
					Transtition.trans("level_scene")
			else:
				Global.data["achieve"]["fuel_refueled"] += 1
				Transtition.trans("level_scene")
	else:
		themed_timer.time -= 1
