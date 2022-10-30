class FatZombie extends Doom_Monster config(DoomMonsters);

var() Name ExtraWalkAnims[4];
var() bool bBonusSkin;
var() bool bSkinChanged;
var() Material BonusSkin;
var() config bool bFatZombieCanThrowBarrel;

simulated function PostBeginPlay()
{
    local int i, iWalk;

    Super.PostBeginPlay();

    if(fRand() > 0.5 && bSkinChanged)
    {
        bBonusSkin = true;
        bSkinChanged = true;
        Skins[0] = InvisMat;
        Skins[2] = default.Skins[0];
    }

    iWalk = Rand(4);
    for(i=0;i<4;i++)
    {
        MovementAnims[i] = ExtraWalkAnims[iWalk];
    }

    TurnRightAnim = ExtraWalkAnims[iWalk];
    TurnLeftAnim = ExtraWalkAnims[iWalk];
}

function FireProjectile()
{
    local Coords BoneLocation;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('BarrelBone');
        Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
    }
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[0] = BurnFX;
        Skins[2] = BurnFX;
        bBurning = true;
    }
}

function RangedAttack(Actor A)
{
    local float Dist;

    Super.RangedAttack(A);

    Dist = VSize(A.Location - Location);

    if(Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        SetAnimAction(MeleeAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if(bFatZombieCanThrowBarrel && Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
}

simulated function HideSkinEffects()
{
    if(bBonusSkin)
    {
        Skins[0] = InvisMat;
    }

    Skins[1] = InvisMat;
    Skins[3] = InvisMat;
}


simulated function FadeSkins()
{
    if(FadeFX != None)
    {
        FadeFX.Reset();
        Skins[2] = FadeFX;
        HideSkinEffects();
        if(!bBonusSkin)
        {
            Skins[0] = FadeFX;
        }
    }
}

simulated function Destroyed()
{
    RemoveEffects();
    FreeBurningObjects();
    Super.Destroyed();
}

defaultproperties
{
     ExtraWalkAnims(0)="Walk02"
     ExtraWalkAnims(1)="Walk03"
     ExtraWalkAnims(2)="Walk04"
     ExtraWalkAnims(3)="Walk05"
     BonusSkin=Shader'tK_DoomMonsterPackv3.FatZombie.FatZombie_Skin_Shader'
     bFatZombieCanThrowBarrel=True
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=10.000000
     RangedAttackIntervalTime=3.500000
     ProjectileDamage=35.000000
     SpeciesName="FatZombie"
     MeleeAnims(0)="MeleeAttack01"
     MeleeAnims(1)="MeleeAttack02"
     MeleeAnims(2)="MeleeAttack03"
     MeleeAnims(3)="MeleeAttack03"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="BarrelThrow"
     RangedAttackAnims(1)="BarrelThrow"
     RangedAttackAnims(2)="BarrelThrow"
     RangedAttackAnims(3)="BarrelThrow"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.FatZombie_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.FatZombie_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.FatZombie_MaterialSequence'
     BurnAnimTime=0.500000
     aimerror=100
     MissSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_whoosh1'
     MissSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_whoosh2'
     MissSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_whoosh3'
     MissSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_whoosh2'
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_attack1'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_attack4'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_attack5'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.melee_02'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.fs_01'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.fs_02'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.fs_03'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.fs_04'
     bCanDodge=False
     HitSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_01'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_02'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_03'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_pain5'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_death1'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_death2'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_death3'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_death4'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_02'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_03'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.chatter_04'
     ScoringValue=3
     WallDodgeAnims(0)="Walk01"
     WallDodgeAnims(1)="Walk01"
     WallDodgeAnims(2)="Walk01"
     WallDodgeAnims(3)="Walk01"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Idle"
     FireHeavyBurstAnim="Idle"
     FireRifleRapidAnim="Idle"
     FireRifleBurstAnim="Idle"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=50.000000
     GroundSpeed=280.000000
     MovementAnims(0)="Walk01"
     MovementAnims(1)="Walk01"
     MovementAnims(2)="Walk01"
     MovementAnims(3)="Walk01"
     TurnLeftAnim="Walk01"
     TurnRightAnim="Walk01"
     SwimAnims(0)="Walk01"
     SwimAnims(1)="Walk01"
     SwimAnims(2)="Walk01"
     SwimAnims(3)="Walk01"
     CrouchAnims(0)="Walk01"
     CrouchAnims(1)="Walk01"
     CrouchAnims(2)="Walk01"
     CrouchAnims(3)="Walk01"
     WalkAnims(0)="Walk01"
     WalkAnims(1)="Walk01"
     WalkAnims(2)="Walk01"
     WalkAnims(3)="Walk01"
     AirAnims(0)="Walk01"
     AirAnims(1)="Walk01"
     AirAnims(2)="Walk01"
     AirAnims(3)="Walk01"
     TakeoffAnims(0)="Walk01"
     TakeoffAnims(1)="Walk01"
     TakeoffAnims(2)="Walk01"
     TakeoffAnims(3)="Walk01"
     LandAnims(0)="Walk01"
     LandAnims(1)="Walk01"
     LandAnims(2)="Walk01"
     LandAnims(3)="Walk01"
     DoubleJumpAnims(0)="Walk01"
     DoubleJumpAnims(1)="Walk01"
     DoubleJumpAnims(2)="Walk01"
     DoubleJumpAnims(3)="Walk01"
     DodgeAnims(0)="Walk01"
     DodgeAnims(1)="Walk01"
     DodgeAnims(2)="Walk01"
     DodgeAnims(3)="Walk01"
     AirStillAnim="Walk01"
     TakeoffStillAnim="Walk01"
     CrouchTurnRightAnim="Walk01"
     CrouchTurnLeftAnim="Walk01"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.FatZombieMesh'
     DrawScale=1.200000
     PrePivot=(Z=-40.000000)
     Skins(0)=FinalBlend'tK_DoomMonsterPackv3.FatZombie.FatZombie_Skin_FinalBlend'
     Skins(1)=Shader'tK_DoomMonsterPackv3.FatZombie.FatZombie_MonkeyWrench_Shader'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(3)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     CollisionRadius=20.000000
     CollisionHeight=40.000000
     Begin Object Class=KarmaParamsSkel Name=FatZombieKParams
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
     KParams=KarmaParamsSkel'FatZombieKParams'

}
