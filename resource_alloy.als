sig flexibleUnits {
	consumes: set resources
}

fact one2one {
	consumes.~consumes in iden
	//Comment this out to allow for floating
		 //unused resources
	//univ.consumes = resources
}

sig resources{//The modeled resource
}

sig staffStrength {
	empowered: set flexibleUnits
}

sig staffCost {
	requires: set resources
}

sig mbase{
	strength: one staffStrength, 
	cost: one staffCost
}

fact connected {
	all m: mbase, s: staffStrength | s in m.strength
	all s: staffStrength, f: flexibleUnits | 
		f in s.empowered
	all m: mbase, sc: staffCost | sc in m.cost
	all sc: staffCost, r: resources | r in sc.requires
}

fact nosharedconsume {
	all disj f1, f2: flexibleUnits | 
		f1.consumes != f2.consumes
}

pred currentMarket {
	//consumes multiple resources
	all f: flexibleUnits | #f.consumes =< 3 
		&& #f.consumes >= 1 
	//all f: flexibleUnits | #f.consumes = 1
}


pred show(b: mbase) {
	currentMarket
	#flexibleUnits = 5
	//#resources < 10
}

run show for 9 but 1 mbase, exactly 10 resources
//run show for 9 but 1 mbase
