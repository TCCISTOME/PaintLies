extends Area2D
var velocidade:int = 0;
var direcao:Vector2 = Vector2(0,1);
var textura:String = "";
@export var nota:Area2D = null;
@export var tipoSprite:Sprite2D = null;
var speed:float = 3.5;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	analisaNotas()

	
func analisaNotas():
	#esquerda
	if(direcao == Vector2(0,1)):
		position.x=position.x + speed
	#direira
	elif(direcao == Vector2(2,1)):
		position.x=position.x - speed
	#cima
	elif(direcao == Vector2(1,2)):
		position.y=position.y + speed
	#baixo
	elif(direcao == Vector2(1,0)):
		position.y=position.y - speed

func diferentesTexturas(tipo:int):
	if (tipo == 1):
		tipoSprite.material["shader_parameter/picked_color"]=Color(0.78,0.124,0.321,1) #rosa
		tipoSprite["texture"] = load("res://imgs/jogo-ritmo/Music-0.png")
	elif(tipo == 2):
		tipoSprite.material["shader_parameter/picked_color"]=Color(0.682,0.001,0.771,1) #roxo
		tipoSprite["texture"] = load("res://imgs/jogo-ritmo/Music-1.png")
	elif(tipo == 3):
		nota.scale = Vector2(0.4,0.4)
		tipoSprite.material["shader_parameter/picked_color"]=Color(0.35,0.806,0,1) #verde
		tipoSprite["texture"] = load("res://imgs/jogo-ritmo/Music-2.png")
	elif(tipo == 4):
		nota.scale = Vector2(0.4,0.4)
		tipoSprite.material["shader_parameter/picked_color"]=Color(1,0.553,0,1) #laranja
		tipoSprite["texture"] = load("res://imgs/jogo-ritmo/Music-3.png")
