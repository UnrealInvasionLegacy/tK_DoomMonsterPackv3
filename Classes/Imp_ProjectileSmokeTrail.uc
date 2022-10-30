class Imp_ProjectileSmokeTrail extends Doom_Emitter;

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
         ColorMultiplierRange=(X=(Min=0.220000,Max=0.220000),Y=(Min=0.120000,Max=0.120000),Z=(Min=0.080000,Max=0.080000))
         Opacity=0.080000
         FadeOutStartTime=0.800000
         FadeInEndTime=0.250000
         MaxParticles=30
         StartSpinRange=(X=(Min=6.000000,Max=12.000000))
         SizeScale(0)=(RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=23.000000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_BarrelPoof'
         LifetimeRange=(Min=0.900000,Max=0.900000)
         StartVelocityRange=(X=(Min=-13.000000,Max=-21.000000))
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Imp_ProjectileSmokeTrail.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=8.000000)
         ColorMultiplierRange=(X=(Min=0.173000,Max=0.173000),Y=(Min=0.020000,Max=0.020000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.050000
         MaxParticles=12
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=20.000000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Rocket_Back_Lit'
         LifetimeRange=(Min=0.900000,Max=0.900000)
         StartVelocityRange=(X=(Min=-13.000000,Max=-21.000000))
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Imp_ProjectileSmokeTrail.SpriteEmitter5'

}
