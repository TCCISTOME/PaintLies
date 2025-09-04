extends AnimatableBody2D

@onready var sprite: Sprite2D = $sprite
@onready var collision: CollisionShape2D = $collision
@onready var collision_detector: CollisionShape2D = $collision_detector/collision
@onready var explosion_sfx: AudioStreamPlayer = $explosion_sfx


const SPEED := 300.0
const EXPLOSION = preload("res://jogo-sabrina/FinalStand/prefebs/explosion.tscn")

var velocity := Vector2.ZERO
var direction := Vector2.ZERO  # Alterado para Vector2

func _ready():
	set_direction(Vector2(1, 0))  # Direção padrão: para a direita


func _physics_process(delta):
	velocity = direction * SPEED * delta
	move_and_collide(velocity)

	# Verifica se o martelão está fora dos limites do mapa
	var viewport_rect = get_viewport().get_visible_rect()
	if not viewport_rect.has_point(global_position):
		# Desativa a física do martelão
		set_physics_process(false)  # Desativa o processamento físico do martelão
		collision.disabled = true  # Desativa a colisão
		collision_detector.disabled = true  # Desativa a colisão
		queue_free()  # Remove o martelão da cena


func set_direction(dir: Vector2):
	direction = dir.normalized()
	sprite.flip_h = direction.x < 0

func _on_collision_detector_body_entered(body):
	if body.name == "sabrina":
		print("Martelo bateu no player")
		visible = false
		
		explosion_sfx.play()
		var explosion_instance = EXPLOSION.instantiate()
		get_parent().add_child(explosion_instance)
		explosion_instance.global_position = global_position

		# Cria um Timer para adicionar o delay
		var delay_timer = Timer.new()
		delay_timer.wait_time = 0.05  # Tempo de espera (em segundos)
		delay_timer.one_shot = true  # Define como um timer de disparo único
		add_child(delay_timer)
		delay_timer.start()

		await delay_timer.timeout  # Aguarda o timer finalizar
		set_physics_process(false)  # Desativa o processamento físico do martelão
		collision.set_deferred("disabled", true)

		# Aguarda a animação apenas se o objeto ainda existir
		if is_instance_valid(explosion_instance):
			await explosion_instance.animation_finished

		queue_free()
