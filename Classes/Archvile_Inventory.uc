class Archvile_Inventory extends Inventory;

var() Pawn PawnMaster;

Replication
{
	reliable if(Role == Role_Authority)
		PawnMaster;
}

defaultproperties
{
     ItemName="ArchvileInv"
     bOnlyRelevantToOwner=False
     bAlwaysRelevant=True
}
