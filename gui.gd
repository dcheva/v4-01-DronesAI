extends CanvasLayer

var win_min = Vector2(-144,80)
var win_max = Vector2(144,-80)

var view_dim: Vector2
var view_scale: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _set_view_dims(drone_max: Vector3) -> void:
	view_dim = Vector2(win_max.x - win_min.x, win_max.y - win_min.y)
	print(view_dim)
	view_scale = Vector3(drone_max.x / view_dim.x, drone_max.y / view_dim.y, drone_max.z / -view_dim.y)
	print(view_scale)
	
func _func_update_map_view(position3: Vector3, scale: float) -> void:
	var view_Rpos2 = Vector2(position3.x/view_scale.x, position3.y/view_scale.y)
	var view_Lpos2 = Vector2(position3.x/view_scale.x, - position3.z/view_scale.z)
	$MapWindowR/RPos.position = win_min + view_Rpos2
	$MapWindowL/LPos.position = win_min + Vector2(view_Lpos2.x, view_Lpos2.y / scale)
