class Bruiser_Projectile extends Doom_Projectile;

defaultproperties
{
     TrailClass=Class'tK_DoomMonsterPackv3.Bruiser_ProjectileTrail'
     ExplosionClass=Class'tK_DoomMonsterPackv3.Bruiser_ProjectileExplosion'
     Speed=900.000000
     MaxSpeed=1150.000000
     Damage=20.000000
     DamageRadius=150.000000
     MomentumTransfer=3000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Bruiser_Projectile'
     ImpactSound=Sound'tK_DoomMonsterPackv3.Imp.imp_exp_03'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightSaturation=127
     LightBrightness=255.000000
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
