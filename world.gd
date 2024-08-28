extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Setup GUI view dimensions
	var drone_max = Vector3($Drone.max_x, $Drone.max_y, $Drone.max_z)
	$GUI._set_view_dims(drone_max)
	# func_update_map_view.call(position3)
	$Drone.func_update_map_view = $GUI._func_update_map_view


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
