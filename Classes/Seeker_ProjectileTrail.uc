class Seeker_ProjectileTrail extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Opacity=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.800000,RelativeSize=10.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=15.000000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000))
         Texture=Texture'tK_DoomMonsterPackv3.BFG.Doom_BFG_Ball_Blast'
         LifetimeRange=(Min=2.000000,Max=2.500000)
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Seeker_ProjectileTrail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=73,G=16,R=53))
         ColorScale(2)=(RelativeTime=0.400000,Color=(B=255,G=255,R=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         Opacity=0.700000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.900000,RelativeSize=40.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=50.000000)
         StartSizeRange=(X=(Min=2.500000,Max=2.500000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Flare1'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=2.000000,Max=2.500000)
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Seeker_ProjectileTrail.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Opacity=0.700000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=20.000000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000))
         InitialParticlesPerSecond=1.000000
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Mystic'
     End Object
     Emitters(2)=SpriteEmitter'tK_DoomMonsterPackv3.Seeker_ProjectileTrail.SpriteEmitter2'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=5
         DistanceThreshold=500.000000
         UseCrossedSheets=True
         PointLifeTime=0.250000
         UseColorScale=True
         FadeOut=True
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=123,G=28,R=62))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=255,R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=5
         StartSizeRange=(X=(Min=25.000000,Max=30.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Beams.Doom_Lightning2'
         LifetimeRange=(Min=0.300000,Max=0.500000)
     End Object
     Emitters(3)=TrailEmitter'tK_DoomMonsterPackv3.Seeker_ProjectileTrail.TrailEmitter0'

}
