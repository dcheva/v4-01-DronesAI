extends CharacterBody2D

@export var speed := 200


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dir_x := Input.get_axis("ui_left", "ui_right")
	if dir_x:
		velocity.x = dir_x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
