extends Sprite

var speed = 100 * Global.difficulty
var velocity = Vector2()
var stun = false
var hp = 2 * Global.difficulty
var death_spray = preload("res://Scenes/death_spray.tscn")
var border = Vector2()
var oneshot = true
var can_shoot = true
var bullet = preload("res://Scenes/LinfocitoT_Bullet.tscn")
var infectable = false

## Função de movimentação do inimigo
func _process(delta):

	if oneshot == true:
		border = Vector2(rand_range(0,1024),rand_range(0,600))
		while border.x > 100 and border.x < 924 or border.y > 100 and border.y < 500:
			border = Vector2(rand_range(0,1024),rand_range(0,600))
		oneshot = false
		$Direction_Timer.start()
	
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(border)
		global_position += velocity * speed * delta
		
	
	if Global.node_creation_parent != null and can_shoot == true:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_Timer.start()
		can_shoot = false
	
	if hp <= 1 and Global.playertype == "virus":
		infectable = true
		modulate = Color.lightgreen
	
	if hp <= 0:
		if Global.node_creation_parent != null:
			var death_spray_instance = Global.instance_node(death_spray, global_position, Global.node_creation_parent)
			death_spray_instance.rotation = velocity.angle() + 3.1415
		Global.increase_infection(1) 
		Global.enemy_count -= 1
		queue_free()

##Função de detecção de hitbox do inimigo (Ativa quando um tiro conecta com a hitbox)
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Infectant") and infectable == true:
		queue_free()
		Global.enemy_count -= 1
		Global.playertype = "linfocitot"
	
	if area.is_in_group("Enemy_damager"):
		modulate = Color.red
		hp -= 1
		stun  = true
		$Stun_Timer.start()
		area.get_parent().queue_free()
		

##Função timer do stun(ativa quando o stun após ser atingido termina)
func _on_Stun_Timer_timeout():
	modulate = Color.white
	stun = false



func _on_Direction_Timer_timeout():
	border = Vector2(rand_range(0,Global.screensize_horiz),rand_range(0,Global.screensize_vert))
	while border.x > 100 and border.x < Global.screensize_horiz -100 or border.y > 100 and border.y < Global.screensize_vert - 100:
		border = Vector2(rand_range(0,Global.screensize_horiz),rand_range(0,Global.screensize_vert))
		

func _on_Reload_Timer_timeout():
	can_shoot = true
