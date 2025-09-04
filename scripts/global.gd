extends Node
var email:String = "";

func proporcional(tamanho_text:int,maximus:int):
	var tam_abertura = Vector2(1152, 648)
	var resolucao = get_viewport().size
	var text_size = tamanho_text
	var area_abertura = tam_abertura[0]*tam_abertura[1]
	var area_resolucao = resolucao[0]*resolucao[1]
	var diferenca = area_resolucao - area_abertura
	var percentual:int = (diferenca / area_abertura) * 100
	var resultado=(((float(text_size)/100)*percentual)+(text_size))
	if(resultado>=maximus):
		return maximus
	return resultado

func acha_filhos(tipe:String,excecoes:Array=[],node_pai:Node=get_node("."),array_filhos:Array=[]):
	var banido:bool=false
	for filho in node_pai.get_children():
		if(filho.get_child_count()>0):
			acha_filhos(tipe,excecoes,filho,array_filhos)
		if excecoes != []:
			for excecao in excecoes:
				if filho.name==str(excecao):
					banido=true
		if filho.is_class(tipe) && !banido:
			array_filhos.append(filho)
		banido=false
	return array_filhos


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
