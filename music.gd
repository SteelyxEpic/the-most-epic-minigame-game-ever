extends Node2D

@onready var button:AudioStreamPlayer2D = $button

# Preload your button click sound effect
var click_sound = preload("res://button1.mp3")
var current

func add_to_button(node:Node2D):
	if current != node.name:
		current = node.name
		for i in get_all_descendants(node):
			if i is Button:
				i.disabled = false
				i.pressed.connect(_on_button_pressed)
func _on_button_pressed() -> void:
	# Dynamically create and play an audio player so sounds can overlap
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = click_sound
	add_child(audio_player)
	
	audio_player.play()
	
	# Automatically delete the player from memory when the sound finishes
	audio_player.finished.connect(audio_player.queue_free)

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
