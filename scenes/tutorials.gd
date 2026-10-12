extends Node2D

var index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$prev.pressed.connect(prev)
	$next.pressed.connect(next)
	$test.pressed.connect(test)
	$leave.pressed.connect(func():
		Transtition.trans("title_screen"))
	datachange()
	
func next():
	if index == len(Global.minigamesinfo) - 1:
		index = 0
	else:
		index += 1
	datachange()
func prev():
	if index ==  0:
		index = len(Global.minigamesinfo) - 1
	else:
		index -= 1
	datachange()
	
func datachange():
	$title.text = Global.minigamesinfo[index]["name"]
	$desc.text = Global.minigamesinfo[index]["description"]
	$play.text = Global.minigamesinfo[index]["how_to_play"]
	$TextureRect.texture = load("res://minigameimages/" + str(index + 1) +  ".png")

func test():
	Global.test = true
	Global.speed = 1
	Transtition.trans("minigame_" + str(index + 1))
