class Imp_ProjectileTrail extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=5.000000)
         ColorMultiplierRange=(X=(Min=0.970000,Max=0.970000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.180000,Max=0.180000))
         Opacity=0.500000
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=17.500000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Smokepuff'
         LifetimeRange=(Min=0.350000,Max=0.350000)
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Imp_ProjectileTrail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorMultiplierRange=(X=(Min=0.320000,Max=0.320000),Y=(Min=0.040000,Max=0.040000),Z=(Min=0.040000,Max=0.040000))
         Opacity=0.500000
         FadeOutStartTime=0.200000
         FadeInEndTime=1.000000
         CoordinateSystem=PTCS_Relative
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=20.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Billow_Glow'
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Imp_ProjectileTrail.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.090000,Max=0.090000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=27.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=22.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_FBeam'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(2)=SpriteEmitter'tK_DoomMonsterPackv3.Imp_ProjectileTrail.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UniformSize=True
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.090000,Max=0.090000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.400000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=60.000000,Max=60.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Vp1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(3)=SpriteEmitter'tK_DoomMonsterPackv3.Imp_ProjectileTrail.SpriteEmitter3'

}
