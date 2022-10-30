class Seeker extends Doom_Monster config(DoomMonsters);

var() config bool bCanLinkMonsters;
var() config bool bSeekerHint;
var() config float SeekerLinkRange;
var() config int LinkedMonsterLimit;
var() config float SeekerHintIntervalTime;
var() float LastHintTime;
var() Emitter SeekerEffect;
var() Actor SeekerBeamEffect;
var() int CurrentNumLink;
var() bool bHeadShouldExplode;
var() float HeadSize;
var() Sound HintSound;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(Role == Role_Authority)
    {
        if(bCanLinkMonsters)
        {
            SetTimer(1.00,true);
        }
    }

    SpawnSeeks();
}

simulated function SpawnSeeks()
{
    SeekerEffect = Spawn(class'Seeker_LightFXEmitter',self);
    AttachToBone(SeekerEffect, 'LightFX');

    SeekerBeamEffect = Spawn(class'Seeker_TorchMesh',self);
    AttachToBone(SeekerBeamEffect, 'LightFX');
}

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None && Controller.Target != None)
    {
        BoneLocation = GetBoneCoords('Head');
        Proj = Spawn(class'Seeker_Projectile',Self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Doom_Projectile(Proj) != None)
        {
            Doom_Projectile(Proj).Seeking = Self;
            PlaySound(ChallengeSound[Rand(4)],SLOT_Interact);
        }
    }
}

function RemoveLink(int NumLink)
{
    CurrentNumLink -= NumLink;
}

function AddLink(int NumLink)
{
    CurrentNumLink += NumLink;
}

function SetMovementPhysics()
{
    SetPhysics(PHYS_Flying);
}

singular function Falling()
{
    SetPhysics(PHYS_Flying);
}

simulated function StartDeRes()
{
    if( Level.NetMode == NM_DedicatedServer )
        return;
    AmbientSound = DeResSound;
    SoundRadius = 40.0;
    bDeRes = true;
}

simulated function RemoveEffects()
{
    if(SeekerBeamEffect != None)
    {
        DetachFromBone(SeekerBeamEffect);
    }
    if(SeekerEffect != None)
    {
        DetachFromBone(SeekerEffect);
        SeekerEffect.Destroy();
    }

    Super.RemoveEffects();
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[0] = BurnFX;
        bBurning = true;
    }
}

function Timer()
{
    local Inventory NewInv;
    local class<Inventory> SeekerInv;
    local Monster M;

    foreach VisibleCollidingActors(class'Monster', M, SeekerLinkRange, Location)
    {
        if(CurrentNumLink < LinkedMonsterLimit && M != None && !M.IsA('Seeker') && M.Controller != None && !M.Controller.IsA('FriendlyMonsterController'))
        {
            SeekerInv = class<Inventory>(DynamicLoadObject("tK_DoomMonsterPackv3.Seeker_Inventory",class'class',true));
            if(M.FindInventoryType(SeekerInv) == None)
            {
                NewInv = Spawn(SeekerInv, M,,,);
                if(Seeker_Inventory(NewInv) != None)
                {
                    Seeker_Inventory(NewInv).PawnMaster = self;
                    NewInv.GiveTo(M);
                }
            }
        }
    }

    if(CurrentNumLink > 0 && Level.TimeSeconds - LastHintTime > SeekerHintIntervalTime && bSeekerHint)
    {
        LastHintTime = Level.TimeSeconds;
        PlaySound(HintSound, SLOT_Interact,50);
    }
}

function RangedAttack(Actor A)
{
    Super.RangedAttack(A);

    if ( CurrentNumLink > 0)
    {
        Acceleration = vect(0,0,0);
        return;
    }

    if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        FireProjectile();
    }
    else
    {
        SetAnimAction(TauntAnim);
    }

    Controller.bPreparingMove = true;
    Acceleration = vect(0,0,0);
    bShotAnim = true;
}

simulated function HideSkinEffects()
{}

simulated function FadeSkins()
{
    if(FadeFX != None)
    {
        FadeFX.Reset();
        Skins[0] = FadeFX;
        HideSkinEffects();
    }
}

simulated function FallBackDeath(vector HitLoc)
{
    bHeadShouldExplode = true;
    PlayAnim('DeathFall',1.00);
}

State Dying
{
ignores AnimEnd, Trigger, Bump, HitWall, HeadVolumeChange, PhysicsVolumeChange, Falling, BreathTimer;

   function Landed(vector HitNormal)
    {
        if(bHeadShouldExplode)
        {
             bHidden = true;
             Spawn(class'Seeker_Impact',self,, Location);
        }

        SetPhysics(PHYS_None);
        if ( !IsAnimating(0) )
            LandThump();
        Super.Landed(HitNormal);
    }

    simulated function Timer()
    {
        if ( !PlayerCanSeeMe() )
        {
            Destroy();
        }
        else if ( LifeSpan <= DeResTime && bDeRes == false )
        {
            StartDeRes();
        }
        else
        {
            SetTimer(1.0, false);
        }
    }

    simulated function Tick(float deltatime)
    {
        local int i;

        if(bBurning)
        {
            if(BurnFX != None)
            {
                if(BurnFX.AlphaRef != 255)
                {
                    BurnFX.AlphaRef += BurnSpeed;
                }
                else
                {
                    for(i=0;i<Skins.Length;i++)
                    {
                        Skins[i] = InvisMat;
                    }

                    bHidden = true;
                    Disable('Tick');
                }
            }
        }
    }

Begin:

    Sleep(0.5);
    if(bHasRagdoll && bMonsterHasBurnFX)
    {
        BurnAway();
    }

    Sleep(0.2);
    if(bHasRagdoll && bMonsterHasBurnFX)
    {
        SpawnSparks();
    }
}

defaultproperties
{
     bCanLinkMonsters=True
     bSeekerHint=True
     SeekerLinkRange=1000.000000
     LinkedMonsterLimit=3
     SeekerHintIntervalTime=7.000000
     HeadSize=1.000000
     HintSound=Sound'tK_DoomMonsterPackv3.Seeker.SoulCubeSeekers'
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=12.000000
     RangedAttackIntervalTime=3.500000
     ProjectileDamage=15.000000
     NewHealth=120
     SpeciesName="Seeker"
     MeleeAnims(0)="Pain"
     MeleeAnims(1)="Pain"
     MeleeAnims(2)="Pain"
     MeleeAnims(3)="Pain"
     HitAnims(0)="Pain"
     HitAnims(1)="Pain"
     HitAnims(2)="Pain"
     HitAnims(3)="Pain"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="Sight"
     RangedAttackAnims(1)="Sight"
     RangedAttackAnims(2)="Sight"
     RangedAttackAnims(3)="Sight"
     FadeClass=Class'tK_DoomMonsterPackv3.Seeker_MaterialSequence'
     aimerror=10
     DodgeSkillAdjust=3.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Seeker.seeker1'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Seeker.seeker2'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Seeker.seeker2'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Seeker.seeker1'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Seeker.seeker_die1'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Seeker.seeker_die2'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Seeker.seeker_die3'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Seeker.seeker_die3'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Seeker.seeker3'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Seeker.seeker4'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Seeker.seeker4'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Seeker.seeker3'
     ScoringValue=5
     WallDodgeAnims(0)="Travel"
     WallDodgeAnims(1)="Travel"
     WallDodgeAnims(2)="Travel"
     WallDodgeAnims(3)="Travel"
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
     MeleeRange=300.000000
     GroundSpeed=400.000000
     AirSpeed=400.000000
     Health=120
     MovementAnims(0)="Travel"
     MovementAnims(1)="Travel"
     MovementAnims(2)="Travel"
     MovementAnims(3)="Travel"
     TurnLeftAnim="Travel"
     TurnRightAnim="Travel"
     SwimAnims(0)="Travel"
     SwimAnims(1)="Travel"
     SwimAnims(2)="Travel"
     SwimAnims(3)="Travel"
     CrouchAnims(0)="Travel"
     CrouchAnims(1)="Travel"
     CrouchAnims(2)="Travel"
     CrouchAnims(3)="Travel"
     WalkAnims(0)="Travel"
     WalkAnims(1)="Travel"
     WalkAnims(2)="Travel"
     WalkAnims(3)="Travel"
     AirAnims(0)="Travel"
     AirAnims(1)="Travel"
     AirAnims(2)="Travel"
     AirAnims(3)="Travel"
     TakeoffAnims(0)="Travel"
     TakeoffAnims(1)="Travel"
     TakeoffAnims(2)="Travel"
     TakeoffAnims(3)="Travel"
     LandAnims(0)="Travel"
     LandAnims(1)="Travel"
     LandAnims(2)="Travel"
     LandAnims(3)="Travel"
     DoubleJumpAnims(0)="Travel"
     DoubleJumpAnims(1)="Travel"
     DoubleJumpAnims(2)="Travel"
     DoubleJumpAnims(3)="Travel"
     DodgeAnims(0)="Travel"
     DodgeAnims(1)="Travel"
     DodgeAnims(2)="Travel"
     DodgeAnims(3)="Travel"
     AirStillAnim="Travel"
     TakeoffStillAnim="Travel"
     CrouchTurnRightAnim="Travel"
     CrouchTurnLeftAnim="Travel"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.SeekerMesh'
     PrePivot=(Z=-70.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Seeker.Seeker_Skin'
     CollisionRadius=30.000000
     CollisionHeight=50.000000
     Begin Object Class=KarmaParamsSkel Name=SeekerKParams
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
     KParams=KarmaParamsSkel'SeekerKParams'

}
