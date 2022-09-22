extends Control

func _ready():
	$VBoxContainer/Dificuldade.grab_focus()
	
	##Ajuste de linguagem para o label Options
	if Global.language == "ptbr":
		$Options.text = "Opções"
	if Global.language == "eng":
		$Options.text = "Options"
	
	##Ajuste de linguagem para o botão Voltar
	if Global.language == "ptbr":
		$Voltar.text = "Voltar"
	if Global.language == "eng":
		$Voltar.text = "Return"
	
	##Ajuste de linguagem para o botão Dificuldade
	if Global.language == "ptbr":
		$VBoxContainer/Dificuldade.text = "Dificuldade"
	if Global.language == "eng":
		$VBoxContainer/Dificuldade.text = "Difficulty"
	
	##Ajuste de linguagem para o botão Teclas
	if Global.language == "ptbr":
		$VBoxContainer/Teclas.text = "Controles"
	if Global.language == "eng":
		$VBoxContainer/Teclas.text = "Controls"
	
	##Ajuste de linguagem para o botão Audio
	if Global.language == "ptbr":
		$VBoxContainer/Audio.text = "Som"
	if Global.language == "eng":
		$VBoxContainer/Audio.text = "Sound"
	
	##Ajuste de linguagem para o botão Idioma
	if Global.language == "ptbr":
		$VBoxContainer/Idioma.text = "Idioma"
	if Global.language == "eng":
		$VBoxContainer/Idioma.text = "Language"

func _on_Voltar_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_Dificuldade_pressed():
	get_tree().change_scene("res://Scenes/Dificuldade.tscn")

func _on_Teclas_pressed():
	get_tree().change_scene("res://Scenes/Teclas.tscn")

func _on_Audio_pressed():
	get_tree().change_scene("res://Scenes/Audio.tscn")

func _on_Idioma_pressed():
	get_tree().change_scene("res://Scenes/Idioma.tscn")
