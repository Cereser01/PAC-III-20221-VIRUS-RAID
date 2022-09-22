extends Label

func _process(_delta):
		##Ajuste de linguagem para a label Health
	if Global.language == "ptbr":
		text = "Vida = " + str(Global.health) + ""
	if Global.language == "eng":
		text = "Health = " + str(Global.health) + ""
