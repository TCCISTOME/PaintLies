extends Control
@export var imgLivroTutoriais:TextureRect = null;
@onready var texture_button: TextureButton = $PanelContainer/HBoxContainer/HBoxContainer/VBoxContainer/TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	imgLivroTutoriais.texture = load("res://imgs/imgs-tutoriais/livro-tutoial1.png")


func _on_atacando_pressed() -> void:
	imgLivroTutoriais["texture"] = load("res://imgs/imgs-tutoriais/livro-tutoial2.png")


func _on_compra_pressed() -> void:
	imgLivroTutoriais.texture = load("res://imgs/imgs-tutoriais/livro-tutoial3.png")
	

func _on_fase_pressed() -> void:
	imgLivroTutoriais.texture = load("res://imgs/imgs-tutoriais/livro-tutoial4.png")


func _on_salvar_pressed() -> void:
	imgLivroTutoriais.texture = load("res://imgs/imgs-tutoriais/livro-tutoial5.png")
	
	
func _on_inventario_pressed() -> void:
	imgLivroTutoriais.texture = load("res://imgs/imgs-tutoriais/livro-tutoial6.png")


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/cena-nova-tutorias.tscn")


func _on_texture_button_mouse_entered() -> void:
	texture_button.modulate = "9a9a9a"


func _on_texture_button_mouse_exited() -> void:
	texture_button.modulate = "ffffff"
