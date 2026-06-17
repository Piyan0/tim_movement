class_name ItemsDatabase
extends Database

func _title():
    return "items database"


func _get_items():
    var db = {}

    var lv1_item = {
        axe = {
            path = "res://assets/items/FD_Item_Axe_BIG_01.png",
        },
        book_of_spell = {
            path = "res://assets/items/FD_Item_BookOfSpells_BIG_01.png"
        },
        bottle_of_mead = {
            path = "res://assets/items/FD_Item_BottleOfMead_BIG_01.png"
        },
        golden_chalice = {
            path = "res://assets/items/FD_Item_GoldenChalice_BIG_01.png"
        },
        golden_ring = {
            path = "res://assets/items/FD_Item_GoldenRing_BIG_01.png"
        },
        human_skull = {
            path = "res://assets/items/FD_Item_HumanSkull_BIG_01.png"
        },
        medicine_potion = {
            path = "res://assets/items/FD_Item_MedicinalPotion_BIG_01.png"
        },
        royal_crystal = {
            path = "res://assets/items/FD_Item_RoyalCrystal_BIG_01.png"
        },
        sword = {
            path = "res://assets/items/FD_Item_Sword_BIG_01.png"
        },
        travel_bag = {
            path = "res://assets/items/FD_Item_Sword_BIG_01.png"
        }
    }

    db.merge(lv1_item)
    return db