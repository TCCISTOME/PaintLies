extends CharacterBody2D


const SPEED = 1200.0
const JUMP_VELOCITY = -400.0
const potion_instance = preload("res://jogo_heleanor/prefabs/potion_heleanor_rigid.tscn")

@onready var wallDetector := $wallDetector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var animation: AnimationPlayer = $animation
@onready var floor_detector: RayCast2D = $floorDetector
@onready var spawn_potion: Marker2D = $spawn_potion


var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation.play("walk")
		
	# Detecta colisão com a parede ou falta de chão
	if wallDetector.is_colliding() or not floor_detector.is_colliding():
		direction *= -1
		wallDetector.scale.x *= -1
		floor_detector.scale.x *= -1
		

	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
	
	velocity.x = direction * SPEED * delta
	move_and_slide()
	
	check_void()


func create_potion():
	var potion = potion_instance.instantiate()
	get_parent().call_deferred("add_child", potion)
	potion.global_position = spawn_potion.global_position
	potion.apply_impulse(Vector2(randi_range(-50,50), -200))

func check_void():
	if global_position.y > 10000:
		queue_free()





func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		create_potion()
		queue_free()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.velocity.y = JUMP_VELOCITY - 200
		animation.play("hurt")
