extends Node

var minigames_done = 0 #track how many minigames done
var lives = 5 #track how many lives left
var lost = false
var minigames_doing = 10
var speed = 1.0
var gamemode = "ori"
var save_location = "user://save.json"
var default: Dictionary = {"Gamemodes": [0], "minigames_played": 0, "aliens_tapped": 0, "planets_collected": 0, "asteriods_collided": 0}
var data: Dictionary

signal minigame4(number)
signal minigame5(index, state)
signal minigame6(state)

func _ready() -> void:
	data = load_data()

func save():
	var file: FileAccess = FileAccess.open(save_location, FileAccess.WRITE)
	var str_data = JSON.stringify(data)
	file.store_line(str_data)
	file.close()

func load_data() -> Dictionary:
	if FileAccess.file_exists(save_location):
		var file: FileAccess = FileAccess.open(save_location, FileAccess.READ)
		var json = JSON.new()
		var datatemp = file.get_line()
		json.parse(datatemp) 
		var dataf: Dictionary = json.get_data()
		file.close()
		return dataf
	return default
