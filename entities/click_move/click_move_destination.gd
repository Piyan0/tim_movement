class_name ClickMoveDestination
extends Node2D

var routes: Array[MovePoint]


func _ready() -> void:
    pass


func get_routes(target_pos, click_pos):
    var get_closest_point = func():
        var shortest_distance = INF
        var shortest_point
        for point in _get_points():
            var distance = point.global_position.distance_to(target_pos)
            if  distance < shortest_distance:
                shortest_distance= distance
                shortest_point = point

        return shortest_point
    
    var current_point: MovePoint = get_closest_point.call()
    var routes = [current_point.global_position]
    var current_point_distance = current_point.global_position.distance_to(click_pos)
    breakpoint
    while true:
        var shortest_f = INF
        var point: MovePoint = null
        var current_point_name = current_point.name
        for neighbour: MovePoint in current_point.neighbours:
            neighbour.set_h(click_pos)
            neighbour.set_g(target_pos)
            var neighbour_name = neighbour.name
            var f = neighbour.get_f()
            pass
            if f < shortest_f:
                shortest_f = f
                point = neighbour
        routes.append(point.global_position)
        current_point = point
        var point_distance = point.global_position.distance_to(click_pos)
        breakpoint
        if point_distance > current_point_distance:
            break
    
    return routes


func _get_points():
    return Bootstrap.get_tree().get_nodes_in_group("move_point")
    
