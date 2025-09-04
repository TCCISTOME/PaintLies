extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Transition").visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

	
func _on_ren_btn_pressed() -> void:
	#get_node("/root").get_child(5).queue_free()
	#get_node("/root").add_child(load("res://cenas/fase1-certa.tscn").instantiate())
	#get_node("Transition").visible = true
	#get_node("Transition/Fill/animation").play("transition-out")
	#await get_node("Transition/Fill/animation").animation_finished
	#self.queue_free()
	get_tree().change_scene_to_file("res://cenas/fase1-certa.tscn")
	


func _on_sair_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
	#self.queue_free()
