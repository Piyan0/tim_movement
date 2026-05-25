extends Node

enum GameState {
    FREE,
    DRAG_ITEM,
    MENU,
}

var current_state = GameState.FREE
var is_holding_item = false