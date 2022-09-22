extends Control


func _ready():
	$VBoxContainer/Start.grab_focus()
	
	##Ajuste de linguagem para o botão Start
	if Global.language == "ptbr":
		$VBoxContainer/Start.text = "Começar"
	if Global.language == "eng":
		$VBoxContainer/Start.text = "Start"

	##Ajuste de linguagem para o botão Options
	if Global.language == "ptbr":
		$VBoxContainer/Options.text = "Opções"
	if Global.language == "eng":
		$VBoxContainer/Options.text = "Options"
	
	##Ajuste de linguagem para o botão howToPlay
	if Global.language == "ptbr":
		$VBoxContainer/howToPlay.text = "Ajuda"
	if Global.language == "eng":
		$VBoxContainer/howToPlay.text = "Help"
	
	##Ajuste de linguagem para o botão Quit
	if Global.language == "ptbr":
		$VBoxContainer/Quit.text = "Sair"
	if Global.language == "eng":
		$VBoxContainer/Quit.text = "Quit"

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Arena.tscn")
	Global.reset_globals()

func _on_Options_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")

func _on_howToPlay_pressed():
	if Global.language == "ptbr":
		get_tree().change_scene("res://Scenes/HelpBR.tscn")
	if Global.language == "eng":
		get_tree().change_scene("res://Scenes/HelpEN.tscn")


func _on_Quit_pressed():
	get_tree().quit()

func _on_Title_ready():
	$Title.position = Vector2(Global.screensize_horiz/2, Global.screensize_vert/2 - 200)


func _on_Tutorial_pressed():
	Global.difficulty = 1
	get_tree().change_scene("res://Scenes/Tutorial.tscn")
