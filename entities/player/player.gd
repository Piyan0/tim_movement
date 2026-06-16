class_name Player
extends CharacterBody2D

@export var speed = 60
@export var lb_hint: Label
@export var spr_character: AnimatedSprite2D
@export var nav_agent: NavigationAgent2D
@export var camera: Camera2D
static var instance: Player
var is_moving = false

func _ready() -> void:
    instance = self
    var input_handler = InputHandler.new(self)

    input_handler.can_process = func():
        return [
            !Bootstrap.state.is_showing_overlay,
            !Bootstrap.state.is_interact,
            !Bootstrap.state.is_hovering_button,
        ]


func _physics_process(delta: float) -> void:
    if is_moving:
        var target_reached = _move(delta)
        is_moving = !target_reached


func move_to_pos(pos, offset_from_target = 10):
    is_moving = true
    nav_agent.target_desired_distance = offset_from_target
    nav_agent.target_position = pos
    nav_agent.target_reached.connect(func():
        nav_agent.target_desired_distance = 10
    , CONNECT_DEFERRED)
    await nav_agent.target_reached


func move_to_click_pos(click_pos):
    if is_moving:
        return
    is_moving = true
    var map_rid = get_world_2d().navigation_map
    var valid_click_pos = NavigationServer2D.map_get_closest_point(map_rid, click_pos)
    nav_agent.target_position = valid_click_pos


func set_facing_to_pos(pos):
    var dir = _get_direction_from_route(global_position, pos)
    _handle_direction_changed(dir, false)


func _handle_direction_changed(dir: Dictionary, walk_mode = true):
    if walk_mode:
        match dir.y:
            "up":
                match dir.x:
                    "left":
                        spr_character.play("walk_upL")
                    "right":
                        spr_character.play("walk_upR")
            "down":
                match dir.x:
                    "left":
                        spr_character.play("walk_downL")
                    "right":
                        spr_character.play("walk_downR")
    else:
        match dir.y:
            "up":
                match dir.x:
                    "left":
                        spr_character.play("idle_upL")
                    "right":
                        spr_character.play("idle_upR")
            "down":
                match dir.x:
                    "left":
                        spr_character.play("idle_downL")
                    "right":
                        spr_character.play("idle_downR")



func _move(delta):
    var next_waypoint = nav_agent.get_next_path_position()
    var dir_route = _get_direction_from_route(position, next_waypoint)

    velocity = position.direction_to(next_waypoint) * speed

    if nav_agent.is_target_reached():
        _handle_direction_changed(dir_route, false)
    else:
        _handle_direction_changed(dir_route, true)

    move_and_slide()
    return nav_agent.is_target_reached()



func _get_direction_from_route(from_pos, to_pos):
    var dir = to_pos -  from_pos
    var result = {}
    result.x = "left" if dir.x < 0 else "right"
    result.y = "up" if dir.y < 0 else "down"
    return result
