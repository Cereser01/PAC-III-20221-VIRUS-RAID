extends Control


func _ready():
		##Ajuste de linguagem para o botão Music
	if Global.language == "ptbr":
		$VBoxContainer/Music.text = "Música"
	if Global.language == "eng":
		$VBoxContainer/Music.text = "Music"
	
		##Ajuste de linguagem para o botão Effects
	if Global.language == "ptbr":
		$VBoxContainer/Effects.text = "Efeitos Sonoros"
	if Global.language == "eng":
		$VBoxContainer/Effects.text = "Effects"
	
	$Audio.rect_position = Vector2(Global.screensize_horiz/2 - 60, Global.screensize_vert/2 - 200)
	$VBoxContainer.rect_position = Vector2(Global.screensize_horiz/2 - 50, Global.screensize_vert/2 )
	
	$VBoxContainer/EffectsSlider.value = db2linear(Global.effectsvolume)
	$VBoxContainer/MusicSlider.value = db2linear(Global.musicvolume)


func _on_Voltar_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")


func _on_EffectsSlider_value_changed(value):
	Global.effectsvolume = linear2db(value)


func _on_MusicSlider_value_changed(value):
	Global.musicvolume = linear2db(value)


func _on_MusicSlider_changed():
	AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1), Global.musicvolume, 0.5))
	$popmusic.play()


func _on_EffectsSlider_changed():
	AudioServer.set_bus_volume_db(2, lerp(AudioServer.get_bus_volume_db(2), Global.effectsvolume, 0.5))
	$popeffects.play()


func _on_Effects_pressed():
	AudioServer.set_bus_volume_db(2, lerp(AudioServer.get_bus_volume_db(2), Global.effectsvolume, 0.5))
	$popeffects.play()


func _on_Music_pressed():
	AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1), Global.musicvolume, 0.5))
	$popmusic.play()
