extends CharacterBody2D
const SPEED = 2000.0
const JUMP_VELOCITY = -400.0

var take_demage_traps_vetor := Vector2.ZERO
var _player_ref = null  # Referência ao jogador
var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dead := false

# Variáveis do inimigo
var knockback_power := 15
@export var jugle_cub_life := 300
@export var xp := 2

@onready var texture: Sprite2D = $sprite
@onready var anim: AnimationPlayer = $anim
@onready var floorDetector: RayCast2D = $floorDetector
@onready var healthbar: ProgressBar = $HealthBar
@onready var detector_player: Area2D = $detector_player

var random_speed = 40

func _ready() -> void:
	healthbar.init_health(jugle_cub_life)
	healthbar.visible = false  # A barra de vida começa invisível

func _physics_process(delta):
	# Aplicar gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	if _player_ref != null:
		# Se o player estiver na área de detecção, o inimigo persegue o player
		pursue_player()
	else:
		# Caso contrário, o inimigo patrulha
		patrol(delta)
	
	move_and_slide()
	
	# Só executa walking se o inimigo não estiver morrendo
	if not is_dead and anim.current_animation != "attack":
		walking()
	# Valida se a personagem caiu no void
	check_void()

func pursue_player():
	# Direção em direção ao player
	var direction_to_player = global_position.direction_to(_player_ref.global_position)
	velocity = direction_to_player * random_speed

	# Inverter a textura com base na posição do jogador em relação ao inimigo
	texture.flip_h = (_player_ref.global_position.x > global_position.x)

func patrol(delta):
	# Movimento de patrulha
	velocity.x = direction * SPEED * delta
	
	# Detecta falta de chão
	if not floorDetector.is_colliding():
		direction *= -1
		
		# Inverte a escala horizontal do floorDetector
		floorDetector.position.x = abs(floorDetector.position.x) * direction

	# Inverte a textura com base na direção de patrulha
	texture.flip_h = direction == 1
	detector_player.position.x = abs(detector_player.position.x) * direction

# Player entrou na área
func _on_detector_player_body_entered(body: Node2D) -> void:
	if body.name == "sabrina":
		_player_ref = body
		walking()  # Atualiza para a animação "walking_evil"

# Player saiu da área
func _on_detector_player_body_exited(body: Node2D) -> void:
	if body == _player_ref:
		_player_ref = null
		patrol(0)  # Atualiza a textura imediatamente com a direção de patrulha
		walking()  # Atualiza para a animação "walking"

func walking():
	if _player_ref != null:
		anim.play("walking_evil")  # Animação quando o player está na área
	else:
		anim.play("walking")  # Animação padrão de patrulha

# Função para verificar se a personagem caiu no void
func check_void():
	if global_position.y > 10000:
		die()

#Inimigo recebendo dano
func _on_hurtbox_area_entered(area):
	if jugle_cub_life <= 0 and not is_dead:
		is_dead = true
		die()
	else:
		if area.is_in_group("player"):
			take_damage()

	if is_instance_valid(healthbar):  # Confirma se ainda existe healthbar
		healthbar.health = jugle_cub_life

func die():
	is_dead = true
	GlobalSabrina.countXp += xp
	anim.play("idle")

# Sinal para quando a animação terminar
func _on_anim_animation_finished(anim_name):
	if anim_name == "idle":
		set_physics_process(false)  
		queue_free()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("trap"):
		var take_demage = Vector2((global_position.x - body.global_position.x) * knockback_power, -50)
		take_demage_traps(take_demage)


# Função para receber dano
func take_damage():
	jugle_cub_life -= GlobalSabrina.player_attack

	if is_instance_valid(healthbar):  # Verifica se a healthbar ainda é válida
		healthbar.health = jugle_cub_life

	if jugle_cub_life <= 0:
		die()
	else:
		if is_instance_valid(healthbar):
			healthbar.visible = true  # Mostra a barra de vida ao sofrer dano
			
	# Altera a cor do inimigo para Preto
	texture.modulate = Color(0, 0, 0)

	# Espera 0.2 segundos usando 'await'
	await get_tree().create_timer(0.2).timeout

	# Volta a cor ao normal (branco)
	texture.modulate = Color(1, 1, 1)

#Aplicar dano de traps
func take_demage_traps(take_demage_traps_force := Vector2.ZERO, duration := 0.15):
	var take_demage_traps_tween := get_tree().create_tween()
	take_demage_traps_tween.parallel().tween_property(self, "take_demage_traps_vetor", Vector2.ZERO, duration)
	texture.modulate = Color(1,0,0,1)
	take_demage_traps_tween.parallel().tween_property(texture, "modulate", Color(1,1,1,1), duration)
	await get_tree().create_timer(0.1).timeout
	queue_free()
