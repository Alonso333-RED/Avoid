extends Node

var attacks: Array[AttackData] = []

func _ready():
	attacks = [
		preload("res://Attacks/bullet_attack/bullet_attack.tres"),
		preload("res://Attacks/laser_attack/laser_attack.tres"),
		preload("res://Attacks/area_attack/area_attack.tres"),
		preload("res://Attacks/area_regen/area_regen.tres")
	]
