extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	proporcionals_texts()
	
func proporcionals_texts():
	get_node("VBoxContainer/VBoxContainer2/Label")["theme_override_font_sizes/font_size"]=Global.proporcional(80,140)
	get_node("VBoxContainer/VBoxContainer4/Label")["theme_override_font_sizes/font_size"]=Global.proporcional(23,40)
	get_node("VBoxContainer/VBoxContainer4/Label2")["theme_override_font_sizes/font_size"]=Global.proporcional(18,25)
