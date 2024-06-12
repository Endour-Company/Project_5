extends Control

signal close_signal
signal area_hutan
signal area_sawah
signal area_pemukiman
signal area_pusatdesa

func _on_close_button_pressed():
	close_signal.emit()


func _on_government_pressed():
	area_pusatdesa.emit()


func _on_houses_pressed():
	area_pemukiman.emit()


func _on_ricefield_pressed():
	area_sawah.emit()


func _on_forest_pressed():
	area_hutan.emit()
