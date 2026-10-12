# the onreadys below run immediately at the start of the game, preventing 
# errors related to variable that haven't been defined yet in later scripts 

extends Node2D
@onready var player: CharacterBody2D = $"../Player" # grabs the parent node
@onready var self_area = $Area2D
@onready var player_area = $"../Player/Area2D"
var main:Node2D

		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == player_area:
		main.emit_signal("collected")
		queue_free()
		
