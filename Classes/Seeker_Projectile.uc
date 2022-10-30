class Seeker_Projectile extends Doom_Projectile placeable;

var() xEmitter xBeam;
var() bool bxBeamActivated;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
	Velocity = Vector(Rotation) * 15;
	SetTimer(2.00,false);
}

simulated function Timer()
{
	if(Level.NetMode == NM_Standalone)
	{
		Velocity *= 25;
	}
	else
	{
		Velocity *= 5;
	}

	SetTimer(0.5,false);
}

simulated function Tick(float DeltaTime)
{
	Super.Tick(deltatime);

	if(Seeking != None)
	{
		if(xBeam == None && !bxBeamActivated)
		{
			xBeam = Spawn(class'Seeker_EnergyBeam',self,,Location,);
			if(xBeam != None)
			{
				Seeker(Seeking).AttachToBone(xBeam,'Head');
				bxBeamActivated = true;
			}
		}
	}

	if(xBeam != None)
	{
		xBeam.mSpawnVecA = Location;
	}
}

simulated function Destroyed()
{
	Super.Destroyed();

    if (Trail != None)
    {
		Trail.Destroy();
    }

    if(xBeam != None)
    {
		xBeam.Destroy();
	}
}

defaultproperties
{
     TrailClass=Class'tK_DoomMonsterPackv3.Seeker_ProjectileTrail'
     ExplosionClass=Class'tK_DoomMonsterPackv3.Seeker_ProjectileExplosion'
     Speed=800.000000
     MaxSpeed=1200.000000
     Damage=15.000000
     DamageRadius=150.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Seeker_Projectile'
     ImpactSound=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_pimpact_02'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightSaturation=127
     LightBrightness=169.000000
     LightRadius=4.000000
     CullDistance=4000.000000
     bDynamicLight=True
     AmbientSound=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_fireball_travel_loop'
     LifeSpan=6.000000
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=15.000000
     CollisionHeight=15.000000
}
