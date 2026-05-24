extends InteractPageSource

func _hover_text():
    return "talk"


func _interact():
    var x = InteractActions.new()
    var text = []
    text.append("Lilian/ It's a good day right...")
    text.append("Lilian/ See you later")
    await x.text(text)
