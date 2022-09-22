extends VBoxContainer

func _on_MusicSlider_value_changed(value):
	Global.musicvolume = linear2db(value)
	AudioServer.set_bus_volume_db(1, Global.musicvolume)



func _on_EffectsSlider_value_changed(value):
	Global.effectsvolume = linear2db(value)
	AudioServer.set_bus_volume_db(2, Global.effectsvolume)
