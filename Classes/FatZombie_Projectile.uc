class FatZombie_Projectile extends Doom_Projectile;

var() Material BarrelSkins[5];

event TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
	Health -= Damage;
	if(Health <= 0)
	{
		 Spawn(class'FatZombie_ProjectileExplosion');
		 HurtRadius(Damage, DamageRadius*0.125, MyDamageType, MomentumTransfer, Location);
		 SetCollision(false,false,false);
		 Destroy();
	}
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
	Skins[0] = BarrelSkins[Rand(5)];
	RandSpin(25000);
}

defaultproperties
{
     BarrelSkins(0)=Texture'tK_DoomMonsterPackv3.FatZombie.FatZombie_Barrel_Red'
     BarrelSkins(1)=Texture'tK_DoomMonsterPackv3.FatZombie.FatZombie_Barrel_Blue'
     BarrelSkins(2)=Texture'tK_DoomMonsterPackv3.FatZombie.FatZombie_Barrel_Yellow'
     BarrelSkins(3)=Texture'tK_DoomMonsterPackv3.FatZombie.FatZombie_Barrel_White'
     BarrelSkins(4)=Texture'tK_DoomMonsterPackv3.FatZombie.FatZombie_Barrel_Slime'
     Health=35
     TrailClass=Class'tK_DoomMonsterPackv3.FatZombie_BarrelTrail'
     ExplosionClass=Class'XEffects.NewExplosionA'
     Speed=800.000000
     MaxSpeed=1000.000000
     TossZ=250.000000
     Damage=35.000000
     DamageRadius=250.000000
     MomentumTransfer=40000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_FatZombie_Barrel'
     ImpactSound=Sound'WeaponSounds.BaseImpactAndExplosions.BExplosion2'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'tK_DoomMonsterPackv3.SM.FatZombie_BarrelMesh'
     bNetTemporary=False
     Rotation=(Yaw=32768)
     PrePivot=(Z=25.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.FatZombie.FatZombie_Barrel_White'
     CollisionRadius=20.000000
     CollisionHeight=25.000000
     bProjTarget=True
     bFixedRotationDir=True
     DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
}
