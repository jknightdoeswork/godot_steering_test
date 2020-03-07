extends Node
class_name Identity

enum IdentityType {
	Ship,
	
}

export(IdentityType) var type
export(int) var faction

func compare_identities(t:int, f:int):
	if type == t:
		if faction == f or f == -1 or faction == -1:
			return true
	return false
