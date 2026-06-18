class_name AudioDatabase
extends Database

func _title():
    return "audio database"

func _get_items():
    return {
        magic = {
            path = "assets/sounds/FD_Audio_Magic_01.ogg"
        },
        solved = {
            path = "res://assets/sounds/FD_Audio_Solved_01.ogg"
        },
        unsolved = {
            path = "res://assets/sounds/FD_Audio_Unsolved_01.ogg"
        },
        menu = {
            path = "res://assets/sounds/FD_Music_Menu_01.ogg"
        },
        world_bgm = {
            path = "res://assets/sounds/FD_Music_Soundtrack_01.ogg"
        }
    }
