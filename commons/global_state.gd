class_name GlobalState
extends Node

enum GameState {
    FREE,
    DRAG_ITEM,
    MENU,
}

var current_state = GameState.FREE
var is_holding_item = false
var is_interact = false
var is_showing_overlay = false
var is_hovering_button = false
var current_item = "":
    get():
        var value = current_item
        current_item = ""
        return value
        
var item_being_dragged = null
