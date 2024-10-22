extends CharacterBody2D
const SPEED = 1500.0
const JUMP_VELOCITY = -400.0
var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dead := false
var xp_enemy = 50
# Variáveis do inimigo
@export var yellowSlime_life := 100
@export var yellowSlime_attack := 10
@export var yellowSlime_xp := 400

@onready var body := $hitBox/collision as Area2D
@onready var wallDetector := $wallDetector as RayCast2D
@onready var floorDetector := $floorDetector as RayCast2D  # Detector de chão
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer


func _physics_process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Detecta colisão com a parede
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

func walking():
	anim.play("walking")
#
func hurtBoxYellow(area: Area2D) -> void:
	if yellowSlime_life <= 0 and not is_dead:  # Verifica se o inimigo já morreu
		print("O inimigo morreu!")  # Verifique se essa linha está sendo executada
		is_dead = true  # Marca o inimigo como morto
		Global.player_xp += xp_enemy
		die()
	else:
		if area.is_in_group("player"):
			take_damage()

# Função chamada ao morrer
func die():
	is_dead = true
	$hitBox/collision.disabled = true
	print("Iniciando animação de morte")
	anim.play("dead")

# Sinal para quando a animação terminar
func _on_anim_animation_finished(anim_name):
	if anim_name == "attack":
		anim.play("walking")
	elif anim_name == "dead":
		print("Animação de morte finalizada, removendo inimigo")
		queue_free()

# Função de ataque do inimigo
func _on_hit_box_area_entered(area):
	if area.is_in_group("player"):
		anim.play("attack")
		Global.player_defese -= yellowSlime_attack
		print("Escudo: ", Global.player_defese)
		if Global.player_defese <= 0:
			print("Player atingido")
			apply_damage_to_player()

func apply_damage_to_player():
	Global.player_life -= yellowSlime_attack
	print("Vida do player: ", Global.player_life)

func take_damage():
	print("YS: ", yellowSlime_life)
	yellowSlime_life -= Global.player_attack 
	# Altera a cor do inimigo para vermelho
	texture.modulate = Color(1, 0, 0)  # Vermelho
	
	# Espera 0.2 segundos usando 'await'
	await get_tree().create_timer(0.2).timeout
	
	# Volta a cor ao normal (branco)
	texture.modulate = Color(1, 1, 1)  # Branco (cor original)
