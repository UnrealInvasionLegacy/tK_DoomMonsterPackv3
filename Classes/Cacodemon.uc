class Cacodemon extends Doom_Monster config(DoomMonsters);

var() Sound RangedAttackSounds[2];
var() Sound RandomSounds[4];
var() Emitter Vents[2];
var() Emitter MouthFlare;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    Vents[0] = Spawn(class'Cacodemon_MouthTorch',self);
        AttachToBone(Vents[0],'LVent');
    Vents[1] = Spawn(class'Cacodemon_MouthTorch',self);
        AttachToBone(Vents[1],'RVent');
    MouthFlare = Spawn(class'Cacodemon_MouthFlare',self);
        AttachToBone(MouthFlare,'caco_mouthfire');

    SetTimer(RandRange(10.00,30.00),true);
}

simulated function Timer()
{
    Super.Timer();
    PlaySound(RandomSounds[Rand(4)], SLOT_Interact);
    SetTimer(RandRange(10.00,30.00),true);
}

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('caco_mouthfire');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(RangedAttackSounds[Rand(2)],SLOT_Interact);
        }
    }
}

simulated function RemoveEffects()
{
    if(Vents[0] != None)
    {
        DetachFromBone(Vents[0]);
        Vents[0].Kill();
    }

    if(Vents[1] != None)
    {
        DetachFromBone(Vents[1]);
        Vents[1].Kill();
    }

    if(MouthFlare != None)
    {
        DetachFromBone(MouthFlare);
        MouthFlare.Kill();
    }
}

function SetMovementPhysics()
{
    SetPhysics(PHYS_Flying);
}

singular function Falling()
{
    SetPhysics(PHYS_Flying);
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
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        bShotAnim = true;
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
}

simulated function HideSkinEffects()
{
    Skins[1] = InvisMat;
    Skins[3] = InvisMat;
    Skins[4] = InvisMat;
}

simulated function FadeSkins()
{
    if(FadeFX != None)
    {
        FadeFX.Reset();
        Skins[0] = FadeFX;
        Skins[2] = FadeFX;
        HideSkinEffects();
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

defaultproperties
{
     RangedAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_fire_02'
     RangedAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_fire_03'
     RandomSounds(0)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_breath2'
     RandomSounds(1)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_chatter1'
     RandomSounds(2)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_chatter2'
     RandomSounds(3)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_chatter5'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=50.000000
     ProjectileDamage=15.000000
     NewHealth=200
     SpeciesName="Cacodemon"
     MeleeAnims(0)="Melee"
     MeleeAnims(1)="Melee"
     MeleeAnims(2)="Melee"
     MeleeAnims(3)="Melee"
     HitAnims(0)="Pain"
     HitAnims(1)="Pain"
     HitAnims(2)="Pain"
     HitAnims(3)="Pain"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="RangedAttack"
     RangedAttackAnims(1)="RangedAttack"
     RangedAttackAnims(2)="RangedAttack"
     RangedAttackAnims(3)="RangedAttack"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Cacodemon_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Cacodemon_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Cacodemon_MaterialSequence'
     BurnAnimTime=0.300000
     aimerror=200
     DodgeSkillAdjust=3.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_pain5'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_pain5'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_pain5'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_pain5'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_death1'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_death3'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_death1'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_death3'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_sight2_4'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_sight2_2'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_sight2_4'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_sight2_2'
     ScoringValue=5
     WallDodgeAnims(0)="Run"
     WallDodgeAnims(1)="Run"
     WallDodgeAnims(2)="Run"
     WallDodgeAnims(3)="Run"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Idle"
     FireHeavyBurstAnim="Idle"
     FireRifleRapidAnim="Idle"
     FireRifleBurstAnim="Idle"
     bCanJump=False
     bCanWalk=False
     bCanFly=True
     bCanWalkOffLedges=True
     MeleeRange=100.000000
     GroundSpeed=400.000000
     AirSpeed=400.000000
     Health=200
     MovementAnims(0)="Run"
     MovementAnims(1)="Run"
     MovementAnims(2)="Run"
     MovementAnims(3)="Run"
     TurnLeftAnim="Run"
     TurnRightAnim="Run"
     SwimAnims(0)="Run"
     SwimAnims(1)="Run"
     SwimAnims(2)="Run"
     SwimAnims(3)="Run"
     CrouchAnims(0)="Run"
     CrouchAnims(1)="Run"
     CrouchAnims(2)="Run"
     CrouchAnims(3)="Run"
     WalkAnims(0)="Run"
     WalkAnims(1)="Run"
     WalkAnims(2)="Run"
     WalkAnims(3)="Run"
     AirAnims(0)="Run"
     AirAnims(1)="Run"
     AirAnims(2)="Run"
     AirAnims(3)="Run"
     TakeoffAnims(0)="Run"
     TakeoffAnims(1)="Run"
     TakeoffAnims(2)="Run"
     TakeoffAnims(3)="Run"
     LandAnims(0)="Run"
     LandAnims(1)="Run"
     LandAnims(2)="Run"
     LandAnims(3)="Run"
     DoubleJumpAnims(0)="Run"
     DoubleJumpAnims(1)="Run"
     DoubleJumpAnims(2)="Run"
     DoubleJumpAnims(3)="Run"
     DodgeAnims(0)="Run"
     DodgeAnims(1)="Run"
     DodgeAnims(2)="Run"
     DodgeAnims(3)="Run"
     AirStillAnim="Run"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     AmbientSound=Sound'tK_DoomMonsterPackv3.Cacodemon.caco_flight_08'
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.CacodemonMesh'
     DrawScale=2.000000
     Skins(0)=Texture'tK_DoomMonsterPackv3.Cacodemon.Cacodemon_Skin'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Cacodemon.Cacodemon_Eye_Shader'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Cacodemon.Cacodemon_Skin'
     Skins(3)=Shader'tK_DoomMonsterPackv3.Cacodemon.Cacodemon_Brain_Shader'
     Skins(4)=FinalBlend'tK_DoomMonsterPackv3.Cacodemon.Cacodemon_Mouth_FinalBlend'
     CollisionRadius=60.000000
     CollisionHeight=60.000000
     Begin Object Class=KarmaParamsSkel Name=CacodemonKParams
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
     KParams=KarmaParamsSkel'CacodemonKParams'

}
