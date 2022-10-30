class HellKnight_Projectile extends Doom_Projectile;

var() Emitter SmokeTrail;
var() class<Emitter> SmokeTrailClass;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
    {
        SmokeTrail = Spawn(class'HellKnight_ProjectileSmokeTrail',self);
        SmokeTrail.SetBase(Self);
    }
}

simulated function Destroyed()
{
    if(SmokeTrail != None)
    {
		SmokeTrail.Kill();
	}

    Super.Destroyed();
}

defaultproperties
{
     SmokeTrailClass=Class'tK_DoomMonsterPackv3.HellKnight_ProjectileSmokeTrail'
     TrailClass=Class'tK_DoomMonsterPackv3.HellKnight_ProjectileTrail'
     ExplosionClass=Class'tK_DoomMonsterPackv3.HellKnight_ProjectileExplosion'
     Speed=1000.000000
     MaxSpeed=1150.000000
     Damage=20.000000
     DamageRadius=150.000000
     MomentumTransfer=3000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_HellKnight_Projectile'
     ImpactSound=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_ns1_v3'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=106
     LightSaturation=104
     LightBrightness=169.000000
     LightRadius=4.000000
     DrawType=DT_Sprite
     CullDistance=4000.000000
     bDynamicLight=True
     AmbientSound=Sound'tK_DoomMonsterPackv3.Imp.imp_fireball_flight_04'
     LifeSpan=10.000000
     Texture=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     DrawScale=0.200000
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
}
