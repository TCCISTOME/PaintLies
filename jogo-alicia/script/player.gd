extends Area2D
const SPEED := 400

@onready var screen_size = get_viewport_rect().size
@onready var anim = $anim
@onready var collision: CollisionShape2D = $collision
@onready var drink_sfx: AudioStreamPlayer = $drink_sfx

var viva:bool = true
var bebendo:bool = false
var PocaoResto: int = 5

@export var timerBebida:Timer = null

signal hit
signal beber

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (viva == true):
		if (bebendo == false):
			var velocity = Input.get_vector("move_left","move_right","move_up","move_down")
			
			if velocity.length() > 0:
				velocity = velocity.normalized() * SPEED
			
			if velocity.x != 0:
				anim.play("move")
			elif velocity.y > 0:
				anim.play("move_down")
			elif  velocity.y < 0:
				anim.play("move_up")
			else:
				anim.play("idle")
			if (velocity.x > 0):
				anim.flip_h = false  # Se estiver indo para a direita, não espelha
			else:
				anim.flip_h = true   # Se estiver indo para a esquerda, espelha horizontalmente
			position += velocity * delta
			position = position.clamp(Vector2.ZERO, screen_size)
	
		BeberPocao()
		
#Verificação da colisão do player com os Bugs
func _on_body_entered(_body):
	viva = false
	hit.emit()
	collision.set_deferred("disabled", true)

func start_pos(pos):
	position = pos
	show()
	collision.disabled = false
	
func BeberPocao():
	if (Input.is_action_just_pressed("beber_pocao") && PocaoResto > 0 && self["scale"] == Vector2(3,3)):
			PocaoResto -= 1
			drink_sfx.play()
			anim.play("drink_potion")
			emit_signal("beber")
			bebendo = true
			await anim.animation_finished 
			bebendo = false
			self["scale"] = Vector2(2,2)
			timerBebida.start()

func _on_timer_timeout() -> void:
	self["scale"] = Vector2(3,3)
