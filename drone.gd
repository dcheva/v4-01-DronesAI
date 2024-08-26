extends CharacterBody2D

@export var speed := 200

func _physics_process(delta: float) -> void:
	var velocity_to := get_input_vetor2d() * speed * delta
	if velocity_to.length() > 1:
		# Moving
		$AnimationPlayer.play("Move")
	else: 
		# Chilling
		$AnimationPlayer.play("idle")
	velocity = lerp(velocity, velocity_to, delta*4)
	position += velocity
	move_and_slide()
	
func get_input_vetor2d() -> Vector3:
	var vector := Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		speed_to = max_speed * acceleration
	if Input.is_action_pressed("move_backward"):
		speed_to = max_speed * breaking
	if Input.is_action_pressed("move_up"):
		speed_to = max_speed * accelerations
	if Input.is_action_pressed("move_down"):
		speed_to = max_speed * breaking
	if Input.is_action_pressed("move_left"):
		steer_to = max_steer
	if Input.is_action_pressed("move_right"):
		steer_to = -max_steer
	return vector
