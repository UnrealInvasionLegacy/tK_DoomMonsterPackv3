class LostSoul_TrailEffect extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter29
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=500.000000)
         ColorMultiplierRange=(Y=(Min=0.840000,Max=0.840000),Z=(Min=0.820000,Max=0.820000))
         FadeOutStartTime=0.450000
         FadeInEndTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=16
         StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=20.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=1.500000,Max=1.500000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Fire_Small2'
         LifetimeRange=(Min=0.250000,Max=0.250000)
         StartVelocityRange=(X=(Min=-10.000000,Max=-10.000000),Z=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.LostSoul_TrailEffect.SpriteEmitter29'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter30
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=500.000000)
         ColorMultiplierRange=(X=(Min=0.920000,Max=0.920000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         Opacity=0.600000
         FadeOutStartTime=0.800000
         FadeInEndTime=0.200000
         CoordinateSystem=PTCS_Relative
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=11.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=9.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_BoomBoom3'
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.LostSoul_TrailEffect.SpriteEmitter30'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         CoordinateSystem=PTCS_Relative
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=15.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Glow_Small'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=-90.000000),Z=(Min=20.000000,Max=90.000000))
     End Object
     Emitters(2)=SpriteEmitter'tK_DoomMonsterPackv3.LostSoul_TrailEffect.SpriteEmitter31'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter32
         UniformSize=True
         ColorMultiplierRange=(X=(Min=0.110000,Max=0.110000),Y=(Min=0.020000,Max=0.020000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-3.000000,Max=3.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_FBeam'
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(3)=SpriteEmitter'tK_DoomMonsterPackv3.LostSoul_TrailEffect.SpriteEmitter32'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=30.000000,Max=30.000000)
         DetermineEndPointBy=PTEP_Distance
         FadeOut=True
         FadeIn=True
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.900000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.400000
         FadeInEndTime=0.400000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-3.000000,Max=3.000000)
         StartSizeRange=(X=(Min=0.500000,Max=0.500000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Small_Tracer'
         LifetimeRange=(Min=0.250000,Max=0.250000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
     End Object
     Emitters(4)=BeamEmitter'tK_DoomMonsterPackv3.LostSoul_TrailEffect.BeamEmitter1'

}
