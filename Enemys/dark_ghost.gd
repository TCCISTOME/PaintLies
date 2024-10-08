extends CharacterBody2D

const SPEED = 1500.0
const JUMP_VELOCITY = -400.0

var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var darkGhost_life := 900
@export var darkGhost_attack := 50
@export var darkGhost_xp := 1300

var knockback_vetor := Vector2.ZERO
@onready var body := $hitBox/collision as Area2D
@onready var wallDetector := $wallDetector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer

func _physics_process(delta):
	# Adiciona a gravidade.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Detecta colisão com a parede
	if wallDetector.is_colliding():
		direction *= -1
		wallDetector.scale.x *= -1
	
	# Inverte a textura com base na direção
	texture.flip_h = direction == 1

	# Aplica o knockback, se houver
	if knockback_vetor != Vector2.ZERO:
		velocity += knockback_vetor

	velocity.x = direction * SPEED * delta
	move_and_slide()

# Função que detecta se o player entrou no hitbox
func _on_hit_box_area_entered(area):
	if area.is_in_group("player"):
		print("O inimigo atingiu o player")
		apply_damage_to_player()

# Função para aplicar o dano no player
func apply_damage_to_player():
	Global.player_life -= darkGhost_attack
	print("Vida do player: ", Global.player_life)

# Função que lida com o dano no inimigo
func take_damage():
	print("VDG: ", darkGhost_life)
	darkGhost_life -= Global.player_attack  # Subtrai o ataque do player da vida do inimigo

	# Se a vida do inimigo acabar, ele morre
	if darkGhost_life < 1:
		anim.play("dead")
		queue_free()
