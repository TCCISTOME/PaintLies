extends Node2D
var tamanhoTela = Vector2();
const notaMusical: = preload("res://cenas/nota_musical.tscn")


var beatmap={
	"beats": [
		{
			"time": 0.8823582766439909,
			"arrow": "Cima"
		},
		{
			"time": 1.5905668934240362,
			"arrow": "Direita"
		},
		{
			"time": 2.3103854875283445,
			"arrow": "Baixo"
		},
		{
			"time": 3.006984126984127,
			"arrow": "Baixo"
		},
		{
			"time": 3.7035827664399092,
			"arrow": "Cima"
		},
		{
			"time": 4.4117913832199545,
			"arrow": "Esquerda"
		},
		{
			"time": 5.131609977324263,
			"arrow": "Baixo"
		},
		{
			"time": 5.828208616780046,
			"arrow": "Direita"
		},
		{
			"time": 6.501587301587302,
			"arrow": "Cima"
		},
		{
			"time": 7.174965986394557,
			"arrow": "Esquerda"
		},
		{
			"time": 7.90639455782313,
			"arrow": "Baixo"
		},
		{
			"time": 8.649433106575964,
			"arrow": "Direita"
		},
		{
			"time": 9.357641723356009,
			"arrow": "Cima"
		},
		{
			"time": 10.042630385487529,
			"arrow": "Esquerda"
		},
		{
			"time": 10.7740589569161,
			"arrow": "Baixo"
		},
		{
			"time": 11.470657596371883,
			"arrow": "Direita"
		},
		{
			"time": 12.1556462585034,
			"arrow": "Cima"
		},
		{
			"time": 12.887074829931972,
			"arrow": "Esquerda"
		},
		{
			"time": 13.572063492063492,
			"arrow": "Baixo"
		},
		{
			"time": 14.268662131519275,
			"arrow": "Esquerda"
		},
		{
			"time": 15.000090702947846,
			"arrow": "Cima"
		},
		{
			"time": 15.70829931972789,
			"arrow": "Esquerda"
		},
		{
			"time": 16.416507936507937,
			"arrow": "Baixo"
		},
		{
			"time": 17.08988662131519,
			"arrow": "Direita"
		},
		{
			"time": 17.76326530612245,
			"arrow": "Cima"
		},
		{
			"time": 18.517913832199547,
			"arrow": "Esquerda"
		},
		{
			"time": 19.272562358276645,
			"arrow": "Baixo"
		},
		{
			"time": 19.9459410430839,
			"arrow": "Direita"
		},
		{
			"time": 20.654149659863947,
			"arrow": "Cima"
		},
		{
			"time": 21.36235827664399,
			"arrow": "Esquerda"
		},
		{
			"time": 22.058956916099774,
			"arrow": "Baixo"
		},
		{
			"time": 22.76716553287982,
			"arrow": "Direita"
		},
		{
			"time": 23.4637641723356,
			"arrow": "Cima"
		},
		{
			"time": 24.18358276643991,
			"arrow": "Esquerda"
		},
		{
			"time": 24.88018140589569,
			"arrow": "Baixo"
		},
		{
			"time": 25.588390022675735,
			"arrow": "Esquerda"
		},
		{
			"time": 26.296598639455784,
			"arrow": "Cima"
		},
		{
			"time": 27.00480725623583,
			"arrow": "Esquerda"
		},
		{
			"time": 27.724625850340136,
			"arrow": "Baixo"
		},
		{
			"time": 28.421224489795918,
			"arrow": "Direita"
		},
		{
			"time": 29.1178231292517,
			"arrow": "Cima"
		},
		{
			"time": 29.826031746031745,
			"arrow": "Esquerda"
		},
		{
			"time": 30.53424036281179,
			"arrow": "Baixo"
		},
		{
			"time": 31.24244897959184,
			"arrow": "Direita"
		},
		{
			"time": 31.93904761904762,
			"arrow": "Cima"
		},
		{
			"time": 32.658866213151924,
			"arrow": "Esquerda"
		},
		{
			"time": 33.35546485260771,
			"arrow": "Baixo"
		},
		{
			"time": 34.05206349206349,
			"arrow": "Direita"
		},
		{
			"time": 34.76027210884354,
			"arrow": "Cima"
		},
		{
			"time": 35.48009070294785,
			"arrow": "Esquerda"
		},
		{
			"time": 36.19990929705215,
			"arrow": "Baixo"
		},
		{
			"time": 36.884897959183675,
			"arrow": "Esquerda"
		},
		{
			"time": 37.581496598639454,
			"arrow": "Cima"
		},
		{
			"time": 38.301315192743765,
			"arrow": "Esquerda"
		},
		{
			"time": 38.99791383219954,
			"arrow": "Baixo"
		},
		{
			"time": 39.717732426303854,
			"arrow": "Direita"
		},
		{
			"time": 40.41433106575964,
			"arrow": "Cima"
		},
		{
			"time": 41.12253968253968,
			"arrow": "Esquerda"
		},
		{
			"time": 41.81913832199547,
			"arrow": "Baixo"
		},
		{
			"time": 42.52734693877551,
			"arrow": "Direita"
		},
		{
			"time": 43.23555555555556,
			"arrow": "Cima"
		},
		{
			"time": 43.9437641723356,
			"arrow": "Esquerda"
		},
		{
			"time": 44.651972789115646,
			"arrow": "Baixo"
		},
		{
			"time": 45.360181405895695,
			"arrow": "Direita"
		},
		{
			"time": 46.05678004535147,
			"arrow": "Cima"
		},
		{
			"time": 46.776598639455784,
			"arrow": "Direita"
		},
		{
			"time": 47.484807256235825,
			"arrow": "Baixo"
		},
		{
			"time": 48.18140589569161,
			"arrow": "Esquerda"
		},
		{
			"time": 48.88961451247165,
			"arrow": "Cima"
		},
		{
			"time": 49.5978231292517,
			"arrow": "Direita"
		},
		{
			"time": 50.29442176870748,
			"arrow": "Baixo"
		},
		{
			"time": 51.00263038548753,
			"arrow": "Direita"
		},
		{
			"time": 51.699229024943314,
			"arrow": "Cima"
		},
		{
			"time": 52.41904761904762,
			"arrow": "Esquerda"
		},
		{
			"time": 53.127256235827666,
			"arrow": "Baixo"
		},
		{
			"time": 53.823854875283445,
			"arrow": "Direita"
		},
		{
			"time": 54.53206349206349,
			"arrow": "Cima"
		},
		{
			"time": 55.240272108843534,
			"arrow": "Esquerda"
		},
		{
			"time": 55.913650793650795,
			"arrow": "Baixo"
		},
		{
			"time": 56.64507936507937,
			"arrow": "Baixo"
		},
		{
			"time": 57.35328798185941,
			"arrow": "Cima"
		},
		{
			"time": 58.06149659863946,
			"arrow": "Direita"
		},
		{
			"time": 58.7697052154195,
			"arrow": "Baixo"
		},
		{
			"time": 59.466303854875285,
			"arrow": "Baixo"
		},
		{
			"time": 60.162902494331064,
			"arrow": "Cima"
		},
		{
			"time": 60.824671201814056,
			"arrow": "Direita"
		},
		{
			"time": 61.59092970521542,
			"arrow": "Baixo"
		},
		{
			"time": 62.2875283446712,
			"arrow": "Baixo"
		},
		{
			"time": 62.98412698412698,
			"arrow": "Cima"
		},
		{
			"time": 63.63428571428572,
			"arrow": "Esquerda"
		},
		{
			"time": 64.41215419501134,
			"arrow": "Baixo"
		},
		{
			"time": 65.10875283446713,
			"arrow": "Baixo"
		},
		{
			"time": 65.81696145124717,
			"arrow": "Cima"
		},
		{
			"time": 66.53678004535148,
			"arrow": "Esquerda"
		},
		{
			"time": 67.24498866213152,
			"arrow": "Baixo"
		},
		{
			"time": 67.9415873015873,
			"arrow": "Direita"
		},
		{
			"time": 68.64979591836735,
			"arrow": "Cima"
		},
		{
			"time": 69.3231746031746,
			"arrow": "Esquerda"
		},
		{
			"time": 70.04299319727892,
			"arrow": "Baixo"
		},
		{
			"time": 70.76281179138321,
			"arrow": "Direita"
		},
		{
			"time": 71.47102040816327,
			"arrow": "Cima"
		},
		{
			"time": 72.17922902494331,
			"arrow": "Esquerda"
		},
		{
			"time": 72.8758276643991,
			"arrow": "Baixo"
		},
		{
			"time": 73.59564625850341,
			"arrow": "Direita"
		},
		{
			"time": 74.29224489795918,
			"arrow": "Cima"
		},
		{
			"time": 75.01206349206349,
			"arrow": "Esquerda"
		},
		{
			"time": 75.68544217687075,
			"arrow": "Direita"
		},
		{
			"time": 76.38204081632654,
			"arrow": "Cima"
		},
		{
			"time": 77.1134693877551,
			"arrow": "Cima"
		},
		{
			"time": 77.83328798185941,
			"arrow": "Esquerda"
		},
		{
			"time": 78.54149659863945,
			"arrow": "Baixo"
		},
		{
			"time": 79.23809523809524,
			"arrow": "Direita"
		},
		{
			"time": 79.94630385487528,
			"arrow": "Cima"
		},
		{
			"time": 80.65451247165532,
			"arrow": "Esquerda"
		},
		{
			"time": 81.35111111111111,
			"arrow": "Baixo"
		},
		{
			"time": 82.05931972789115,
			"arrow": "Direita"
		},
		{
			"time": 82.75591836734694,
			"arrow": "Cima"
		},
		{
			"time": 83.47573696145125,
			"arrow": "Direita"
		},
		{
			"time": 84.19555555555556,
			"arrow": "Baixo"
		},
		{
			"time": 84.89215419501134,
			"arrow": "Esquerda"
		},
		{
			"time": 85.58875283446712,
			"arrow": "Cima"
		},
		{
			"time": 86.29696145124717,
			"arrow": "Esquerda"
		},
		{
			"time": 87.00517006802721,
			"arrow": "Baixo"
		},
		{
			"time": 87.71337868480725,
			"arrow": "Baixo"
		},
		{
			"time": 88.40997732426304,
			"arrow": "Cima"
		},
		{
			"time": 89.12979591836735,
			"arrow": "Esquerda"
		},
		{
			"time": 89.82639455782314,
			"arrow": "Baixo"
		},
		{
			"time": 90.53460317460318,
			"arrow": "Direita"
		},
		{
			"time": 91.24281179138322,
			"arrow": "Cima"
		},
		{
			"time": 91.95102040816326,
			"arrow": "Esquerda"
		},
		{
			"time": 92.65922902494331,
			"arrow": "Baixo"
		},
		{
			"time": 93.35582766439909,
			"arrow": "Direita"
		},
		{
			"time": 94.06403628117914,
			"arrow": "Cima"
		},
		{
			"time": 94.77224489795918,
			"arrow": "Esquerda"
		},
		{
			"time": 95.4920634920635,
			"arrow": "Baixo"
		},
		{
			"time": 96.18866213151928,
			"arrow": "Esquerda"
		},
		{
			"time": 96.88526077097505,
			"arrow": "Cima"
		},
		{
			"time": 97.5934693877551,
			"arrow": "Esquerda"
		},
		{
			"time": 98.30167800453515,
			"arrow": "Baixo"
		},
		{
			"time": 99.00988662131519,
			"arrow": "Direita"
		},
		{
			"time": 99.70648526077098,
			"arrow": "Cima"
		},
		{
			"time": 100.41469387755102,
			"arrow": "Esquerda"
		},
		{
			"time": 101.12290249433107,
			"arrow": "Baixo"
		},
		{
			"time": 101.83111111111111,
			"arrow": "Direita"
		},
		{
			"time": 102.5277097505669,
			"arrow": "Cima"
		},
		{
			"time": 103.23591836734694,
			"arrow": "Esquerda"
		},
		{
			"time": 103.95573696145125,
			"arrow": "Baixo"
		},
		{
			"time": 104.65233560090702,
			"arrow": "Direita"
		},
		{
			"time": 105.36054421768708,
			"arrow": "Cima"
		},
		{
			"time": 106.05714285714286,
			"arrow": "Esquerda"
		},
		{
			"time": 106.77696145124716,
			"arrow": "Baixo"
		},
		{
			"time": 107.47356009070295,
			"arrow": "Baixo"
		},
		{
			"time": 108.18176870748299,
			"arrow": "Cima"
		},
		{
			"time": 108.88997732426304,
			"arrow": "Esquerda"
		},
		{
			"time": 109.58657596371881,
			"arrow": "Baixo"
		},
		{
			"time": 110.29478458049887,
			"arrow": "Direita"
		},
		{
			"time": 111.00299319727891,
			"arrow": "Cima"
		},
		{
			"time": 111.71120181405895,
			"arrow": "Direita"
		},
		{
			"time": 112.41941043083901,
			"arrow": "Baixo"
		},
		{
			"time": 113.12761904761905,
			"arrow": "Direita"
		},
		{
			"time": 113.83582766439909,
			"arrow": "Cima"
		},
		{
			"time": 114.53242630385488,
			"arrow": "Esquerda"
		},
		{
			"time": 115.24063492063492,
			"arrow": "Baixo"
		},
		{
			"time": 115.94884353741497,
			"arrow": "Direita"
		},
		{
			"time": 116.65705215419501,
			"arrow": "Cima"
		},
		{
			"time": 117.36526077097506,
			"arrow": "Esquerda"
		},
		{
			"time": 118.0734693877551,
			"arrow": "Baixo"
		},
		{
			"time": 118.77006802721088,
			"arrow": "Direita"
		},
		{
			"time": 119.47827664399092,
			"arrow": "Cima"
		},
		{
			"time": 120.18648526077098,
			"arrow": "Esquerda"
		},
		{
			"time": 120.89469387755102,
			"arrow": "Baixo"
		},
		{
			"time": 121.5912925170068,
			"arrow": "Direita"
		},
		{
			"time": 122.29950113378685,
			"arrow": "Direita"
		},
		{
			"time": 123.00770975056689,
			"arrow": "Baixo"
		},
		{
			"time": 123.70430839002267,
			"arrow": "Baixo"
		},
		{
			"time": 124.41251700680272,
			"arrow": "Cima"
		},
		{
			"time": 125.12072562358277,
			"arrow": "Cima"
		},
		{
			"time": 125.82893424036281,
			"arrow": "Esquerda"
		},
		{
			"time": 126.53714285714285,
			"arrow": "Baixo"
		},
		{
			"time": 127.23374149659864,
			"arrow": "Direita"
		},
		{
			"time": 127.94195011337868,
			"arrow": "Cima"
		},
		{
			"time": 128.65015873015872,
			"arrow": "Esquerda"
		},
		{
			"time": 129.35836734693876,
			"arrow": "Baixo"
		},
		{
			"time": 130.05496598639456,
			"arrow": "Direita"
		},
		{
			"time": 130.7631746031746,
			"arrow": "Cima"
		},
		{
			"time": 131.48299319727892,
			"arrow": "Esquerda"
		},
		{
			"time": 132.19120181405896,
			"arrow": "Baixo"
		},
		{
			"time": 132.88780045351473,
			"arrow": "Esquerda"
		},
		{
			"time": 133.58439909297053,
			"arrow": "Cima"
		},
		{
			"time": 134.30421768707484,
			"arrow": "Esquerda"
		},
		{
			"time": 135.0008163265306,
			"arrow": "Baixo"
		},
		{
			"time": 135.70902494331065,
			"arrow": "Baixo"
		},
		{
			"time": 136.40562358276645,
			"arrow": "Cima"
		},
		{
			"time": 137.12544217687073,
			"arrow": "Esquerda"
		},
		{
			"time": 137.8336507936508,
			"arrow": "Baixo"
		},
		{
			"time": 138.53024943310658,
			"arrow": "Direita"
		},
		{
			"time": 139.23845804988662,
			"arrow": "Cima"
		},
		{
			"time": 139.94666666666666,
			"arrow": "Esquerda"
		},
		{
			"time": 140.64326530612246,
			"arrow": "Baixo"
		},
		{
			"time": 141.3514739229025,
			"arrow": "Direita"
		},
		{
			"time": 142.05968253968254,
			"arrow": "Cima"
		},
		{
			"time": 142.76789115646258,
			"arrow": "Esquerda"
		},
		{
			"time": 143.4877097505669,
			"arrow": "Baixo"
		},
		{
			"time": 144.18430839002266,
			"arrow": "Esquerda"
		},
		{
			"time": 144.89251700680273,
			"arrow": "Cima"
		},
		{
			"time": 145.60072562358278,
			"arrow": "Esquerda"
		},
		{
			"time": 146.29732426303855,
			"arrow": "Baixo"
		},
		{
			"time": 147.0055328798186,
			"arrow": "Esquerda"
		},
		{
			"time": 147.7021315192744,
			"arrow": "Cima"
		},
		{
			"time": 148.41034013605443,
			"arrow": "Esquerda"
		},
		{
			"time": 149.13015873015874,
			"arrow": "Baixo"
		},
		{
			"time": 149.8267573696145,
			"arrow": "Direita"
		},
		{
			"time": 150.51174603174604,
			"arrow": "Cima"
		},
		{
			"time": 151.2431746031746,
			"arrow": "Esquerda"
		},
		{
			"time": 151.9397732426304,
			"arrow": "Baixo"
		},
		{
			"time": 152.64798185941044,
			"arrow": "Direita"
		},
		{
			"time": 153.35619047619048,
			"arrow": "Cima"
		},
		{
			"time": 154.06439909297052,
			"arrow": "Esquerda"
		},
		{
			"time": 154.77260770975056,
			"arrow": "Baixo"
		},
		{
			"time": 155.4808163265306,
			"arrow": "Baixo"
		},
		{
			"time": 156.1774149659864,
			"arrow": "Cima"
		},
		{
			"time": 156.88562358276644,
			"arrow": "Esquerda"
		},
		{
			"time": 157.59383219954648,
			"arrow": "Baixo"
		},
		{
			"time": 158.30204081632652,
			"arrow": "Direita"
		},
		{
			"time": 158.99863945578232,
			"arrow": "Cima"
		},
		{
			"time": 159.70684807256237,
			"arrow": "Esquerda"
		},
		{
			"time": 160.4150566893424,
			"arrow": "Baixo"
		},
		{
			"time": 161.12326530612245,
			"arrow": "Direita"
		},
		{
			"time": 161.8314739229025,
			"arrow": "Cima"
		},
		{
			"time": 162.53968253968253,
			"arrow": "Esquerda"
		},
		{
			"time": 163.24789115646257,
			"arrow": "Baixo"
		},
		{
			"time": 163.94448979591837,
			"arrow": "Direita"
		},
		{
			"time": 164.6526984126984,
			"arrow": "Cima"
		},
		{
			"time": 165.36090702947845,
			"arrow": "Esquerda"
		},
		{
			"time": 166.0691156462585,
			"arrow": "Baixo"
		},
		{
			"time": 166.7657142857143,
			"arrow": "Esquerda"
		},
		{
			"time": 167.4855328798186,
			"arrow": "Cima"
		},
		{
			"time": 168.18213151927438,
			"arrow": "Direita"
		},
		{
			"time": 168.89034013605442,
			"arrow": "Baixo"
		},
		{
			"time": 169.59854875283446,
			"arrow": "Direita"
		},
		{
			"time": 170.29514739229026,
			"arrow": "Cima"
		},
		{
			"time": 171.0033560090703,
			"arrow": "Direita"
		},
		{
			"time": 171.7231746031746,
			"arrow": "Baixo"
		},
		{
			"time": 172.41977324263038,
			"arrow": "Baixo"
		},
		{
			"time": 173.1395918367347,
			"arrow": "Cima"
		},
		{
			"time": 173.82458049886623,
			"arrow": "Esquerda"
		},
		{
			"time": 174.5443990929705,
			"arrow": "Baixo"
		},
		{
			"time": 175.2409977324263,
			"arrow": "Baixo"
		},
		{
			"time": 175.78666666666666,
			"arrow": "Cima"
		}
	]
}
var tempo_corrido:float=0
@export var audio_player:AudioStreamPlayer=null
var indice:int=0
@export var joshFuncionando:Area2D = null;
var clique:int = 1;


func _physics_process(_delta: float) -> void:
	playerGanha()
	tempo_corrido = audio_player.get_playback_position()
	tamanhoTela = get_viewport().size
	# Verifica se o jogador morreu
	if self.get_child(0).name == "joshMorto":
		audio_player.pitch_scale = 1
		audio_player.stop()
#Chamadas das funções
	leitura_partitura()
	beber_pocao()

#Responsavel por ler a partitura
func leitura_partitura() -> void:
	#não deixa com que o indice ultrapasse a quantidade de beats do $beatmap
	if(indice <= beatmap["beats"].size()-1):
		"""caso queira ver os tempo dos beats é só descomentar a linha abaixo"""
		#print(str(tempo_corrido,": ",round(beatmap["beats"][indice]["time"]*100)/100))
		#Verifica se o $tempo_corrido chegou no proximo beat a se tocar
		if abs(tempo_corrido - beatmap["beats"][indice]["time"]) < 0.1:
			#print(beatmap["beats"][indice]["time"])
			#muda a cor conforme a seta
			criaNotas(beatmap["beats"][indice]["arrow"])
			#passa para o proximo beat
			indice+=1

func acharMeio(direcao: String):
	# Verifica se o jogador está definido e retorna a posição global dele
	if joshFuncionando != null:
		var player_position = joshFuncionando.global_position
		if direcao == "Esquerda":
			return Vector2(0, player_position.y)
		elif direcao == "Direita":
			return Vector2(tamanhoTela.x, player_position.y)
		elif direcao == "Cima":
			return Vector2(player_position.x, 0)
		elif direcao == "Baixo":
			return Vector2(player_position.x, tamanhoTela.y)
	else:
		# Retorna o centro da tela caso o jogador não esteja configurado
		return tamanhoTela / 2

#func acharMeio(direcao:String):
	#if (direcao == "Esquerda"):
		#return Vector2(0,tamanhoTela[1]/2)
	#elif(direcao == "Direita"):
		#return Vector2(tamanhoTela[0],tamanhoTela[1]/2)
	#elif(direcao == "Cima"):
		#return Vector2(tamanhoTela[0]/2,0)
	#elif(direcao == "Baixo"):
		#return Vector2(tamanhoTela[0]/2,tamanhoTela[1])
	#else:
		#pass

func criaNotas(notaDirecao:String):
	var instancia
	instancia = notaMusical.instantiate()
	var valorDirecao:Vector2;
	if (notaDirecao == "Esquerda"):
		instancia.diferentesTexturas(1)
		valorDirecao = Vector2(0,1)
	elif (notaDirecao == "Direita"):
		instancia.diferentesTexturas(2)
		valorDirecao = Vector2(2,1)
	elif (notaDirecao == "Cima"):
		instancia.diferentesTexturas(3)
		valorDirecao = Vector2(1,2)
	elif(notaDirecao == "Baixo"):
		instancia.diferentesTexturas(4)
		valorDirecao = Vector2(1,0)
	instancia.direcao = valorDirecao
	instancia.global_position = acharMeio(notaDirecao)
	get_parent().add_child.call_deferred(instancia)
	
func beber_pocao():
	if(Input.is_action_just_pressed("botao_e") && clique < 6):
		joshFuncionando.get_child(8).play("bebendo-pocao")
		await joshFuncionando.get_child(8).animation_finished
		clique += 1
		audio_player["pitch_scale"] += 0.16

func playerGanha():
	if (abs(tempo_corrido - audio_player.stream.get_length()) < 2.0):
		var savegame: SaveGame
		if (!FileAccess.file_exists("user://savegame.tres")):
			# Cria um novo save se o arquivo não existe
			savegame = SaveGame.new()
			if(tempo_corrido <= 40):
				savegame.jogoJosh["numeroDesempenho"] = "I"
			elif(tempo_corrido <= 70):
				savegame.jogoJosh["numeroDesempenho"] = "R"
			elif(tempo_corrido <= 100):
				savegame.jogoJosh["numeroDesempenho"] = "B"
			else:
				savegame.jogoJosh["numeroDesempenho"] = "MB"
			savegame.jogoJosh["melhorDesempenho"] = tempo_corrido
			savegame.jogoJosh["ultimoDesempenho"] = tempo_corrido
		else:
			#Carrega os dados existentes
			var loaded_data = ResourceLoader.load("user://savegame.tres")
			if loaded_data != null:
				savegame = loaded_data as SaveGame
				#print(savegame.jogoJosh)
				#Atualiza os valores se o desempenho for melhor
				if savegame.jogoJosh["melhorDesempenho"] < tempo_corrido:
					savegame.jogoJosh["melhorDesempenho"] = tempo_corrido
		# Atualiza o número de desempenhos
				savegame.jogoJosh["ultimoDesempenho"] = tempo_corrido
				if(tempo_corrido <= 40):
					savegame.jogoJosh["numeroDesempenho"] = "I"
				elif(tempo_corrido <= 70):
					savegame.jogoJosh["numeroDesempenho"] = "R"
				elif(tempo_corrido <= 100):
					savegame.jogoJosh["numeroDesempenho"] = "B"
				else:
					savegame.jogoJosh["numeroDesempenho"] = "MB"
			#Salva os dados atualizados
		savegame.save_game()


func _on_audio_stream_player_finished() -> void:
	# Verifique se o jogo está pausado e desative o estado de pausa
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/escolha-fases.tscn")
