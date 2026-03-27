extends Sprite2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer

func _ready() -> void:
	if LevelManager.current_level == "Level1":
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/Level2.tscn")
	if LevelManager.current_level == "Level2":
		canvas_layer.show()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
