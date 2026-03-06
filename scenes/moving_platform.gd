extends AnimatableBody2D

@export var move_distance: Vector2 = Vector2(200, 0)
@export var duration: float = 2.0

var start_position: Vector2
var end_position: Vector2
var time_passed: float = 0.0

func _ready() -> void:
	start_position = global_position
	end_position = start_position + move_distance

func _physics_process(delta: float) -> void:
	time_passed += delta
	
	var t = pingpong(time_passed / duration, 1.0)
	
	t = smoothstep(0.0, 1.0, t)
	
	global_position = start_position.lerp(end_position, t)
