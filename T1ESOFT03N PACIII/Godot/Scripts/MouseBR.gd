extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TITULO.rect_position = Vector2(Global.screensize_horiz/3, Global.screensize_vert/8)
	$MouseIconVector.position +=  Vector2(Global.screensize_horiz/5 -120, Global.screensize_vert/8)
	$Label.rect_position = Vector2(Global.screensize_horiz/4.7, Global.screensize_vert/1.6)
	$Anterior.rect_position = Vector2(Global.screensize_horiz/3+120, Global.screensize_vert/1.2)
	$Proximo.rect_position = Vector2(Global.screensize_horiz/3+200, Global.screensize_vert/1.2)
	$Menu.rect_position = Vector2(Global.screensize_horiz/500, Global.screensize_vert/1.12)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Anterior_pressed():
	assert(get_tree().change_scene("res://Scenes/MTBR.tscn") == OK)
	pass # Replace with function body.


func _on_Proximo_pressed():
	assert(get_tree().change_scene("res://Scenes/FagBR.tscn") == OK)
	pass # Replace with function body.


func _on_Menu_pressed():
	assert(get_tree().change_scene("res://Scenes/Menu.tscn") == OK)
	pass # Replace with function body.
