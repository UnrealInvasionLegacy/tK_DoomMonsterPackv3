class Cacodemon_MouthFlare extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=128,G=191,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=255,R=255))
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         SpinsPerSecondRange=(X=(Min=-5.000000,Max=5.000000))
         SizeScale(0)=(RelativeSize=-0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=2.000000,Max=6.000000))
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_White_Flash_Strip3'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.200000)
         VelocityScale(0)=(RelativeVelocity=(Y=1.000000))
         VelocityScale(1)=(RelativeTime=0.800000,RelativeVelocity=(Y=1.000000))
         VelocityScale(2)=(RelativeTime=1.000000,RelativeVelocity=(Y=-10.000000))
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Cacodemon_MouthFlare.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=136,G=174,R=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         SpinsPerSecondRange=(X=(Min=2.000000,Max=2.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Cyber_Mouth_Flare'
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Cacodemon_MouthFlare.SpriteEmitter6'

     Begin Object Class=BeamEmitter Name=BeamEmitter2
         BeamDistanceRange=(Min=100.000000,Max=200.000000)
         RotatingSheets=2
         HighFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         UseColorScale=True
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         StartSizeRange=(X=(Min=1.000000,Max=1.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Beams.Doom_Lightning_Bolt4'
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-40.000000,Max=50.000000),Y=(Min=-40.000000,Max=50.000000),Z=(Min=-40.000000,Max=50.000000))
     End Object
     Emitters(2)=BeamEmitter'tK_DoomMonsterPackv3.Cacodemon_MouthFlare.BeamEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=125,G=190,R=255))
         CoordinateSystem=PTCS_Relative
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=2.000000,Max=6.000000))
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_White_Flash_Strip'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(3)=SpriteEmitter'tK_DoomMonsterPackv3.Cacodemon_MouthFlare.SpriteEmitter7'

}
