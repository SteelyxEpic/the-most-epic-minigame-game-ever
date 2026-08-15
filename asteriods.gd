extends Node2D

@onready var anim:AnimationPlayer = $AnimationPlayer 
@onready var area:Area2D = $Asteroid/Area2D
@export var speed: float = 400.0

func _physics_process(delta: float) -> void:
	# Move along the current facing direction scaled by delta time
	global_position -= transform.x * speed * delta
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("spin")
	
# the onreadys below run immediately at the start of the game, preventing 
# errors related to variable that haven't been defined yet in later scripts 

@onready var parent: Node2D = $".."
@onready var player: CharacterBody2D = $"../Ship" # grabs the parent node
@onready var self_area = $Asteroid/Area2D
@onready var player_area = $"../Ship/Area2D"

func _process(delta: float) -> void: # this runs EVERY FRAME! 
	
	if player_area.overlaps_area(self_area): # checks if overlapping
		parent.hit()
		
