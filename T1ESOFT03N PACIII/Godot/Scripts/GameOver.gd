extends Node2D

func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/Arena.tscn")
	Global.reset_globals()


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Restart_ready():
	##Ajuste de linguagem para o botão Restart
	if Global.language == "ptbr":
		$VBoxContainer/Restart.text = "Recomeçar"
	if Global.language == "eng":
		$VBoxContainer/Restart.text = "Restart"

func _on_Menu_ready():
	##Ajuste de linguagem para o botão Menu
	if Global.language == "ptbr":
		$VBoxContainer/Menu.text = "Menu"
	if Global.language == "eng":
		$VBoxContainer/Menu.text = "Menu"

func _on_Quit_ready():
	##Ajuste de linguagem para o botão Sair
	if Global.language == "ptbr":
		$VBoxContainer/Quit.text = "Sair do Jogo"
	if Global.language == "eng":
		$VBoxContainer/Quit.text = "Quit Game"

func _on_VBoxContainer_ready():
	$VBoxContainer.rect_position = Vector2(Global.screensize_horiz/2 - 30, Global.screensize_vert/2)

func _on_Game_over_ready():
	$"Game over".position = Vector2(Global.screensize_horiz/2 , Global.screensize_vert/2 - 100)

func _on_GameOver_ready():
	self.position = Vector2(0,0)
