extends Node2D

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sfx: HSlider = $SFX
@onready var music: HSlider = $Music
# This single variable controls all SFX volume (Range: 0.0 to 1.0)
var sfx_volume: float = 0.5:
	set(value):
		sfx_volume = clamp(value, 0.0, 1.0) # Keeps value safe between 0 and 1
		Music._update_bus_volume("SFX", sfx_volume)
		Global.data["Settings"]["SFX"] = sfx_volume

var music_volume: float = 0.5:
	set(value):
		music_volume = clamp(value, 0.0, 1) # Keeps value safe between 0 and 1
		Music._update_bus_volume("Music", music_volume)
		Global.data["Settings"]["Music"] = music_volume

func _ready() -> void:
	Music.add_to_button(self)
	sfx_volume = Global.data["Settings"]["SFX"]
	music_volume = Global.data["Settings"]["Music"]
	music.value = music_volume
	sfx.value = sfx_volume
	Global.save()


func _on_h_slider_value_changed(value: float) -> void:
	sfx_volume = value

func _on_h_slider2_value_changed(value: float) -> void:
	music_volume = value
func _on_h_slider_drag_ended(value_changed: bool) -> void:
	audio.play()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
