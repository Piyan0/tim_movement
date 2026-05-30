class_name ClickMoveDestination
extends Node2D

const CLICK_ID = 99999999
const TARGET_ID = 99999998


func _ready() -> void:
    pass


func get_routes(target_pos, click_pos):
    var astar = _create_astar()

    var point_closest_to_target_id = astar.get_closest_point(target_pos)
    var point_closest_to_click_id = astar.get_closest_point(click_pos)

    astar.add_point(TARGET_ID, target_pos)
    astar.add_point(CLICK_ID, click_pos)

    astar.connect_points(TARGET_ID, point_closest_to_target_id)
    astar.connect_points(CLICK_ID, point_closest_to_click_id)
    
    var point_closest_to_target: MovePoint = instance_from_id(point_closest_to_target_id)
    var point_closest_to_click: MovePoint = instance_from_id(point_closest_to_click_id)
   
    var routes = Array(astar.get_point_path(TARGET_ID, CLICK_ID))
    routes.pop_front()

    if routes.front().distance_to(target_pos) > target_pos.distance_to(click_pos):
        return [click_pos]

    return routes

func _create_astar() -> AStar2D:
    var astar = AStar2D.new()

    for point: MovePoint in _get_points():
        astar.add_point(point.get_instance_id(), point.global_position)

    for point: MovePoint in _get_points():
        for neighbour: MovePoint in point.neighbours:
            astar.connect_points(point.get_instance_id(), neighbour.get_instance_id())
    
    return astar

func _get_points():
    return Bootstrap.get_tree().get_nodes_in_group("move_point")
