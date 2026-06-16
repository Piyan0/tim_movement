class_name InteractActions


func text(arr = ["Shane shane.png owh is that right"]):
    var batches: Array[HUDDialogue.DialogueWithPortrait]

    for el in arr:
        var split = Array(el.split(" "))
        var name = split[0]
        var portrait_id = split[1]
        var content = split.slice(2)
        content = " ".join(content)
        # printt(name, portrait_id, content)
        var batch_el = HUDDialogue.DialogueWithPortrait.new(
            name,
            content,
            Bootstrap.portraits.get_asset(portrait_id)
        ) 
        batches.append(batch_el)
    
    await Bootstrap.hud.dialogue.start_dialogue(batches)


func goto(map_path, player_pos):
    await Bootstrap.fade.fade_in()
    var ins = load("res://levels/level_screen.tscn").instantiate()
    ins.map_path = map_path
    ins.player_position = player_pos
    await Bootstrap.get_tree().process_frame
    await Bootstrap.get_tree().process_frame
    Bootstrap.get_tree().change_scene_to_node(ins)


func load_data(data: Dictionary):
    Bootstrap.state = GlobalState.new()
    await goto("res://levels/main/main.tscn", str_to_var(data.player_pos))
    

# TODO add mutiple tags
func add_tag(tag):
    if tag in Bootstrap.tags:
        return
    Bootstrap.tags.append(tag)
    Bootstrap.get_tree().call_group("interact_click", "refresh_page", Bootstrap.tags)



func remove_tag(tag):
    Bootstrap.tags.erase(tag)
    Bootstrap.get_tree().call_group("interact_click", "refresh_page", Bootstrap.tags)

