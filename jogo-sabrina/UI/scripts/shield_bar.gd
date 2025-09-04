extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar
@onready var regenerador: Timer = $regenerador

# Variáveis para o escudo
var shield := GlobalSabrina.player_defese : set = _set_shield
var max_shield := GlobalSabrina.player_defese_max

func _ready() -> void:
	init_shield()
	if shield < max_shield:
		regenerador.start()  # Usar apenas o regenerador para a lógica de regeneração

# Função para definir o valor do escudo e atualizar a barra de defesa
func _set_shield(new_shield) -> void:
	shield = min(max_shield, new_shield)  # Garante que o escudo não ultrapasse o máximo
	GlobalSabrina.player_defese = shield  # Atualiza o valor global do escudo
	value = shield  # Atualiza a barra de escudo principal
	damage_bar.value = shield  # Atualiza a barra de dano visual

# Inicializa a barra de escudo com o valor atual e máximo
func init_shield() -> void:
	max_shield = GlobalSabrina.player_defese_max
	shield = GlobalSabrina.player_defese
	max_value = max_shield
	value = shield
	damage_bar.max_value = max_shield
	damage_bar.value = shield

	# Inicia o timer se o escudo estiver abaixo do máximo
	if shield < max_shield:
		timer.start()

# Função chamada a cada intervalo do timer para regenerar o escudo
func _on_timer_timeout() -> void:
	# Regenera o escudo se ele estiver abaixo do máximo
	if shield < max_shield:
		_set_shield(shield + 5)  # Usa _set_shield para aplicar a regeneração e atualizar visualmente
	else:
		timer.stop()  # Para o timer se o escudo estiver completo


func _on_regenerador_timeout() -> void:
	if shield < max_shield:
		_set_shield(shield + 5)
		damage_bar.value = shield
	else:
		regenerador.stop()
