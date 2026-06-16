extends Node2D


@export var cr_rect: ColorRect
@export var player: Player


func _ready() -> void:
	get_tree().call_group("interact_click", "refresh_page", Bootstrap.tags)