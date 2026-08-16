extends Node2D

const acheivement = preload("res://achievement.tscn")
@onready var ACHEIVE = [$Achievement, $Achievement2, $Achievement3, $Achievement4]
@onready var back: Button = $Back
var index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back.pressed.connect(func():
		Transtition.trans("title_screen")
)
	change(0)
		

func change(i = 1):
	index = i * 4 + 1
	for x in range(4):
		if x + index>= len(Global.data):
			break
		ACHEIVE[x].get_child(0).get_child(0).text = Global.data.keys()[x + index]
		ACHEIVE[x].get_child(0).get_child(1).text = str(Global.data.values()[x + index])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
