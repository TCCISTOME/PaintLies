extends CharacterBody2D
const SPEED = 1500.0
const JUMP_VELOCITY = -400.0
const potion_instance = preload("res://UI/scenes/potion_rigid.tscn")
var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dead := false

# Variáveis do inimigo
@export var darkGhost_life := 500
@export var darkGhost_attack := 20
@export var xp := 2

@onready var spawn_potion: Marker2D = $spawn_potion
@onready var body := $hitBox/collision as Area2D
@onready var wallDetector := $wallDetector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer
@onready var floorDetector := $floorDetector as RayCast2D  # Detector de chão
@onready var healthbar = $HealthBar #Barra de vida

func _ready() -> void:
	healthbar.init_health(darkGhost_life)
	healthbar.visible = false  # A barra de vida começa invisível

func _physics_process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Detecta colisão com a parede ou falta de chão
	if wallDetector.is_colliding() or not floorDetector.is_colliding():
		direction *= -1
		wallDetector.scale.x *= -1
		floorDetector.scale.x *= -1
		
	# Inverte a textura com base na direção
	texture.flip_h = direction == 1

	velocity.x = direction * SPEED * delta
	move_and_slide()
	
	# Só executa walking se o inimigo não estiver morrendo
	if not is_dead and anim.current_animation != "attack":
		walking()
	# Valida se a personagem caiu no void
	check_void()

func create_potion():
	var potion = potion_instance.instantiate()
	get_parent().call_deferred("add_child", potion)
	potion.global_position = spawn_potion.global_position
	potion.apply_impulse(Vector2(randi_range(-50,50), -200))
	
	

# Função para verificar se a personagem caiu no void
func check_void():
	if global_position.y > 10000:
		die()


func walking():
	anim.play("walking")

#Inimigo recebendo dano
func _on_hurt_box_area_entered(area):
	if darkGhost_life <= 0 and not is_dead:
		is_dead = true
		die()
	else:
		if area.is_in_group("player"):
			take_damage()
			
	if is_instance_valid(healthbar):  # Confirma se ainda existe healthbar
		healthbar.health = darkGhost_life

func die():
	is_dead = true
	
	Global.countXp += xp
	anim.play("dead")
	

# Player recebendo dano
func _on_hit_box_area_entered(area):
	if is_dead:  # Verifica se o inimigo está morto
		return  # Se o inimigo estiver morto, não ataca
	
	if area.is_in_group("player"):
		anim.play("attack")
		Global.player_defese -= darkGhost_attack
		if Global.player_defese <= 0:
			apply_damage_to_player()

# Sinal para quando a animação terminar
func _on_anim_animation_finished(anim_name):
	if anim_name == "attack":
		anim.play("walking")
	elif anim_name == "dead":
		create_potion()
		queue_free()

#Subtraindo a vida do player
func apply_damage_to_player():
	Global.player_life -= darkGhost_attack
	print("Vida do player: ", Global.player_life)

#Subtraindo a vida do inimigo e exibindo animação de dano
# Função para receber dano
func take_damage():
	print("VDG: ", darkGhost_life)
	darkGhost_life -= Global.player_attack

	if is_instance_valid(healthbar):  # Verifica se a healthbar ainda é válida
		healthbar.health = darkGhost_life

	if darkGhost_life <= 0:
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
