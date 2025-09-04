extends Control
var alquimistaPocoes = Comerciantes.new()
@export var vBox : VBoxContainer=null
var clic_img
@export var imgPocoes: TextureRect=null
@export var BauCaveira: AnimatedSprite2D=null
@export var Descricao: Label=null
var pocaoClicada: String




# Called when the node enters the scene tree for the first time.
func _ready():
	create()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create():
	for i in alquimistaPocoes.itensAlquimista:
		var btn = Button.new()
		var separador = VSeparator.new()
		btn.name = str("btn_",i)
		btn.text = i
		btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		btn.custom_minimum_size= Vector2(400,61)
		var caminho = "res://sprites/pocoes/" + str(i) + "/" + str(i) + ".png"
		btn.icon = load(caminho)
		btn.theme = preload("res://themes/tema-botoes-comercio.tres")
		separador.custom_minimum_size= Vector2(10,10)
		separador.theme = preload("res://themes/tema-botoes-comercio.tres")
		var func_rect = get(str("_",i))
		btn.pressed.connect(func_rect)
		vBox.add_child(btn)
		vBox.add_child(separador)
		
func clicar_pocao(nome:String):
	imgPocoes.texture = load(str("res://sprites/pocoes/" + nome + "/" + nome + ".png"))
	imgPocoes.custom_minimum_size= Vector2(80,10)
	BauCaveira.play("brilha")
	mostrar_texto()


func mostrar_texto():
	if (pocaoClicada != null):
		print(pocaoClicada)
		Descricao.text = alquimistaPocoes.itensAlquimista[pocaoClicada][0]
	
	
		
func _CURA():
	pocaoClicada = "CURA"
	clicar_pocao("CURA")
func _ATAQUE():
	pocaoClicada = "ATAQUE"
	clicar_pocao("ATAQUE")
func _DEFESA():
	pocaoClicada = "DEFESA"
	clicar_pocao("DEFESA")
func _BREAKTIME():
	pocaoClicada = "BREAKTIME"
	clicar_pocao("BREAKTIME")
	





func _on_button_pressed():
	BauCaveira.play("abrir")
