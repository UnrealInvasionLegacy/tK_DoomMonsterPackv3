class Forgotten extends Doom_Monster config(DoomMonsters);

var() Emitter Trail;
var() Sound ChargeSound;
var() float LastChargeSoundTime;
var() float ChargeSoundIntervalTime;
var() Name ChargeAnims[2];
var() float OriginalAirSpeed;
var() float LastChargeTime;
var() float ChargeIntervalTime;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
    {
        Trail = Spawn(class'Forgotten_TrailEffect', self);
            AttachToBone(Trail, 'headflame');
    }

    OriginalAirSpeed = AirSpeed;
}

function SetMovementPhysics()
{
    SetPhysics(PHYS_Flying);
}

singular function Falling()
{
    SetPhysics(PHYS_Flying);
}

simulated function PlayChargeSound()
{
    if(Level.TimeSeconds - LastChargeSoundTime> ChargeSoundIntervalTime)
    {
        LastChargeSoundTime = Level.TimeSeconds;
        PlaySound(ChargeSound,SLOT_Talk,8,,,,);
    }
}

function RangedAttack(Actor A)
{
    local float Dist;

    Super.RangedAttack(A);

    Dist = VSize(A.Location - Location);

    if(Dist > MeleeRange + 250 && Dist < 1000 && Level.TimeSeconds - LastChargeTime > ChargeIntervalTime)
    {
        LastChargeTime = Level.TimeSeconds;
        AirSpeed = 1000;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
        SetAnimAction(ChargeAnims[Rand(2)]);
    }
    else if ( Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        AirSpeed = OriginalAirSpeed;
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
        AirSpeed = OriginalAirSpeed;
    }
    else
    {
        AirSpeed = OriginalAirSpeed;
    }
}

simulated function HideSkinEffects()
{
     Skins[1] = InvisMat;
     Skins[2] = InvisMat;
}

simulated function RemoveEffects()
{
    if(Trail != None)
    {
        Trail.Kill();
    }

    Super.RemoveEffects();
}

simulated function FadeSkins()
{
    if(FadeFX != None)
    {
        FadeFX.Reset();
        Skins[0] = FadeFX;
        HideSkinEffects();
    }
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[0] = BurnFX;
        bBurning = true;
    }
}

simulated function AllocateBurningObjects()
{
    if(bHasRagdoll)
    {
        Super.AllocateBurningObjects();
    }
}

simulated function FallBackDeath(vector HitLoc)
{
    bHidden = true;
    Spawn(class'Forgotten_Explosion', self, , Location);
}

defaultproperties
{
     ChargeSound=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_sight_01'
     ChargeSoundIntervalTime=4.000000
     ChargeAnims(0)="Charge"
     ChargeAnims(1)="Charge2"
     ChargeIntervalTime=3.000000
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=12.000000
     NewHealth=50
     SpeciesName="Forgotten"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack1"
     MeleeAnims(3)="Attack2"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain01"
     HitAnims(3)="Pain02"
     DeathAnims(0)="Pain02"
     DeathAnims(1)="Pain02"
     DeathAnims(2)="Pain02"
     DeathAnims(3)="Pain02"
     TauntAnim="Sight"
     FadeClass=Class'tK_DoomMonsterPackv3.Forgotten_MaterialSequence'
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_chomp_01'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_chomp_02'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_chomp_03'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_chomp_01'
     bCanDodge=False
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_pain_03'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_pain_04'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_pain_03'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_pain_04'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_death_01'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_death_05'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_death_01'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_death_05'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_sight_02'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_sight_03'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_idle_01'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_idle_03'
     ScoringValue=5
     WallDodgeAnims(0)="Idle"
     WallDodgeAnims(1)="Idle"
     WallDodgeAnims(2)="Idle"
     WallDodgeAnims(3)="Idle"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Idle"
     FireHeavyBurstAnim="Idle"
     FireRifleRapidAnim="Idle"
     FireRifleBurstAnim="Idle"
     bCanFly=True
     bCanStrafe=False
     MeleeRange=40.000000
     GroundSpeed=400.000000
     AirSpeed=400.000000
     Health=50
     MovementAnims(0)="Idle"
     MovementAnims(1)="Idle"
     MovementAnims(2)="Idle"
     MovementAnims(3)="Idle"
     TurnLeftAnim="Idle"
     TurnRightAnim="Idle"
     SwimAnims(0)="Idle"
     SwimAnims(1)="Idle"
     SwimAnims(2)="Idle"
     SwimAnims(3)="Idle"
     CrouchAnims(0)="Idle"
     CrouchAnims(1)="Idle"
     CrouchAnims(2)="Idle"
     CrouchAnims(3)="Idle"
     WalkAnims(0)="Idle"
     WalkAnims(1)="Idle"
     WalkAnims(2)="Idle"
     WalkAnims(3)="Idle"
     AirAnims(0)="Idle"
     AirAnims(1)="Idle"
     AirAnims(2)="Idle"
     AirAnims(3)="Idle"
     TakeoffAnims(0)="Idle"
     TakeoffAnims(1)="Idle"
     TakeoffAnims(2)="Idle"
     TakeoffAnims(3)="Idle"
     LandAnims(0)="Idle"
     LandAnims(1)="Idle"
     LandAnims(2)="Idle"
     LandAnims(3)="Idle"
     DoubleJumpAnims(0)="Idle"
     DoubleJumpAnims(1)="Idle"
     DoubleJumpAnims(2)="Idle"
     DoubleJumpAnims(3)="Idle"
     DodgeAnims(0)="Idle"
     DodgeAnims(1)="Idle"
     DodgeAnims(2)="Idle"
     DodgeAnims(3)="Idle"
     AirStillAnim="Idle"
     TakeoffStillAnim="Idle"
     CrouchTurnRightAnim="Idle"
     CrouchTurnLeftAnim="Idle"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     AmbientSound=Sound'tK_DoomMonsterPackv3.Forgotten.Forgotten_flight_02a'
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.ForgottenMesh'
     DrawScale=2.500000
     PrePivot=(Z=-20.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Forgotten.Forgotten_Skin'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Forgotten.Forgotten_Flames_Shader'
     Skins(2)=FinalBlend'tK_DoomMonsterPackv3.Forgotten.Forgotten_Skin_FinalBlend'
     CollisionHeight=25.000000
     Begin Object Class=KarmaParamsSkel Name=ForgottenKParams
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
     KParams=KarmaParamsSkel'ForgottenKParams'

}
