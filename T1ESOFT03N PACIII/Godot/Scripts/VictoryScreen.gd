extends Node2D

func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/Arena.tscn")
	Global.reset_globals()

func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_Sair_pressed():
	get_tree().quit()

func _on_Dificuldade_ready():
	##Ajuste de linguagem para o label Dificuldade
	if Global.language == "ptbr":
		if Global.difficulty == 0.5:
			$Control/Dificuldade.text = "Dificuldade: Fácil"
		if Global.difficulty == 1:
			$Control/Dificuldade.text = "Dificuldade: Normal"
		if Global.difficulty == 2:
			$Control/Dificuldade.text = "Dificuldade: Difícil"
	
	if Global.language == "eng":
		if Global.difficulty == 0.5:
			$Control/Dificuldade.text = "Difficulty: Easy"
		if Global.difficulty == 1:
			$Control/Dificuldade.text = "Difficulty: Normal"
		if Global.difficulty == 2:
			$Control/Dificuldade.text = "Difficulty: Hard"

func _on_Parabens_ready():
	##Ajuste de linguagem para o Label Parabens
	if Global.language == "ptbr":
		get_node("Control/Parabens").text = "Parabéns! Você matou seu hospedeiro!"
	if Global.language == "eng":
		get_node("Control/Parabens").set_text("Congratulations! You killed your host") 


func _on_Sair_ready():
	##Ajuste de linguagem para o botão Sair
	if Global.language == "ptbr":
		$VBoxContainer/Sair.text = "Sair"
	if Global.language == "eng":
		$VBoxContainer/Sair.text = "Quit"


func _on_Menu_ready():
	##Ajuste de linguagem para o botão Menu
	if Global.language == "ptbr":
		$VBoxContainer/Menu.text = "Menu"
	if Global.language == "eng":
		$VBoxContainer/Menu.text = "Menu"


func _on_Restart_ready():
	##Ajuste de linguagem para o botão Restart
	if Global.language == "ptbr":
		$VBoxContainer/Restart.text = "Recomeçar"
	if Global.language == "eng":
		$VBoxContainer/Restart.text = "Restart"


func _on_VictoryScreen_ready():
	self.position = Vector2(0,0)

func _on_VBoxContainer_ready():
	$VBoxContainer.rect_position = Vector2(Global.screensize_horiz/2 - 40, Global.screensize_vert/2)


func _on_Control_ready():
	$Control.rect_position = Vector2(Global.screensize_horiz/2 - 60, Global.screensize_vert/2 - 70)


func _on_Vitoria_ready():
	$Vitoria.position = Vector2(Global.screensize_horiz/2, Global.screensize_vert/2 - 150)
