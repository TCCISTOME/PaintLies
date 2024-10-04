extends CharacterBody2D

const SPEED = 1500.0
const JUMP_VELOCITY = -400.0

var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var darkGhost_life := 50
var knockback_vetor := Vector2.ZERO

@onready var rayRight := $rayRight as RayCast2D
@onready var rayLeft := $rayLeft as RayCast2D
@onready var wallDetector := $wallDetector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if wallDetector.is_colliding():
		direction *= -1
		wallDetector.scale.x *= -1
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false

	# Aplicando o knockback, se houver
	if knockback_vetor != Vector2.ZERO:
		velocity += knockback_vetor

	velocity.x = direction * SPEED * delta

	move_and_slide()

#func _on_anim_animation_finished(anim_name):
	#if anim_name == "dead":
		#print("morreu")
		#queue_free()
		


func _on_hurt_box_area_entered(area):
	#if area.name == "hitBox":
		#print("Darkghost_life = ", darkGhost_life)
		#darkGhost_life -= Global.player_attack   
		#if darkGhost_life < 1:
			#anim.play("dead")
			#queue_free()

	
	if darkGhost_life < 1:
		queue_free()
	else:
		if $rayRight.is_colliding():
			print("Entrou no if 1")
			#Vector com valores em (x,y)
			take_damage(Vector2(-580,-30))
		if $rayLeft.is_colliding():
			print("Entrou no if 2")
			take_damage(Vector2(-580,50))
		
func take_damage(knockback_force := Vector2.ZERO, duration := 0.15):
	print("Entrou no take_demage")
	darkGhost_life -= Global.dark_ghost
	if knockback_force != Vector2.ZERO:
		knockback_vetor = knockback_force
		# Tween para resetar o knockback
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vetor", Vector2.ZERO, duration)
		#animation.modulate = Color(1,0,0,1)
		#knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)



	
	


