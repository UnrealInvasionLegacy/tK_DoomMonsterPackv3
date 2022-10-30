class Guardian_ProjectileMouthTrail extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(RelativeTime=0.800000,Color=(B=64,G=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=40.000000,Max=50.000000),Y=(Min=10.000000,Max=10.000000))
         UseSkeletalLocationAs=PTSU_Location
         SkeletalScale=(X=0.400000,Y=0.400000,Z=0.370000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Flare1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Guardian_ProjectileMouthTrail.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         SpinParticles=True
         UniformSize=True
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         SpinsPerSecondRange=(X=(Min=5.000000,Max=5.000000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=10.000000,Max=10.000000))
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_Flash_Strip3'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Guardian_ProjectileMouthTrail.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=128,G=128,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=128))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=80
         SpinsPerSecondRange=(X=(Min=5.000000,Max=5.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=25.000000,Max=30.000000))
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_Flash_Strip3'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(2)=SpriteEmitter'tK_DoomMonsterPackv3.Guardian_ProjectileMouthTrail.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=67,G=173,R=252))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=128))
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.CyberMouthFlare'
         LifetimeRange=(Min=0.500000,Max=0.200000)
     End Object
     Emitters(3)=SpriteEmitter'tK_DoomMonsterPackv3.Guardian_ProjectileMouthTrail.SpriteEmitter4'

}
