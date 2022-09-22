extends Sprite

var speed = 220
var mov = Vector2.ZERO
var bullet = preload("res://Scenes/Bullet.tscn")
var can_shoot = true
var immunityframe = true

##Declarando tipos de inimigos que podem ser infectados
var infected_fagocito = preload("res://Scenes/Infected_Fagocito.tscn")
var infected_linfocitob = preload("res://Scenes/Infected_LinfocitoB.tscn")
var infected_linfocitot = preload("res://Scenes/Infected_LinfocitoT.tscn")
var infected_citotoxica = preload("res://Scenes/Infected_Citotoxica.tscn")
var infected_anticorpo = preload("res://Scenes/Infected_Anticorpo.tscn")

func _ready():
	Global.player = self
	Global.playertype = "virus"
	if Global.difficulty == 0.5:
		Global.health = 2
	else:
		Global.health = 1
	$Damage_Timer.start()

func _process(delta:float)-> void:
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
	
	##Faz o tiro do player baseado nos inputs do mouse ou teclado
	if Input.is_action_pressed("shootback") and Global.mira == "teclado":
		Global.shoot_backwards = true
	if Input.is_action_pressed("shootforward") and Global.mira == "teclado":
		Global.shoot_backwards = false
	if Input.is_action_pressed("shoot") and Global.node_creation_parent != null and can_shoot == true:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		#Global.infection += 50
		$Reload_Speed.start()
		can_shoot = false
		
	##Troca o node para o node da celula infectada
	if Global.playertype == "fagocito":
		Global.instance_node(infected_fagocito, global_position, Global.node_creation_parent)
		queue_free()
	
	if Global.playertype == "linfocitob":
		Global.instance_node(infected_linfocitob, global_position, Global.node_creation_parent)
		queue_free()
	
	if Global.playertype == "linfocitot":
		Global.instance_node(infected_linfocitot, global_position, Global.node_creation_parent)
		queue_free()
	
	if Global.playertype == "citotoxica":
		Global.instance_node(infected_citotoxica, global_position, Global.node_creation_parent)
		queue_free()
	
	if Global.playertype == "anticorpo":
		Global.instance_node(infected_anticorpo, global_position, Global.node_creation_parent)
		queue_free()

func _on_Reload_Speed_timeout():
	can_shoot = true


func _on_Hitbox_area_entered(area):
	
	##Calcula o dano para ataques que causam 1 de dano
	if area.is_in_group("Player_damager") and immunityframe == false:
		modulate = Color.red
		Global.health -= 1
	
	##Calcula o dano para ataques que causam 1 de dano
	if area.is_in_group("Player_2Damage") and immunityframe == false:
		modulate = Color.red
		Global.health -= 2
	
	
	##Recarrega a cena e mostra a tela de game over
	if Global.health <=0 and Global.level != 0:
		get_tree().reload_current_scene()
		get_tree().change_scene("res://Scenes/GameOver.tscn")
	if Global.health <= 0 and Global.level == 0:
		queue_free()
	
	##Inicia o timer dos frames de imunidade do player, onde ele não poderá receber outro dano
	immunityframe = true
	$Damage_Timer.start()


func _on_Damage_Timer_timeout():
	immunityframe = false
	modulate = Color.white
	

	
