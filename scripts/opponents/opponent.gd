extends Node2D

@export var escalation_progress_bar: ProgressBar;
@export var buttons_handler: Node2D;

@export var max_escalation: float = 100;
@export var escalation_increase_speed: float = 2;
@export var escalation_decrease_speed: float = -4;

@export_range(1, 2) var which_texture: int;
@export var sprite: Sprite2D;
@export var shadow_sprite: Sprite2D;
@export var texture_1: Texture2D;
@export var texture_2: Texture2D;

var escalation: float = 0;
var escalation_delta: float;
var dt: float;

signal lose();


func _ready() -> void:
	if which_texture == 1:
		sprite.texture = texture_1;
		shadow_sprite.texture = texture_1;
	else:
		sprite.texture = texture_2;
		shadow_sprite.texture = texture_2;
	escalation_delta = escalation_increase_speed;
# End ready


func _process(delta: float) -> void:
	dt = delta;
	escalation_progress_bar.value = escalation;
	escalation += delta * escalation_delta;

	if escalation <= 0:
		escalation = 0;

	if escalation > max_escalation:
		emit_signal("lose");
		# Lose
# End Process


func _begin_player_gun_overlapping(opp: Area2D) -> void:
	if opp.is_in_group("player"):
		escalation_delta = escalation_decrease_speed;
# End begin_overlapping


func _end_player_gun_overlapping(opp: Area2D) -> void:
	if opp.is_in_group("player"):
		escalation_delta = escalation_increase_speed;
# End end_overlapping


func get_buttons_handler() -> Node2D:
	return buttons_handler;
# end get buttons


func get_escalation() -> float:
	return escalation;
# end get escalation
