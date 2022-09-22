extends Sprite

var velocity = Vector2(1,0)
var speed = 320
var look_once = true


func _ready():
	$Duration_Timer.start()


func _process(delta):
	##Função de movimentação do projétil com mira no mouse
	if Global.mira == "mouse":
		if look_once:
			look_at(get_global_mouse_position())
			look_once = false
		global_position += velocity.rotated(rotation) * speed * delta
	
	##Função de movimentação do projétil com mira no teclado
	if Global.mira == "teclado":
		if look_once:
			if Global.shoot_backwards:
				speed = -320
			else:
				speed = 320
			look_at(get_global_mouse_position())
			look_once = false
		global_position += velocity.rotated(rotation) * speed * delta
	
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Duration_Timer_timeout():
	queue_free()
