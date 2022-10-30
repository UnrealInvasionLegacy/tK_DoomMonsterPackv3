class HunterInvul_ElecBody extends Doom_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=188,R=121))
         ColorScale(1)=(RelativeTime=0.700000,Color=(B=255,G=183,R=111))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=187,R=119))
         FadeOutStartTime=0.700000
         CoordinateSystem=PTCS_Relative
         MaxParticles=500
         StartLocationRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         UseSkeletalLocationAs=PTSU_Location
         SkeletalScale=(X=1.200000,Y=1.200000,Z=1.200000)
         RelativeBoneIndexRange=(Min=0.100000,Max=0.900000)
         Texture=Texture'XEffectMat.Shock.Shock_Elec_a'
         TextureUSubdivisions=10
         TextureVSubdivisions=10
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.900000,Max=0.900000)
     End Object
     Emitters(0)=SpriteEmitter'tK_DoomMonsterPackv3.HunterInvul_ElecBody.SpriteEmitter0'

     bHardAttach=True
}
