extends Node2D
func _ready():
	$TITLE.rect_position = Vector2(Global.screensize_horiz/4.6, Global.screensize_vert/8)
	$Wsad.position +=  Vector2(Global.screensize_horiz/5 -120, Global.screensize_vert/8)
	$Label.rect_position = Vector2(Global.screensize_horiz/3.3, Global.screensize_vert/1.6)
	$Anterior.rect_position = Vector2(Global.screensize_horiz/3+120, Global.screensize_vert/1.2)
	$Proximo.rect_position = Vector2(Global.screensize_horiz/3+200, Global.screensize_vert/1.2)
	$Menu.rect_position = Vector2(Global.screensize_horiz/500, Global.screensize_vert/1.12)
func _on_Anterior_pressed():
	get_tree().change_scene("res://Scenes/ObjectivesBR.tscn")


func _on_Proximo_pressed():
	get_tree().change_scene("res://Scenes/MouseBR.tscn")


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
