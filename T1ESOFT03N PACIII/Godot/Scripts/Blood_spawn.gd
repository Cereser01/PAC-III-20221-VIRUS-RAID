extends Node

var pre_blood = preload("res://Scenes/bloodcell.tscn")
var intervalo = 2
var bloodcell
func _ready():
	set_process(true)
	pass 

func _process(delta):
	
	if intervalo>0:
		intervalo-=delta
	else:
		intervalo = rand_range(0.3, 1)
		bloodcell = pre_blood.instance()
		bloodcell.set_position(Vector2(rand_range(0,Global.screensize_horiz), -100))
		get_owner().add_child(bloodcell)
	pass
