class_name LevelScreen
extends Node2D

@export_file_path var map_path: String
@export var player_position: Vector2


func _ready() -> void:
    await get_tree().process_frame
    var map = load(map_path).instantiate()
    var player = load("res://entities/player/player.tscn")
    player = player.instantiate() as Player
    player.position = player_position
    map.add_child.call_deferred(player)
    Bootstrap.get_tree().change_scene_to_node(map)
    await Bootstrap.fade.fade_out()

    

class PlayerTransferData:
    var position: Vector2
    var map_path: String

    func _init(map_path, position):
        self.map_path = map_path
        self.position = position
