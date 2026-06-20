extends Node2D


@export var cr_rect: ColorRect
@export var player: Player


func _ready() -> void:
    var actions = InteractActions.new()
    actions.play_bgm("world_bgm")
    get_tree().call_group("interact_click", "refresh_page", Bootstrap.tags)
    
    if Bootstrap.state.new_game:
        actions = InteractActions.new()
        Bootstrap.state.is_interact = true
        Player.instance.set_facing_to_pos(Vector2(4345, 2697))
        await actions.wait(1)
        await actions.image("res://assets/images/narator/intro1.png", 4)
        await actions.text([
            "Shane shane.png I shall not rest until you are free again, Princess Yontu.",
            "Shane shane.png I solemnly promise to seek out the three royal crystals needed to break the evil spell.",
        ])
        await actions.image("res://assets/images/narator/intro2.png", 3)
        Bootstrap.state.is_interact = false