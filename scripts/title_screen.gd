extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	proporcionals_texts()

func proporcionals_texts():
	for i in range(3):
		get_node(str("HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Button",i+1))["theme_override_font_sizes/font_size"]=Global.proporcional(20,20)
	
	

func _on_button_pressed():	
	#if (!FileAccess.file_exists("user://savegame.tres")):
		#var Tutoriais = preload("res://cenas/tutorial-principal.tscn").instantiate()
		#get_node("/root").add_child(Tutoriais)
		
#		Botão para tutoriais parou de funcionar, solução provisória
		get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
	


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://cenas/cena-nova-tutorias.tscn")



func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://cenas/creditos.tscn")

#Botão apenas para desenvolvimento, não definido para projeto final.
func _on_button_4_pressed() -> void:
	get_tree().quit()
