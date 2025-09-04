extends Control
@export var texto:Label = null;
@export var imagemPersonagem:TextureRect = null;
var contaTela:int = 0;
@onready var texture_button: TextureButton = $HBoxContainer/HBoxContainer/VBoxContainer/TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	proporcionals_texts()

func proporcionals_texts():
	get_node("HBoxContainer/HBoxContainer2/VBoxContainer/Label")["theme_override_font_sizes/font_size"]=Global.proporcional(35,35)
	get_node("HBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer/VBoxContainer/Button")["theme_override_font_sizes/font_size"]=Global.proporcional(45,50)
	get_node("HBoxContainer/HBoxContainer3/VBoxContainer/PanelContainer/Button")["theme_override_font_sizes/font_size"]=Global.proporcional(50,70)
	get_node("HBoxContainer/HBoxContainer3/VBoxContainer/PanelContainer2/Button")["theme_override_font_sizes/font_size"]=Global.proporcional(50,70)
	get_node("HBoxContainer/HBoxContainer3/VBoxContainer/PanelContainer4/Button")["theme_override_font_sizes/font_size"]=Global.proporcional(50,70)
	get_node("HBoxContainer/HBoxContainer3/VBoxContainer/PanelContainer3/Button")["theme_override_font_sizes/font_size"]=Global.proporcional(50,70)
	get_node("HBoxContainer/HBoxContainer3/VBoxContainer/PanelContainer5/Button")["theme_override_font_sizes/font_size"]=Global.proporcional(50,70)
	

func _on_button_pressed1() -> void:
	contaTela = 1
	texto["text"] = "Josh Willy"
	imagemPersonagem.texture = load("res://sprites/josh/Parado_Frente1.png")

func _on_button_pressed2() -> void:
	contaTela = 2
	texto["text"] = "Heleanor Ferreira"
	imagemPersonagem.texture = load("res://sprites/Heleanor/Parado_Frente1.png")


func _on_button_pressed3() -> void:
	contaTela = 3
	texto["text"] = "Alícia Lopes"
	imagemPersonagem.texture = load("res://sprites/alicia/Parado_Frente1-a.png")


func _on_button_pressed4() -> void:
	contaTela = 4
	texto["text"] = "Sabrina Correa"
	imagemPersonagem.texture = load("res://sprites/sabrina/Parado_Frente1-s.png")


func _on_button_pressed_jogar() -> void:
	if (contaTela == 1):
		get_tree().change_scene_to_file("res://cenas/cutscenes.tscn")
	elif (contaTela == 2):
		get_tree().change_scene_to_file("res://jogo_heleanor/levels/node_2d.tscn")
	elif (contaTela == 3):
		get_tree().change_scene_to_file("res://cenas/cutscene_alicia.tscn")
	elif (contaTela == 4):
		get_tree().change_scene_to_file("res://jogo-sabrina/FinalStand/final_stand.tscn")


func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/title_screen.tscn")


func _on_texture_button_mouse_entered() -> void:
	texture_button.modulate = "9a9a9a"


func _on_texture_button_mouse_exited() -> void:
	texture_button.modulate = "ffffff"
