extends Area2D

@export var vida:int = 6;
@export var animacaoJosh:AnimationPlayer = null;
@export var Haste:Area2D = null;
@export var animacaoHaste:AnimationPlayer = null;

var ganhos:bool = false;
var jaMorreu:bool = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (jaMorreu == false):
		joshMorrendo()
	giraGira()
		

func _on_area_entered(area: Area2D) -> void:
	if (area.name != "Haste-Area2D" && jaMorreu == false):		
		if(animacaoJosh.current_animation != "bebendo-pocao"):
			animacaoJosh.play("dano-josh")
		vida-=1
		area.queue_free()
		

func giraGira():
	if(Input.is_action_just_pressed("botao_a")):
		animacaoHaste.play("esquerda")
	elif(Input.is_action_just_pressed("botao_d")):
		animacaoHaste.play("direita")
	elif(Input.is_action_just_pressed("botao_s")):
		animacaoHaste.play("baixo")
	elif(Input.is_action_just_pressed("botao_w")):
		animacaoHaste.play("cima")
		

func _on_area_2d_area_entered_haste(area: Area2D) -> void:
	if(area.name != "Josh-Area2D"):
		area.queue_free()
		
func joshMorrendo():
	if (vida < 0):
		jaMorreu = true
		animacaoJosh.play("josh_morrendo")
		await get_tree().create_timer(1.2).timeout
		#get_node("/root").add_child(load("res://cenas/game_over.tscn").instantiate())
		#self.name = "joshMorto"
		# Verifique se o jogo está pausado e desative o estado de pausa
		if get_tree().paused:
			get_tree().paused = false
		get_tree().change_scene_to_file("res://cenas/game_over.tscn")
