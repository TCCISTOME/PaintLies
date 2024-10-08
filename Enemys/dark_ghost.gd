extends CharacterBody2D
const SPEED = 1500.0
const JUMP_VELOCITY = -400.0
var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dead := false

# Variáveis do inimigo
@export var darkGhost_life := 900
@export var darkGhost_attack := 5
@export var darkGhost_xp := 1300

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
	if darkGhost_life <= 0:
		die()
	else:
		take_damage()

# Função chamada ao morrer
func die():
	is_dead = true
	anim.play("dead")

# Função de ataque do inimigo
func _on_hit_box_area_entered(area):
	if area.is_in_group("player"):
		anim.play("attack")
		Global.player_defese -= darkGhost_attack
		print("Escudo: ", Global.player_defese)
		if Global.player_defese <= 0:
			print("Player atingido")
			apply_damage_to_player()

# Sinal para quando a animação terminar
func _on_anim_animation_finished(anim_name):
	if anim_name == "attack":
		anim.play("walking")
	elif anim_name == "dead":
		queue_free() 


func apply_damage_to_player():
	Global.player_life -= darkGhost_attack
	print("Vida do player: ", Global.player_life)

func take_damage():
	print("VDG: ", darkGhost_life)
	darkGhost_life -= Global.player_attack  
