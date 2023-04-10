extends Node2D

@export var timer: Timer;
@export var key_demand_label: RichTextLabel;

var keys_array = ["Q", "R", "A", "O", "E", "K"];

var is_demanding_keys: bool = false;
var current_key: String;

var game_manager: Node2D;

signal turn_has_ended();
signal deescalate();
signal escalate();


func _ready() -> void:
	key_demand_label.text = "";
	game_manager = get_tree().get_first_node_in_group("gm");
	connect("escalate", Callable(game_manager, "escalate"));
	connect("deescalate", Callable(game_manager, "deescalate"));
# end ready


func _input(event: InputEvent) -> void:
	var event_key: String;
	if event is InputEventKey:
		event_key = OS.get_keycode_string(event.keycode);
	
		if is_demanding_keys and event_key == current_key:
			emit_signal("deescalate");
			timer.start();
			next_key();
# End input


func begin_turn() -> void:
	is_demanding_keys = true;
	next_key();
	timer.start();
# end begin turn


func end_turn() -> void:
	is_demanding_keys = false;
	timer.stop();
	key_demand_label.text = "";
	emit_signal("turn_has_ended");
# end end turn


func _on_timeout() -> void:
	if is_demanding_keys:
		emit_signal("escalate");
		next_key();
# end on_timeout


func next_key() -> void:
	var rand_ind = randi_range(0, keys_array.size() - 1);
	current_key = keys_array[rand_ind];
	key_demand_label.text = "[center]" + current_key;
