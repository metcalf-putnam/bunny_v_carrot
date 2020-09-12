extends Node2D



func _ready():
	$GameOver.hide()


func _on_player_player_killed():
	$carrot.stop()
	$GameOver.show()


func _on_GameOver_restart():
	$GameOver.hide()
	$player.revive()
	yield(get_tree().create_timer(2), "timeout")
	$carrot.start()

