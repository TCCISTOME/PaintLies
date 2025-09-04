extends Area2D

@onready var player: CharacterBody2D = $"../sabrina"
@onready var transition: CanvasLayer = $"../transition"
@onready var anim: AnimationPlayer = $anim
@onready var timer: Timer = $Timer
@onready var door_open_sfx: AudioStreamPlayer = $doorOpen_sfx
@onready var door_close_sfx: AudioStreamPlayer = $doorClose_sfx

@export var next_level : String = ""

var jogador_dentro: bool = false


# Verifica constantemente se a tecla "i" foi pressionada enquanto o jogador está na área
func _process(delta: float) -> void:
	if jogador_dentro and Input.is_action_just_pressed("interact"):
		print("Player interagiu com a porta")
		iniciar_sequencia_animacao()

# Função chamada quando um corpo entra na área
func _on_body_entered(body: Node2D) -> void:
	if body.name == "sabrina":
		jogador_dentro = true
		print("Player entrou na área")

func iniciar_sequencia_animacao() -> void:
	# Inicia a primeira animação da porta
	door_open_sfx.play()
	anim.play("open_door")
	await anim.animation_finished
	print("Animação 'open_door' finalizada")
	
	# Inicia a animação de fechar a porta
	door_close_sfx.play()
	anim.play("close_door")
	print("Iniciando animação 'close_door'")

# Função chamada quando a animação da porta termina
func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open_door":
		#player.get_node("anim").play("doorEnter")
		player.queue_free()
	if anim_name == "close_door":
		transition.change_scene(next_level)
		#get_tree().change_scene_to_file("res://jogo-sabrina/FinalStand/final_stand_boss.tscn")


func _on_timer_timeout() -> void:
	pass # Replace with function body.
