class Seeker_ProjectileExplosion extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=85,G=28,R=57))
         ColorScale(2)=(RelativeTime=0.600000,Color=(B=255,G=255,R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.700000
         MaxParticles=5
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=10.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=35.000000,Max=45.000000),Y=(Min=60.000000,Max=80.000000),Z=(Min=60.000000,Max=80.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_White_Flash_Strip3'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.800000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Seeker_ProjectileExplosion.SpriteEmitter0'

}
