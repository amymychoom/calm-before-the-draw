extends Button

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;

func _on_pressed() -> void:
	get_tree().quit();
