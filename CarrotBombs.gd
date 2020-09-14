extends Area2D
var player_in_area := false
var bomb_index := 0
export (PackedScene) var CarrotBomb
var min_wait := 0.25
var max_wait := 1.5
var wait_step := 0.25


func stop():
	player_in_area = false
	$Timer.stop()
	$Timer.wait_time = max_wait

func _ready():
	$Timer.wait_time = max_wait
	pass # Replace with function body.


func _on_CarrotBombs_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		$Timer.start()


func _on_CarrotBombs_body_exited(body):
	if body.is_in_group("player"):
		stop()


func _on_Timer_timeout():
	spawn_bombs()


func spawn_bombs():
	# TODO: make looops xD
	$InnerRing/PathFollow2D.offset = randi()
	create_bomb($InnerRing/PathFollow2D.position)
	
	$MiddleRing/PathFollow2D.offset = randi()
	create_bomb($MiddleRing/PathFollow2D.position)
	$MiddleRing/PathFollow2D.offset = randi()
	create_bomb($MiddleRing/PathFollow2D.position)
	
	$OuterRing/PathFollow2D.offset = randi()
	create_bomb($OuterRing/PathFollow2D.position)
	$OuterRing/PathFollow2D.offset = randi()
	create_bomb($OuterRing/PathFollow2D.position)
	$OuterRing/PathFollow2D.offset = randi()
	create_bomb($OuterRing/PathFollow2D.position)


func create_bomb(pos : Vector2):
	var bomb = CarrotBomb.instance()
	add_child(bomb)
	bomb.position = pos
	

