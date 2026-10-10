extends Node2D
@onready var player: CharacterBody2D = $"../Player" # grabs the parent node
@onready var self_area = $Area2D
@onready var player_area = $"../Player/Area2D"


func _on_area_2d_area_entered(area: Area2D = null) -> void:
	if area:
		if area == player_area:
			if self.visible:
				Global.data["coins"] += 1
				self.hide() #removed from player sight; collected
	elif self.visible:
		Global.data["coins"] += 1
		self.hide() #removed from player sight; collected
