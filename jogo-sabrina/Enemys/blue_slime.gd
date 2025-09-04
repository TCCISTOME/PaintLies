extends CharacterBody2D
const SPEED = 1500.0
const JUMP_VELOCITY = -400.0
const potion_instance = preload("res://jogo-sabrina/UI/scenes/potion_rigid.tscn")

var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dead := false

# Variáveis do inimigo
@export var blueSlime_life := 300
@export var xp := 1

@onready var wallDetector := $wallDetector as RayCast2D
@onready var floorDetector := $floorDetector as RayCast2D  # Detector de chão
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer
@onready var healthbar = $HealthBar
@onready var spawn_potion: Marker2D = $spawn_potion


func _ready() -> void:
	healthbar.init_health(blueSlime_life)
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

func create_potion():
	var potion = potion_instance.instantiate()
	get_parent().call_deferred("add_child", potion)
	potion.global_position = spawn_potion.global_position
	potion.apply_impulse(Vector2(randi_range(-50,50), -200))

func walking():
	anim.play("walking")

# Função chamada ao morrer
func die():
	is_dead = true
	GlobalSabrina.countXp += xp
	anim.play("dead")
	
	


# Sinal para quando a animação terminar
func _on_anim_animation_finished(anim_name):
	if anim_name == "attack":
		anim.play("walking")
	elif anim_name == "dead":
		create_potion()
		queue_free()  # O inimigo só será removido quando a animação "dead" terminar

func take_damage():
	if is_dead:  # Impede que o inimigo receba dano se já estiver morto
		return
	print("BS: ", blueSlime_life)

	blueSlime_life -= GlobalSabrina.player_attack
	healthbar.health = blueSlime_life

	if blueSlime_life <= 0:
		healthbar.visible = false  # Esconde a barra de vida quando o slime morre
		die()
	else:
		healthbar.visible = true  # Mostra a barra de vida ao sofrer dano
	texture.modulate = Color(0, 0, 0)  # Muda para Preto
	await get_tree().create_timer(0.2).timeout
	texture.modulate = Color(1, 1, 1)  # Volta para branco



func _on_hurt_box_area_entered(area: Area2D) -> void:
	if blueSlime_life <= 0 and not is_dead:  # Verifica se o inimigo já morreu
		is_dead = true  # Marca o inimigo como morto
		
		die()
	else:
		if area.is_in_group("player"):
			take_damage()
			
	if is_instance_valid(healthbar):
		healthbar.health = blueSlime_life  # Apenas atualiza se o healthbar ainda existir
