extends Sprite

var speed = 270
var mov = Vector2.ZERO
var virus
var infection_duration = 7
var flipflop = false

func _ready():
	Global.player = self
	Global.playertype = "linfocitob"
	Global.health = 1
	virus = load("res://Scenes/Virus.tscn")
	$Death_Timer.start()

func _process(delta):
	##Faz a movimentação do player baseado nos inputs do teclado
	if(Global.movimentacao == "teclado"):
		mov.x = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
		mov.y = int(Input.is_action_pressed("baixo")) - int(Input.is_action_pressed("cima"))
		mov = mov.normalized()
		
	##Faz a movimentação do player baseado na posição do mouse
	if Global.movimentacao == "mouse":
		mov = global_position.direction_to(get_global_mouse_position())
	
	
	##Impede que jogadores com movimentação com teclado saiam da tela
	if global_position.x <= Global.screensize_horiz and global_position.x >= 0 and global_position.y < Global.screensize_vert and global_position.y >= 0:
		global_position += speed * mov * delta
	else:
		if global_position.x > Global.screensize_horiz:
			mov.x = -30
		if global_position.x < 0:
			mov.x = +30
		if global_position.y > Global.screensize_vert:
			mov.y = -30
		if global_position.y < 0:
			mov.y = +30
		mov = mov.normalized()
		global_position += speed * mov * delta
	
	if infection_duration < 2:
		if flipflop == true:
			modulate = Color.darkolivegreen
		else:
			modulate = Color.white

	
	##Realiza a troca de volta para o virus ao acabar o tempo ou morrer
	if Global.health <=0 or infection_duration <= 0:
		Global.immunity -= 15 * (1 - infection_duration/7)
		Global.instance_node(virus, global_position , Global.node_creation_parent)
		queue_free()


func _on_Hitbox_area_entered(area):
	##Calcula o dano para ataques que causam 1 de dano
	if area.is_in_group("Player_damager"):
		Global.health -= 1
	
	##Calcula o dano para ataques que causam 1 de dano
	if area.is_in_group("Player_2Damage"):
		Global.health -= 2


func _on_Death_Timer_timeout():
	infection_duration -= 1
	if infection_duration == 3:
		$Death_Alert_Sound.play()

func _on_Color_timer_timeout():
	if flipflop == true:
		flipflop = false
	elif flipflop == false:
		flipflop = true
