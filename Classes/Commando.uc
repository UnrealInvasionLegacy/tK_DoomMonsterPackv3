class Commando extends Doom_Monster config(DoomMonsters);

var() Sound RandomTaunts[8];
var() Sound MeleeSound[5];
var() Name RangedMelee[3];
var() int NormalMeleeRange;
var() MaterialSequence FadeFXTentacle;
var() class<MaterialSequence> FadeTentacleClass;

simulated function Timer()
{
    PlaySound(RandomTaunts[Rand(8)], SLOT_Interact, 8);
    Super.Timer();
    SetTimer(RandRange(5.00,20.00),false);
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

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    SetTimer(RandRange(5.00,12.00),false);
}

function RangedAttack(Actor A)
{
    local float Dist;

    Super.RangedAttack(A);

    Dist = VSize(A.Location - Location);

    if(Dist < NormalMeleeRange + CollisionRadius + A.CollisionRadius )
    {
        PlaySound(MeleeSound[Rand(5)], SLOT_Talk);
        SetAnimAction(MeleeAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if(Dist < MeleeRange + CollisionRadius + A.CollisionRadius && Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        PlaySound(MeleeSound[Rand(5)], SLOT_Talk);
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if (Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
        bShotAnim = true;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
}

simulated function HideSkinEffects()
{
     Skins[2] = InvisMat;
     Skins[3] = InvisMat;
}

simulated function FadeSkins()
{
    if(FadeFX != None && FadeFXTentacle != None)
    {
        FadeFX.Reset();
        FadeFXTentacle.Reset();
        Skins[0] = FadeFX;
        Skins[1] = FadeFXTentacle;
        HideSkinEffects();
    }
}

simulated function AllocateBurningObjects()
{
    if(BurnClass != None && FadeClass != None && FadeTentacleClass != None)
    {
        BurnFX = FinalBlend(Level.ObjectPool.AllocateObject(BurnClass));
        FadeFX = MaterialSequence(Level.ObjectPool.AllocateObject(FadeClass));
        FadeFXTentacle = MaterialSequence(Level.ObjectPool.AllocateObject(FadeTentacleClass));

        if(BurnFX != None && FadeFX != None && FadeFXTentacle != None)
        {
            bMonsterHasBurnFX = True;
            SetUpFinalBlend(BurnFX);
        }
    }
}

simulated function FreeBurningObjects()
{
    Super.FreeBurningObjects();

    if(FadeFXTentacle != None)
    {
        Level.ObjectPool.FreeObject(FadeFXTentacle);
        FadeFXTentacle = None;
    }
}

defaultproperties
{
     RandomTaunts(0)=Sound'tK_DoomMonsterPackv3.Commando.combat_04'
     RandomTaunts(1)=Sound'tK_DoomMonsterPackv3.Commando.combat_03'
     RandomTaunts(2)=Sound'tK_DoomMonsterPackv3.Commando.combat_04'
     RandomTaunts(3)=Sound'tK_DoomMonsterPackv3.Commando.combat_05'
     RandomTaunts(4)=Sound'tK_DoomMonsterPackv3.Commando.site2'
     RandomTaunts(5)=Sound'tK_DoomMonsterPackv3.Commando.site2'
     RandomTaunts(6)=Sound'tK_DoomMonsterPackv3.Commando.site3_you'
     RandomTaunts(7)=Sound'tK_DoomMonsterPackv3.Commando.site6_die'
     MeleeSound(0)=Sound'tK_DoomMonsterPackv3.Commando.melee1_1'
     MeleeSound(1)=Sound'tK_DoomMonsterPackv3.Commando.melee2_1'
     MeleeSound(2)=Sound'tK_DoomMonsterPackv3.Commando.melee3_1'
     MeleeSound(3)=Sound'tK_DoomMonsterPackv3.Commando.melee2_1'
     MeleeSound(4)=Sound'tK_DoomMonsterPackv3.Commando.melee1_1'
     NormalMeleeRange=60
     FadeTentacleClass=Class'tK_DoomMonsterPackv3.Commando_Tentacle_MaterialSequence'
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=10.000000
     RangedAttackIntervalTime=2.000000
     NewHealth=150
     SpeciesName="Commando"
     MeleeAnims(0)="MeleeAttack01"
     MeleeAnims(1)="MeleeAttack02"
     MeleeAnims(2)="MeleeAttack03"
     MeleeAnims(3)="MeleeAttack04"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="RangedMelee01"
     RangedAttackAnims(1)="RangedMelee02"
     RangedAttackAnims(2)="RangedMelee01"
     RangedAttackAnims(3)="RangedMelee02"
     FadeClass=Class'tK_DoomMonsterPackv3.Commando_MaterialSequence'
     BurnAnimTime=0.150000
     MissSound(0)=Sound'tK_DoomMonsterPackv3.Commando.whoosh1_deep'
     MissSound(1)=Sound'tK_DoomMonsterPackv3.Commando.whoosh11_light'
     MissSound(2)=Sound'tK_DoomMonsterPackv3.Commando.whoosh11_light'
     MissSound(3)=Sound'tK_DoomMonsterPackv3.Commando.whoosh1_deep'
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Commando.squish10_impact'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Commando.squish11_impact'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Commando.squish12_impact'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Commando.squish14_impact'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step2'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step3'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step4'
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Commando.pain3'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Commando.pain2'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Commando.pain3'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Commando.pain4'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Commando.death1'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Commando.Death2'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Commando.Death3'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Commando.Death4'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Commando.combat_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Commando.combat_03'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Commando.combat_04'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Commando.combat_05'
     ScoringValue=8
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
     MeleeRange=250.000000
     GroundSpeed=600.000000
     Health=150
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
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.CommandoMesh'
     DrawScale=1.200000
     PrePivot=(Z=-57.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Commando.Commando_Skin'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Commando.Commando_Tentacle_Skin'
     Skins(2)=Shader'tK_DoomMonsterPackv3.Commando.Commando_Teeth_Shader'
     Skins(3)=Shader'tK_DoomMonsterPackv3.Commando.Commando_Eye_Shader'
     CollisionHeight=52.000000
     Begin Object Class=KarmaParamsSkel Name=CommandoKParams
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
     KParams=KarmaParamsSkel'CommandoKParams'

}
