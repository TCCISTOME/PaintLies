extends Resource
class_name SaveGame
var save_path := "user://savegame.tres"
var savegame

@export var jogoJosh: Dictionary = {
	"ultimoDesempenho": 0,
	"melhorDesempenho": 0,
	"numeroDesempenho": 0
}
#jogo Josh
func save_game():
	ResourceSaver.save(self,save_path)
func load_game():
	var loaded_data = ResourceLoader.load("user://savegame.tres")
	if loaded_data != null:
		savegame = loaded_data as SaveGame
	return SaveGame

func setJogoJosh(dictionary:Dictionary):
	jogoJosh = dictionary
	
