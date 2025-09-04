extends Control
@export var Anination: AnimationTree= null
var animacao_galinha
@export var contGalinha: Container= null
@export var frango: Sprite2D= null
@export var tela:Control=null

# Called when the node enters the scene tree for the first time.
func _ready():
	animacao_galinha= Anination["parameters/playback"]
	animacao_galinha.travel("move")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	proportional_text()
	var tamanho_tela=get_viewport().size
	frango.global_position = Vector2 (tamanho_tela[0]-Global.proporcional(255,400),tamanho_tela[1]-Global.proporcional(146,215))

	

func proportional_text():
	get_node("PanelContainer/MarginContainer/VBoxContainer/LabelP")["theme_override_font_sizes/font_size"]=Global.proporcional(27,40)
	get_node("PanelContainer3/VBoxContainer/MarginContainer2/Button3")["theme_override_font_sizes/font_size"]=Global.proporcional(16,32)
	
	frango.scale=Vector2(Global.proporcional(8,13),Global.proporcional(8,13))
	
	for i in range(4):
		var b = str("PanelContainer/MarginContainer/VBoxContainer/Label",i+1)
		get_node(b)["theme_override_font_sizes/font_size"]=Global.proporcional(20,36)
		
	for i in range(4):
		var l = str("PanelContainer/MarginContainer/VBoxContainer/ProgressBar",i+1)
		get_node(l)["theme_override_font_sizes/font_size"]=Global.proporcional(25,42)
		
	for k in range(2):
		var c = str("PanelContainer3/VBoxContainer/MarginContainer/VBoxContainer/Button",k+1)
		get_node(c)["theme_override_font_sizes/font_size"]=Global.proporcional(16,25)
		
