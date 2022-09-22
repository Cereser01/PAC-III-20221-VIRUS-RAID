extends Sprite

var speed = 100 * Global.difficulty
var velocity = Vector2()
var stun = false
var hp = 1 * Global.difficulty
var death_spray = preload("res://Scenes/death_spray.tscn")
var border = Vector2()
var anticorpo = preload("res://Scenes/Anticorpo.tscn")
var leaving = false
var infectable = false

func _ready():
	border = Vector2(rand_range(0, Global.screensize_horiz),rand_range(0, Global.screensize_vert))
	while border.x > 100 and border.x < Global.screensize_horiz - 100 or border.y > 100 and border.y < Global.screensize_vert - 100:
		border = Vector2(rand_range(0,Global.screensize_horiz),rand_range(0,Global.screensize_vert))
	$Leave_Timer.start()	

func _process(delta):
	
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(border)
		global_position += velocity * speed * delta
		
	if hp <= 1 and Global.playertype == "virus":
		infectable = true
		modulate = Color.lightgreen
	
	if hp <= 0:
		if Global.node_creation_parent != null:
			var death_spray_instance = Global.instance_node(death_spray, global_position, Global.node_creation_parent)
			death_spray_instance.rotation = velocity.angle() + 3.1415
		Global.increase_infection(1)
		Global.enemy_count -= 1
		Global.linfocitobvivo = false
		queue_free()

func _on_Hitbox_area_entered(area):
	
	if area.is_in_group("Infectant") and infectable == true:
		queue_free()
		Global.enemy_count -= 1
		Global.playertype = "linfocitob"
	
	if area.is_in_group("Enemy_damager"):
		modulate = Color.red
		hp -= 1
		stun  = true
		$Stun_Timer.start()
		area.get_parent().queue_free()


func _on_Stun_Timer_timeout():
	modulate = Color.white
	stun = false


func _on_Leave_Timer_timeout():
	leaving = true
	if (border.y - (Global.screensize_vert / 2)) > (Global.screensize_vert / 2):
		border.y =  Global.screensize_vert + 100
	else:
		border.y = -100


func _on_VisibilityNotifier2D_screen_exited():
	if leaving == true:
		var spawn_height
		var enemy_position
		##SPAWNA OS INIMIGOS QUANDO O LINFOCITO ESCAPA TA TELA
		for _number in range(3):
			spawn_height = rand_range(-10, 10)
			enemy_position = Vector2(rand_range(0 + 60,Global.screensize_horiz - 60), -100)
			if spawn_height >= 0:
				enemy_position = Vector2(rand_range(0 + 60,Global.screensize_horiz - 60), -100)
			if spawn_height < 0:
				enemy_position = Vector2(rand_range(0 + 60,Global.screensize_horiz - 60), Global.screensize_vert + 100)
			Global.instance_node(anticorpo, enemy_position, Global.node_creation_parent)
			Global.enemy_count += 1
			Global.immunity += 5
			
		queue_free()
		Global.enemy_count -= 1
		Global.linfocitobvivo = false
		leaving  = false




