extends Node2D

func _ready():
	$VBoxContainer.rect_position = Vector2(Global.screensize_horiz/2 - 120, Global.screensize_vert/2)

func _on_HowToPlay_pressed():
	get_tree().change_scene("res://Scenes/AboutBR (1).tscn")


func _on_Player_pressed():
	get_tree().change_scene("res://Scenes/AboutBR.tscn")


func _on_Controls_pressed():
	get_tree().change_scene("res://Scenes/MTBR.tscn")


func _on_Enemies_pressed():
	get_tree().change_scene("res://Scenes/FagBR.tscn")


func _on_Objectives_pressed():
	get_tree().change_scene("res://Scenes/ObjectivesBR.tscn")


func _on_Voltar_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
