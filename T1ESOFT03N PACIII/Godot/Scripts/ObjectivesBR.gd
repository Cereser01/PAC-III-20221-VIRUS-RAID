extends Node2D
func _ready():
	$TITLE.rect_position = Vector2(Global.screensize_horiz/2.5, Global.screensize_vert/8)
	$Sprite.position +=  Vector2(Global.screensize_horiz/5 -120, Global.screensize_vert/8)
	$Label.rect_position = Vector2(Global.screensize_horiz/6, Global.screensize_vert/1.6)
	$Anterior.rect_position = Vector2(Global.screensize_horiz/3+120, Global.screensize_vert/1.2)
	$Proximo.rect_position = Vector2(Global.screensize_horiz/3+200, Global.screensize_vert/1.2)
	$Menu.rect_position = Vector2(Global.screensize_horiz/500, Global.screensize_vert/1.12)

func _on_Anterior_pressed():
	get_tree().change_scene("res://Scenes/AboutBR (1).tscn")


func _on_Proximo_pressed():
	get_tree().change_scene("res://Scenes/MTBR.tscn")


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
