extends Node2D

@export var opponent_1: Node2D;
@export var opponent_2: Node2D;
@export var global_escalation_progress_bar: ProgressBar;

@export var max_global_escalation: float = 250;
@export var base_global_escalation: float = 100;
@export var escalation_change: float = 5;
@export var deescalation_change: float = 3;

var opp_1_button_handler: Node2D;
var opp_2_button_handler: Node2D;

var global_escalation: float;
var added_escalation: float = 0;


func _ready() -> void:
	global_escalation_progress_bar.max_value = max_global_escalation;
	opp_1_button_handler = opponent_1.get_buttons_handler();
	opp_2_button_handler = opponent_2.get_buttons_handler();
# End Ready


func _process(_delta: float) -> void:
	global_escalation = base_global_escalation + opponent_1.get_escalation() + opponent_2.get_escalation() + added_escalation;
	global_escalation_progress_bar.value = global_escalation;

	if global_escalation >= max_global_escalation:
		lose();
	if global_escalation <= 0:
		win();
# end process


func _change_opp_turn() -> void:
	if opp_1_button_handler.is_demanding_keys: # opponent 1 is currently going
		opp_1_button_handler.end_turn(); # stop going
		opp_2_button_handler.begin_turn(); # let opponent 2 have a turn
	elif opp_2_button_handler.is_demanding_keys: # opponent 2 is currently going
		opp_2_button_handler.end_turn(); # stop going
		opp_1_button_handler.begin_turn(); # let opponent 1 have a turn
	else: # nobody is going
		opp_1_button_handler.begin_turn(); # just let opponent 1 go
# end change turn


func escalate() -> void:
	added_escalation += escalation_change;
# end


func deescalate() -> void:
	added_escalation -= deescalation_change;
# end 


func lose() -> void:
	get_tree().change_scene_to_file("res://scenes/lose_scene.tscn");
# end lose


func win() -> void:
	get_tree().change_scene_to_file("res://scenes/win_scene.tscn");
# end win
