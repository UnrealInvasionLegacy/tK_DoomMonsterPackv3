class HunterInvul_Projectile extends Doom_Projectile;

var() Emitter SmokeTrail;
var() class<Emitter> SmokeTrailClass;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

	if ( Level.NetMode != NM_DedicatedServer && SmokeTrailClass != None)
	{
		SmokeTrail = Spawn(SmokeTrailClass,self);
		SmokeTrail.SetBase(Self);
	}

	Velocity.Z += 250;
}

simulated function Destroyed()
{
    if (SmokeTrail != None)
    {
		SmokeTrail.Kill();
    }

    Super.Destroyed();
}

defaultproperties
{
     SmokeTrailClass=Class'tK_DoomMonsterPackv3.HunterInvul_ProjectileSmokeTrail'
     TrailClass=Class'tK_DoomMonsterPackv3.HunterInvul_ProjectileTrail'
     ExplosionClass=Class'tK_DoomMonsterPackv3.HunterInvul_ProjectileExplosion'
     bSeeking=True
     Speed=900.000000
     MaxSpeed=1150.000000
     Damage=8.000000
     DamageRadius=75.000000
     MomentumTransfer=3000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_HunterInvul_Projectile'
     ImpactSound=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_helltime_exp_03'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=141
     LightSaturation=127
     LightBrightness=255.000000
     LightRadius=4.000000
     DrawType=DT_Sprite
     CullDistance=4000.000000
     bDynamicLight=True
     bNetTemporary=False
     AmbientSound=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_helltime_flight1'
     LifeSpan=10.000000
     Texture=Shader'tK_DoomMonsterPackv3.Effects.Doom_HunterInvul_Proj_Tex'
     DrawScale=0.300000
     SoundVolume=50
     SoundRadius=150.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
}
