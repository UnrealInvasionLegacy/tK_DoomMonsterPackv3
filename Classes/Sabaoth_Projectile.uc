class Sabaoth_Projectile extends Doom_Projectile;

var() class<xEmitter> GreenArcs[2];
var() int ArcCounter;
var() Sound ArcSounds[2];

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
	SetTimer(1.0,true);
}

simulated function Timer()
{
	local xEmitter GArc;
	local Actor A;

	foreach VisibleCollidingActors(class'Actor', A, 500, location)
	{
		if(A != None && ArcCounter < 4 && A != Owner)
		{
			GArc = Spawn(GreenArcs[Rand(2)],self,,location);
			GArc.SetBase(self);
			GArc.mSpawnVecA = A.Location;
			ArcCounter++;
			PlaySound(ArcSounds[Rand(2)], SLOT_Misc);
			if(Role==Role_Authority)
			{
				A.TakeDamage(10,Instigator,Location,-1000 * vRand(),MyDamageType);
			}
		}
	}

	if(ArcCounter <= 4)
	{
		ArcCounter = 0;
	}
}

defaultproperties
{
     GreenArcs(0)=Class'tK_DoomMonsterPackv3.Sabaoth_ProjectileArc'
     GreenArcs(1)=Class'tK_DoomMonsterPackv3.Sabaoth_ProjectileArcFat'
     ArcSounds(0)=Sound'tK_DoomMonsterPackv3.BFG.arc_1'
     ArcSounds(1)=Sound'tK_DoomMonsterPackv3.BFG.arc_4'
     TrailClass=Class'tK_DoomMonsterPackv3.Sabaoth_ProjectileTrail'
     ExplosionClass=Class'tK_DoomMonsterPackv3.Sabaoth_ProjectileExplosion'
     Speed=1000.000000
     MaxSpeed=1150.000000
     Damage=20.000000
     DamageRadius=250.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Sabaoth_Projectile'
     ImpactSound=Sound'tK_DoomMonsterPackv3.BFG.bfg_explode1'
     ExplosionDecal=Class'tK_DoomMonsterPackv3.Sabaoth_ProjectileDecal'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=106
     LightSaturation=104
     LightBrightness=169.000000
     LightRadius=4.000000
     DrawType=DT_Sprite
     CullDistance=4000.000000
     bDynamicLight=True
     bNetTemporary=False
     AmbientSound=Sound'tK_DoomMonsterPackv3.BFG.bfg_fly'
     LifeSpan=10.000000
     Texture=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     DrawScale=0.200000
     SoundVolume=255
     SoundRadius=250.000000
     CollisionRadius=16.000000
     CollisionHeight=16.000000
}
