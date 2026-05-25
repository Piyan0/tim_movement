class_name ClickMoveDestination
extends Node2D


var routes: Array

func _ready() -> void:
    pass
    
    
func get_routes(target_pos, click_pos):
    var routes_to_move = [target_pos]
    var available_routes = routes.duplicate()
    available_routes.append(click_pos)
    while true:
        var shortest_distance = INF
        var route_to_add = Vector2.ZERO
        for route in available_routes:
            var distance = route.distance_to(routes_to_move.back())
            if distance < shortest_distance:
                route_to_add = route
                shortest_distance = distance
        routes_to_move.append(route_to_add)
        available_routes.erase(route_to_add)
        pass
        if route_to_add == click_pos:
            break
        
    #print(routes_to_move)
    return routes_to_move
        
        
        
        
