extends Area2D
@export var Anination: AnimationTree= null
var animacao_frango
@export var speed: float 
var tamanho_tela
@onready var galinha = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	animacao_frango= Anination["parameters/playback"]
	animacao_frango.travel("andar")
	animacao_frango.travel("pular")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var tamanho_tela=get_viewport().size
	if (position.x < tamanho_tela[0]-150):
		_move()
	#30x por segundo, garante q funcione igual em todos os computadores!
	
func _move():
	galinha.global_position.x += speed
