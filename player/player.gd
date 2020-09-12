extends KinematicBody2D
var speed = 200
var animationState : AnimationNodeStateMachinePlayback
var health := 100.0
var screen_size
signal player_killed

# Called when the node enters the scene tree for the first time.
func _ready():
	animationState = $AnimationTree["parameters/playback"]
	$HealthBar.value = health
	screen_size = get_viewport_rect().size

func _physics_process(_delta):
	var velocity = Vector2()
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")


	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		velocity = move_and_slide(velocity)
		update_sprite(velocity)
	else:
		animationState.travel("idle")

	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	
func update_sprite(velocity : Vector2):
	var direction = velocity.normalized()
	$AnimationTree.set("parameters/idle/blend_position", direction)
	$AnimationTree.set("parameters/walk/blend_position", direction)
	animationState.travel("walk")


func hit(damage):
	print("taking damage!")
	health -= damage
	$HealthBar.value = health
	if health <= 0:
		emit_signal("player_killed")
		$death_sound.play()


func _on_Area2D_body_entered(body):
	if body.is_in_group("boss_weapon"):
		hit(body.damage)
		$hit_sound.play()
		body.queue_free()


func revive():
	health = 100
	$HealthBar.value = health
