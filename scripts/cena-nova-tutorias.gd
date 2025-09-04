extends CanvasLayer

@export var Anination: AnimationTree= null
@export var contGalinha: Container= null
@export var frango: Sprite2D= null
@export var tela:Control=null
@export var imgLivroTutoriais:TextureRect = null;

var is_fullscreen = true
var config_file_path = "user://settings.cfg"

@onready var button_4: Button = $MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/Button4
@onready var music_bar: HSlider = $MarginContainer/HBoxContainer/HBoxContainer2/VBoxContainer/VBoxContainer/HSlider
@onready var sfx_bar: HSlider = $MarginContainer/HBoxContainer/HBoxContainer2/VBoxContainer/VBoxContainer/HSlider2
@onready var music_bus_id = AudioServer.get_bus_index("music")
@onready var sfx_bus_id = AudioServer.get_bus_index("sfx")
@onready var texture_button: TextureButton = $MarginContainer/HBoxContainer/HBoxContainer2/VBoxContainer2/TextureButton


func _ready():
	#button_4.text = "Tela cheia"
	load_slider_values()


	if music_bus_id == -1:
		print("Bus de música não encontrado.")
		# Criar o bus de música se não existir
	elif sfx_bus_id == -1:
		print("Bus de SFX não encontrado.")
		# Criar o bus de SFX se não existir


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var tamanho_tela = get_viewport().size
	#frango.global_position = Vector2(tamanho_tela[0] - Global.proporcional(255, 400), tamanho_tela[1] - Global.proporcional(146, 215))
	
	
func proporcionals_texts():
	for text in Global.acha_filhos("Label",[],get_node(".")):
		text["theme_override_font_sizes/font_size"]=Global.proporcional(26,45)
		
	for progressBar in Global.acha_filhos("ProgressBar",[],get_node("MarginContainer/HBoxContainer/HBoxContainer2/VBoxContainer/VBoxContainer")):
		progressBar["theme_override_font_sizes/font_size"]=Global.proporcional(26,40)

	for btn in Global.acha_filhos("Button",[],get_node("MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer")):
		btn["theme_override_font_sizes/font_size"]=Global.proporcional(18,32)


func voltar_button_pressed() -> void:
	if(!get_tree().paused):
		get_tree().change_scene_to_file("res://cenas/title_screen.tscn")
	else:
		self.queue_free()	


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/tela-tutorial_cer.tscn")
	
	#if (get_tree().paused):
		#get_tree().change_scene_to_file("res://cenas/tela-tutorial_cer.tscn")
	#else:
		#var Tutoriais = preload("res://cenas/tela-tutorial_cer.tscn").instantiate()
		#get_node("/root").add_child(Tutoriais)
		
func _on_button_4_pressed() -> void:
	if is_fullscreen:
		# Alterar para o modo janela
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		is_fullscreen = false
		button_4.text = "Tela Cheia"  # Atualizar o texto do botão
	else:
		# Alterar para o modo tela cheia
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		is_fullscreen = true
		button_4.text = "Normal"  # Atualizar o texto do botão

	
	
func _on_h_slider_value_changed(value: float) -> void:
	 # Salvar o valor do slider ao ser alterado
	save_slider_value("music_volume", value)
	AudioServer.set_bus_volume_db(music_bus_id, linear_to_db(value))
	AudioServer.set_bus_mute(music_bus_id, value < .05)

func _on_h_slider_2_value_changed(value: float) -> void:
	 # Salvar o valor do slider ao ser alterado
	save_slider_value("sfx_volume", value)
	AudioServer.set_bus_volume_db(sfx_bus_id, linear_to_db(value))
	AudioServer.set_bus_mute(sfx_bus_id, value < .05)
	
func save_slider_value(key: String, value: float) -> void:
	var config = ConfigFile.new()
	if config.load(config_file_path) != OK:
		print("Criando novo arquivo de configurações.")
	config.set_value("audio", key, value)
	config.save(config_file_path)

func load_slider_values() -> void:
	var config = ConfigFile.new()
	if config.load(config_file_path) == OK:
		# Carregar valores salvos de música
		var music_saved_value = config.get_value("audio", "music_volume", 1.0)  # Padrão: 1.0
		music_bar.value = music_saved_value
		AudioServer.set_bus_volume_db(music_bus_id, linear_to_db(music_saved_value))
		AudioServer.set_bus_mute(music_bus_id, music_saved_value < .05)

		# Carregar valores salvos de SFX
		var sfx_saved_value = config.get_value("audio", "sfx_volume", 1.0)  # Padrão: 1.0
		sfx_bar.value = sfx_saved_value
		AudioServer.set_bus_volume_db(sfx_bus_id, linear_to_db(sfx_saved_value))
		AudioServer.set_bus_mute(sfx_bus_id, sfx_saved_value < .05)
		
	else:
		print("Nenhum arquivo de configurações encontrado. Usando valores padrão.")
		# Aqui, se não houver arquivo de configuração, você pode também criar novos "buses" ou valores padrão.
		setup_default_buses()

func setup_default_buses():
	# Certifique-se de configurar os "buses" de áudio padrões, caso o arquivo de configuração não exista.
	AudioServer.set_bus_volume_db(music_bus_id, linear_to_db(1.0))  # Padrão
	AudioServer.set_bus_volume_db(sfx_bus_id, linear_to_db(1.0))  # Padrão


func _on_button_option_item_selected(index: int) -> void:
	match index:
		0: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		4:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		_:
			print("Índice desconhecido:", index)


func _on_texture_button_mouse_entered() -> void:
	texture_button.modulate = "9a9a9a"



func _on_texture_button_mouse_exited() -> void:
	texture_button.modulate = "ffffff"
