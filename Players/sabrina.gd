extends CharacterBody2D

var SPEED = 250.0
var JUMP_VELOCITY = -370.0

var animation_jump := false
@onready var animation := $anim as AnimatedSprite2D
# @onready var raycast = $RayCast2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attack = false
var is_drink = false
var is_down = false
var down_x1 = true
var is_jump = false

func _physics_process(delta):
	drop_plataform()
	
	if !is_attack && !is_drink:
		move(delta)
		
	if !is_drink && !animation_jump:
		attack_player()
	
	if !animation_jump:
		drink()
	
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
	
	move_and_slide()
	
func attack_player():
	if not animation.is_playing():
		is_attack = false
	if Input.is_action_just_pressed("ataque") and is_on_floor():
		is_attack = true
		animation.play("attackBlack")
	
func drink():
	if not animation.is_playing():
		is_drink = false
	if Input.is_action_just_pressed("beber") and is_on_floor():
		is_drink = true
		animation.play("drink")

func drop_plataform():
	if Input.is_action_just_pressed("descer"):
		position.y += 4
