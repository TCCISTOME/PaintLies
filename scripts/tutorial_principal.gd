extends Control
@export var ImgTutorial:TextureRect = null;
var posicao:int = 0;
var ImagensTutoris:Array = ["res://imgs/imgs-tutoriais/livro-tutoial1.png","res://imgs/imgs-tutoriais/livro-tutoial2.png","res://imgs/imgs-tutoriais/livro-tutoial3.png","res://imgs/imgs-tutoriais/livro-tutoial4.png","res://imgs/imgs-tutoriais/livro-tutoial5.png","res://imgs/imgs-tutoriais/livro-tutoial6.png"];



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mudarImagem()


func _on_btn_e_pressed() -> void:
	posicao+=1


func _on_btn_q_pressed() -> void:
	posicao-=1

func mudarImagem():
	if(posicao < 0):
		posicao = ImagensTutoris.size()-1
	if(posicao > ImagensTutoris.size()-1):
		posicao = 0
	ImgTutorial.texture = load(ImagensTutoris[posicao])
	

func _on_texture_button_pressed() -> void:
	self.queue_free()
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
