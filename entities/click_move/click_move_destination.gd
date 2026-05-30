class_name ClickMoveDestination
extends Node2D

var routes: Array[MovePoint]


func _ready() -> void:
    pass


func get_routes(target_pos, click_pos):
    var get_closest_point_to_pos = func(pos):
        var shortest_distance = INF
        var shortest_point
        for point in _get_points():
            var distance = point.global_position.distance_to(pos)
            if  distance < shortest_distance:
                shortest_distance= distance
                shortest_point = point

        return shortest_point
    
    var current_g = 0
    var current_point: MovePoint = get_closest_point_to_pos.call(target_pos)
    var last_point: MovePoint = get_closest_point_to_pos.call(click_pos)
    # breakpoint
    var routes = [current_point.global_position]

    var click_distance_from_player = click_pos.distance_to(target_pos)
    var click_distance_from_first_point = click_pos.distance_to(current_point.global_position)
    #breakpoint
    if click_distance_from_player < click_distance_from_first_point:
        return [click_pos]
       
    while true:
        var distance_from_click = current_point.global_position.distance_to(click_pos)
        var shortest_f = INF
        var point: MovePoint = null
        var current_point_name = current_point.name
        var g
        for neighbour: MovePoint in current_point.neighbours:
            neighbour.set_h(click_pos)
            var neighbour_name = neighbour.name
            g = current_point.global_position.distance_to(neighbour.global_position)
            var f = (current_g + g) + neighbour.h
            if f < shortest_f:
                shortest_f = f
                point = neighbour
        
        # click in the middle of 2 point.
        if distance_from_click < current_point.global_position.distance_to(point.global_position):
            routes.append(click_pos)
            return routes
            
        routes.append(point.global_position)
        current_g += g
        current_point = point
        
        if point == last_point:
            routes.append(click_pos)
            return routes
    

func _get_points():
    return Bootstrap.get_tree().get_nodes_in_group("move_point")
    
