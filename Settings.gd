extends Node2D

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
# This single variable controls all SFX volume (Range: 0.0 to 1.0)
var sfx_volume: float = 0.5:
	set(value):
		sfx_volume = clamp(value, 0.0, 1.0) # Keeps value safe between 0 and 1
		_update_sfx_bus_volume()

func _ready() -> void:
	# Initialize the bus volume on game start
	_update_sfx_bus_volume()

func _update_sfx_bus_volume() -> void:
	# Find the index position of the "SFX" bus
	var bus_index = AudioServer.get_bus_index("SFX")
	
	# Convert the linear 0.0 - 1.0 value into decibels
	var db_volume = linear_to_db(sfx_volume)
	
	# Apply the new decibel volume to the SFX bus
	AudioServer.set_bus_volume_db(bus_index, db_volume)


func _on_h_slider_value_changed(value: float) -> void:
	sfx_volume = value


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	audio.play()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
