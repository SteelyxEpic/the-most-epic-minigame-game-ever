# the onreadys below run immediately at the start of the game, preventing 
# errors related to variable that haven't been defined yet in later scripts 

extends Node2D
@onready var player: CharacterBody2D = $"../Player" # grabs the parent node
@onready var self_area = $Area2D
@onready var player_area = $"../Player/Area2D"
var bad = load("res://planetbad.png") as Texture2D
var main:Node2D

func _ready() -> void:
	if Global.difficulty == "Hell":
		if randf() > 0.5:
			main.needed -= 1
			$Planet.texture = bad
	elif Global.difficulty == "Hard":
		if randf() > 0.75:
			main.needed -= 1
			$Planet.texture = bad
	

		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if Transtition.transtitioning:
		position = Vector2(randf_range(0, get_viewport_rect().size.x/6.3)*4, randf_range(0, get_viewport_rect().size.y/6.3)*4)
	else:
		if area == player_area:
			if $Planet.texture == bad:
				main.emit_signal("collectedbad")
			else:
				main.emit_signal("collected")
			queue_free()
		
