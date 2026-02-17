extends Node

@export var attack_scenes : Array[PackedScene] = []

var spawn_rate : float = 1.0
var spawn_accumulator : float = 0.0
var time_elapsed : float = 0.0

func _process(delta: float):
	if attack_scenes.size() == 0:
		return

	time_elapsed += delta
	spawn_rate = 1.0 + (time_elapsed * 0.1)
	spawn_accumulator += spawn_rate * delta
	var to_spawn : int = int(floor(spawn_accumulator))
	
	if to_spawn > 0:
		spawn_accumulator -= to_spawn
		for i in to_spawn:
			spawn_attack()

func spawn_attack():
	var idx = randi() % attack_scenes.size()
	var attack = attack_scenes[idx].instantiate()
	add_child(attack)
