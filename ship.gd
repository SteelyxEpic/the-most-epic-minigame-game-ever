extends CharacterBody2D


@export var SPEED = 300.0

func _ready() -> void:
	SPEED *= Global.speed
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if direction:
		velocity = direction * SPEED
		if velocity.x != 0:
			$Plane.scale.x = sign(velocity.x)
			$Plane/CPUParticles2D.gravity = Vector2(-400, 0) * sign(velocity.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
