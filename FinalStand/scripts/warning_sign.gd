extends Node2D

@onready var texture: Sprite2D = $texture
@onready var area_sign: Area2D = $area_sign

const lines : Array[String] = [
	"Bem-vindo, aventureiro!",
	"Preparado para enfretar suas inseguranças nessa ultima fase?",
	"Eu irei treina-lo para enfrentar o grande mal!",
	"Preparece!",
	"Primeiro, derrote esses monstros...",
	"Caso receba dano, use as poções de cura dropada por eles",
	"Após derrotar todos eles, a porta abrirá...",
	"Depois que passar por ela, use o treinamento para lutar!",
	"Boa sorte..."
]

func _unhandled_input(event):
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interagir") && !DialogManager.is_message_active:
			texture.hide()
			DialogManager.star_message(global_position, lines)
	else:
		texture.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
