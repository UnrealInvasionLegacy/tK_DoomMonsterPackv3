class Forgotten_Weak extends Forgotten;

simulated function Destroyed()
{
	if(Maledict(Owner) != None)
	{
		Maledict(Owner).MonsterCounter--;
	}

	Super.Destroyed();
}

defaultproperties
{
     MeleeDamage=10.000000
     NewHealth=30
     Health=30
     DrawScale=1.800000
     PrePivot=(Z=-15.000000)
     CollisionRadius=20.000000
     CollisionHeight=20.000000
}
