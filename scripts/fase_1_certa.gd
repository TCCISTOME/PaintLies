extends Control
@export var faseJosh:Node2D = null;
@onready var score_label: Label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if faseJosh.get_child(0).get_child_count() > 8 and faseJosh.get_child(0).get_child(8) != null:
		bebeuPocao()
		updateScore()
		if (faseJosh.get_child(0).vida > 0):
			get_node("HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer2/TextureRect").texture = load(str("res://imgs/Life/life",faseJosh.get_child(0).vida,".png"))
		elif (faseJosh.get_child(0).vida < 0):
			get_node("HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/TextureRect").texture = load("res://imgs/Life/Heart1.png")

func updateScore():
		if(int(faseJosh.get_child(1).get_playback_position()) != 0):
			score_label.text = str(int(faseJosh.get_child(1).get_playback_position()))
		
func bebeuPocao():
		if(faseJosh.get_child(0).get_child(8).current_animation == "bebendo-pocao"):
			if (get_node("Node2D").clique < 6  && get_node("Node2D").clique >= 0):
				get_node("HBoxContainer/VBoxContainer/PanelContainer2/HBoxContainer2/TextureRect").texture = load(str("res://imgs/BluePotion/blue",get_node("Node2D").clique,".png"))
		
		
	
