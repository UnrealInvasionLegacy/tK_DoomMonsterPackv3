class Vulgar extends Doom_Monster config(DoomMonsters);

var() Sound FireBallCreate;
var() Emitter FireTrail;
var() MaterialSequence FadeFXTail;
var() class<MaterialSequence> FadeTailClass;

simulated function Destroyed()
{
    if(FireTrail != None)
    {
        FireTrail.Kill();
    }

    Super.Destroyed();
}

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('l_fireball');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function FireRProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('r_fireball');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function OutGoingSmallFireBall()
{
    FireTrail = Spawn(class'Vulgar_HandTrail', self);
    AttachToBone(FireTrail, 'l_fireball');
    PlaySound(FireBallCreate,SLOT_Interact);
}

simulated function OutGoingRSmallFireBall()
{
    FireTrail = Spawn(class'Vulgar_HandTrail', self);
    AttachToBone(FireTrail, 'r_fireball');
    PlaySound(FireBallCreate,SLOT_Interact);
}

simulated function RemoveEffects()
{
    if(FireTrail != None)
    {
        FireTrail.Kill();
    }

    Super.RemoveEffects();
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
    else if(Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        LastTauntTime = Level.TimeSeconds;
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        bShotAnim = true;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime && !Controller.bPreparingMove && Controller.InLatentExecution(Controller.LATENT_MOVETOWARD))
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
     Skins[1] = InvisMat;
}

simulated function FadeSkins()
{
    if(FadeFX != None && FadeFXTail != None)
    {
        FadeFX.Reset();
        Skins[0] = FadeFX;
        Skins[2] = FadeFXTail;
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

simulated function AllocateBurningObjects()
{
    if(BurnClass != None && FadeClass != None && FadeTailClass != None)
    {
        BurnFX = FinalBlend(Level.ObjectPool.AllocateObject(BurnClass));
        FadeFX = MaterialSequence(Level.ObjectPool.AllocateObject(FadeClass));
        FadeFXTail = MaterialSequence(Level.ObjectPool.AllocateObject(FadeTailClass));

        if(BurnFX != None && FadeFX != None && FadeFXTail != None)
        {
            bMonsterHasBurnFX = True;
            SetUpFinalBlend(BurnFX);
        }
    }
}

simulated function FreeBurningObjects()
{
    Super.FreeBurningObjects();

    if(FadeFXTail != None)
    {
        Level.ObjectPool.FreeObject(FadeFXTail);
        FadeFXTail = None;
    }
}

defaultproperties
{
     FireBallCreate=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_fireball_create_01'
     FadeTailClass=Class'tK_DoomMonsterPackv3.Vulgar_Tail_MaterialSequence'
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     RangedAttackIntervalTime=2.500000
     NewHealth=130
     SpeciesName="Vulgar"
     MeleeAnims(0)="Attack3"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack3"
     MeleeAnims(3)="Attack1"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain01"
     HitAnims(3)="Pain02"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="RangedAttack1"
     RangedAttackAnims(1)="RangedAttack2"
     RangedAttackAnims(2)="RangedAttack1"
     RangedAttackAnims(3)="RangedAttack2"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Vulgar_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Vulgar_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Vulgar_MaterialSequence'
     SpawnFXClass=Class'tK_DoomMonsterPackv3.Vulgar_SpawnEffect'
     BurnAnimTime=0.250000
     aimerror=5
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_melee_01'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_melee_02'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_melee_04'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_melee_05'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_step_01a'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_step_02a'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_step_03a'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_step_02a'
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_pain_03a'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_pain_05'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_pain_08'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_pain_09'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_death_01'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_death_02'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_death_03'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_death_04'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_cc_03'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_sight_03'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_sight_04'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_sight_05'
     FireSound=Sound'tK_DoomMonsterPackv3.Vulgar.Vulgar_fireball_create_02'
     ScoringValue=5
     WallDodgeAnims(0)="DodgeL"
     WallDodgeAnims(1)="DodgeR"
     WallDodgeAnims(2)="DodgeL"
     WallDodgeAnims(3)="DodgeR"
     IdleHeavyAnim="Idle2"
     IdleRifleAnim="Idle2"
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=50.000000
     GroundSpeed=550.000000
     Health=130
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
     AirAnims(0)="Lunge"
     AirAnims(1)="Lunge"
     AirAnims(2)="Lunge"
     AirAnims(3)="Lunge"
     TakeoffAnims(0)="JumpStart"
     TakeoffAnims(1)="JumpStart"
     TakeoffAnims(2)="JumpStart"
     TakeoffAnims(3)="JumpStart"
     LandAnims(0)="Run"
     LandAnims(1)="Run"
     LandAnims(2)="Run"
     LandAnims(3)="Run"
     DoubleJumpAnims(0)="Run"
     DoubleJumpAnims(1)="Run"
     DoubleJumpAnims(2)="Run"
     DoubleJumpAnims(3)="Run"
     DodgeAnims(0)="DodgeL"
     DodgeAnims(1)="DodgeR"
     DodgeAnims(2)="DodgeL"
     DodgeAnims(3)="DodgeR"
     AirStillAnim="Lunge"
     TakeoffStillAnim="JumpStart"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle2"
     IdleSwimAnim="Idle2"
     IdleWeaponAnim="Idle2"
     IdleRestAnim="Idle2"
     IdleChatAnim="Idle2"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.VulgarMesh'
     DrawScale=1.250000
     PrePivot=(Z=-40.000000)
     Skins(0)=Shader'tK_DoomMonsterPackv3.Vulgar.Vulgar_Eye_Shader'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Vulgar.Vulgar_Tail_Skin'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Vulgar.Vulgar_Skin'
     CollisionRadius=20.000000
     CollisionHeight=40.000000
     Begin Object Class=KarmaParamsSkel Name=VulgarKParams
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
     KParams=KarmaParamsSkel'VulgarKParams'

}
