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
var enemy = fagocito
var tutorial = 1

func _ready():
	##Se coloca com o creation parent, o node pai onde inimigos, o player e projéteis serão criadas
	Global.node_creation_parent = self
	Global.level = 0
	tutorial = 1
	##Cria o player
	Global.instance_node(virus, Vector2(Global.screensize_horiz/2, Global.screensize_vert/2), Global.node_creation_parent)
	##Esconde os menus
	$Layer/Pause_Menu.hide()
	$Layer/Audio_Menu.hide()
	$Layer/Tutorial1.hide()
	$Layer/Tutorial2.hide()
	$Layer/Tutorial3.hide()
	$Layer/Tutorial4.hide()
	$Layer/Tutorial5.hide()
	$Layer/Tutorial6.hide()
	$Layer/Tutorial7.hide()
	$Layer/Tutorial8.hide()
	$Layer/Tutorial9.hide()
	$Layer/Tutorial10.hide()
	$Layer/Tutorial11.hide()
	$Layer/Tutorial12.hide()
	
	AudioServer.set_bus_volume_db(1,linear2db(Global.musicvolume))
	AudioServer.set_bus_volume_db(2,linear2db(Global.effectsvolume))
	
	
	##Cria as parades preliminares, antes das paredes reais chegarem
	Global.instance_node(leftwall, Vector2(Global.screensize_horiz - 30, Global.screensize_vert/2), Global.node_creation_parent)
	Global.instance_node(rightwall, Vector2(30, Global.screensize_vert/2), Global.node_creation_parent)
	for number in range(8):
		Global.instance_node(leftwall, Vector2(Global.screensize_horiz - 30, number * (-100)), Global.node_creation_parent)
		Global.instance_node(rightwall, Vector2(30, number * (-100)), Global.node_creation_parent)
	
	##Garante que a imunidade nunca seja menor que 0
	if Global.immunity < 0:
		Global.immunity = 0
	
	##Spawna inimigo no inicio do jogo para efeitos de teste
##	Global.instance_node(fagocito, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)
##	Global.instance_node(linfocitob, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)
##	Global.instance_node(linfocitot, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)
##	Global.instance_node(citotoxica, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)
##	Global.instance_node(anticorpo, Vector2(Global.screensize_horiz/2, Global.screensize_vert), Global.node_creation_parent)
	
	##Tutorial
	$Tutorial_timer.start()

func _exit_tree():
	Global.node_creation_parent = null

func _process(_delta):
	
	if Global.immunity < 0:
		Global.immunity = 0
	if Global.enemy_count <0:
		Global.enemy_count = 0
	
	##Barras de infecção e imunidade
	$UI/Control/ImmunityPBar.value = Global.immunity
	$UI/Control/InfectionPBar.value = Global.infection
	
	##Menu de Pausa
	if Input.is_action_just_pressed("escape"):
		pause()
	##Infection 100% 
	if Global.infection >= 100:
		Global.infection = 25
	##Immunity 100%
	if Global.immunity >=100:
		Global.immunity = 25
	##Player death in tutorial
	if Global.health <= 0:
		for _i in self.get_children():
			if _i.is_in_group("enemy"):
				_i.queue_free()
		Global.reset_globals()
		Global.node_creation_parent = self
		tutorial -= 1
		show_tutorial()
		Global.instance_node(virus, Vector2(Global.screensize_horiz/2, Global.screensize_vert/2), Global.node_creation_parent)
		
	if tutorial == 7:
		if Global.enemy_count <= 0 or Global.playertype != "virus":
			Global.infection += 30
			show_tutorial()
	
	if tutorial == 9:
		if Global.enemy_count <= 0:
			if Global.playertype == "fagocito":
				show_tutorial()
			else:
				spawn_enemy()
	
	if tutorial == 10:
		if Global.enemy_count <= 0:
			show_tutorial()
	
	if tutorial == 11:
		if Global.playertype == "virus":
			show_tutorial()
	
	if tutorial  == 13:
		if Global.enemy_count <= 0:
			spawn_enemy()
			spawn_enemy()

func spawn_enemy():
	if Global.enemy_count < max_enemies:
		##Define a posição do spawn (levemente fora da tela)
		var spawn_height = rand_range(-10, 10)
		var enemy_position = Vector2(rand_range(0 + 60,Global.screensize_horiz - 60), -100)
		if spawn_height >= 0:
			enemy_position = Vector2(rand_range(0 + 60,Global.screensize_horiz - 60), -100)
		if spawn_height < 0:
			enemy_position = Vector2(rand_range(0 + 60,Global.screensize_horiz - 60), Global.screensize_vert+100)
		
		Global.instance_node(enemy, enemy_position, Global.node_creation_parent)
		Global.enemy_count += 1

func _on_Enemy_spawn_timer_timeout():
	spawn_enemy()

#Botão do menu de pausa
func _on_Menu_pressed():
		get_tree().change_scene("res://Scenes/Menu.tscn")
		get_tree().paused = false

##Aumenta a imunidade
func _on_Immunity_timer_timeout():
	Global.immunity += 1

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

func _on_Tutorial_timer_timeout():
	show_tutorial()

func _on_Continue_pressed():
	if tutorial == 1:
		$Layer/Tutorial1.hide()
		$Tutorial_timer.start()
	if tutorial == 2:
		$Layer/Tutorial2.hide()
		$Tutorial_timer.wait_time = 4
		$Tutorial_timer.start()
	if tutorial == 3:
		$Layer/Tutorial3.hide()
		$Tutorial_timer.start()
	if tutorial == 4:
		$Layer/Tutorial4.hide()
		$Tutorial_timer.wait_time = 2
		Global.immunity += 30
		$Immunity_timer.start()
		$Tutorial_timer.start()
	if tutorial == 5:
		$Layer/Tutorial5.hide()
		$Tutorial_timer.start()
	if tutorial == 6:
		$Layer/Tutorial6.hide()
		spawn_enemy()
	if tutorial == 7:
		$Layer/Tutorial7.hide()
		$Tutorial_timer.start()
	if tutorial == 8:
		$Layer/Tutorial8.hide()
		spawn_enemy()
	if tutorial == 9:
		$Layer/Tutorial9.hide()
		spawn_enemy()
	if tutorial == 10:
		$Layer/Tutorial10.hide()
		$Tutorial_timer.start()
	if tutorial == 11:
		$Layer/Tutorial11.hide()
		$Tutorial_timer.start()
	if tutorial == 12:
		$Layer/Tutorial12.hide()
	tutorial += 1
	get_tree().paused = false

func show_tutorial():
	if tutorial == 1:
		$Layer/Tutorial1.show()
	if tutorial == 2:
		$Layer/Tutorial2.show()
	if tutorial == 3:
		$Layer/Tutorial3.show()
	if tutorial == 3:
		$Layer/Tutorial3.show()
	if tutorial == 4:
		$Layer/Tutorial4.show()
	if tutorial == 5:
		$Layer/Tutorial5.show()
	if tutorial == 6:
		$Layer/Tutorial6.show()
	if tutorial == 7:
		$Layer/Tutorial7.show()
	if tutorial == 8:
		$Layer/Tutorial8.show()
	if tutorial == 9:
		$Layer/Tutorial9.show()
	if tutorial == 10:
		$Layer/Tutorial10.show()
	if tutorial == 11:
		$Layer/Tutorial11.show()
	if tutorial == 12:
		$Layer/Tutorial12.show()
	get_tree().paused = true

func _on_Tutorial1_ready():
	$Layer/Tutorial1.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial1/Texto.text = "\nVIRUS RAID:\n\n Bem vindo ao Tutorial!"
	if Global.language == "eng":
		$Layer/Tutorial1/Texto.text = "\nVIRUS RAID:\n\n Welcome to the Tutorial!"


func _on_Tutorial2_ready():
	$Layer/Tutorial2.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.movimentacao == "teclado":
		if Global.language == "ptbr":
			$Layer/Tutorial2/Texto.text = "\nCONTROLES:\n\nUtilize as teclas W, A, S, D para se movimentar pela tela."
		if Global.language == "eng":
			$Layer/Tutorial2/Texto.text = "\nCONTROLLS:\n\nUse the W, A, S, D keys to move about the screen."
	
	if Global.movimentacao == "mouse":
		$Layer/Tutorial2/Imagem.hide()
		if Global.language == "ptbr":
			$Layer/Tutorial2/Texto.text = "\nCONTROLES:\n\nSeu personagem seguirá o cursor do mouse, utilize-o para\n se mover pela tela."
		if Global.language == "eng":
			$Layer/Tutorial2/Texto.text = "\nCONTROLLS:\n\nYour character will follow the mouse cursos, use it to\n move about the screen."

func _on_Tutorial3_ready():
	$Layer/Tutorial3.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial3/Texto.text = "\nCOMBATE:\n\n Clique em um ponto da tela com o botão esquerdo do mouse\n para atirar em sua direção."
	if Global.language == "eng":
		$Layer/Tutorial3/Texto.text = "\nCOMBAT:\n\n Click somewhere on the screen with left mouse button to \n shoot in that direction."

func _on_Tutorial4_ready():
	$Layer/Tutorial4.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial4/Texto.text = "\nCOMBATE:\n\n Sua barra de vida está localizada no canto superior esquerdo."
	if Global.language == "eng":
		$Layer/Tutorial4/Texto.text = "\nCOMBAT:\n\n Your health bar is located on the top left corner of the screen."

func _on_Tutorial5_ready():
	$Layer/Tutorial5.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial5/Texto.text = "\nIMUNIDADE:\n\n Com o tempo, o hospedeiro desenvolverá imunidade a seu vírus.\n A imunidade é representada pela barra azul no canto inferior\n esquerdo.\n\n Caso a imunidade chegue a 100%, você será derrotado.\n\n Destrua as hemácias para retardar a imunidade."
	if Global.language == "eng":
		$Layer/Tutorial5/Texto.text = "\nIMMUNITY:\n\n With time, the host will develop immunity to your virus.\n Immunity is represented by the blue bar on the bottom left corner\n of the screen.\n\n If Immunity hits 100%, you will be defeated.\n\n Destroy the red blood cells to slow immunity gain."

func _on_Tutorial6_ready():
	$Layer/Tutorial6.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial6/Texto.text = "\nINIMIGOS:\n\n O sistema imune do hospedeiro enviará celulas de defesa\npara te destruir.\n\n Acabe com elas antes que acabem com você."
	if Global.language == "eng":
		$Layer/Tutorial6/Texto.text = "\nENEMIES:\n\n The Immune System of the host will its send defense cells\n to destroy you.\n\n Kill them before they kill you."

func _on_Tutorial7_ready():
	$Layer/Tutorial7.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial7/Texto.text = "\nINFECÇÃO:\n\nSeu objetivo é infectar completamente seu hospedeiro. Seus pontos\n de infecção aumentam ao derrotar células de defesa.\n\n A barra de infecção no canto superior esquerdo mostra seu progresso."
	if Global.language == "eng":
		$Layer/Tutorial7/Texto.text = "\nINFECTION:\n\nYour objetctive is to completely infect your host. Your infection\n points increase as you defeat the host's defenses.\n\n The infection bar on the upper left corner keeps track of your progress."

func _on_Tutorial8_ready():
	$Layer/Tutorial8.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial8/Texto.text = "\nINFECTANDO INIMIGOS:\n\nSendo um vírus, você pode tomar controle de inimigos enfraquecidos.\nInimigos ficam enfraquecidos quando atingem um único ponto de vida\nInimigos enfraquecidos mudam de cor.\n\nExperimente atirar duas vezes em um Fagócito e então tocar nele."
	if Global.language == "eng":
		$Layer/Tutorial8/Texto.text = "\nINFECTING ENEMIES:\n\n Being a virus, you can take control of weakened enemies.\n Enemies turn weakened when they reach a single health point.\nWeakened enemies change color.\n\n Try shooting this Fagocyte twice and then touching him."

func _on_Tutorial9_ready():
	$Layer/Tutorial9.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial9/Texto.text = "\nINFECTANDO INIMIGOS:\n\n Dependendo do tipo de inimigo que você tomou controle, você\n receberá novos tipos de ataque, velocidade de movimento,\n dano de ataque e quantidade de vida.\n\nExperimente seu novo ataque derrotando um Fagócito."
	if Global.language == "eng":
		$Layer/Tutorial9/Texto.text = "\nINFECTING ENEMIES:\n\n Depending on the type of enemy you've infected, you will recieve\n a new attack type, movement speed, attack damage and \n health pool.\n\nTry out your new attack by deafeating this Fagocyte."

func _on_Tutorial10_ready():
	$Layer/Tutorial10.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial10/Texto.text = "\nINFECTAR INIMIGOS:\n\nInimigos controlados não duram para sempre, após algum tempo\n eles irão mudar de cor para sinalizar que seu controle está prestes\na acabar.\n\nRetornar a sua forma de vírus desta forma te recompensa\n com alguns pontos de infecção.\n\n Se sua vida chegar a zero enquanto estiver controlando um inimigo,\n você será forçado à sua forma de vírus novamente, mas não receberá\n os pontos de infecção bonus."
	if Global.language == "eng":
		$Layer/Tutorial10/Texto.text = "\nINFECTING ENEMIES:\n\n Infected enemies don't last forever, after some time they \n will change color to warn you that the infection is on the verge of \n ending.\n\n Returning to your virus form from completing an infection\n rewards you with bonus infection points.\n\n If your health reaches zero while in control of an enemy,\n you will be forced back into your virus form, and will not recieve\n the bonus infection points."

func _on_Tutorial11_ready():
	$Layer/Tutorial11.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial11/Texto.text = "\nINIMIGOS:\n\n Cada inimigo possui um comportamento diferente, análogo à função que\n realiza no sistema imune humano. Você pode ler sobre cada inimigo na\n aba ''Ajuda'' no Menu Principal."
	if Global.language == "eng":
		$Layer/Tutorial11/Texto.text = "\nENEMIES:\n\n Each enemy behaves differently, in a similar way to their real world\n counterparts. You can read more about each enemy in the ''Help'' tab\n on the main menu."

func _on_Tutorial12_ready():
	$Layer/Tutorial12.rect_position = Vector2(Global.screensize_horiz/2 - 239, Global.screensize_vert/2 - 160)
	if Global.language == "ptbr":
		$Layer/Tutorial12/Texto.text = "\nCONTROLES:\n\n Você pode apertar ESC a qualquer momento para pausar o jogo.\n\nQuando estiver satisfeito, pressione ESC e retorne ao Menu Principal."
	if Global.language == "eng":
		$Layer/Tutorial12/Texto.text = "\nCONTROLLS:\n\n You can press ESC at any time to pause the game.\n\n When you are done with the tutorial, press ESC and return to\n the Main Menu."

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
