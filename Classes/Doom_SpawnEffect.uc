class Doom_SpawnEffect extends Doom_Emitter;

var() Sound SpawnSound[2];

simulated function PostBeginPlay()
{
	local Vector HitLocation, HitNormal;
	local Actor A;

	PlaySound(SpawnSound[Rand(2)],SLOT_Interact);
	A = Trace(HitLocation, HitNormal, Location + Vect(0,0,-500),Location,false);
	if(A != None)
	{
		Spawn(class'Doom_Projector', self,, HitLocation + Vect(0,0,10), );
	}

	Super.PostBeginPlay();
}

defaultproperties
{
     SpawnSound(0)=Sound'tK_DoomMonsterPackv3.Misc.Misc_tele2_full3_1s'
     SpawnSound(1)=Sound'tK_DoomMonsterPackv3.Misc.Misc_spiritsting'
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(0)=(Color=(B=5,G=134,R=250))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=255))
         FadeOutStartTime=0.120000
         FadeInEndTime=0.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         StartLocationRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=40.000000))
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=25.000000,Max=50.000000),Z=(Min=25.000000,Max=50.000000))
         ScaleSizeByVelocityMax=5000.000000
         InitialParticlesPerSecond=60.000000
         Texture=Texture'VMParticleTextures.buildEffects.PC_buildStreaks'
         LifetimeRange=(Min=1.000000,Max=1.500000)
         InitialDelayRange=(Min=0.700000,Max=0.700000)
         StartVelocityRange=(Z=(Min=1.000000,Max=5.000000))
         VelocityScale(1)=(RelativeTime=1.000000,RelativeVelocity=(X=10.000000,Y=10.000000,Z=500.000000))
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Normal
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=113,R=152))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=3
         StartLocationOffset=(Z=-20.000000)
         StartLocationShape=PTLS_All
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'tK_DoomMonsterPackv3.Symbols.Doom_Spawn3'
         LifetimeRange=(Min=0.500000,Max=1.000000)
         InitialDelayRange=(Min=0.700000,Max=0.700000)
     End Object
     Emitters(1)=SpriteEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=100.000000,Max=200.000000)
         BeamEndPoints(0)=(offset=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-200.000000,Max=-75.000000)),Weight=0.800000)
         BeamEndPoints(1)=(offset=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-50.000000,Max=-200.000000)),Weight=0.200000)
         DetermineEndPointBy=PTEP_Offset
         RotatingSheets=3
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         HighFrequencyPoints=5
         HFScaleFactors(0)=(FrequencyScale=(X=1.000000,Y=1.000000,Z=1.000000))
         HFScaleFactors(1)=(FrequencyScale=(X=10.000000,Y=10.000000,Z=10.000000),RelativeLength=0.500000)
         HFScaleFactors(2)=(FrequencyScale=(X=1.000000,Y=1.000000,Z=1.000000),RelativeLength=1.000000)
         UseHighFrequencyScale=True
         BranchProbability=(Min=1.000000,Max=1.000000)
         BranchSpawnAmountRange=(Min=10.000000,Max=10.000000)
         UseColorScale=True
         RespawnDeadParticles=False
         ColorScale(0)=(Color=(G=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=7,G=164,R=248))
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(Z=150.000000)
         StartLocationRange=(X=(Min=-8.000000,Max=8.000000),Y=(Min=-8.000000,Max=8.000000),Z=(Max=10.000000))
         StartSizeRange=(X=(Min=2.000000,Max=5.000000),Y=(Min=1.000000,Max=5.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Beams.Doom_Lightning_Bolt4'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         InitialDelayRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(Z=(Min=-350.000000,Max=-350.000000))
     End Object
     Emitters(2)=BeamEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=100.000000,Max=200.000000)
         BeamEndPoints(0)=(offset=(Z=(Min=-200.000000,Max=-200.000000)),Weight=0.800000)
         DetermineEndPointBy=PTEP_Offset
         RotatingSheets=2
         LowFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         HighFrequencyNoiseRange=(X=(Min=-8.000000,Max=8.000000),Y=(Min=-3.000000,Max=8.000000),Z=(Min=-3.000000,Max=8.000000))
         LFScaleFactors(0)=(FrequencyScale=(X=1.000000,Y=1.000000,Z=1.000000),RelativeLength=1.000000)
         LFScaleFactors(1)=(FrequencyScale=(X=100.000000,Y=100.000000,Z=100.000000),RelativeLength=10.000000)
         HFScaleFactors(0)=(FrequencyScale=(X=1.000000,Y=1.000000,Z=1.000000))
         HFScaleFactors(1)=(FrequencyScale=(X=2.000000,Y=2.000000),RelativeLength=0.400000)
         HFScaleFactors(2)=(FrequencyScale=(X=5.000000,Y=5.000000,Z=5.000000),RelativeLength=0.500000)
         HFScaleFactors(3)=(FrequencyScale=(X=1.000000,Y=1.000000,Z=1.000000),RelativeLength=1.000000)
         UseHighFrequencyScale=True
         UseLowFrequencyScale=True
         RespawnDeadParticles=False
         ColorMultiplierRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=0.200000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         StartLocationOffset=(Z=150.000000)
         StartLocationRange=(X=(Min=-8.000000,Max=8.000000),Y=(Min=-8.000000,Max=8.000000))
         StartSizeRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=10.000000,Max=10.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Beams.Doom_Lightning_Bolt3'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.600000,Max=0.600000)
     End Object
     Emitters(3)=BeamEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=64,G=128,R=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=13,G=99,R=242))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=74,G=198,R=251))
         FadeOutStartTime=0.200000
         StartLocationOffset=(Z=150.000000)
         SpinsPerSecondRange=(X=(Min=-5.000000,Max=-8.000000),Y=(Min=-5.000000,Max=-8.000000))
         SizeScale(1)=(RelativeTime=0.200000,RelativeSize=10.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=20.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=45.000000)
         StartSizeRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=1.500000))
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_White_Flash_Strip2'
         TextureUSubdivisions=12
         TextureVSubdivisions=1
         LifetimeRange=(Min=1.000000,Max=2.000000)
     End Object
     Emitters(4)=SpriteEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         FadeOutStartTime=0.200000
         MaxParticles=1
         StartLocationOffset=(Z=150.000000)
         SpinsPerSecondRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=0.200000,Max=0.200000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=80.000000)
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000))
         Texture=Texture'tK_DoomMonsterPackv3.BFG.Doom_BFG_Blast2'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(5)=SpriteEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         FadeOutStartTime=0.500000
         MaxParticles=3
         StartLocationOffset=(Z=150.000000)
         SpinsPerSecondRange=(X=(Min=1.000000,Max=5.000000))
         StartSpinRange=(X=(Min=1.000000,Max=0.500000),Y=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000))
         Texture=Texture'tK_DoomMonsterPackv3.Effects.Doom_Flare1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(6)=SpriteEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.200000
         MaxParticles=3
         SpinsPerSecondRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000))
         Texture=Texture'tK_DoomMonsterPackv3.FlashStrips.Doom_Flash_Strip2'
         TextureUSubdivisions=12
         TextureVSubdivisions=1
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.700000,Max=0.700000)
     End Object
     Emitters(7)=SpriteEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(1)=(RelativeTime=0.200000,Color=(G=128,R=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(G=255,R=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=255,R=255))
         FadeOutStartTime=0.400000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=100.000000)
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000))
         Texture=Texture'tK_DoomMonsterPackv3.BFG.Doom_BFG_Blast3'
         LifetimeRange=(Min=0.500000,Max=1.000000)
         InitialDelayRange=(Min=0.700000,Max=0.700000)
     End Object
     Emitters(8)=SpriteEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.SpriteEmitter6'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'tK_DoomMonsterPackv3.SM.DemonSpawnSphere'
         UseParticleColor=True
         UseColorScale=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(G=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         Opacity=0.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartLocationOffset=(Z=150.000000)
         SpinsPerSecondRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(9)=MeshEmitter'tK_DoomMonsterPackv3.Doom_SpawnEffect.MeshEmitter0'

     AmbientGlow=150
}
