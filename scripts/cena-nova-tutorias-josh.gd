extends CanvasLayer
@export var Anination: AnimationTree= null
var animacao_galinha
@export var contGalinha: Container= null
@export var frango: Sprite2D= null
@export var tela:Control=null
@export var imgLivroTutoriais:TextureRect = null;

func _ready():
	pass
# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	proporcionals_texts()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var tamanho_tela=get_viewport().size
	frango.global_position = Vector2 (tamanho_tela[0]-Global.proporcional(255,400),tamanho_tela[1]-Global.proporcional(146,215))
	
	
func proporcionals_texts():
	for text in Global.acha_filhos("Label",[],get_node(".")):
		text["theme_override_font_sizes/font_size"]=Global.proporcional(26,45)
		
	for progressBar in Global.acha_filhos("ProgressBar",[],get_node("MarginContainer/HBoxContainer/HBoxContainer2/VBoxContainer/VBoxContainer")):
		progressBar["theme_override_font_sizes/font_size"]=Global.proporcional(26,40)

	for btn in Global.acha_filhos("Button",[],get_node("MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer")):
		btn["theme_override_font_sizes/font_size"]=Global.proporcional(18,32)


func voltar_button_pressed() -> void:
	# Despausar o jogo, caso esteja pausado
	get_tree().paused = false

	# Obter o caminho da cena atual
	var current_scene_path = get_tree().current_scene.get_filename()
	
	# Verificar se a cena atual é a "fase1-certa"
	if current_scene_path == "res://cenas/fase1-certa.tscn":
		# Voltar para a escolha de fases
		get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
	else:
		# Caso contrário, voltar para a tela de título
		get_tree().change_scene_to_file("res://cenas/title_screen.tscn")




func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/tela-tutorial_cer.tscn")
