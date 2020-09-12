extends Node2D


func _ready():
	$GameOver.hide()


func _on_player_player_killed():
	$carrot.stop()
	$GameOver.show()
	$player.set_inactive()
	

func _on_GameOver_restart():
	$GameOver.hide()
	$player.revive()
	$player.position = $PlayerStart.position
	yield(get_tree().create_timer(2), "timeout") # TODO: setup count down
	$carrot.start()
