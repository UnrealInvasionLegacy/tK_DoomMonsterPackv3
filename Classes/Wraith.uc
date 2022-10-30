class Wraith extends Doom_Monster config(DoomMonsters);

var() Sound TeleportIn;
var() Sound TeleportOut;
var() config bool bWraithCanTeleport;
var() config float TeleportIntervalTime;

var() FinalBlend BurnFXTwo;
var() class<FinalBlend> BurnClassTwo;

simulated function SpawnTeleEffects(vector OldLoc, vector NewLoc)
{
    local xEmitter xBeam;

    xBeam = Spawn(class'Wraith_PortalBeam',self,,OldLoc,);
    xBeam.mSpawnVecA = NewLoc;
    Spawn(class'Wraith_PortalFlare',self,,OldLoc,);
    Spawn(class'Wraith_Portal',self,,NewLoc,);
}

function RangedAttack(Actor A)
{
    local float Dist;
    local vector OldLocation, DesiredLocation;

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
        LastTauntTime = Level.TimeSeconds;
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if(bWraithCanTeleport && Dist > 650 && Level.TimeSeconds - LastTeleportTime > TeleportIntervalTime)
    {
        LastTeleportTime = Level.TimeSeconds;
        OldLocation = Location;

        if(Health > (default.Health/10))
        {
            DesiredLocation = GetTeleLocation(OldLocation, Controller.Target.Location);
        }
        else
        {
            DesiredLocation = GetTeleLocation(OldLocation,Location);
        }

        if(DesiredLocation != vect(0,0,0))
        {
            if(SetLocation(DesiredLocation))
            {
                Controller.Destination = A.Location;
                SpawnTeleEffects(OldLocation,Location);
                PlaySound(TeleportOut, SLOT_Interact);
                SetAnimAction(TauntAnim);
                Controller.Destination = A.Location;
                Controller.bPreparingMove = true;
                Acceleration = vect(0,0,0);
                bShotAnim = true;
            }
        }
    }
}

simulated function HideSkinEffects()
{
     Skins[1] = InvisMat;
}

simulated function FadeSkins()
{
    HideSkinEffects();
}

simulated function BurnAway()
{
    if(BurnFX != None && BurnFXTwo != None)
    {
        Skins[2] = BurnFX;
        Skins[1] = BurnFXTwo;
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
     TeleportIn=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_teleport_in_01'
     TeleportOut=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_teleport_out_01'
     bWraithCanTeleport=True
     TeleportIntervalTime=2.200000
     BurnClassTwo=Class'tK_DoomMonsterPackv3.Wraith_Wing_FinalBlend'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=20.000000
     NewHealth=180
     SpeciesName="Wraith"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack3"
     MeleeAnims(3)="Attack2"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain01"
     HitAnims(3)="Pain03"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     BurnAnimTime=0.250000
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_Attack1'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_Attack2'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_Attack3'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_Attack1'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_footstep1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_footstep2'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_footstep3'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_footstep4'
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_Pain'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_Pain_Chest'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_pain_left_arm'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_pain_right_arm'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_Death'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_death_04'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_death_03'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_death_02'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_chatter1'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_chatter2'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_chatter3'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Wraith.Wraith_chatter4'
     ScoringValue=15
     WallDodgeAnims(0)="DodgeL"
     WallDodgeAnims(1)="DodgeR"
     WallDodgeAnims(2)="DodgeL"
     WallDodgeAnims(3)="DodgeR"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=40.000000
     GroundSpeed=550.000000
     AirSpeed=100.000000
     Health=180
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
     DodgeAnims(0)="DodgeL"
     DodgeAnims(1)="DodgeR"
     DodgeAnims(2)="DodgeL"
     DodgeAnims(3)="DodgeR"
     AirStillAnim="Run"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.WraithMesh'
     DrawScale=1.300000
     PrePivot=(Z=-30.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Wraith.Wraith_Wing_Shader'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Wraith.Wraith_Skin'
     CollisionRadius=30.000000
     CollisionHeight=30.000000
     Begin Object Class=KarmaParamsSkel Name=WraithKParams
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
     KParams=KarmaParamsSkel'WraithKParams'

}
