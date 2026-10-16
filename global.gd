extends Node

var minigames_done = 0 #track how many minigames done
var lives = 5 #track how many lives left
var lost = false
var minigames_doing = 10
var speed = 1.0
var gamemode = "ori"
var save_location = "user://save.json"
var default: Dictionary = {"Gamemodes": [1],"Difficulty": ["Normal"],"coins":int(0),"Settings":{"SFX": 1, "Music": 1, "Rounds": 10}, "achieve":{ "minigames_played": int(0), "aliens_tapped": int(0), "planets_collected": int(0), "asteriods_collided": int(0), "fuel_refueled": int(0), "levers_flicked": int(0), "lights_turned_on": int(0), "Earths_found": int(0)}}
var difficulty: String = "Normal"
var backgrounds: Dictionary = {"ori": load("res://epicbg3.png") as Texture2D, "stranded": load("res://coolbg4.png") as Texture2D, "refined": load("res://awesomebg2.png") as Texture2D, "hideout": load("res://alienbg2.png") as Texture2D, "infinity": load("res://infbg.png") as Texture2D}
var levels: Dictionary = {"ori": Vector2(1, 4), "stranded": Vector2(5, 10), "refined": Vector2(11, 12), "hideout": Vector2(13, 15)}
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
func new(type, index):
	if type == 0:
		if data["Gamemodes"].find(index) == -1:
			data["Gamemodes"].append(index)
			Acheivements.alerts.append("New Gamemode " + backgrounds.keys()[index - 1] + " Unlocked!")
	save()
