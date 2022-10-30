class Vulgar_ProjectileTrail extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         DisableFogging=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=175,G=244,R=138,A=255))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=131,G=164,R=62))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=125,G=136,R=47))
         ColorScale(3)=(RelativeTime=1.000000)
         ColorMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         FadeOutStartTime=0.800000
         CoordinateSystem=PTCS_Relative
         StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
         StartSizeRange=(X=(Min=60.000000,Max=80.000000),Y=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Plasma_Burn_FX'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.500000)
         WarmupTicksPerSecond=2.000000
         RelativeWarmupTime=1.000000
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Vulgar_ProjectileTrail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         DisableFogging=True
         UniformSize=True
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=181,G=244,R=11))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=20.000000,Max=20.000000))
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_White_Flash_Strip3'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.500000,Max=1.000000)
         WarmupTicksPerSecond=2.000000
         RelativeWarmupTime=1.000000
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Vulgar_ProjectileTrail.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=182,G=254,R=84))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=183,G=250,R=5))
         Opacity=0.500000
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=3
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=40.000000))
         Texture=Texture'EmitterTextures.MultiFrame.smokelight_a'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.600000,Max=0.800000)
         WarmupTicksPerSecond=2.000000
         RelativeWarmupTime=1.000000
     End Object
     Emitters(2)=SpriteEmitter'tK_DoomMonsterPackv3.Vulgar_ProjectileTrail.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.600000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=4.000000,Max=6.000000))
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_White_Flash_Strip3'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.600000,Max=0.300000)
         WarmupTicksPerSecond=2.000000
         RelativeWarmupTime=1.000000
     End Object
     Emitters(3)=SpriteEmitter'tK_DoomMonsterPackv3.Vulgar_ProjectileTrail.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         UniformSize=True
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=20.000000,Max=20.000000))
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_White_Flash_Strip3'
         TextureUSubdivisions=32
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.500000,Max=1.000000)
         WarmupTicksPerSecond=2.000000
         RelativeWarmupTime=1.000000
     End Object
     Emitters(4)=SpriteEmitter'tK_DoomMonsterPackv3.Vulgar_ProjectileTrail.SpriteEmitter4'

}
