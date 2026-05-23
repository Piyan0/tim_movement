extends Node2D

@export var mr_target_pos: Node2D
@export var mr_click_pos: Node2D
@export var player: Node2D
@export var click_destination_pos: ClickMoveDestination
func _ready():
    await get_tree().create_timer(.2).timeout
    var x = click_destination_pos.get_routes(player.position, mr_click_pos.position)
    x.pop_front()
    for i in x:
        player.position = i
        print(1)
        await get_tree().create_timer(0.2).timeout
