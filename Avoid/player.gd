extends CharacterBody2D

var speed = 225

var min_x = -450
var max_x = 450
var min_y = -450
var max_y = 450

@export var max_health: int = 100
var health: int = max_health
var is_dead = false

@onready var hp_indicator = get_node("/root/Node2D/CanvasLayer/Label")

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if Input.is_action_pressed("ui_up_right"):
		input_vector = Vector2(1, -1)
	elif Input.is_action_pressed("ui_up_left"):
		input_vector = Vector2(-1, -1)
	elif Input.is_action_pressed("ui_down_right"):
		input_vector = Vector2(1, 1)
	elif Input.is_action_pressed("ui_down_left"):
		input_vector = Vector2(-1, 1)

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, min_y, max_y)
	
func take_damage(amount: int) -> void:
	if is_dead:
		return
	health -= amount
	$hit.play()
	hp_indicator.text = str(health)
	health = clamp(health, 0, max_health)
	if health == 0:
		is_dead = true
		get_tree().call_deferred("reload_current_scene")
		
func recover_health(amount: int) -> void:
	health += amount
	$recover_sound.play()
	health = clamp(health, 0, max_health)
	hp_indicator.text = str(health)
	
func _on_timer_timeout() -> void:
	if health < max_health:
		$regen.play()
		health += 1
		health = clamp(health, 0, max_health)
		hp_indicator.text = str(health)
