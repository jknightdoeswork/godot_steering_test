extends Node
class_name Identity

enum IdentityType {
	Ship,	
}

export(IdentityType) var type
export(int) var faction
export(Color) var color

var identifier := 0

func compare_identities(i:Identity)->bool:
	if type == i.type:
		if faction == i.faction or faction == -1 or i.faction == -1:
			return true
	return false

func is_enemy(i:Identity)->bool:
	return i.faction != faction and !is_neutral(i)

func is_friend(i:Identity)->bool:
	return i.faction == faction and !is_neutral(i)

func is_neutral(i:Identity)->bool:
	return i.faction == -1 or faction == -1
	
