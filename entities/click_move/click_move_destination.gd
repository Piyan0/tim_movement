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
            var distance = point.distance_to(target_pos)
            if  distance < shortest_distance:
                shortest_distance= distance
                shortest_point = point
        return shortest_point
    
    var current_point = get_closest_point.call()
    var routes = [closest_point.global_position]
    
    while true:
        var shortest_f = INF
        var point
        for neighbour in current_point:
            neighbour.set_h(click_pos)
            neighbour.set_g(target_pos)
            if neighbour.get_f() < shortest_f:
                shortest_f = neighbour.get_f()
                point = neighbour
        
        routes.append(point.global_position)
        current_point = point
        if point == click_pos:
            break
    
    return routes


func _get_points():
    return Bootstrap.get_tree().get_nodes_in_group("move_point")
    
