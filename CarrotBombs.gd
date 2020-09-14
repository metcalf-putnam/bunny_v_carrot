extends Area2D
var player_in_area := false
var num_bombs = [3, 5, 7, 9]
var bomb_index := 0


func _ready():
	pass # Replace with function body.


func _on_CarrotBombs_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		$Timer.start()


func _on_CarrotBombs_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
		$Timer.stop()


func _on_Timer_timeout():
	create_bombs()
	
	
func create_bombs():
	bomb_index = (bomb_index + 1) % len(num_bombs)
