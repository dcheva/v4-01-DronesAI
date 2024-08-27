extends CharacterBody2D

@export var Xspeed := 500
@export var Yspeed := 1.0/3.0
@export var Zspeed := 1.0/1.3
@export var screen := Vector2i(1280, 540)
@export var scale_k := 10
var scale_to := 1.0
var velocity3 := Vector3.ZERO
var position3 := Vector3.ZERO

func _physics_process(delta: float) -> void:
	var velocity3_to := get_input_vetor3i() * Xspeed * delta
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
	get_tested_values3()
	position3 += velocity3
	
	# Parallax on Y axis
	var s: float = screen.y / (screen.y + scale_k * sqrt3(scale_k * -position3.y))
	scale_to = s
	self.scale = Vector2(scale_to, scale_to)
	
	# Convert Vector2 to Vector 3 and change position on screen
	velocity = vector3_to_vector2(velocity3) * scale_to
	position += velocity
	# The Height affects the shadow distance
	$Shadow.position = Vector2(25 + position3.z/4, 50 + position3.z/1.2)
	
	print(scale_to, " ", position3, " ", position)
	move_and_slide()
	
## Test the position3 + velocity3 are in the bounds and are not collided
func get_tested_values3() -> void:
# Correct velocity3 and add warning $AnimationPlayer.play("Warning, Damage")
	pass
	
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
	return Vector2(vector3.x, vector3.y * Yspeed - vector3.z * Zspeed)
	
func sqrt3(square: float) -> float:
	if square < 0:
		square = 0
	return sqrt(square)
