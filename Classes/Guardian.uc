class Guardian extends Doom_Monster config(DoomMonsters);

var() config bool bGuardianCanCharge;
var() config float GroundShockDamage;
var() config float GroundShockRadius;
var() Sound GroundSlamSound;
var int ShockDamage;
var float ShockRadius;
var float SavedGroundSpeed;
var Name RunningMeleeAttacks[2];
var Emitter Flames[4];
var MaterialSequence FadeFXTongue;
var class<MaterialSequence> FadeTongueClass;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    Flames[0] = Spawn(class'Guardian_HandFlame',self);
        AttachToBone(Flames[0],'GFlameRHand');
    Flames[1] = Spawn(class'Guardian_HandFlame',self);
        AttachToBone(Flames[1],'GFlameLHand');
    Flames[2] = Spawn(class'Guardian_BackFlame',self);
        AttachToBone(Flames[2],'GFlameBack');
    Flames[3] = Spawn(class'Guardian_TailFlame',self);
        AttachToBone(Flames[3],'tail_12');
}

function MeleeAttack()
{
    if(Controller != None && Controller.Target != None)
    {
        if (MeleeDamageTarget(MeleeDamage, (90000 * Normal(Controller.Target.Location - Location))) )
        {
            PlaySound(MeleeAttackSounds[Rand(4)], SLOT_Interact);
        }
        else
        {
            PlaySound(MissSound[Rand(4)], SLOT_Interact);
        }
    }
}

simulated function BothWaves()
{
    LeftWave();
    RightWave();
}

simulated function LeftWave()
{
    local Coords BoneLocation;

    BoneLocation = GetBoneCoords('GFlameLhand');
    Spawn(class'Guardian_ShockWave',self,,BoneLocation.origin);
}

simulated function RightWave()
{
    local Coords BoneLocation;

    BoneLocation = GetBoneCoords('GFlameRhand');
    Spawn(class'Guardian_ShockWave',self,,BoneLocation.origin);
}

function RangedShock()
{
    MultiProjectiles();
    LeftShock();
    RightShock();
    PlaySound(FireSound,SLOT_Talk);
}

function MultiProjectiles()
{
    local Coords BoneLocation;
    local Rotator Rot;

    BoneLocation = GetBoneCoords('GFlameLhand');
    Rot.Yaw = 0;
    Spawn(ProjectileClass[0],self,,BoneLocation.Origin, Rotation + Rot);

    Rot.Yaw = 32768;
    Spawn(ProjectileClass[0],self,,BoneLocation.Origin, Rotation + Rot);

    Rot.Yaw = -16834;
    Spawn(ProjectileClass[0],self,,BoneLocation.Origin, Rotation + Rot);

    BoneLocation = GetBoneCoords('GFlameRhand');
    Rot.Yaw = 0;
    Spawn(ProjectileClass[0],self,,BoneLocation.Origin, Rotation + Rot);

    Rot.Yaw = 32768;
    Spawn(ProjectileClass[0],self,,BoneLocation.Origin, Rotation + Rot);

    Rot.Yaw = 16834;
    Spawn(ProjectileClass[0],self,,BoneLocation.Origin, Rotation + Rot);
}

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None && Controller.Target != None)
    {
        BoneLocation = GetBoneCoords('tounge_4');
        Proj = Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Doom_Projectile(Proj) != None)
        {
            Doom_Projectile(Proj).Seeking = Controller.Target;
        }
    }
}

simulated function RemoveEffects()
{
    local int i;

    for(i=0;i<4;i++)
    {
        if(Flames[i] != None)
        {
            DetachFromBone(Flames[i]);
            Flames[i].Kill();
        }
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
    else if (Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
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
}

function ShockWave(Name ShockBone)
{
    local Coords BoneLocation;
    local Actor P;
    local vector dir;
    local float damageScale, dist, Momentum, Shake;

    if(ShockBone != 'None' && ShockBone != '')
    {
        BoneLocation = GetBoneCoords(ShockBone);
        PlaySound(GroundSlamSound,SLOT_Interact);

        foreach VisibleCollidingActors(class'Actor', P, GroundShockRadius, BoneLocation.Origin)
        {
            if(xPawn(P) != None && xPawn(P).Health > 0 && xPawn(P) != Self && xPawn(P).Controller != None && !xPawn(P).Controller.IsA('MonsterController'))
            {
                Shake = RandRange(2000,3000);
                xPawn(P).Controller.ShakeView( vect(0.0,0.02,0.0)*Shake, vect(0,1000,0),0.003*Shake, vect(0.02,0.02,0.02)*Shake, vect(1000,1000,1000),0.003*Shake);
                Momentum = 100 * xPawn(P).CollisionRadius;
                dir = xPawn(P).Location - BoneLocation.origin;
                dist = FMax(1,VSize(dir));
                dir = dir/dist;
                damageScale = 1 - FMax(0,(dist - xPawn(P).CollisionRadius)/GroundShockRadius);
                xPawn(P).TakeDamage(damageScale * ShockDamage,self,xPawn(P).Location - 0.5 * (xPawn(P).CollisionHeight + xPawn(P).CollisionRadius) * dir,(damageScale * Momentum * dir), class'DamType_Guardian_ShockWave');
            }

            if(TransBeacon(P) != None)
            {
                P.TakeDamage(GroundShockDamage, self, P.Location, vect(0,0,0), class'DamType_Guardian_ShockWave');
            }
        }
    }
}

function RightShock()
{
    ShockWave('GFlameRhand');
}

function LeftShock()
{
    ShockWave('GFlameLhand');
}

simulated function HideSkinEffects()
{
     Skins[2] = InvisMat;
}

simulated function FadeSkins()
{
    if(FadeFX != None && FadeFXTongue != None)
    {
        HideSkinEffects();
        FadeFX.Reset();
        FadeFXTongue.Reset();
        Skins[0] = FadeFXTongue;
        Skins[1] = FadeFX;
    }
}

simulated function AllocateBurningObjects()
{
    if(BurnClass != None && FadeClass != None && FadeTongueClass != None)
    {
        BurnFX = FinalBlend(Level.ObjectPool.AllocateObject(BurnClass));
        FadeFX = MaterialSequence(Level.ObjectPool.AllocateObject(FadeClass));
        FadeFXTongue = MaterialSequence(Level.ObjectPool.AllocateObject(FadeTongueClass));

        if(BurnFX != None && FadeFX != None && FadeFXTongue != None)
        {
            bMonsterHasBurnFX = True;
            SetUpFinalBlend(BurnFX);
        }
    }
}

simulated function FreeBurningObjects()
{
    Super.FreeBurningObjects();
    if(FadeFXTongue != None)
    {
        Level.ObjectPool.FreeObject(FadeFXTongue);
        FadeFXTongue = None;
    }
}

defaultproperties
{
     bGuardianCanCharge=True
     GroundShockDamage=30.000000
     GroundShockRadius=300.000000
     GroundSlamSound=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_rocksmash'
     ShockDamage=20
     ShockRadius=300.000000
     RunningMeleeAttacks(0)="RunHeadbutt"
     RunningMeleeAttacks(1)="RunHeadbutt"
     FadeTongueClass=Class'tK_DoomMonsterPackv3.Guardian_Tongue_MaterialSequence'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=40.000000
     RangedAttackIntervalTime=3.500000
     NewHealth=1200
     SpeciesName="Guardian"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack3"
     MeleeAnims(3)="Attack3"
     HitAnims(0)="Pain"
     HitAnims(1)="Pain"
     HitAnims(2)="Pain"
     HitAnims(3)="Pain"
     DeathAnims(0)="Death"
     DeathAnims(1)="Death"
     DeathAnims(2)="Death"
     DeathAnims(3)="Death"
     TauntAnim="Sight"
     RangedAttackAnims(0)="RangedAttack01"
     RangedAttackAnims(1)="RangedAttack02"
     RangedAttackAnims(2)="RangedAttack01"
     RangedAttackAnims(3)="RangedAttack02"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Guardian_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Guardian_ProjectileMouth'
     FadeClass=Class'tK_DoomMonsterPackv3.Guardian_MaterialSequence'
     BurnAnimTime=1.200000
     aimerror=10
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_chatter1'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_chatter3'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_chatter1'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_chatter3'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_step4'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_step4'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_step4'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_step4'
     bCanDodge=False
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_pain1'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_pain2'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_pain3'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_pain1'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Guardian.guardian_death'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Guardian.guardian_death'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Guardian.guardian_death'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Guardian.guardian_death'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_chatter_combat2'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Guardian.guardian_sight'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_sight2_1'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Guardian.Guardian_sight1_1'
     FireSound=Sound'tK_DoomMonsterPackv3.Guardian.guardian_fire_flare_up'
     ScoringValue=15
     WallDodgeAnims(0)="Walk"
     WallDodgeAnims(1)="Walk"
     WallDodgeAnims(2)="Walk"
     WallDodgeAnims(3)="Walk"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Walk"
     FireHeavyBurstAnim="Walk"
     FireRifleRapidAnim="Walk"
     FireRifleBurstAnim="Walk"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=250.000000
     GroundSpeed=200.000000
     Health=700
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
     DodgeAnims(0)="Walk"
     DodgeAnims(1)="Walk"
     DodgeAnims(2)="Walk"
     DodgeAnims(3)="Walk"
     AirStillAnim="Walk"
     TakeoffStillAnim="Walk"
     CrouchTurnRightAnim="Walk"
     CrouchTurnLeftAnim="Walk"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.GuardianMesh'
     PrePivot=(X=-50.000000,Z=-115.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Guardian.Guardian_Tongue_Skin'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Guardian.Guardian_Skin'
     Skins(2)=Shader'tK_DoomMonsterPackv3.Guardian.Guardian_Skin_Shader'
     CollisionRadius=80.000000
     CollisionHeight=115.000000
     Begin Object Class=KarmaParamsSkel Name=GuardianKParams
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
     KParams=KarmaParamsSkel'GuardianKParams'

}
