extends Node2D


@export var cr_rect: ColorRect
@export var player: Player


func _ready() -> void:
	var actions = InteractActions.new()
	actions.play_bgm("world_bgm")
	get_tree().call_group("interact_click", "refresh_page", Bootstrap.tags)