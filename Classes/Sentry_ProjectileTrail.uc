class Sentry_ProjectileTrail extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=80.000000
         UseCrossedSheets=True
         PointLifeTime=0.100000
         UseColorScale=True
         ColorScale(0)=(Color=(B=17,G=136,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=13,G=255,R=255))
         StartSizeRange=(X=(Min=5.000000,Max=5.000000))
         Texture=Texture'AW-2k4XP.Cicada.MissileTrail1a'
     End Object
     Emitters(0)=TrailEmitter'tK_DoomMonsterPackv3.Sentry_ProjectileTrail.TrailEmitter0'

}
