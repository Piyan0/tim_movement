extends Node


var click_move: ClickMoveDestination
func _enter_tree():
    _add_hud()
    click_move = _create_click_move()
    

func _create_click_move():
    var c_move = ClickMoveDestination.new()
    return c_move


func _add_hud():
    var hud = load("uid://dfb46lbo028lg").instantiate()
    GlobalCanvas.add_child(hud)
