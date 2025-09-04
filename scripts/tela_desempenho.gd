extends Control
var objSave = SaveGame.new()
var objLoad = objSave.load_game()
@onready var labelDesempenho: Label = $HBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer2/PanelContainer2/VBoxContainer/Label2
@onready var minutosSegundos: Label = $HBoxContainer/HBoxContainer2/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label
@onready var milesimos: Label = $HBoxContainer/HBoxContainer2/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	labelDesempenho["text"] = str(objSave.jogoJosh["numeroDesempenho"])
	minutosSegundos["text"] = str(objSave.jogoJosh["melhorDesempenho"])
	milesimos["text"] = str(objSave.jogoJosh["melhorDesempenho"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
