extends CanvasLayer
@onready var _1_btn: Button = $"MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/VBoxContainer2/MarginContainer/VBoxContainer/1_btn"


var previous_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	


func tirarPrint():
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png("res://prints/isadora.png")



#func proportional_text():
	#for i in range(5):
		#var url = str("HBoxContainer/VBoxContainer2/VBoxContainer/VBoxContainer2/MarginContainer/VBoxContainer/",i+1,"_btn")
		#get_node(url)["theme_override_font_sizes/font_size"]=Global.proporcional(20,40)


func _on__btn_pressed() -> void:
	tirarPrint()


func _on__btncontinuar_pressed() -> void:
	get_tree().paused = false
	visible = false
	_1_btn.grab_focus()


func _on__btnreiniciar_pressed() -> void:
	pass


func _on__btn_sair_salvar_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")  # Carrega a nova cena


	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true


func _on__configure_pressed() -> void:
	var Configuration = preload("res://cenas/cena-nova-tutorias.tscn").instantiate()
	get_node("/root").add_child(Configuration)
	visible = false
	#get_tree().paused = false
	#get_tree().change_scene_to_file("res://cenas/cena-nova-tutorias.tscn")  # Carrega a nova cena
	

	
	
