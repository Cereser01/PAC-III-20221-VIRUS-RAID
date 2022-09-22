extends Sprite

var velocity = Vector2(1,0)
var speed = 200
var look_once = true

func _process(delta):
	if look_once:
		look_at(Global.player.global_position)
		look_once = false
	global_position += velocity.rotated(rotation) * speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player"):
		queue_free()
