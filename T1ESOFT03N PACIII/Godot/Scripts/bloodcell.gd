extends Node2D

var vel = 100.0
var velocity = Vector2()
var rot = 0
var time = 0
var stun = false
var hp = 1
var reddeath_spray = preload("res://Scenes/reddeath_spray.tscn")

func _ready():
	randomize()
	set_process(true)
	rot = rand_range(-20, 20)
	
	
func _process(delta):
	if stun == false:
		set_position(get_position() + Vector2(0.0 , 1.0) * vel * delta)
		rotate(rot*delta)
	
	
	if hp <= 0:
		if Global.immunity > 0:
			Global.immunity -= 0.1
		var death_spray_instance = Global.instance_node(reddeath_spray, global_position, Global.node_creation_parent)
		death_spray_instance.rotation = (death_spray_instance.global_position - Global.player.global_position).angle()
		queue_free()


func _on_Area2D_area_entered(area):
		if area.is_in_group("Bloodcell_damager"):
			hp -=1
		
		if area.is_in_group("Enemy_damager"):
			area.get_parent().queue_free()
			hp-=1
			stun = true


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
