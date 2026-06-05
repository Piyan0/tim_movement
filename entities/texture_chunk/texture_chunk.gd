extends Node


@export var notif: VisibleOnScreenNotifier2D

var texture: Texture
func _enter_tree() -> void:
    return
    texture = get_parent().texture 
    get_parent().texture = null

    notif.screen_entered.connect(func():
        var text = texture
        get_parent().texture = text    
        print(get_parent(), get_parent().texture, text)
    )

    notif.screen_exited.connect(func():
        print(2)
        get_parent().texture = null    
    )
