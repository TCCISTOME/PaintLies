extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var animation: AnimatedSprite2D = null

func _ready():
	animation.play("Comerciante")

func _physics_process(delta): 
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	
	


	
