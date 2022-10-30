class Wraith_PortalFlare extends Doom_Emitter;

simulated function PostBeginPlay()
{
	Spawn(class'Wraith_TeleportScorch', ,, Location + vect(0,0,10), );
	Super.PostBeginPlay();
	SetTimer(0.50,true);
}

simulated function Timer()
{
	if(Emitters[0].RespawnDeadParticles)
	{
		Emitters[0].RespawnDeadParticles = false;
		SetTimer(1.00,true);
	}
	else
	{
		Destroy();
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(1)=(RelativeTime=0.200000,Color=(G=128,R=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=75.000000,Max=75.000000))
         Texture=Texture'AW-2004Particles.Energy.BurnFlare'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.Wraith_PortalFlare.SpriteEmitter1'

     AmbientGlow=150
}
