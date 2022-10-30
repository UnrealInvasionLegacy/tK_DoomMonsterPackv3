class Bruiser extends Doom_Monster config(DoomMonsters);

var() Sound ProjFireSounds[5];
var() Sound ReloadSounds[4];

var() Material ScreenImages[5];
var() MaterialSequence FadeFXMouth;
var() class<MaterialSequence> FadeMouthClass;

function RangedAttack(Actor A)
{
    local float Dist;

    Super.RangedAttack(A);

    Dist = VSize(A.Location - Location);

    if(Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        SetAnimAction(MeleeAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if ( Velocity == vect(0,0,0) )
    {
        SetAnimAction(RangedAttackAnims[3]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
        LastRangedAttackTime = Level.TimeSeconds;
    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        SetAnimAction(RangedAttackAnims[Rand(3)]);
        LastRangedAttackTime = Level.TimeSeconds;
        bShotAnim = true;
    }
}

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('flame_l');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(ProjFireSounds[Rand(5)],SLOT_Interact);
        }
    }
}

function FireRProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('flame_r');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(ProjFireSounds[Rand(5)],SLOT_Interact);
        }
    }
}

simulated function LFireGlow()
{
    local Emitter Puff;
    local Coords BoneLocation;

    BoneLocation = GetBoneCoords('flame_l');
    Puff = Spawn(class'Revenant_SmokePuffs',self,,BoneLocation.Origin);
}

simulated function RFireGlow()
{
    local Emitter Puff;
    local Coords BoneLocation;

    BoneLocation = GetBoneCoords('flame_r');
    Puff = Spawn(class'Revenant_SmokePuffs',self,,BoneLocation.Origin);
}

simulated function Reload()
{
    PlaySound(ReloadSounds[Rand(4)],SLOT_Talk);
}

simulated function SetAngryImage()
{
    local Shader Shad;

    Shad = Shader(Skins[2]);
    Shad.Diffuse = ScreenImages[0];
}

simulated function SetIdleImage()
{
    local Shader Shad;

    Shad = Shader(Skins[2]);
    Shad.Diffuse = ScreenImages[1];
}

simulated function SetPainImage()
{
    local Shader Shad;

    Shad = Shader(Skins[2]);
    Shad.Diffuse = ScreenImages[2];
}

simulated function SetSightImage()
{
    local Shader Shad;

    Shad = Shader(Skins[2]);
    Shad.Diffuse = ScreenImages[4];
}

simulated function SetDefaultImage()
{
    local Shader Shad;

    Shad = Shader(Skins[2]);
    Shad.Diffuse = ScreenImages[1];
}

simulated function HideSkinEffects()
{
     Skins[2] = InvisMat;
}

simulated function FadeSkins()
{
    if(FadeFX != None && FadeFXMouth != None)
    {
        FadeFX.Reset();
        FadeFXMouth.Reset();
        Skins[0] = FadeFX;
        Skins[1] = FadeFXMouth;
        HideSkinEffects();
    }
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[0] = BurnFX;
        Skins[1] = BurnFX;
        bBurning = true;
    }
}

simulated function AllocateBurningObjects()
{
    if(BurnClass != None && FadeClass != None && FadeMouthClass != None)
    {
        BurnFX = FinalBlend(Level.ObjectPool.AllocateObject(BurnClass));
        FadeFX = MaterialSequence(Level.ObjectPool.AllocateObject(FadeClass));
        FadeFXMouth = MaterialSequence(Level.ObjectPool.AllocateObject(FadeMouthClass));

        if(BurnFX != None && FadeFX != None && FadeFXMouth != None)
        {
            bMonsterHasBurnFX = True;
            SetUpFinalBlend(BurnFX);
        }
    }
}

simulated function FreeBurningObjects()
{
    Super.FreeBurningObjects();

    if(FadeFXMouth != None)
    {
        Level.ObjectPool.FreeObject(FadeFXMouth);
        FadeFXMouth = None;
    }
}

defaultproperties
{
     ProjFireSounds(0)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_fire_01'
     ProjFireSounds(1)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_fire_02'
     ProjFireSounds(2)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_fire_03'
     ProjFireSounds(3)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_fire_04'
     ProjFireSounds(4)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_fire_05'
     ReloadSounds(0)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_reload_01'
     ReloadSounds(1)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_reload_02'
     ReloadSounds(2)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_reload_03'
     ReloadSounds(3)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_reload_04'
     ScreenImages(0)=Texture'tK_DoomMonsterPackv3.Bruiser.Bruiser_AngryTex'
     ScreenImages(1)=Texture'tK_DoomMonsterPackv3.Bruiser.Bruiser_IdleTex'
     ScreenImages(2)=Texture'tK_DoomMonsterPackv3.Bruiser.Bruiser_PainTex'
     ScreenImages(3)=Texture'tK_DoomMonsterPackv3.Bruiser.Bruiser_ScreenTex'
     ScreenImages(4)=Texture'tK_DoomMonsterPackv3.Bruiser.Bruiser_SightTex'
     FadeMouthClass=Class'tK_DoomMonsterPackv3.Bruiser_Mouth_MaterialSequence'
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=30.000000
     NewHealth=500
     SpeciesName="Bruiser"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack1"
     MeleeAnims(3)="Attack2"
     HitAnims(0)="PainL"
     HitAnims(1)="PainR"
     HitAnims(2)="PainL"
     HitAnims(3)="PainR"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="RangedAttack1"
     RangedAttackAnims(1)="RangedAttack2"
     RangedAttackAnims(2)="RangedAttack1"
     RangedAttackAnims(3)="RangedAttack3"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Bruiser_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Bruiser_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Bruiser_MaterialSequence'
     BurnAnimTime=0.250000
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_melee_02'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_melee_02'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_combat_chatter_01'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_combat_chatter_01'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_fs_01'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_fs_02'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_fs_01'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_fs_02'
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_pain_01'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_pain_02'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_pain_01'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_pain_02'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_death_03'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_death_01'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_death_03'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_death_01'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_sight_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_sight_03'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_sight_01'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Bruiser.Bruiser_sight_03'
     ScoringValue=15
     FootstepVolume=0.500000
     WallDodgeAnims(0)="DodgeL"
     WallDodgeAnims(1)="DodgeR"
     WallDodgeAnims(2)="DodgeL"
     WallDodgeAnims(3)="DodgeR"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Walk"
     FireHeavyBurstAnim="Walk"
     FireRifleRapidAnim="Walk"
     FireRifleBurstAnim="Walk"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=170.000000
     GroundSpeed=200.000000
     Health=500
     MovementAnims(0)="Walk"
     MovementAnims(1)="Walk"
     MovementAnims(2)="Walk"
     MovementAnims(3)="Walk"
     TurnLeftAnim="Walk"
     TurnRightAnim="Walk"
     SwimAnims(0)="Walk"
     SwimAnims(1)="Walk"
     SwimAnims(2)="Walk"
     SwimAnims(3)="Walk"
     CrouchAnims(0)="Walk"
     CrouchAnims(1)="Walk"
     CrouchAnims(2)="Walk"
     CrouchAnims(3)="Walk"
     WalkAnims(0)="Walk"
     WalkAnims(1)="Walk"
     WalkAnims(2)="Walk"
     WalkAnims(3)="Walk"
     AirAnims(0)="Walk"
     AirAnims(1)="Walk"
     AirAnims(2)="Walk"
     AirAnims(3)="Walk"
     TakeoffAnims(0)="Walk"
     TakeoffAnims(1)="Walk"
     TakeoffAnims(2)="Walk"
     TakeoffAnims(3)="Walk"
     LandAnims(0)="Walk"
     LandAnims(1)="Walk"
     LandAnims(2)="Walk"
     LandAnims(3)="Walk"
     DoubleJumpAnims(0)="Walk"
     DoubleJumpAnims(1)="Walk"
     DoubleJumpAnims(2)="Walk"
     DoubleJumpAnims(3)="Walk"
     DodgeAnims(0)="DodgeL"
     DodgeAnims(1)="DodgeR"
     DodgeAnims(2)="DodgeL"
     DodgeAnims(3)="DodgeR"
     AirStillAnim="Walk"
     TakeoffStillAnim="Walk"
     CrouchTurnRightAnim="Walk"
     CrouchTurnLeftAnim="Walk"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.BruiserMesh'
     DrawScale=1.300000
     PrePivot=(Z=-75.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Bruiser.Bruiser_Skin'
     Skins(1)=FinalBlend'tK_DoomMonsterPackv3.Bruiser.Bruiser_Mouth_FinalBlend'
     Skins(2)=Shader'tK_DoomMonsterPackv3.Bruiser.Bruiser_Screen_Shader'
     CollisionRadius=40.000000
     CollisionHeight=75.000000
     Begin Object Class=KarmaParamsSkel Name=BruiserKParams
         KConvulseSpacing=(Max=2.200000)
         KMass=700.000000
         KLinearDamping=0.150000
         KAngularDamping=0.050000
         KBuoyancy=1.000000
         KStartEnabled=True
         KVelDropBelowThreshold=50.000000
         bHighDetailOnly=False
         KFriction=1.700000
         KRestitution=0.050000
         KImpactThreshold=300.000000
     End Object
     KParams=KarmaParamsSkel'BruiserKParams'

}
