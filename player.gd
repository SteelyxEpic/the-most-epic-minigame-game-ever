extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer

var SPEED = 300.0
const JUMP_VELOCITY = -750.0

var state = "idle"

func set_state(new_state):
	if state == new_state:
		return
	state = new_state
	match state:
		"idle":
			anim.play("idle")
		"walk":
			anim.play("walk")

func _ready() -> void:
	set_state("idle")
	SPEED *= Global.speed
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		set_state("walk")
		velocity.x = direction * SPEED
		if direction > 0:
			sprite.flip_h = false 
		else:
			sprite.flip_h = true
	else:
		set_state("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()
