extends CharacterBody2D
const SPEED = 1500.0
const JUMP_VELOCITY = -400.0
var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dead := false
var xp_enemy = 50
# Variáveis do inimigo
@export var greenSlime_life := 50
@export var greenSlime_attack := 10
@export var greenSlime_xp := 200

@onready var body := $hitBox/collision as Area2D
@onready var wallDetector := $wallDetector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer

func _physics_process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Detecta colisão com a parede
	if wallDetector.is_colliding():
		direction *= -1
		wallDetector.scale.x *= -1
	
	# Inverte a textura com base na direção
	texture.flip_h = direction == 1

	velocity.x = direction * SPEED * delta
	move_and_slide()
	
	# Só executa walking se o inimigo não estiver morrendo
	if not is_dead and anim.current_animation != "attack":
		walking()

func walking():
	anim.play("walking")

#Função de hurt para receber dano do player 
func _on_hurt_box_area_entered(area):
	if greenSlime_life <= 0 and not is_dead:  # Verifica se o inimigo já morreu
		is_dead = true  # Marca o inimigo como morto
		Global.player_xp += xp_enemy
		die()
	else:
		if area.is_in_group("player"):
			take_damage()

# Função chamada ao morrer
func die():
	is_dead = true
	anim.play("dead")
	

# Função de ataque do inimigo
func _on_hit_box_area_entered(area):
	if area.is_in_group("player"):
		anim.play("attack")
		Global.player_defese -= greenSlime_attack
		if Global.player_defese <= 0:
			apply_damage_to_player()

# Sinal para quando a animação terminar
func _on_anim_animation_finished(anim_name):
	if anim_name == "attack":
		anim.play("walking")
	elif anim_name == "dead":
		queue_free()  # O inimigo só será removido quando a animação "dead" terminar


func apply_damage_to_player():
	Global.player_life -= greenSlime_attack

func take_damage():
	print("GS: ", greenSlime_life)
	greenSlime_life -= Global.player_attack 
	# Altera a cor do inimigo para vermelho
	texture.modulate = Color(1, 0, 0)  # Vermelho
	
	# Espera 0.2 segundos usando 'await'
	await get_tree().create_timer(0.2).timeout
	
	# Volta a cor ao normal (branco)
	texture.modulate = Color(1, 1, 1)  # Branco (cor original)
