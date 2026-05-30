class_name Player
extends Node2D

@export var speed = 60
@export var movement: ClickMoveDestination
@export var lb_hint: Label
@export var spr_character: AnimatedSprite2D
var is_moving = false 

func set_path(routes):
    movement.routes = routes
    
    
func _input(e):
    if e is InputEventMouseButton:
        if e.pressed && e.button_index == MOUSE_BUTTON_LEFT:
            var click_pos = get_global_mouse_position()
            var routes = Bootstrap.click_move.get_routes(global_position, click_pos)
            if !is_moving:
                is_moving = true
                await _move(routes)
                is_moving = false


func _move(routes):
    var starting_pos = global_position
    var current_route = global_position
    var t = create_tween()
    for route in routes:
        t.tween_callback(func():
            var dir_data =_get_direction_from_route(global_position, route)
            match dir_data.y:
                "up":
                    match dir_data.x:
                        "left":
                            spr_character.play("walk_upL")
                        "right":
                            spr_character.play("walk_upR")
                "down":
                    match dir_data.x:
                        "left":
                            spr_character.play("walk_downL")
                        "right":
                            spr_character.play("walk_downR")
        )
        t.tween_property(self, "global_position", route, current_route.distance_to(route)/speed)
        current_route = route
        
    await t.finished
    var last_pos = routes.pop_back()
    var from_pos = routes.pop_back()
    from_pos = starting_pos if from_pos == null else from_pos
    var last_dir = _get_direction_from_route(from_pos, last_pos)

    match last_dir.y:
        "up":
            match last_dir.x:
                "left":
                    spr_character.play("idle_upL")
                "right":
                    spr_character.play("idle_upR")
        "down":
            match last_dir.x:
                "left":
                    spr_character.play("idle_downL")
                "right":
                    spr_character.play("idle_downR")


func _get_direction_from_route(from_pos, route):
    var dir = route -  from_pos
    var result = {}
    result.x = "left" if dir.x < 0 else "right"
    result.y = "up" if dir.y < 0 else "down"
    return result
