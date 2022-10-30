class Sabaoth_ProjectileExplosionSmall extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=0.200000
         MaxParticles=3
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=25.000000)
         StartSizeRange=(X=(Min=2.000000,Max=5.000000),Y=(Min=60.000000,Max=80.000000),Z=(Min=60.000000,Max=80.000000))
         InitialParticlesPerSecond=10.000000
         Texture=Texture'tK_DoomMonsterPackv3.BFG.Doom_BFG_Ball_Blast'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.800000)
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Sabaoth_ProjectileExplosionSmall.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         MaxParticles=3
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-20.000000,Max=20.000000)
         StartLocationPolarRange=(Y=(Min=-32768.000000,Max=32768.000000),Z=(Min=10.000000,Max=10.000000))
         UseRotationFrom=PTRS_Actor
         RotationOffset=(Yaw=-16384)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         InitialParticlesPerSecond=500.000000
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_Green_Flash_Strip'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRadialRange=(Min=200.000000,Max=200.000000)
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.300000,RelativeVelocity=(X=0.100000,Y=0.100000,Z=0.100000))
         VelocityScale(2)=(RelativeTime=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Sabaoth_ProjectileExplosionSmall.SpriteEmitter1'

}
