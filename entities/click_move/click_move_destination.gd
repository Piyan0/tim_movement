class_name ClickMoveDestination
extends Node2D

var routes: Array[MovePoint]


func _ready() -> void:
    pass


func get_routes(target_pos, click_pos):
    pass
    

func _get_points():
    return Bootstrap.get_tree().get_nodes_in_group("move_point")
