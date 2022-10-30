class Tick extends Doom_Monster config(DoomMonsters);

var() FinalBlend BurnFXTwo;
var() class<FinalBlend> BurnClassTwo;

simulated function Timer()
{
    bCanLunge = true;
    SetTimer(RandRange(4.00,12.00),false);
}

singular function Bump(actor Other)
{
    local name Anim;
    local float frame,rate;

    if ( bShotAnim && bLunging )
    {
        bCanLunge = true;
        bLunging = false;
        GetAnimParams(0, Anim,frame,rate);
        if ( Anim == 'Jump_Mid' )
        {
            MeleeAttack();
        }
    }
    Super.Bump(Other);
}

simulated function Landed(vector HitNormal)
{
    bLunging = false;
    Super.Landed(HitNormal);
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    SetTimer(RandRange(5.00,15.00),false);
}

function RangedAttack(Actor A)
{
    local float Dist;

    Super.RangedAttack(A);

    Dist = VSize(A.Location - Location);

    if(Dist > 350)
    {
        return;
    }
    else if(Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        SetAnimAction(MeleeAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if (Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        LastTauntTime = Level.TimeSeconds;
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        bShotAnim = true;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
    else if(!bLunging && bCanLunge)
    {
        bCanLunge = false;
        bLunging = true;
        Enable('Bump');
        SetAnimAction('Jump_Mid');
        bShotAnim = true;
        Velocity = 700 * Normal(A.Location + A.CollisionHeight * vect(0,0,0.75) - Location);
        if ( Dist > CollisionRadius + A.CollisionRadius + 35 )
        {
            Velocity.Z += 0.7 * Dist;
        }
        SetPhysics(PHYS_Falling);
    }
}

simulated function HideSkinEffects()
{
     Skins[0] = InvisMat;
}

simulated function FadeSkins()
{
    HideSkinEffects();
}

simulated function BurnAway()
{
    if(BurnFX != None && BurnFXTwo != None)
    {
        Skins[1] = BurnFXTwo;
        Skins[2] = BurnFX;
        bBurning = true;
    }
}

simulated function AllocateBurningObjects()
{
    if(BurnClass != None && BurnClassTwo != None)
    {
        BurnFX = FinalBlend(Level.ObjectPool.AllocateObject(BurnClass));
        BurnFXTwo = FinalBlend(Level.ObjectPool.AllocateObject(BurnClassTwo));

        if(BurnFX != None && BurnFXTwo != None)
        {
            bMonsterHasBurnFX = True;
            SetUpFinalBlend(BurnFX);
            SetUpFinalBlend(BurnFXTwo);
        }
    }
}

simulated function FreeBurningObjects()
{
    Super.FreeBurningObjects();

    if(BurnFXTwo != None)
    {
        Level.ObjectPool.FreeObject(BurnFXTwo);
        BurnFXTwo = None;
    }
}

State Dying
{
ignores AnimEnd, Trigger, Bump, HitWall, HeadVolumeChange, PhysicsVolumeChange, Falling, BreathTimer;

   function Landed(vector HitNormal)
    {
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
            if(BurnFX != None && BurnFXTwo != None)
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

                if(BurnFXTwo.AlphaRef != 255)
                {
                    BurnFXTwo.AlphaRef += BurnSpeed;
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
     BurnClassTwo=Class'tK_DoomMonsterPackv3.Tick_FinalBlend'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=10.000000
     NewHealth=70
     SpeciesName="Tick"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack1"
     MeleeAnims(3)="Attack2"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain03"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     BurnDustClass=Class'tK_DoomMonsterPackv3.Doom_Dust_Small'
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Tick.Tick_chirp1'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Tick.Tick_chirp2'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Tick.Tick_chirp3'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Tick.Tick_chirp4'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Tick.tick_walk1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Tick.tick_walk2'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Tick.tick_walk3'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Tick.tick_walk4'
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Tick.tick_pain1'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Tick.tick_pain2'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Tick.tick_pain3'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Tick.tick_pain4'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Tick.tick_death1'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Tick.tick_death2'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Tick.tick_death3'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Tick.tick_death3'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Tick.tick_sight2'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Tick.tick_sight3'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Tick.Tick_chirp5'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Tick.Tick_chirp6'
     ScoringValue=5
     WallDodgeAnims(0)="DodgeL"
     WallDodgeAnims(1)="DodgeR"
     WallDodgeAnims(2)="DodgeL"
     WallDodgeAnims(3)="DodgeR"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Idle"
     FireHeavyBurstAnim="Idle"
     FireRifleRapidAnim="Idle"
     FireRifleBurstAnim="Idle"
     MeleeRange=60.000000
     GroundSpeed=500.000000
     Health=70
     MovementAnims(0)="Walk1"
     MovementAnims(1)="Walk1"
     MovementAnims(2)="Walk1"
     MovementAnims(3)="Walk1"
     TurnLeftAnim="Walk2"
     TurnRightAnim="Walk2"
     SwimAnims(0)="Walk1"
     SwimAnims(1)="Walk1"
     SwimAnims(2)="Walk1"
     SwimAnims(3)="Walk1"
     CrouchAnims(0)="Walk3"
     CrouchAnims(1)="Walk3"
     CrouchAnims(2)="Walk3"
     CrouchAnims(3)="Walk3"
     WalkAnims(0)="Walk1"
     WalkAnims(1)="Walk1"
     WalkAnims(2)="Walk1"
     WalkAnims(3)="Walk1"
     AirAnims(0)="Jump_Mid"
     AirAnims(1)="Jump_Mid"
     AirAnims(2)="Jump_Mid"
     AirAnims(3)="Jump_Mid"
     TakeoffAnims(0)="Jump_Start"
     TakeoffAnims(1)="Jump_Start"
     TakeoffAnims(2)="Jump_Start"
     TakeoffAnims(3)="Jump_Start"
     LandAnims(0)="Jump_Start"
     LandAnims(1)="Jump_Start"
     LandAnims(2)="Jump_Start"
     LandAnims(3)="Jump_Start"
     DoubleJumpAnims(0)="Jump_Start"
     DoubleJumpAnims(1)="Jump_Start"
     DoubleJumpAnims(2)="Jump_Start"
     DoubleJumpAnims(3)="Jump_Start"
     DodgeAnims(0)="DodgeL"
     DodgeAnims(1)="DodgeR"
     DodgeAnims(2)="DodgeL"
     DodgeAnims(3)="DodgeR"
     AirStillAnim="Jump_Mid"
     TakeoffStillAnim="Jump_Start"
     CrouchTurnRightAnim="Walk3"
     CrouchTurnLeftAnim="Walk3"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.TickMesh'
     DrawScale=1.800000
     PrePivot=(Z=-35.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Tick.Tick_Leg_Shader'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Tick.Tick_Skin'
     CollisionRadius=40.000000
     CollisionHeight=30.000000
     Begin Object Class=KarmaParamsSkel Name=TickKParams
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
     KParams=KarmaParamsSkel'TickKParams'

}
