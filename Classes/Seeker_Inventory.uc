class Seeker_Inventory extends Inventory;

var() xEmitter xBeam;
var() Pawn PawnMaster;
var() bool bDestroy;

Replication
{
	reliable if(Role == Role_Authority)
		PawnMaster, bDestroy;
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	if(Seeker(PawnMaster) != None && Pawn(Owner) != None)
	{
		Seeker(PawnMaster).AddLink(1);
		xBeam = Spawn(class'Seeker_EnergyBeam',self,,Location,);
		Seeker(PawnMaster).AttachToBone(xBeam,'Head');
		Enable('Tick');
	}

	Super.GiveTo(Other);
}

simulated function Tick(float deltaTime)
{
	local float SeekerDistance;

	if(Pawn(Owner) != None && Pawn(Owner).Health > 0 && PawnMaster != None && PawnMaster.Health > 0)
	{
		SeekerDistance = VSize(PawnMaster.Location - Owner.Location);

		if(SeekerDistance > Seeker(PawnMaster).SeekerLinkRange || !FastTrace(Owner.Location,PawnMaster.Location))
		{
			bDestroy = true;
		}

		if(xBeam != None)
		{
			xBeam.mSpawnVecA = Owner.Location;
		}
		else
		{
			bDestroy = true;
		}
	}
	else
	{
		bDestroy = true;
	}

	if(bDestroy)
	{
		Destroy();
		Disable('Tick');
	}

	Super.Tick(deltatime);
}

simulated function Destroyed()
{
	if(xBeam != None)
	{
		xBeam.Destroy();
	}

	if(Seeker(PawnMaster) != None)
	{
		Seeker(PawnMaster).RemoveLink(1);
	}

	Super.Destroyed();
}

defaultproperties
{
     ItemName="SeekerInv"
     bOnlyRelevantToOwner=False
     bAlwaysRelevant=True
     bReplicateInstigator=True
}
