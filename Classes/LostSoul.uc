class LostSoul extends Doom_Monster config(DoomMonsters);

var() Emitter LostTrail;
var() Sound ChargeSound;
var() float LastChargeSound;
var() float ChargeSoundIntervalTime;
var() float OriginalAirSpeed;
var() float LastChargeTime;
var() float ChargeIntervalTime;

simulated function PostBeginPlay()
{
    local Rotator Rot;
    local vector Vec;

    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
    {
        Rot.Roll = -16384;
        Vec.X = -5;
        LostTrail = Spawn(class'LostSoul_TrailEffect', self);
        AttachToBone(LostTrail, 'LostFlame');
        LostTrail.SetRelativeRotation(Rot);
        LostTrail.SetRelativeLocation(Vec);
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
    Spawn(class'LostSoul_Explosion', self, , Location);
    Spawn(class'LostSoul_ExplodeDust',self,,Location);
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
        SetAnimAction('Charge');
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
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
        AirSpeed = OriginalAirSpeed;
    }
    else
    {
        AirSpeed = OriginalAirSpeed;
        Controller.bPreparingMove = true;
        bShotAnim = true;
        Acceleration = vect(0,0,0);
    }
}

simulated function HideSkinEffects()
{
     Skins[0] = InvisMat;
     Skins[2] = InvisMat;
}

simulated function RemoveEffects()
{
    if(LostTrail != None)
    {
        LostTrail.Kill();
    }

    Super.RemoveEffects();
}

simulated function FadeSkins()
{
    if(FadeFX != None)
    {
        FadeFX.Reset();
        Skins[1] = FadeFX;
        HideSkinEffects();
    }
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[1] = BurnFX;
        bBurning = true;
    }
}

defaultproperties
{
     ChargeSound=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_charge_01'
     ChargeSoundIntervalTime=4.000000
     ChargeIntervalTime=3.000000
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=12.000000
     NewHealth=50
     SpeciesName="LostSoul"
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
     FadeClass=Class'tK_DoomMonsterPackv3.LostSoul_MaterialSequence'
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_attack_02'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_attack_02'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_attack_02'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_attack_02'
     bCanDodge=False
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_pain_01'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_pain_02'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_pain_01'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_pain_02'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_death_01'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_death_02'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_death_04'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_death_04'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_chatter_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_chatter_02'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_sight_02'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_sight_03'
     ScoringValue=5
     WallDodgeAnims(0)="Walk"
     WallDodgeAnims(1)="Walk"
     WallDodgeAnims(2)="Walk"
     WallDodgeAnims(3)="Walk"
     IdleHeavyAnim="Walk"
     IdleRifleAnim="Walk"
     FireHeavyRapidAnim="Walk"
     FireHeavyBurstAnim="Walk"
     FireRifleRapidAnim="Walk"
     FireRifleBurstAnim="Walk"
     bCanFly=True
     bCanStrafe=False
     MeleeRange=40.000000
     GroundSpeed=400.000000
     AirSpeed=400.000000
     Health=50
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
     IdleCrouchAnim="Walk"
     IdleSwimAnim="Walk"
     IdleWeaponAnim="Walk"
     IdleRestAnim="Walk"
     IdleChatAnim="Walk"
     AmbientSound=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_idle_01'
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.LostSoulMesh'
     DrawScale=2.500000
     PrePivot=(Z=0.000000)
     Skins(0)=Shader'tK_DoomMonsterPackv3.Lost.LostSoul_Teeth_Shader'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Lost.LostSoul_Skin'
     Skins(2)=Shader'tK_DoomMonsterPackv3.Lost.LostSoul_FXShader'
     CollisionHeight=25.000000
     Begin Object Class=KarmaParamsSkel Name=LostSoulKParams
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
     KParams=KarmaParamsSkel'LostSoulKParams'

}
