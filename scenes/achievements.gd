extends Node2D

const acheivement = preload("res://achievement.tscn")
@onready var ACHEIVE = [$Achievement, $Achievement2, $Achievement3, $Achievement4]
@onready var back: Button = $Back
@onready var re: TextureButton = $TextureButton
@onready var fo: TextureButton = $TextureButton2

var index = 0
var previous = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back.pressed.connect(func():
		Transtition.trans("title_screen")
)
	change(0)
		

func change(i = 1):
	index = i * 4
	for x in range(4):
		ACHEIVE[x].get_child(0).get_child(0).text = ""
		ACHEIVE[x].get_child(0).get_child(1).text = ""
		if(x + index >= len(Global.data["achieve"])):
			continue
		ACHEIVE[x].get_child(0).get_child(0).text = Global.data["achieve"].keys()[x + index]
		ACHEIVE[x].get_child(0).get_child(1).text = str(Global.data["achieve"].values()[x + index])
func next():
	change(index/4 + 1)
	re.show()
	if index + 4 >= len(Global.data["achieve"]):
		fo.hide()

func returns():
	change(index/4 - 1)
	fo.show()
	if index == 0:
		re.hide()
