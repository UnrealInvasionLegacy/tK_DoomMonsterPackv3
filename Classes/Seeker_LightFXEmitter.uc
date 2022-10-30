class Seeker_LightFXEmitter extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutoReset=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Opacity=0.400000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'XEffectMat.Link.grey_ring'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         VelocityScale(0)=(RelativeVelocity=(X=100.000000,Y=100.000000,Z=100.000000))
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Seeker_LightFXEmitter.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         UniformSize=True
         Opacity=0.600000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Seeker.Seeker_FlareLightTex'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Seeker_LightFXEmitter.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutoReset=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Opacity=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000))
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'tK_DoomMonsterPackv3.Seeker_LightFXEmitter.SpriteEmitter7'

}
