extends Node2D


@export var cr_rect: ColorRect
@export var player: Player


func _ready() -> void:
    get_tree().call_group("interact_click", "refresh_page", ["tag1", "tag2"])
    # player.set_path(get_tree().get_nodes_in_group("route").map(func(value):
    #         return value.global_position
    #         )
    #     )
