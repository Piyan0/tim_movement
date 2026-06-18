class_name ItemsDatabase
extends Database

func _title():
    return "items database"


func _get_items():
    var db = {}

    var lv1_item = {
        axe = {
            path = "res://assets/items/FD_Item_Axe_BIG_01.png",
            ui = "Axe",
        },
        book_of_spell = {
            path = "res://assets/items/FD_Item_BookOfSpells_BIG_01.png",
            ui = "Book Of Spell",
            
        },
        bottle_of_mead = {
            path = "res://assets/items/FD_Item_BottleOfMead_BIG_01.png",
            ui = "Bottle Of Mead",
        },
        golden_chalice = {
            path = "res://assets/items/FD_Item_GoldenChalice_BIG_01.png",
            ui = "Golden Chalice",
        },
        golden_ring = {
            path = "res://assets/items/FD_Item_GoldenRing_BIG_01.png",
            ui = "Golden Ring",
        },
        human_skull = {
            path = "res://assets/items/FD_Item_HumanSkull_BIG_01.png",
            ui = "Human Skull",
        },
        medicine_potion = {
            path = "res://assets/items/FD_Item_MedicinalPotion_BIG_01.png",
            ui = "Medicinal Potion",
        },
        royal_crystal = {
            path = "res://assets/items/FD_Item_RoyalCrystal_BIG_01.png",
            ui = "Royal Crystal",
        },
        sword = {
            path = "res://assets/items/FD_Item_Sword_BIG_01.png",
            ui = "Sword",
        },
        travel_bag = {
            path = "res://assets/items/FD_Item_TravelBag_BIG_01.png",
            ui = "Travle Bag",
        }
    }

    db.merge(lv1_item)
    return db
