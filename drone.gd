extends CharacterBody2D

var screen := Vector2i(1280, 540)
var Xspeed := 500
var Yspeed := 1.0/3.0
var Zspeed := 1.0/1.5
var scale_k := 1.25
var max_x := 1280
var max_y := -1620
var max_z := 480
var scale_to := 1.0
var velocity3 := Vector3.ZERO
var position3 := Vector3.ZERO
var sun_pos := Vector2(-0.25, -0.35) 

func _physics_process(delta: float) -> void:
	var velocity3_to := get_input_vetor3i() * Xspeed * delta
	if velocity3_to.z > 0:
		# Climb
		if $AnimationPlayer.current_animation != "Damage":
			$AnimationPlayer.current_animation = "Load"
	elif velocity3_to.length() > 1:
		# Move
		if $AnimationPlayer.current_animation != "Damage":
			$AnimationPlayer.current_animation = "Move"
	else:
		# Chill
			$AnimationPlayer.current_animation = "idle"
	
	# LERP veloctity 3d and change position in memory
	velocity3 = lerp(velocity3, velocity3_to * scale_to, delta * 4)
	# Test position3 in bounds
	test_pos3()
	position3 += velocity3
	# Convert Vector2 to Vector 3 and change position on screen
	position = pos3_to_pos2(position3)
	
	# Parallax on Y axis
	var s: float = screen.y / (screen.y + (scale_k * -position3.y))
	scale_to = s
	self.scale = Vector2(scale_to, scale_to)
	
	# The Height affects the shadow distance
	$Shadow.position = Vector2(
		20 + -sun_pos.x * position3.z / scale_to, 
		40 + -sun_pos.y * 2 * position3.z / scale_to)
	
	#print(scale_to, " ", position3, " ", position)
	move_and_slide()
	
## Test the position3 + velocity3 are in the bounds and are not collided
func test_pos3() -> void:
# Correct velocity3 and add warning $AnimationPlayer.play("Warning, Damage")
	var velocity3test := velocity3
	if position3.x > max_x:
		velocity3test.x = -1
	if position3.x < 0:
		velocity3test.x = 1
	if position3.y > 0:
		velocity3test.y = -1
	if position3.y < max_y:
		velocity3test.y = 1
	if position3.z < 0:
		velocity3test.z = 1
	if position3.z > max_z:
		velocity3test.z = -1
		
	if velocity3test != velocity3:
		velocity3 = velocity3test
		$AnimationPlayer.current_animation = "Damage"
	
	
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
func pos3_to_pos2(vector3: Vector3) -> Vector2:
	return Vector2(vector3.x, screen.y + vector3.y * Yspeed - vector3.z * Zspeed)
	
