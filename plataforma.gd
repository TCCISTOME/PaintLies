extends StaticBody2D

@onready var collison = $CollisionShape2D
@onready var area = $Area2D




func _unhandled_input(event) -> void:
	
		if event.is_action_pressed("descer"):
			area.set_deferred("monitoring", true)
			#print('teste')
		

#func disable():
	#area.set_deferred("monitoring", true)

func _on_area_2d_body_entered(body):
	collison.set_deferred("disabled", true)


func _on_area_2d_body_exited(body):
	area.set_deferred("monitoring", false)
	collison.set_deferred("disabled", false)
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


