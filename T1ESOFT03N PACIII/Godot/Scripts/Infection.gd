extends Label

func _process(_delta):
	text = "  Infection = " + str(Global.infection) + "%"
