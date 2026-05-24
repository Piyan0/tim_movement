extends InteractPageSource

func _hover_text():
    return "talk"


func _interact():
    print("start")
    await Engine.get_main_loop().create_timer(1).timeout
    print("end")
