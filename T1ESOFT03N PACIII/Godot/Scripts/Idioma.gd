extends Control

func _ready():
	$VBoxContainer/PTBR.grab_focus()
	##Ajuste de linguagem para o label Idiomas
	if Global.language == "ptbr":
		$Idiomas.text = "Idiomas"
	if Global.language == "eng":
		$Idiomas.text = "Languages"

func _on_Voltar_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")

func _on_PTBR_pressed():
	Global.language = "ptbr"
	get_tree().change_scene("res://Scenes/Options.tscn")


func _on_ENGUS_pressed():
	Global.language = "eng"
	get_tree().change_scene("res://Scenes/Options.tscn")
