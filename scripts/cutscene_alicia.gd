extends Control
@onready var texture_button: TextureButton = $MarginContainer/TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://jogo-alicia/main.tscn")


func _on_cutscene_josh_finished() -> void:
	get_tree().change_scene_to_file("res://jogo-alicia/main.tscn")


func _on_texture_button_mouse_entered() -> void:
	texture_button.modulate = "9a9a9a"


func _on_texture_button_mouse_exited() -> void:
	texture_button.modulate = "ffffff"
