extends Node

var minigames_done = 0 #track how many minigames done
var lives = 5 #track how many lives left
var lost = false
var minigames_doing = 10
var speed = 1.0
var gamemode = "ori"
var save_location = "user://save.json"
var default: Dictionary = {"Gamemodes": [1],"coins":int(0),"Settings":{"SFX": 1, "Music": 1, "Rounds": 10}, "achieve":{ "minigames_played": int(0), "aliens_tapped": int(0), "planets_collected": int(0), "asteriods_collided": int(0), "fuel_refueled": int(0), "levers_flicked": int(0), "lights_turned_on": int(0), "Earths_found": int(0)}}
var data: Dictionary
var minigamesinfo
var test = false

signal minigame4(number)
signal minigame5(index, state)
signal minigame6(state)

func _ready() -> void:
	data = load_data()
	var file = FileAccess.open("res://minigames.json", FileAccess.READ)
	var json_text = file.get_as_text()
	var json = JSON.new()
	json.parse(json_text)
	minigamesinfo = json.data
	
func override():
	data = default
	save()
	
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
