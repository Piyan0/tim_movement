extends Node2D


@export var cr_rect: ColorRect


func _ready() -> void:
    get_tree().call_group("interact_click", "refresh_page", ["tag1", "tag2"])
