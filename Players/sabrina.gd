extends CharacterBody2D

var SPEED = 250.0
var JUMP_VELOCITY = -370.0
var animation_jump := false
var is_dead: bool = false
var knockback_power := 15

var knockback_vetor := Vector2.ZERO

@onready var animation := $anim as AnimatedSprite2D
@onready var hitbox := $hitBox/collision as CollisionShape2D
@onready var healthbar = $CanvasLayer/HealthBar
@onready var shieldBar = $CanvasLayer/shieldBar
@onready var remote_transform: RemoteTransform2D = $remote

signal player_has_died()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attack = false
var is_drink = false
var is_down = false
var down_x1 = true
var is_jump = false


func _ready() -> void:
	healthbar.init_health(Global.player_life)
	shieldBar.init_shield()  # Chama init_shield sem argumentos
	
func _physics_process(delta):
	drop_plataform()
	
	if !is_attack && !is_drink:
		move(delta)
		
	if !is_drink && !animation_jump:
		attack_player()
	
	if !animation_jump:
		potionLife_drink()
		
	check_void()

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func check_void():
	if global_position.y > 1000:
		dead()

func move(delta):
	# Aplicando gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Verifica se as teclas de pular e andar estão pressionadas
	var is_moving = Input.get_axis("esquerda", "direita") != 0
	var is_jumping = Input.is_action_pressed("pular") and is_on_floor()
	
	if is_jumping:
		velocity.y = JUMP_VELOCITY
		animation_jump = true
		is_jump = true

	if is_on_floor():
		animation_jump = false
		down_x1 = true
	
	if not is_on_floor() and animation.animation != "jump":
		is_down = true
		if is_down and down_x1:
			animation.play("down")
			down_x1 = false
			is_down = false
	
	# Andar para a direita e para a esquerda
	var direction = Input.get_axis("esquerda", "direita")
	
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		$hitBox.scale.x = direction
		
		if is_jumping and is_moving:
			animation.play("jump")
		if  is_moving and is_on_floor():
			animation.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if animation_jump and is_jump:
			animation.play("jump")
			if animation.animation_finished:
				is_jump = false
		elif is_on_floor():
			animation.play("side")
	
	# Aplicando o knockback, se houver
	if knockback_vetor != Vector2.ZERO:
		velocity += knockback_vetor

	# Realiza o movimento com o knockback e gravidade aplicados
	move_and_slide()

func attack_player():
	if not animation.is_playing():
		is_attack = false
		$hitBox/collision.disabled = true
		
	if Input.is_action_just_pressed("ataque") and is_on_floor():
		is_attack = true
		animation.play("attack")
		$hitBox/collision.disabled = false

func potionLife_drink():
	# Verifica se a animação de beber terminou
	if not animation.is_playing():
		is_drink = false

	# Verifica se o botão "beber" foi pressionado e o player está no chão
	if Input.is_action_just_pressed("beber") and is_on_floor() and not is_drink:
		# Condição para usar uma poção
		if Global.countPotion > 0 and Global.player_life < Global.player_life_max:
			# Ativa a animação de beber
			is_drink = true
			animation.play("drink")

			# Aumenta a vida do player em 5, mas não ultrapassa o máximo
			Global.player_life = min(Global.player_life + 5, Global.player_life_max)

			# Atualiza a barra de vida para refletir a nova vida
			if is_instance_valid(healthbar):
				healthbar.health = Global.player_life

			# Diminui o número de poções
			Global.countPotion -= 1




func drop_plataform():
	if Input.is_action_just_pressed("descer"):
		position.y += 4

func dead():
	queue_free()
	emit_signal("player_has_died")

func _on_hurt_box_body_entered(body: Node2D)-> void:
	print("PL: ", Global.player_life )
	print("PE: ", Global.player_defese )
	var knockback = Vector2((global_position.x - body.global_position.x) * knockback_power, -50)
	knockBack(knockback)
	if Global.player_life <= 0:
		dead()
	if is_instance_valid(shieldBar):
		shieldBar.shield = Global.player_defese  # Apenas atualiza se o shieldBar ainda existir
		
	if is_instance_valid(healthbar):
		healthbar.health = Global.player_life  # Apenas atualiza se o healthbar ainda existir

func knockBack(knockback_force := Vector2.ZERO, duration := 0.15):
	if knockback_force != Vector2.ZERO:
		knockback_vetor = knockback_force
		# Tween para resetar o knockback
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vetor", Vector2.ZERO, duration)
		animation.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
