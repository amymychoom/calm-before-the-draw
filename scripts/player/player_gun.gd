extends Node2D

@export var gun_move_speed: float = 5;
@export var sway_multiplier = Vector2(5, 5);

var random_sway_amt = Vector2(0, 0);
var mouse_pos: Vector2;


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN;
# End ready


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_pos = event.position;
# End input


func _process(delta: float) -> void:
	position = position.lerp(
		mouse_pos,
		delta * gun_move_speed
	);

	gun_sway(random_sway_amt);
# End process


func gun_sway(sway_amt: Vector2) -> void:
	position += sway_amt;
# End gun sway


func _on_timer_timeout() -> void:
	random_sway_amt.x = randf_range(
		-1,
		1
	) * sway_multiplier.x;
	random_sway_amt.y = randf_range(
		-1,
		1
	) * sway_multiplier.y;
# end timer signal