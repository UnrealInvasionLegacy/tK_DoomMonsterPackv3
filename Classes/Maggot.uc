class Maggot extends Doom_Monster config(DoomMonsters);

var() Sound LonelySound[2];
var() Sound Snorts[8];
var() Sound RandomDodgeSound[2];

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    if(Role == Role_Authority)
    {
        SetTimer(RandRange(5.00,15.00),false);
    }
}

Auto State UpdateAnims
{
    simulated function ChangeRunAnim()
    {
        local int i;

        for(i=0;i<4;i++)
        {
            MovementAnims[i] = 'Run';
        }

        TurnRightAnim = 'Run';
        TurnLeftAnim = 'Run';
    }

    simulated function DefaultRunAnim()
    {
        local int i;

        for(i=0;i<4;i++)
        {
            MovementAnims[i] = default.MovementAnims[i];
        }

        TurnRightAnim = default.TurnRightAnim;
        TurnLeftAnim = default.TurnLeftAnim;
    }

    Begin:
        Sleep(Rand(12));
            ChangeRunAnim();
        Sleep(Rand(3));
            DefaultRunAnim();
        GoTo('Begin');
}

function Timer()
{
    PlaySound(LonelySound[Rand(2)], SLOT_Misc,8);
    SetTimer(RandRange(4.00,12.00),false);
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
}

simulated function HideSkinEffects()
{
     Skins[0] = InvisMat;
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
    }
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[0] = InvisMat;
        Skins[1] = InvisMat;
        Skins[2] = BurnFX;
        Skins[3] = InvisMat;
        bBurning = true;
    }
}

defaultproperties
{
     LonelySound(0)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_distant_screams_01'
     LonelySound(1)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_distant_screams_03'
     Snorts(0)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_melee1'
     Snorts(1)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_melee4'
     Snorts(2)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_melee2'
     Snorts(3)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_melee1h2'
     Snorts(4)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_melee3'
     Snorts(5)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_melee3h2'
     Snorts(6)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_melee2h2'
     Snorts(7)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_melee4h2'
     RandomDodgeSound(0)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_evade_right'
     RandomDodgeSound(1)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_evade_left'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=16.000000
     NewHealth=80
     SpeciesName="Maggot"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack_Tongue"
     MeleeAnims(3)="Attack_Tongue"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain01"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     FadeClass=Class'tK_DoomMonsterPackv3.Maggot_MaterialSequence'
     BurnAnimTime=0.250000
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_attack_01'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_attack_03'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_attack_01'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_attack_03'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_fs_01'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_fs_02'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_fs_01'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_fs_02'
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_pain_02'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_pain_04'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_pain_05'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_pain_05'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_death_01'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_death_02'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_death_03'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_death_04'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_idle_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_sight_01'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_hiss3h2'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Maggot.Maggot_idle_03'
     ScoringValue=8
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
     MeleeRange=80.000000
     GroundSpeed=500.000000
     Health=80
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
     AirAnims(0)="Lunge"
     AirAnims(1)="Lunge"
     AirAnims(2)="Lunge"
     AirAnims(3)="Lunge"
     TakeoffAnims(0)="Jump_Start"
     TakeoffAnims(1)="Jump_Start"
     TakeoffAnims(2)="Jump_Start"
     TakeoffAnims(3)="Jump_Start"
     LandAnims(0)="Jump_End"
     LandAnims(1)="Jump_End"
     LandAnims(2)="Jump_End"
     LandAnims(3)="Jump_End"
     DoubleJumpAnims(0)="Jump_Start"
     DoubleJumpAnims(1)="Jump_Start"
     DoubleJumpAnims(2)="Jump_Start"
     DoubleJumpAnims(3)="Jump_Start"
     DodgeAnims(0)="DodgeL"
     DodgeAnims(1)="DodgeR"
     DodgeAnims(2)="DodgeL"
     DodgeAnims(3)="DodgeR"
     AirStillAnim="Lunge"
     TakeoffStillAnim="Jump_Start"
     CrouchTurnRightAnim="Walk"
     CrouchTurnLeftAnim="Walk"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.MaggotMesh'
     DrawScale=1.400000
     PrePivot=(X=-10.000000,Z=-40.000000)
     Skins(0)=Shader'tK_DoomMonsterPackv3.Maggot.Maggot_Spine_Shader'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Maggot.Maggot_Tongue_Shader'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Maggot.Maggot_Skin'
     Skins(3)=Shader'tK_DoomMonsterPackv3.Maggot.Maggot_Eye_Shader'
     CollisionRadius=30.000000
     CollisionHeight=38.000000
     Begin Object Class=KarmaParamsSkel Name=MaggotKParams
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
     KParams=KarmaParamsSkel'MaggotKParams'

}
