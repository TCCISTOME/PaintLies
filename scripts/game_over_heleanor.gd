extends CanvasLayer


func _on_ren_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://jogo_heleanor/levels/node_2d.tscn")


func _on_sair_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
