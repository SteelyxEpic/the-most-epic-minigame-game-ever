extends Node

var minigames_done = 0 #track how many minigames done
var lives = 5 #track how many lives left
var lost = false
var minigames_doing = 10
var speed = 1.0
var gamemode = "ori"

signal minigame4(number)
signal minigame5(index, state)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
