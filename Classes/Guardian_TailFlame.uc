class Guardian_TailFlame extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=8.000000)
         ColorMultiplierRange=(X=(Min=0.070000,Max=0.070000),Y=(Min=0.070000,Max=0.070000),Z=(Min=0.090000,Max=0.090000))
         Opacity=0.200000
         FadeOutStartTime=0.900000
         FadeInEndTime=0.100000
         MaxParticles=7
         StartSpinRange=(X=(Max=50.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.330000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_BarrelPoof'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Guardian_TailFlame.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=10.000000)
         ColorMultiplierRange=(X=(Min=0.540000,Max=0.540000),Y=(Min=0.070000,Max=0.070000),Z=(Min=0.040000,Max=0.040000))
         FadeOutStartTime=0.500000
         MaxParticles=7
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-10.000000,Max=10.000000)
         StartSpinRange=(X=(Max=-50.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.300000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Rocket_Back_Lit'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=50.000000,Max=50.000000))
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Guardian_TailFlame.SpriteEmitter5'

}
