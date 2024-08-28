extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var drone_max = Vector2($Drone.max_x, $Drone.max_y)
	$GUI._set_view_dims(drone_max)
	$Drone.func_update_map_view = $GUI._func_update_map_view


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
