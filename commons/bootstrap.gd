extends Node


func _enter_tree():
    _add_hud()
    

func _add_hud():
    var hud = load("uid://dfb46lbo028lg").instantiate()
    GlobalCanvas.add_child(hud)
