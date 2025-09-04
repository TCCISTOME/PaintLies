extends Area2D

@onready var potin_sfx: AudioStreamPlayer = $potin_sfx

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.name == "sabrina":
		$anim.play("colect")
		await $collision.call_deferred("queue_free")
		GlobalSabrina.countPotion += 1
		print("Colidiu com a poção")
		potin_sfx.play()


func _on_anim_animation_finished() -> void:
	queue_free()
