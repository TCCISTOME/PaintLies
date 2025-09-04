extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Transition").visible = false

func _on_ren_btn_pressed() -> void:
	# Reiniciar a cena atual (jogo da Sabrina)
	get_tree().change_scene_to_file("res://jogo-sabrina/FinalStand/final_stand.tscn")
func _on_sair_btn_pressed() -> void:
	# Mudar para a cena de escolha de fases
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
