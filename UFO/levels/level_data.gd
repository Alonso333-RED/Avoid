extends Resource
class_name LevelData

@export var name: String
@export_multiline var description: String
@export_enum("Muy Facil", "Facil", "Normal", "Difícil", "Muy Dificil") var difficulty: int
@export var scene: PackedScene
