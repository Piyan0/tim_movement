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