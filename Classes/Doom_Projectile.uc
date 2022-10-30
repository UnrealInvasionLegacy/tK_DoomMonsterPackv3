class Doom_Projectile extends Projectile placeable;

var() int Health;
var() Emitter Trail;
var() class<Emitter> TrailClass;
var() class<Emitter> ExplosionClass;
var() Actor Seeking;
var() vector InitialDir;
var() bool bSeeking;

replication
{
    reliable if( bNetInitial && (Role==ROLE_Authority) )
        Seeking, InitialDir;
}

simulated function PostBeginPlay()
{
	local Rotator R;

    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer && TrailClass != None )
    {
        Trail = Spawn(TrailClass, self);
        Trail.SetBase(self);
    }

    Velocity = Vector(Rotation) * Speed;
	R = Rotation;
	R.Roll = 32768;
	SetRotation(R);

	if(bSeeking)
	{
		SetTimer(0.1,true);
	}
}

simulated function Timer()
{
    local vector ForceDir;
    local float VelMag;

    if ( InitialDir == vect(0,0,0) )
    {
        InitialDir = Normal(Velocity);
	}

    Acceleration = vect(0,0,0);
    Super.Timer();
    if(Seeking != None)
    {
		ForceDir = Normal(Seeking.Location - Location);

        if( (ForceDir Dot InitialDir) > 0 )
        {
            VelMag = VSize(Velocity);

            if ( Seeking.Physics == PHYS_Karma )
                ForceDir = Normal(ForceDir * 0.8 * VelMag + Velocity);
            else
                ForceDir = Normal(ForceDir * 0.5 * VelMag + Velocity);
            Velocity =  VelMag * ForceDir;
            Acceleration += 5 * ForceDir;
        }
        SetRotation(rotator(Velocity));
    }
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
    if ( (Other != instigator) && (!Other.IsA('Projectile') || Other.bProjTarget) )
    {
        Explode(HitLocation, vect(0,0,1));
    }
}

simulated function Explode(vector HitLocation,vector HitNormal)
{
    if ( Role == ROLE_Authority )
    {
        HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
    }

    PlaySound(ImpactSound, SLOT_Misc);
    Spawn(ExplosionClass,,, Location);
    SetCollisionSize(0.0, 0.0);
    Destroy();
}

simulated function Destroyed()
{
    if (Trail != None)
    {
		Trail.Kill();
    }

    Super.Destroyed();
}

defaultproperties
{
}
