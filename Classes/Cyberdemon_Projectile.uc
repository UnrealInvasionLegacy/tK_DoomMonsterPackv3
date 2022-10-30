class Cyberdemon_Projectile extends Doom_Projectile;

var() class<Emitter> SmokeTrailClass;
var() Emitter SmokeTrail;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
    {
        SmokeTrail = Spawn(SmokeTrailClass,self);
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
     SmokeTrailClass=Class'tK_DoomMonsterPackv3.Revenant_ProjectileSmokeTrail'
     TrailClass=Class'tK_DoomMonsterPackv3.Cyberdemon_ProjectileTrail'
     ExplosionClass=Class'tK_DoomMonsterPackv3.Cyberdemon_ProjectileExplosion'
     bSeeking=True
     Speed=900.000000
     MaxSpeed=1150.000000
     Damage=20.000000
     DamageRadius=150.000000
     MomentumTransfer=3000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Cyberdemon_Projectile'
     ImpactSound=Sound'WeaponSounds.BaseImpactAndExplosions.BExplosion3'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightSaturation=127
     LightBrightness=255.000000
     LightRadius=4.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'tK_DoomMonsterPackv3.SM.CyberDemonRocketMesh'
     CullDistance=4000.000000
     bDynamicLight=True
     bNetTemporary=False
     AmbientSound=Sound'WeaponSounds.RocketLauncher.RocketLauncherProjectile'
     LifeSpan=10.000000
     Skins(0)=Texture'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_RocketTex'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_RocketFin'
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
}
