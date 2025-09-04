extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Transition").visible = false

func _on_ren_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://jogo-alicia/main.tscn")

func _on_sair_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
