class Maledict extends Doom_Monster config(DoomMonsters);

var() config bool bMaledictCanSummon;
var() config float BigMeteorDamage;
var() config float SmallMeteorDamage;
var() config float FireWallDamage;
var() config float ForgottenSummonIntervalTime;
var() config int ForgottenSpawnLimit;

var() Name GlideAnims[4];

var() int MonsterCounter;

var() float LastSummonTime;
var() float LastChargeSoundTime;
var() float ChargeSoundIntervalTime;
var() float LastFlapTime;
var() bool bAttacking;
var() Sound AsteroidSpawnSounds[2];
var() Sound OtherSpawnSpawns[4];
var() Sound ChargeSound[2];

function SetMovementPhysics()
{
    SetPhysics(PHYS_Flying);
}

singular function Falling()
{
    SetPhysics(PHYS_Flying);
}

function PlayChargeSound()
{
    if(Level.TimeSeconds - LastChargeSoundTime > ChargeSoundIntervalTime)
    {
        LastChargeSoundTime = Level.TimeSeconds;
        PlaySound(ChargeSound[Rand(2)],SLOT_Talk,8,,,,);
    }
}

function SpawnBigMeteor()
{
    local vector X, Y, Z, SpawnOffSet, FireStart;

    if(Controller != None)
    {
        GetAxes(Rotation,X,Y,Z);
        SpawnOffSet = X;
        FireStart = location + 100 * SpawnOffSet;
        if(fRand() > 0.5)
        {
            Spawn(ProjectileClass[1],self,,FireStart,Controller.AdjustAim(SavedFireProperties,FireStart,AimError));
        }
        else
        {
            Spawn(class'Maledict_ProjectileFirewall',self,,FireStart,Controller.AdjustAim(SavedFireProperties,FireStart,AimError));
        }
    }
}

function SummonMeteors()
{
    local vector X, Y, Z, SpawnOffSet, FireStart;
    local int i;

    if(Controller != None)
    {
        GetAxes(Rotation,X,Y,Z);
        SpawnOffSet = X;
        if(Rand(2) == 1)
        {
            Y *= -1;
        }

        for(i=0;i<6;i++)
        {
            FireStart = location + 100 * SpawnOffSet + ((10 * Rand(10)) * Y) + ((10 * Rand(10)) * Z);
            Spawn(ProjectileClass[0],self,,FireStart,Controller.AdjustAim(SavedFireProperties,FireStart,AimError));
        }
    }
}

function SummonSouls()
{
    local vector X, Y, Z, SpawnOffSet;
    local int i;
    local Forgotten F;

    if(Controller != None)
    {
        LastSummonTime = Level.TimeSeconds;
        GetAxes(Rotation,X,Y,Z);
        SpawnOffSet = X;
        if(Rand(2) == 1)
        {
            Y *= -1;
        }

        for(i=0;i<2;i++)
        {
            if(MonsterCounter < ForgottenSpawnLimit)
            {
                F = Spawn(class'Forgotten_Weak',self,,location + 100 * SpawnOffSet + ((10 * Rand(10)) * Y) + ((10 * Rand(10)) * Z),Rotation);
                if(F != None)
                {
                    if(Invasion(Level.Game) != None)
                    {
                        Invasion(Level.Game).NumMonsters++;
                    }

                    MonsterCounter++;
                }
            }
        }
    }
}

function RangedAttack(Actor A)
{
    local float Dist;

    if(bShotAnim || A == None || Controller == None)
    {
        return;
    }

    Dist = VSize(A.Location - Location);

    if ( Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction(MeleeAnims[Rand(4)]);
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        if(bMaledictCanSummon && MonsterCounter < ForgottenSpawnLimit && Level.TimeSeconds - LastSummonTime > ForgottenSummonIntervalTime)
        {
            SetAnimAction(RangedAttackAnims[Rand(4)]);
        }
        else
        {
            SetAnimAction(RangedAttackAnims[Rand(3)]);
        }

        bShotAnim = true;
    }
    else if(Dist > 700)
    {
        Controller.Destination = A.Location;
        bShotAnim = true;
        Acceleration = vect(0,0,0);
        Velocity *= 500;
        SetAnimAction(GlideAnims[Rand(4)]);
    }
}

event GainedChild(Actor Other)
{
    if(bUseDamageConfig)
    {
        if(Other.Class == ProjectileClass[1])
        {
            Projectile(Other).Damage = BigMeteorDamage;
        }
        else if(Other.Class == ProjectileClass[0])
        {
            Projectile(Other).Damage = SmallMeteorDamage;
        }
        else if(Other.Class == class'Maledict_ProjectileFirewall')
        {
            Projectile(Other).Damage = FireWallDamage;
        }
    }

    Super(Monster).GainedChild(Other);
}

simulated function HideSkinEffects()
{
     Skins[1] = InvisMat;
     Skins[2] = InvisMat;
     Skins[3] = InvisMat;
}

simulated function FadeSkins()
{
    HideSkinEffects();
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[0] = BurnFX;
        Skins[4] = BurnFX;
        bBurning = true;
    }
}

simulated function Tick(float DeltaTime)
{
    Super.Tick(DeltaTime);

    if(Role==Role_Authority)
    {
        if(!bShotAnim && (AnimAction == 'None' || AnimAction == '') && Physics == PHYS_Flying && MonsterController(Controller) != None)
        {
            if(MonsterController(Controller).GoalString ~= "FAILED HUNT - HANG OUT" || Left(MonsterController(Controller).GoalString, 19) ~= "WhatToDoNext Wander")
            {
                if(Level.TimeSeconds - LastFlapTime > 0.2)
                {
                    SetAnimAction('FlapNormal');
                    LastFlapTime = Level.TimeSeconds;
                }
            }
        }
    }
}

defaultproperties
{
     bMaledictCanSummon=True
     BigMeteorDamage=20.000000
     SmallMeteorDamage=12.000000
     FireWallDamage=5.000000
     ForgottenSummonIntervalTime=5.000000
     ForgottenSpawnLimit=4
     GlideAnims(0)="Sight"
     GlideAnims(1)="Glide02"
     GlideAnims(2)="Glide01"
     GlideAnims(3)="FlapFast"
     ChargeSoundIntervalTime=4.000000
     AsteroidSpawnSounds(0)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_fire_05'
     AsteroidSpawnSounds(1)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_fire_02'
     OtherSpawnSpawns(0)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_firestarter_01'
     OtherSpawnSpawns(1)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_firestarter_02'
     OtherSpawnSpawns(2)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_firestarter_03'
     OtherSpawnSpawns(3)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_firestarter_04'
     ChargeSound(0)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_whoosh_01'
     ChargeSound(1)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_whoosh_02'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=16.000000
     RangedAttackIntervalTime=2.000000
     NewHealth=500
     SpeciesName="Maledict"
     MeleeAnims(0)="MeleeAttack01"
     MeleeAnims(1)="MeleeAttack01"
     MeleeAnims(2)="MeleeAttack01"
     MeleeAnims(3)="MeleeAttack01"
     HitAnims(0)="Pain"
     HitAnims(1)="Pain"
     HitAnims(2)="Pain"
     HitAnims(3)="Pain"
     DeathAnims(0)="DeathB"
     DeathAnims(1)="DeathF"
     DeathAnims(2)="DeathB"
     DeathAnims(3)="DeathF"
     TauntAnim="Sight"
     RangedAttackAnims(0)="Summon"
     RangedAttackAnims(1)="Attack01"
     RangedAttackAnims(2)="Summon"
     RangedAttackAnims(3)="SummonForgotten"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Maledict_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Maledict_ProjectileBig'
     BurnClass=Class'tK_DoomMonsterPackv3.Maledict_FinalBlend'
     BurnAnimTime=0.500000
     aimerror=100
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_whoosh_01'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_whoosh_02'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_whoosh_01'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_whoosh_02'
     bMeleeFighter=False
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_05'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_05'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_05'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_05'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_10'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_14'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_18'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_19'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_Scream_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_04'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_07'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_scream_09'
     ScoringValue=15
     WallDodgeAnims(0)="FlapFast"
     WallDodgeAnims(1)="FlapFast"
     WallDodgeAnims(2)="FlapFast"
     WallDodgeAnims(3)="FlapFast"
     IdleHeavyAnim="FlapNormal"
     IdleRifleAnim="FlapNormal"
     FireHeavyRapidAnim="FlapFast"
     FireHeavyBurstAnim="FlapFast"
     FireRifleRapidAnim="FlapFast"
     FireRifleBurstAnim="FlapFast"
     bCanWalk=False
     bCanFly=True
     bCanStrafe=False
     MeleeRange=200.000000
     GroundSpeed=700.000000
     AirSpeed=500.000000
     Health=500
     MovementAnims(0)="FlapNormal"
     MovementAnims(1)="FlapNormal"
     MovementAnims(2)="FlapNormal"
     MovementAnims(3)="FlapNormal"
     TurnLeftAnim="FlapNormal"
     TurnRightAnim="FlapNormal"
     SwimAnims(0)="FlapNormal"
     SwimAnims(1)="FlapNormal"
     SwimAnims(2)="FlapNormal"
     SwimAnims(3)="FlapNormal"
     CrouchAnims(0)="FlapNormal"
     CrouchAnims(1)="FlapNormal"
     CrouchAnims(2)="FlapNormal"
     CrouchAnims(3)="FlapNormal"
     WalkAnims(0)="FlapNormal"
     WalkAnims(1)="FlapNormal"
     WalkAnims(2)="FlapNormal"
     WalkAnims(3)="FlapNormal"
     AirAnims(0)="FlapNormal"
     AirAnims(1)="FlapNormal"
     AirAnims(2)="FlapNormal"
     AirAnims(3)="FlapNormal"
     TakeoffAnims(0)="FlapNormal"
     TakeoffAnims(1)="FlapNormal"
     TakeoffAnims(2)="FlapNormal"
     TakeoffAnims(3)="FlapNormal"
     LandAnims(0)="FlapNormal"
     LandAnims(1)="FlapNormal"
     LandAnims(2)="FlapNormal"
     LandAnims(3)="FlapNormal"
     DoubleJumpAnims(0)="FlapFast"
     DoubleJumpAnims(1)="FlapFast"
     DoubleJumpAnims(2)="FlapFast"
     DoubleJumpAnims(3)="FlapFast"
     DodgeAnims(0)="FlapNormal"
     DodgeAnims(1)="FlapNormal"
     DodgeAnims(2)="FlapNormal"
     DodgeAnims(3)="FlapNormal"
     AirStillAnim="FlapNormal"
     TakeoffStillAnim="FlapNormal"
     CrouchTurnRightAnim="FlapNormal"
     CrouchTurnLeftAnim="FlapNormal"
     IdleCrouchAnim="FlapNormal"
     IdleSwimAnim="FlapNormal"
     IdleWeaponAnim="FlapNormal"
     IdleRestAnim="FlapNormal"
     IdleChatAnim="FlapNormal"
     AmbientSound=Sound'tK_DoomMonsterPackv3.LostSoul.LostSoul_idle_01'
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.MaledictMesh'
     DrawScale=0.700000
     PrePivot=(X=-30.000000)
     Skins(0)=Shader'tK_DoomMonsterPackv3.Maledict.Maledict_Skin_Shader'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(3)=Shader'tK_DoomMonsterPackv3.Maledict.Maledict_Teeth_Shader'
     Skins(4)=Shader'tK_DoomMonsterPackv3.Maledict.MaledictSkullShader'
     CollisionRadius=60.000000
     CollisionHeight=50.000000
     Begin Object Class=KarmaParamsSkel Name=MaledictKParams
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
     KParams=KarmaParamsSkel'MaledictKParams'

}
