extends Area2D

@onready var player: CharacterBody2D = $"../player"
@onready var sprite: Sprite2D = $sprite
@onready var anim: AnimationPlayer = $anim
@onready var timer: Timer = $Timer
@onready var door_open_sfx: AudioStreamPlayer = $doorOpen_sfx
@onready var door_close_sfx: AudioStreamPlayer = $doorClose_sfx
@onready var win_sfx: AudioStreamPlayer = $win_sfx


var jogador_dentro: bool = false
signal player_win()

# Verifica constantemente se a tecla "i" foi pressionada enquanto o jogador está na área
func _process(delta: float) -> void:
	if jogador_dentro and Input.is_action_just_pressed("interact"):
		print("Player interagiu com a porta")
		emit_signal("player_win")
		win_sfx.play()
		iniciar_sequencia_animacao()

# Função chamada quando um corpo entra na área
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
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
		player.queue_free()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
