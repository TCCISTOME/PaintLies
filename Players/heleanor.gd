extends CharacterBody2D

var SPEED = 250.0
var JUMP_VELOCITY = -370.0
var animation_jump := false
var is_dead: bool = false

@export var player_life := 10
var knockback_vetor := Vector2.ZERO

@onready var animation := $anim as AnimatedSprite2D
@onready var hitbox := $hitBox/collison as CollisionShape2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attack = false
var is_drink = false
var is_down = false
var down_x1 = true
var is_jump = false

var attack := 50

func _physics_process(delta):
	drop_plataform()
	
	if !is_attack && !is_drink:
		move(delta)
		
	if !is_drink && !animation_jump:
		attack_player()
	
	if !animation_jump:
		drink()
		
	check_void()

# Função para verificar se a personagem caiu no void
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
		print("XP: ",Global.player_xp)
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
		$hitBox/collison.disabled = true
		
	if Input.is_action_just_pressed("ataque") and is_on_floor():
		is_attack = true
		animation.play("attack")
		$hitBox/collison.disabled = false

func drink():
	if not animation.is_playing():
		is_drink = false
	if Input.is_action_just_pressed("beber") and is_on_floor():
		is_drink = true
		animation.play("drink")

func drop_plataform():
	if Input.is_action_just_pressed("descer"):
		position.y += 4

func dead():
	get_tree().quit()  
	# get_tree().change_scene("res://path_para_sua_cena_de_game_over.tscn")

func _on_hurt_box_body_entered(_body):
	print("PL: ", Global.player_life )
	print("PE: ", Global.player_defese )
	if Global.player_life <= 0:
		dead()
	else:
		if $ray_right.is_colliding():
			knockBack(Vector2(-280,-70))
		elif $ray_left.is_colliding():
			knockBack(Vector2(280,-70))
		elif $ray_bottom.is_colliding():
			knockBack(Vector2(300,-70))




func knockBack(knockback_force := Vector2.ZERO, duration := 0.15):
	if knockback_force != Vector2.ZERO:
		knockback_vetor = knockback_force
		# Tween para resetar o knockback
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vetor", Vector2.ZERO, duration)
		animation.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)





func _on_anim_animation_finished():
	pass # Replace with function body.
