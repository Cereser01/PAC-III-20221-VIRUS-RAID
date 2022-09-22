extends Node2D

func _ready():
	$VBoxContainer.rect_position = Vector2(Global.screensize_horiz/2 - 120, Global.screensize_vert/2)

func _on_HowToPlay_pressed():
	assert(get_tree().change_scene("res://Scenes/AboutEN (1).tscn") == OK)
	$pop.play()
	pass # Replace with function body.


func _on_Player_pressed():
	assert(get_tree().change_scene("res://Scenes/AboutEN.tscn") == OK)

	pass # Replace with function body.


func _on_Controls_pressed():
	assert(get_tree().change_scene("res://Scenes/MTEN.tscn") == OK)

	pass # Replace with function body.


func _on_Enemies_pressed():
	assert(get_tree().change_scene("res://Scenes/FagEN.tscn") == OK)
	
	pass # Replace with function body.




func _on_Objectives_pressed():
	assert(get_tree().change_scene("res://Scenes/AboutEN (1).tscn") == OK)

	pass # Replace with function body.


func _on_Back_pressed():
	assert(get_tree().change_scene("res://Scenes/Menu.tscn") == OK)

	pass # Replace with function body.
