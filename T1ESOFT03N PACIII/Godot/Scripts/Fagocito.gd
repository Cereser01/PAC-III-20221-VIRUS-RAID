extends Sprite

var speed = 100 * Global.difficulty
var velocity = Vector2()
var stun = false
var hp = 3 * Global.difficulty
var death_spray = preload("res://Scenes/death_spray.tscn")
var infectable = false
var oneshot = true

## Função de movimentação do inimigo
func _process(delta):
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
		global_position += velocity * speed * delta
	
	if hp <= 1 and Global.playertype == "virus":
		infectable = true
		modulate = Color.lightgreen
		if oneshot == true:
			$Hitbox.remove_from_group ("Player_damager")
			oneshot = false
	
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
		Global.playertype = "fagocito"
	
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
