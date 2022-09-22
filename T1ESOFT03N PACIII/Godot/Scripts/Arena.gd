extends Node2D

##Preload dos inimigos
var fagocito   = preload("res://Scenes/Fagocito.tscn")
var linfocitob = preload("res://Scenes/LinfocitoB.tscn")
var linfocitot = preload("res://Scenes/LinfocitoT.tscn")
var citotoxica = preload("res://Scenes/Citotoxica.tscn")
var anticorpo  = preload("res://Scenes/Anticorpo.tscn")
var virus      = preload("res://Scenes/Virus.tscn")
var leftwall   = preload("res://Scenes/leftwall.tscn")
var rightwall  = preload("res://Scenes/rightwall.tscn")
var max_enemies = 10 * Global.difficulty
var enemy = preload("res://Scenes/Fagocito.tscn")
var coin

func _ready():
	Global.level = 1
	Global.node_creation_parent = self
	Global.instance_node(virus, Vector2(Global.screensize_horiz/2, Global.screensize_vert/2), Global.node_creation_parent)
	$Layer/Pause_Menu.hide()
	$Layer/Audio_Menu.hide()
	
	Global.instance_node(leftwall, Vector2(Global.screensize_horiz - 30, Global.screensize_vert/2), Global.node_creation_parent)
	Global.instance_node(rightwall, Vector2(30, Global.screensize_vert/2), Global.node_creation_parent)
	for number in range(8):
		Global.instance_node(leftwall, Vector2(Global.screensize_horiz - 30, number * (-100)), Global.node_creation_parent)
		Global.instance_node(rightwall, Vector2(30, number * (-100)), Global.node_creation_parent)
	
	AudioServer.set_bus_volume_db(1, Global.musicvolume)
	AudioServer.set_bus_volume_db(2,Global.effectsvolume)
	

	##Spawna inimigo no inicio do jogo para efeitos de teste
##	Global.instance_node(fagocito, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)
##	Global.instance_node(linfocitob, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)
##	Global.instance_node(linfocitot, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)
##	Global.instance_node(citotoxica, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)
##	Global.instance_node(anticorpo, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)

func _exit_tree():
	Global.node_creation_parent = null



func _process(_delta):
	
	##Barras de infecção e imunidade
	$UI/Control/ImmunityPBar.value = Global.immunity
	$UI/Control/InfectionPBar.value = Global.infection
	
	##Menu de Pausa
	if Input.is_action_just_pressed("escape"):
		pause()
	##Infection Victory Screen
	if Global.infection >= 100:
		get_tree().reload_current_scene()
		get_tree().change_scene("res://Scenes/VictoryScreen.tscn")
	##Immunity GAME OVER SCREEN
##	if Global.immunity >=100:
##		get_tree().reload_current_scene()
##		get_tree().change_scene("res://Scenes/GameOver.tscn")
	
	if Global.immunity < 0:
		Global.immunity = 0
	
	$bgm.volume_db = Global.musicvolume

##Enemy Spawner
func _on_Enemy_spawn_timer_timeout():

	if Global.enemy_count < max_enemies:
		##Define a posição do spawn (levemente fora da tela)
		var spawn_height = rand_range(-10, 10)
		var enemy_position = Vector2(rand_range(0 + 60,Global.screensize_horiz - 60), -100)
		if spawn_height >= 0:
			enemy_position = Vector2(rand_range(0 + 60,Global.screensize_horiz - 60), -100)
		if spawn_height < 0:
			enemy_position = Vector2(rand_range(0 + 60,Global.screensize_horiz - 60), Global.screensize_vert+100)
		
		##Define o tipo de inimigo que vai ser spawnado
		
		if Global.infection < 10 or Global.immunity <5:
			enemy = fagocito
		
		if Global.infection > 10 or Global.immunity > 5:
			coin = rand_range(-1,1)
			if(coin > 0):
				enemy = fagocito
			else:
				enemy = linfocitot
				
		if Global.infection > 20 or Global.immunity > 15:
			coin = rand_range(0,3)
			if coin > 0:
				enemy = fagocito
			if coin > 1:
				enemy = linfocitot
			if coin > 2:
				if Global.linfocitobvivo == false:
					enemy = linfocitob
					Global.linfocitobvivo = true
				else:
					enemy = linfocitot
		
		if Global.infection > 40 or Global.immunity > 20:
			coin = rand_range(0,5)
			if coin > 0:
				enemy = fagocito
			if coin > 1:
				enemy = linfocitot
			if coin > 3:
				if Global.linfocitobvivo == false:
					enemy = linfocitob
					Global.linfocitobvivo = true
				else:
					enemy = linfocitot
			if coin > 4:
				enemy = citotoxica
				
		if Global.infection > 60 or Global.immunity > 40:
			coin = rand_range(0,10)
			if coin > 0:
				enemy = fagocito
			if coin > 1:
				enemy = linfocitot
			if coin > 3:
				if Global.linfocitobvivo == false:
					enemy = linfocitob
					Global.linfocitobvivo = true
				else:
					enemy = linfocitot
			if coin > 6:
				enemy = citotoxica
			if coin > 9:
				enemy = anticorpo
				
		if Global.infection > 90 or Global.immunity > 85:
			enemy = anticorpo
		
		##Realiza o spawn
		Global.instance_node(enemy, enemy_position, Global.node_creation_parent)
		Global.enemy_count += 1
		

#Botão do menu de pausa
func _on_Menu_pressed():
		assert(get_tree().change_scene("res://Scenes/Menu.tscn") == OK)
		get_tree().paused = false

##Aumenta a imunidade
func _on_Immunity_timer_timeout():
	Global.immunity += 1.5

#Inicia o estado de pausa e revela o menu de pausa
func pause():
	$Layer/Pause_Menu.show()
	$Layer/Pause_Menu/Unpause.grab_focus()
	get_tree().paused = true

#Botão do menu de pausa
func _on_Unpause_pressed():
	$Layer/Pause_Menu.hide()
	get_tree().paused = false

#Botão do menu de pausa
func _on_Quit_pressed():
	get_tree().quit()


func _on_Unpause_ready():
	##Ajuste de linguagem para o botão Unpause
	if Global.language == "ptbr":
		$Layer/Pause_Menu/Unpause.text = "Despausar"
	if Global.language == "eng":
		$Layer/Pause_Menu/Unpause.text = "Unpause"


func _on_Menu_ready():
	##Ajuste de linguagem para o botão Menu
	if Global.language == "ptbr":
		$Layer/Pause_Menu/Menu.text = "Menu"
	if Global.language == "eng":
		$Layer/Pause_Menu/Menu.text = "Menu"


func _on_Quit_ready():
	##Ajuste de linguagem para o botão Quit
	if Global.language == "ptbr":
		$Layer/Pause_Menu/Quit.text = "Sair do Jogo"
	if Global.language == "eng":
		$Layer/Pause_Menu/Quit.text = "Quit Game"


func _on_Pause_Menu_ready():
	$Layer/Pause_Menu.rect_position = Vector2(Global.screensize_horiz/2 - 35, Global.screensize_vert/2 - 50)


func _on_ImmunityPBar_ready():
	$UI/Control/ImmunityPBar.rect_position = Vector2(20,Global.screensize_vert - 300)


func _on_InfectionPBar_ready():
	$UI/Control/InfectionPBar.rect_position = Vector2(20, 200)


func _on_Immunity_ready():
	$UI/Control/Immunity.rect_position = Vector2(20,Global.screensize_vert - 300 + 217)
	##Ajuste de linguagem para a label Immunity
	if Global.language == "ptbr":
		$UI/Control/Immunity.text = "Imunidade"
	if Global.language == "eng":
		$UI/Control/Immunity.text = "Immunity"

func _on_Infection_ready():
	$UI/Control/Infection.rect_position = Vector2(20, 200 + 217)
	##Ajuste de linguagem para a label Infection
	if Global.language == "ptbr":
		$UI/Control/Infection.text = "Infecção"
	if Global.language == "eng":
		$UI/Control/Infection.text = "Infection"


func _on_Health_ready():
	$UI/Control/Health.rect_position = Vector2(10, 170)


func _on_Audio_ready():
	##Ajuste de linguagem para o botão Audio
	if Global.language == "ptbr":
		$Layer/Pause_Menu/Audio.text = "Audio"
	if Global.language == "eng":
		$Layer/Pause_Menu/Audio.text = "Audio"



func _on_Audio_pressed():
	$Layer/Pause_Menu.hide()
	$Layer/Audio_Menu/EffectsSlider.value = db2linear(Global.effectsvolume)
	$Layer/Audio_Menu/MusicSlider.value = db2linear(Global.musicvolume)
	$Layer/Audio_Menu.show()


func _on_MusicSlider_value_changed(value):
	Global.musicvolume = linear2db(value)
	AudioServer.set_bus_volume_db(1, Global.musicvolume)



func _on_EffectsSlider_value_changed(value):
	Global.effectsvolume = linear2db(value)
	AudioServer.set_bus_volume_db(2, Global.effectsvolume)


func _on_Effects_ready():
	##Ajuste de linguagem para o label Effects
	if Global.language == "ptbr":
		$Layer/Audio_Menu/Effects.text = "Efeitos Sonoros"
	if Global.language == "eng":
		$Layer/Audio_Menu/Effects.text = "Effects"


func _on_Music_ready():
	##Ajuste de linguagem para o label Music
	if Global.language == "ptbr":
		$Layer/Audio_Menu/Music.text = "Música"
	if Global.language == "eng":
		$Layer/Audio_Menu/Music.text = "Music"


func _on_Return_ready():
	##Ajuste de linguagem para o botão Return
	if Global.language == "ptbr":
		$Layer/Audio_Menu/Return.text = "Voltar"
	if Global.language == "eng":
		$Layer/Audio_Menu/Return.text = "Return"


func _on_Return_pressed():
	$Layer/Pause_Menu.show()
	$Layer/Audio_Menu.hide()


func _on_Audio_Menu_ready():
	$Layer/Audio_Menu.rect_position = Vector2(Global.screensize_horiz/2 - 50, Global.screensize_vert/2 - 50)
