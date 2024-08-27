extends CharacterBody2D

@export var speed := 200
var velocity3 := Vector3.ZERO
var position3 := Vector3.ZERO

func _physics_process(delta: float) -> void:
	var velocity3_to := get_input_vetor3i() * speed * delta
	if velocity3_to.z > 0:
		# Climb
		$AnimationPlayer.play("Load")
	elif velocity3_to.length() > 1:
		# Move
		$AnimationPlayer.play("Move")
	else:
		# Chill
		$AnimationPlayer.play("idle")
	
	# LERP veloctity 3d and change position in memory
	velocity3 = lerp(velocity3, velocity3_to, delta * 4)
	if get_tested_values3():
		position3 += velocity3
	
	# The Height affects the shadow distance
	$Shadow.position += Vector2(velocity3.z/2, velocity3.z*2)
	# Convert Vector2 to Vector 3 and change position on screen
	velocity = vector3_to_vector2(velocity3)
	position += velocity
	
	move_and_slide()
	
## Test the position3 + velocity3 are in the bounds and are not collided
func get_tested_values3() -> bool:
# Correct velocity3 and add warning $AnimationPlayer.play("Warning, Damage") 
	return true
	
## Returns Vector3i(x:right,-y:forward, z:up)
func get_input_vetor3i() -> Vector3i:
	var vector3i := Vector3i.ZERO
	if Input.is_action_pressed("move_left"):
		vector3i += Vector3i(-1, 0, 0)
	if Input.is_action_pressed("move_right"):
		vector3i += Vector3i( 1, 0, 0)
	if Input.is_action_pressed("move_forward"):
		vector3i += Vector3i( 0,-1, 0)
	if Input.is_action_pressed("move_backward"):
		vector3i += Vector3i( 0, 1, 0)
	if Input.is_action_pressed("move_up"):
		vector3i += Vector3i( 0, 0, 1)
	if Input.is_action_pressed("move_down"):
		vector3i += Vector3i( 0, 0,-1)
	return vector3i
	
## Returns Vector3 proection to 2d perspective
func vector3_to_vector2(vector3: Vector3) -> Vector2:
	return Vector2(vector3.x, vector3.y/3 - vector3.z)
	
	
