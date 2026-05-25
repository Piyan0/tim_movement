class_name InteractPageSource


func _hover_text():
    return "<hover text>"
    

func _interact():
    print("default interact.")


func _item_dropped(item_id):
    print("given with id ", item_id, ".")