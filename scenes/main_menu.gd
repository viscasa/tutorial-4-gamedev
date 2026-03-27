extends MarginContainer

@onready var first_list: VBoxContainer = $"HBoxContainer/VBoxContainer/First List"
@onready var second_list: VBoxContainer = $"HBoxContainer/VBoxContainer/Second List"

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level1.tscn")


func _on_select_stage_pressed() -> void:
	first_list.hide()
	second_list.show()
	


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level1.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level2.tscn")
