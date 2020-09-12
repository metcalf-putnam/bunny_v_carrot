extends Node2D
signal restart


func _on_Button_pressed():
	emit_signal("restart")
