class Vulgar_Projector extends Doom_Projector;

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
     ProjTexture=Texture'tK_DoomMonsterPackv3.Symbols.Doom_Spawn_Vulgar_Decal'
}
