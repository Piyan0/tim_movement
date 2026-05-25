class_name ClickMoveDestination
extends Node2D


var routes: Array

func _ready() -> void:
    pass
    
    
func get_routes(target_pos, click_pos):
    var routes_to_move = [click_pos]
    var available_routes = routes.duplicate()
    available_routes.append(target_pos)
    
    while true:
        var route_with_distance = []
        
        for route in available_routes:
            var current_shortest_route = routes_to_move.back()
            var distance = route.distance_to(current_shortest_route)
            route_with_distance.append({
                distance = distance,
                pos = route
            })
            
        route_with_distance.sort_custom(func(a, b):
            return a.distance < b.distance
        )
        var shortest_route = route_with_distance.front()
        routes_to_move.append(shortest_route.pos)
        
        for i in range(0, available_routes.size() - 1):
            if available_routes[i] == shortest_route.pos:
                available_routes.pop_at(i)
        
        if shortest_route.pos == target_pos:
            break
    
    routes_to_move.reverse()
    return routes_to_move
        
        
        
        
