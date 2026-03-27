extends Node2D

@export var level_name: String = "Level1"


@onready var player: CharacterBody2D = $Player
@onready var life_counter_label: Label = $CanvasLayer/LifeCounter/VBoxContainer/Label

func _ready() -> void:
	LevelManager.current_level = level_name
	if player and life_counter_label:
		player.life_changed.connect(update_life_counter)
		update_life_counter(player.life_count)

func update_life_counter(lives: int) -> void:
	if life_counter_label:
		life_counter_label.text = "Live : " + str(lives)
