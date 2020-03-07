extends Node
class_name Identity

enum IdentityType {
	Ship,
	
}

export(IdentityType) var type
export(int) var faction

func compare_identities(i:Identity):
	if type == i.type:
		if faction == i.faction or faction == -1 or i.faction == -1:
			return true
	return false

func is_enemy(i:Identity):
	return i.faction != faction
