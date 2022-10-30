class Doom_Projector extends Projector;

function PostBeginPlay()
{
    local Rotator R;

    if ( PhysicsVolume.bNoDecals )
    {
        Destroy();
        return;
    }

	R.Pitch = -16384;

    SetRotation(R);
    Super.PostBeginPlay();
}

defaultproperties
{
     MaterialBlendingOp=PB_AlphaBlend
     FrameBufferBlendingOp=PB_Add
     ProjTexture=Texture'tK_DoomMonsterPackv3.Symbols.Doom_Spawn_Decal'
     FOV=1
     MaxTraceDistance=75
     bProjectParticles=False
     bProjectActor=False
     bClipBSP=True
     bClipStaticMesh=True
     bProjectOnUnlit=True
     FadeInTime=1.000000
     bStatic=False
     LifeSpan=4.000000
     DrawScale=0.350000
     bGameRelevant=True
}
