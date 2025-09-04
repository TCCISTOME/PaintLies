extends AnimatableBody2D

@onready var animation := $animation as AnimationPlayer
@onready var respawnTimer := $respawnTimer as Timer
@onready var respawn_position := global_position

@export var reset_timer := 3.0

var velocity := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered := false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity.y += gravity * _delta
	position += velocity * _delta

func has_collided_with(_collision: KinematicCollision2D, _collider: CharacterBody2D):
	if !is_triggered:
		is_triggered = true
		animation.play("shake")
		velocity = Vector2.ZERO
		
func _on_animation_animation_finished(_anim_name: StringName) -> void:
	set_physics_process(true)
	respawnTimer.start(reset_timer)
	
	


func _on_respawn_timer_timeout() -> void:
	set_physics_process(false)
	global_position = respawn_position
	if is_triggered:
		var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spawn_tween.tween_property($texture, "scale", Vector2(1,1), 0.2).from(Vector2(0,0))
	
	is_triggered = false
