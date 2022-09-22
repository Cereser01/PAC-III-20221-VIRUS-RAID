extends Node2D

var vel = 100.0

func _process(delta):
		set_position(get_position() + Vector2(0.0 , 1.0) * vel * delta)
		pass


func _ready():
	pass # Replace with function body.
