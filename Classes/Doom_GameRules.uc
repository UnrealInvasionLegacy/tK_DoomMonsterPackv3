class Doom_GameRules extends GameRules;

function int NetDamage( int OriginalDamage, int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	local Inventory Inv;

	if(injured != None)
	{
		for( Inv=injured.Inventory; Inv!=None; Inv=Inv.Inventory )
		{
			if (Inv.IsA('Seeker_Inventory'))
			{
				Damage = 0;
				break;
			}
		}
	}

    if ( NextGameRules != None )
    {
        return NextGameRules.NetDamage( OriginalDamage,Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
	}

    return Damage;
}

defaultproperties
{
}
