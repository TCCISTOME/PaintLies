extends CharacterBody2D

const MARTELAO := preload("res://jogo-sabrina/FinalStand/prefebs/martelao.tscn")
const CUBS := preload("res://jogo-sabrina/Enemys/Boss/jugle_cubs.tscn")

var SPEED = 8000.0

signal boss_has_died()

@onready var healthbar: ProgressBar = $HealthBar
@onready var floor_detector: RayCast2D = $floorDetector
@onready var sprite: Sprite2D = $sprite
@onready var martelo_point: Marker2D = %martelo_point
@onready var cubs_point: Marker2D = %cubs_point
@onready var anim_tree: AnimationTree = $anim_tree
@onready var state_machine: AnimationNodeStateMachinePlayback = $anim_tree.get("parameters/playback")
@onready var hurtBox: CollisionShape2D = $hurtBox/collision
@onready var collision: CollisionShape2D = $hurtBox/collision
@onready var collision_detector: CollisionShape2D = $detector_player/collision
@onready var anim: AnimationPlayer = $anim_player
@onready var dead_sfx: AudioStreamPlayer = $dead_sfx

@export var boss_life := 400

var direction = -1
var is_dead := false

#Flags para estados do boss
var turn_count := 0
var martelao_count := 0
var invocation_count := 0
var can_launch_martelao := true
var can_launch_cubs := true
var player_hit := false

func _ready():
	set_physics_process(false)
	healthbar.init_health(boss_life)
	healthbar.visible = false  # A barra de vida começa invisível
	#process_mode = Node.PROCESS_MODE_ALWAYS  # Continua processando fora da tela

func _physics_process(delta):
	if not floor_detector.is_colliding():
		direction *= -1
		
		# Inverte a escala horizontal do floor_detector
		floor_detector.position.x = abs(floor_detector.position.x) * direction
		turn_count += 1

	match state_machine.get_current_node():
		"moving":
			if direction == 1:
				hurtBox.disabled = true  # Desabilita a hurtBox quando o boss está se movendo
				velocity.x = SPEED * delta
				sprite.scale.x = direction
			else:
				velocity.x = -SPEED * delta
				sprite.scale.x = -direction
				
		"martelao":
			hurtBox.disabled = true  # Desabilita a hurtBox quando o boss está se movendo
			velocity.x = 0
			await get_tree().create_timer(1.2).timeout
			if can_launch_martelao:
				var players = get_tree().get_nodes_in_group("player")
				if players.size() > 0:
					var player = players[0]
					throw_materlao(player.global_position)
					can_launch_martelao = false
				else:
					print("Player não encontrado")
					
		"invocation":
			hurtBox.disabled = true  # Desabilita a hurtBox quando o boss está se movendo
			velocity.x = 0
			await get_tree().create_timer(4).timeout
			
			if can_launch_cubs:
				throw_cubs()
				can_launch_cubs = false
		"vunerable":
			hurtBox.disabled = false
			can_launch_martelao = false
			can_launch_cubs = false
			player_hit = false
			
			
			
	if turn_count <= 4:
		anim_tree.set("parameters/conditions/can_move", true)
		anim_tree.set("parameters/conditions/can_martelao", false)

	elif martelao_count >= 5:
		anim_tree.set("parameters/conditions/can_invocation", true)
		martelao_count = 0
		
	elif invocation_count >= 4:
		anim_tree.set("parameters/conditions/is_vunerable", true)
		invocation_count = 0

	else:
		anim_tree.set("parameters/conditions/can_move", false)
		anim_tree.set("parameters/conditions/is_vunerable", false)
		anim_tree.set("parameters/conditions/can_invocation", false)
		anim_tree.set("parameters/conditions/can_dead", false)
		anim_tree.set("parameters/conditions/can_martelao", true)
			
	move_and_slide()

func throw_materlao(player_position: Vector2):
	if martelao_count <= 5:
		var materlao_instance = MARTELAO.instantiate()
		add_sibling(materlao_instance)
		materlao_instance.global_position = martelo_point.global_position
		
		# Calcula a direção do martelão com base na posição do jogador
		var direction = (player_position - materlao_instance.global_position).normalized()
		materlao_instance.set_direction(direction)
		$martelo_timer.start()
		martelao_count += 1

func throw_cubs():
	if invocation_count <= 4:
		var cubs_instance = CUBS.instantiate()
		add_sibling(cubs_instance)  # Adiciona como irmão, não filho do Boss
		cubs_instance.global_position = cubs_point.global_position
		$cubs_timer.start()
		invocation_count += 1

#Invocar o martelão >:D
func _on_martelo_timer_timeout() -> void:
	can_launch_martelao = true
	
#Invocar os cubs >:D
func _on_cubs_timer_timeout() -> void:
	can_launch_cubs = true

func _on_detector_player_body_entered(body: Node2D) -> void:
	print("player entrou na area")
	set_physics_process(true)
	anim_tree.set("parameters/conditions/can_move", true)
	$detector_player.disconnect("body_entered", Callable(self, "_on_detector_player_body_entered"))

func _on_visible_screen_entered() -> void:
	print("Boss na area visivel")
	#sprite.visible = true
	#$visible.disconnect("screen_entered", Callable(self, "_on_visible_screen_entered"))
	
func _on_hurt_box_area_entered(area):
	if area.is_in_group("player") and not player_hit:
		player_hit = true
		#await get_tree().create_timer(0.1).timeout
		#turn_count = 0
		print("player hit me")
		take_damage()
	
func take_damage():
	boss_life -= GlobalSabrina.player_attack
	if is_instance_valid(healthbar):  # Verifica se a healthbar ainda é válida
		healthbar.health = boss_life

	if boss_life <= 0 and not is_dead:
		print("Iniciando animação de morte do boss")
		anim_tree.set("parameters/conditions/can_move", false)
		anim_tree.set("parameters/conditions/is_vunerable", false)
		dead_sfx.play()
		die()
	else:
		if is_instance_valid(healthbar):
			healthbar.visible = true  # Mostra a barra de vida ao sofrer dano

		# Altera a cor do inimigo para Preto
		sprite.modulate = Color(0, 0, 0)
		# Espera 0.2 segundos usando 'await'
		await get_tree().create_timer(0.2).timeout
		# Volta a cor ao normal (branco)
		sprite.modulate = Color(1, 1, 1)
		turn_count = 0
	
func die():
	is_dead = true
	emit_signal("boss_has_died")
	state_machine.travel("dead")  # Troca o estado diretamente
	await get_tree().create_timer(3).timeout
	queue_free()
