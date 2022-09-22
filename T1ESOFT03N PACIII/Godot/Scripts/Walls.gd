extends Node

var leftwall = preload("res://Scenes/leftwall.tscn")
var rightwall = preload("res://Scenes/rightwall.tscn")
var intervalo = 2
var wall
func _ready():
	set_process(true)
	pass 

func _process(delta):
	
	if intervalo>0:
		intervalo-=delta
	else:
		intervalo = rand_range(0.3, 1)
		wall = leftwall.instance()
		wall.set_position(Vector2(Global.screensize_horiz - 30, -1000))
		get_owner().add_child(wall)
		
		wall = rightwall.instance()
		wall.set_position(Vector2(30, -1000))
		get_owner().add_child(wall)
	pass
