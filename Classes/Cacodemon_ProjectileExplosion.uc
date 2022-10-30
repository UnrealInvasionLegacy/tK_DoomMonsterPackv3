class Cacodemon_ProjectileExplosion extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=255,R=255))
         MaxParticles=3
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=10.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=60.000000,Max=80.000000),Z=(Min=60.000000,Max=80.000000))
         InitialParticlesPerSecond=10.000000
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_White_Flash_Strip3'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.800000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Cacodemon_ProjectileExplosion.SpriteEmitter4'

}
