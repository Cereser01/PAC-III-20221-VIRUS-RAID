extends Control

func _ready():
	$VBoxContainer/Facil.grab_focus()
	
	##Ajuste de linguagem para o label Dificuldade
	if Global.language == "ptbr":
		$Dificuldade.text = "Dificuldade"
	if Global.language == "eng":
		$Dificuldade.text = "Difficulty"
	
	##Ajuste de linguagem para o botão Dificuldade
	if Global.language == "ptbr":
		$VBoxContainer/Facil.text = "Facil"
	if Global.language == "eng":
		$VBoxContainer/Facil.text = "Easy"
	
	##Ajuste de linguagem para o botão Dificuldade
	if Global.language == "ptbr":
		$VBoxContainer/Normal.text = "Normal"
	if Global.language == "eng":
		$VBoxContainer/Normal.text = "Normal"
	
	##Ajuste de linguagem para o botão Dificuldade
	if Global.language == "ptbr":
		$VBoxContainer/Dificil.text = "Difícil"
	if Global.language == "eng":
		$VBoxContainer/Dificil.text = "Hard"
	
func _on_Facil_pressed():
	Global.difficulty = 0.5
	get_tree().change_scene("res://Scenes/Options.tscn")


func _on_Dificil_pressed():
	Global.difficulty = 2.0
	get_tree().change_scene("res://Scenes/Options.tscn")


func _on_Normal_pressed():
	Global.difficulty = 1.0
	get_tree().change_scene("res://Scenes/Options.tscn")
	


func _on_Voltar_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")



