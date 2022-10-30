class Vagary_Projectile extends Doom_Projectile;

var() Material NewSkins[3];

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

	Skins[1] = NewSkins[Rand(3)];
 	RandSpin(25000);
}

defaultproperties
{
     NewSkins(0)=Texture'tK_DoomMonsterPackv3.Vagary.Vagary_SpikeTex4'
     NewSkins(1)=Texture'tK_DoomMonsterPackv3.Vagary.Vagary_SpikeTex3'
     NewSkins(2)=Texture'tK_DoomMonsterPackv3.Vagary.Vagary_SpikeTex2'
     ExplosionClass=Class'tK_DoomMonsterPackv3.Vagary_ProjectileExplosion'
     Speed=900.000000
     MaxSpeed=1150.000000
     Damage=10.000000
     DamageRadius=150.000000
     MomentumTransfer=3000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Vagary_Projectile'
     ImpactSound=Sound'tK_DoomMonsterPackv3.Imp.imp_exp_05'
     LightEffect=LE_QuadraticNonIncidence
     LightHue=8
     LightSaturation=90
     LightBrightness=255.000000
     LightRadius=4.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'tK_DoomMonsterPackv3.SM.VagarySpike'
     CullDistance=4000.000000
     bDynamicLight=True
     LifeSpan=10.000000
     Skins(0)=Texture'tK_DoomMonsterPackv3.Vagary.Vagary_SpikeTex1'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Vagary.Vagary_SpikeTex2'
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bFixedRotationDir=True
     DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
}
