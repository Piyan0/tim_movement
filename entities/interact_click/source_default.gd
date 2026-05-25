extends InteractPageSource

func _hover_text():
    if GlobalState.is_holding_item:
        return "Give"
    else:
        return "talk"


func _interact():
    var x = InteractActions.new()
    var text = []
    text.append("Lilian/lilian/ It's a good day right...")
    text.append("Shane/ shane / See you later")
    await x.text(text)


func _item_dropped(item_id):
    var x = InteractActions.new()
    var text = []
    text.append("Lilian/lilian/ I don't need that...")
    await x.text(text)
   
