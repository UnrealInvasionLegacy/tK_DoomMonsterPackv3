class Maledict_Projectile extends Doom_Projectile;

var() Sound SpawnSounds[2];
var() StaticMesh SmallMeteorMesh[3];

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetStaticMesh(SmallMeteorMesh[Rand(3)]);
	RandSpin(25000);
	PlaySound(SpawnSounds[Rand(2)],SLOT_Interact,,,,,);
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,Vector momentum, class<DamageType> damageType)
{
	Health -= Damage;
    if(Health <= 0)
    {
		Explode(HitLocation,Vect(0,0,1));
	}
}

defaultproperties
{
     SpawnSounds(0)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_fire_05'
     SpawnSounds(1)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_fire_02'
     SmallMeteorMesh(0)=StaticMesh'tK_DoomMonsterPackv3.SM.MaledictMeteorMesh01'
     SmallMeteorMesh(1)=StaticMesh'tK_DoomMonsterPackv3.SM.MaledictMeteorMesh02'
     SmallMeteorMesh(2)=StaticMesh'tK_DoomMonsterPackv3.SM.MaledictMeteorMesh03'
     Health=8
     TrailClass=Class'tK_DoomMonsterPackv3.Maledict_ProjectileTrail'
     ExplosionClass=Class'tK_DoomMonsterPackv3.Maledict_ProjectileExplosion'
     Speed=850.000000
     MaxSpeed=1150.000000
     Damage=12.000000
     DamageRadius=50.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Maledict_Projectile'
     ImpactSound=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_asteroid_01'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightSaturation=127
     LightBrightness=255.000000
     LightRadius=5.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'tK_DoomMonsterPackv3.SM.MaledictMeteorMesh01'
     CullDistance=4000.000000
     bDynamicLight=True
     bNetTemporary=False
     AmbientSound=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_helltime_flight1'
     LifeSpan=8.000000
     DrawScale=0.400000
     Skins(0)=Texture'tK_DoomMonsterPackv3.Maledict.Maledict_Hellbones_Skin'
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=13.000000
     CollisionHeight=10.000000
}
