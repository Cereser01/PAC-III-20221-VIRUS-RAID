extends Control

func _ready():
	$VBoxContainer/Mouse.grab_focus()
	
	##Ajuste de linguagem para o label Teclas
	if Global.language == "ptbr":
		$Teclas.text = "Controles"
	if Global.language == "eng":
		$Teclas.text = "Controls"
		
		##Ajuste de linguagem para o botão Mouse
	if Global.language == "ptbr":
		$VBoxContainer/Mouse.text = "Movimento com Teclado"
	if Global.language == "eng":
		$VBoxContainer/Mouse.text = "Movement with Keyboard"
		
		##Ajuste de linguagem para o botão Teclado
	if Global.language == "ptbr":
		$VBoxContainer/Teclado.text = "Movimento com Mouse"
	if Global.language == "eng":
		$VBoxContainer/Teclado.text = "Movement with Mouse"

func _on_Voltar_pressed():
	assert(get_tree().change_scene("res://Scenes/Options.tscn") == OK)



func _on_Mouse_pressed():
	Global.mira = "mouse"
	Global.movimentacao = "teclado"
	get_tree().change_scene("res://Scenes/Options.tscn")


func _on_Teclado_pressed():
	Global.mira = "teclado"
	Global.movimentacao = "mouse"
	get_tree().change_scene("res://Scenes/Options.tscn")
