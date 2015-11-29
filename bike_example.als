open util/integer 

sig flexible {}
sig Chainrings { allowFor: flexible }
sig Cassette { drive: set Chainrings }
sig Crank { drive: lone Chainrings }
pred initComparison { #(Chainrings) >= 5 }
fact enforceComparison { initComparison }
fact one2one {
	cassette.~cassette in iden
	univ.cassette = Cassette
	crank.~crank in iden
	univ.crank = Crank
	allowFor.~allowFor in iden
	univ.allowFor = flexible
}
fact noOverlapRings {
	all disj a,b : Chainrings | a !=b
	all c: Crank, cs: Cassette, cr: Chainrings 
		| cr not in (c.drive & cs.drive)
}
sig Drivetrain {
	cassette: one Cassette,
	crank: one Crank
}
sig bike {
	drivetrain: one Drivetrain
}
pred fullyAssembleBike {
	all b: bike, d: Drivetrain | d in b.drivetrain
	all cs: Cassette, c: Chainrings, cr: Crank 
		| c in cs.drive || c in cr.drive
}
run fullyAssembleBike for 9 but exactly 1 bike, 1 Drivetrain
