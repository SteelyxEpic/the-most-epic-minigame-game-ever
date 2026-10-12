extends Node2D

@onready var button:AudioStreamPlayer2D = $button

# Preload your button click sound effect
var click_sound = preload("res://button1.mp3")
var current



func get_all_descendants(parent_node: Node) -> Array[Node]:
	var list: Array[Node] = []
	for child in parent_node.get_children():
		list.append(child)
		list.append_array(get_all_descendants(child)) # Recursive call
	return list
	
func _ready() -> void:
	# Initialize the bus volume on game start
	_update_bus_volume("SFX", Global.data["Settings"]["SFX"])
	_update_bus_volume("Music", Global.data["Settings"]["Music"])
	
func _update_bus_volume(names, value) -> void:
	# Find the index position of the "SFX" bus
	var bus_index = AudioServer.get_bus_index(names)
	
	# Convert the linear 0.0 - 1.0 value into decibels
	var db_volume = linear_to_db(value)
	
	# Apply the new decibel volume to the SFX bus
	AudioServer.set_bus_volume_db(bus_index, db_volume)
