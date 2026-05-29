class_name Player
extends Node2D

@export var speed = 60
@export var movement: ClickMoveDestination
@export var lb_hint: Label


func set_path(routes):
    movement.routes = routes
    
    
func _input(e):
    if e is InputEventMouseButton:
        if e.pressed && e.button_index == MOUSE_BUTTON_LEFT:
            var click_pos = get_global_mouse_position()
            var routes = Bootstrap.click_pos.get_routes(global_position, click_pos)
            print(routes)
            return
            # var t = create_tween()
            # var current_route = global_position
            # for route in routes:
            #     t.tween_property(self, "global_position", route, current_route.distance_to(route)/speed)
            #     current_route = route
                
            # await t.finished
