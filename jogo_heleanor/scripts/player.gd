extends CharacterBody2D

var SPEED = 250.0
var JUMP_VELOCITY = -550.0

var animation_jump := false
var is_dead: bool = false
var knockback_power := 2
var knockback_vector := Vector2.ZERO

@onready var animation: AnimatedSprite2D = $animatedSprite
@onready var remote_transform: RemoteTransform2D = $remote

@onready var spawner: Marker2D = $"../spawner"
@onready var jump_sfx: AudioStreamPlayer = $jump_sfx
@onready var attack_sfx: AudioStreamPlayer = $attack_sfx
@onready var hurt_sfx: AudioStreamPlayer = $hurt_sfx
@onready var die_sfx: AudioStreamPlayer = $die_sfx
@onready var drink_sfx: AudioStreamPlayer = $drink_sfx


signal Heleanor_has_died()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attack = false
var is_drink = false
var is_down = false
var down_x1 = true
var is_jump = false


func _physics_process(delta):
	if is_dead:
		return  # Ignora todo o código abaixo se o jogador está morto
		
	drop_plataform()
	
	# Aplica física independente do estado
	apply_gravity(delta)
	
	if !is_attack && !is_drink:
		move(delta)
		
	
	if !animation_jump:
		potionLife_drink()
	
		
	check_void()


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func move(delta):
	# Aplicando gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Verifica se as teclas de pular e andar estão pressionadas
	var is_moving = Input.get_axis("move_left", "move_right") != 0
	var is_jumping = Input.is_action_pressed("move_up") and is_on_floor()
	
	if is_jumping:
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()
		animation_jump = true
		is_jump = true

	if is_on_floor():
		animation_jump = false
		down_x1 = true
	
	if not is_on_floor() and animation.animation != "up":
		is_down = true
		if is_down and down_x1:
			animation.play("down")
			down_x1 = false
			is_down = false
	
	# Andar para a direita e para a esquerda
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		
		if is_jumping and is_moving:
			animation.play("up")
		if  is_moving and is_on_floor():
			animation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if animation_jump and is_jump:
			animation.play("up")
			if animation.animation_finished:
				is_jump = false
		elif is_on_floor():
			animation.play("idle")
	
	# Aplicando o knockback, se houver
	if knockback_vector != Vector2.ZERO:
		velocity += knockback_vector

	# Realiza o movimento com o knockback e gravidade aplicados
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)


func potionLife_drink():
	# Verifica se a animação de beber terminou
	if not animation.is_playing():
		is_drink = false

	# Verifica se o botão "beber" foi pressionado e o player está no chão
	if Input.is_action_just_pressed("beber_pocao") and is_on_floor() and not is_drink:
		# Condição para usar uma poção
		if GlobalSabrina.countPotionHelanor > 0:
			# Ativa a animação de beber
			is_drink = true
			animation.play("drink")
			drink_sfx.play()
			# Aumenta a vida do player 
			GlobalSabrina.countLifeHelanor += 1
			# Diminui o número de poções
			GlobalSabrina.countPotionHelanor -= 1

func drop_plataform():
	if Input.is_action_just_pressed("move_down"):
		position.y += 4

func dead():
	if is_dead:  # Verifica se o personagem já está morto para evitar repetição
		return
	is_dead = true
	die_sfx.play()
	emit_signal("Heleanor_has_died")
	animation.play("die")
	
func _on_anim_animation_finished() -> void:
	if is_dead and animation.animation == "die":
		print("Retirando player de cena")
		queue_free()  # Remove o personagem da cena

func _on_hurt_box_body_entered(body: Node2D)-> void:
	if is_dead:
		return  # Ignora dano se o jogador já está morto
	var knockback = Vector2((global_position.x - body.global_position.x) * knockback_power, -50)
	take_damage(knockback)

#Aplicar dano de inimigos
func take_damage(knockback_force := Vector2.ZERO, duration := 0.15):
	if GlobalSabrina.countLifeHelanor > 0:
		hurt_sfx.play()
		is_dead = false
		GlobalSabrina.countLifeHelanor -= 1
		
		# Teletransporta o jogador para a posição do spawner
		var spawner_position = spawner.global_position
		global_position = spawner_position
		print("Jogador teletransportado para: ", spawner_position)
		
	elif GlobalSabrina.countLifeHelanor <= 0:
		dead()

	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1, 0, 0, 1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1, 1, 1, 1), duration)
		

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func handle_death_zone():
	take_damage()

func check_void():
	if global_position.y > 1000:
		set_physics_process(false)
		dead()
