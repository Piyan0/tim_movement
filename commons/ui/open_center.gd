@tool
class_name OpenCenter
extends Control

@export var anim_dur = 0.2
@export var play: bool:
    set(value):
        if not is_inside_tree():
            return
        play = value
        if play:
            _open()
        else:
            _close()
        

func _open():
    var parent_size_y = get_parent().size.y
    
    var t = create_tween().set_parallel().set_trans(Tween.TRANS_BACK)
    t.tween_property(self, "position:y", 0, anim_dur)
    t.tween_property(self, "size:y", parent_size_y, anim_dur)
    await t.finished
    

func _close():
    var parent_size_y = get_parent().size.y
    var t = create_tween().set_parallel().set_trans(Tween.TRANS_BACK)
    t.tween_property(self, "position:y", parent_size_y/2, anim_dur)
    t.tween_property(self, "size:y", 1, anim_dur)
    await t.finished
