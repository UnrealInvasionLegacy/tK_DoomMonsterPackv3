class Archvile extends Doom_Monster config(DoomMonsters);

var() float LastFireWallTime;
var() float LastSummonTime;
var() float LastResurrectionTime;
var() float LastFireBurnTime;

var() Emitter LeftHandTrail, RightHandTrail;

var() Sound ResurrectionSound;
var() Sound BurnSounds[3];

var() config bool bArchvileCanResurrect;
var() config bool bArchvileCanSummon;

var() config float FlameWallDamage;
var() config float FireBurnIntervalTime;
var() config float ResurrectionIntervalTime;
var() config float ResurrectionRadius;
var() config float FlameDamage;
var() config float ResurrectedHealthPercent;
var() config float SummonIntervalTime;

var() config int SummonMonsterLimit;

var() config Array<String> SummonMonsterClass;

function RangedAttack(Actor A)
{
    local float Dist, Percentage;
    local vector X, Y, Z, SpawnOffSet;
    local Monster M, Resurrected, Summoned;
    local class<Monster> MonsterClass;
    local Inventory Inv;
    local class<Inventory> InvClass;

    Super.RangedAttack(A);

    Dist = VSize(A.Location - Location);

    if(Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        SetAnimAction(MeleeAnims[Rand(4)]);
        bShotAnim = true;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
    else if(Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        bShotAnim = true;
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }

    if(bArchvileCanResurrect && Level.TimeSeconds - LastResurrectionTime > ResurrectionIntervalTime)
    {
        foreach VisibleActors(class'Monster', M, ResurrectionRadius)
        {
            if(M != Self && M.GetStateName() == 'Dying')
            {
                M.SetCollision(false,false,false);
                M.bHidden = true;
                Resurrected = Spawn(M.class, self,, M.Location,);
                if(Resurrected != None)
                {
                    if(Doom_Monster(Resurrected) == None)
                    {
                        Spawn(SpawnFXClass,Self,,Resurrected.Location);
                    }

                    if(Invasion(Level.Game) != None)
                    {
                        Invasion(Level.Game).NumMonsters++;
                    }

                    LastResurrectionTime = Level.TimeSeconds;
                    Percentage = ResurrectedHealthPercent * 100;
                    Percentage = (Percentage/100) * Resurrected.default.health;
                    Resurrected.Health = Percentage;
                    Resurrected = None;
                    SetAnimAction('Resurrection');
                    bShotAnim = true;
                    Controller.bPreparingMove = true;
                    Acceleration = vect(0,0,0);
                    return;
                }
            }
        }
    }

    if(bArchvileCanSummon && NumMinions() < SummonMonsterLimit && Level.TimeSeconds - LastSummonTime > SummonIntervalTime)
    {
        GetAxes(Rotation,X,Y,Z);
        SpawnOffSet = X;
        MonsterClass = class<Monster>(DynamicLoadObject(SummonMonsterClass[Rand(SummonMonsterClass.Length)], class'class',true));
        if(MonsterClass != None)
        {
            Summoned = Spawn(MonsterClass,self,,location + 300 * SpawnOffSet);
            if(Summoned != None)
            {
                if(Doom_Monster(Summoned) == None)
                {
                    Spawn(SpawnFXClass,Self,,Resurrected.Location);
                }
                if(Invasion(Level.Game) != None)
                {
                    Invasion(Level.Game).NumMonsters++;
                }

                InvClass = class<Inventory>(DynamicLoadObject("tK_DoomMonsterPackv3.Archvile_Inventory",class'class',true));
                if(Summoned.FindInventoryType(InvClass) == None)
                {
                    Inv = Spawn(InvClass, Summoned,,,);
                    if(Archvile_Inventory(Inv) != None)
                    {
                        Archvile_Inventory(Inv).PawnMaster = self;
                        Inv.GiveTo(Summoned);
                    }
                }

                Summoned = None;
                LastSummonTime = Level.TimeSeconds;
                SetAnimAction('Resurrection');
                bShotAnim = true;
                Controller.bPreparingMove = true;
                Acceleration = vect(0,0,0);
                return;
            }
        }
    }

    if(Level.TimeSeconds - LastFireWallTime > RangedAttackIntervalTime)
    {
        SetAnimAction(RangedAttackAnims[1]);
        bShotAnim = true;
    }
    else if( Level.TimeSeconds - LastFireBurnTime > FireBurnIntervalTime)
    {
        SetAnimAction(RangedAttackAnims[0]);
        bShotAnim = true;
    }

    Controller.bPreparingMove = true;
    Acceleration = vect(0,0,0);
}

function int NumMinions()
{
    local Inventory Inv;
    local int i;

    i = 0;

    foreach DynamicActors(class'Inventory',Inv)
    {
        if(Archvile_Inventory(Inv) != None && Archvile_Inventory(Inv).PawnMaster == Self)
        {
            i++;
        }
    }

    return i;
}

function FireProjectile()
{
    local Projectile Proj;

    LastFireBurnTime = Level.TimeSeconds;
    LastRangedAttackTime = Level.TimeSeconds;

    if ( Controller != None && Controller.Target != None)
    {
        Spawn(class'Archvile_FlameAttackEffect',self,,Controller.Target.Location);
        Proj = Spawn(ProjectileClass[0],self,,Controller.Target.Location);
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function LightUp()
{
     if ( Level.NetMode != NM_DedicatedServer )
    {
        LeftHandTrail = Spawn(class'Archvile_HandEffect', self);
            AttachToBone(LeftHandTrail, 'LBulb');
        RightHandTrail = Spawn(class'Archvile_HandEffect', self);
            AttachToBone(RightHandTrail, 'RBulb');
    }
}

function Resurrect()
{
    PlaySound(ResurrectionSound,SLOT_Interact, 8);
}

function FireWall()
{
    local Coords BoneLocation;
    local Projectile Proj;

    LastFireWallTime = Level.TimeSeconds;
    LastRangedAttackTime = Level.TimeSeconds;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('WallBone');
        Proj = Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(BurnSounds[Rand(3)],SLOT_Interact);
        }
    }
}

simulated function RemoveEffects()
{
    if(LeftHandTrail != None)
    {
        LeftHandTrail.Kill();
    }
    if(RightHandTrail != None)
    {
        RightHandTrail.Kill();
    }
}

event GainedChild(Actor Other)
{
    if(bUseDamageConfig)
    {
        if(Other.Class == ProjectileClass[0])
        {
            Projectile(Other).Damage = FlameDamage;
        }
        else if(Other.Class == ProjectileClass[1])
        {
            Projectile(Other).Damage = FlameWallDamage;
        }
    }

    Super(Monster).GainedChild(Other);
}

simulated function HideSkinEffects()
{
     Skins[1] = InvisMat;
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

defaultproperties
{
     ResurrectionSound=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_Resurrection'
     BurnSounds(0)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_fire_01'
     BurnSounds(1)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_fire_02'
     BurnSounds(2)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_fire_04'
     bArchvileCanResurrect=True
     bArchvileCanSummon=True
     FlameWallDamage=5.000000
     FireBurnIntervalTime=1.000000
     ResurrectionIntervalTime=7.000000
     ResurrectionRadius=1500.000000
     FlameDamage=30.000000
     ResurrectedHealthPercent=0.250000
     SummonIntervalTime=7.000000
     SummonMonsterLimit=4
     SummonMonsterClass(0)="tK_DoomMonsterPackv3.Tick_Weak"
     SummonMonsterClass(1)="tK_DoomMonsterPackv3.Trite_Weak"
     SummonMonsterClass(2)="tK_DoomMonsterPackv3.Cherub_Weak"
     SummonMonsterClass(3)="tK_DoomMonsterPackv3.LostSoul_Weak"
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=20.000000
     RangedAttackIntervalTime=5.000000
     NewHealth=130
     SpeciesName="Archvile"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack3"
     MeleeAnims(3)="Attack1"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="RangedAttack1"
     RangedAttackAnims(1)="RangedAttack2"
     RangedAttackAnims(2)="RangedAttack1"
     RangedAttackAnims(3)="RangedAttack2"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Archvile_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Archvile_ProjectileFirewall'
     FadeClass=Class'tK_DoomMonsterPackv3.Archvile_MaterialSequence'
     BurnAnimTime=0.250000
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight12'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight12'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight12'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight12'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_step4'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_step2'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_step4'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_step2'
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight11'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight11'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight11'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight11'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_die4'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_die4'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_die4'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_die4'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_cin_sight'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_cin_sight'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight2_1'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_sight2_2'
     FireSound=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_burn'
     ScoringValue=8
     WallDodgeAnims(0)="DodgeL"
     WallDodgeAnims(1)="DodgeL"
     WallDodgeAnims(2)="DodgeR"
     WallDodgeAnims(3)="DodgeR"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Walk"
     FireHeavyBurstAnim="Walk"
     FireRifleRapidAnim="Walk"
     FireRifleBurstAnim="Walk"
     bCanJump=False
     MeleeRange=30.000000
     GroundSpeed=340.000000
     Health=130
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
     DodgeAnims(0)="DodgeL"
     DodgeAnims(1)="DodgeR"
     DodgeAnims(2)="DodgeL"
     DodgeAnims(3)="DodgeR"
     AirStillAnim="Walk"
     TakeoffStillAnim="Walk"
     CrouchTurnRightAnim="Walk"
     CrouchTurnLeftAnim="Walk"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.ArchvileMesh'
     DrawScale=1.200000
     PrePivot=(Z=-58.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Archvile.Archvile_Skin'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Archvile.Archvile_Hand_Shader'
     CollisionHeight=58.000000
     Begin Object Class=KarmaParamsSkel Name=ArchvileKParams
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
     KParams=KarmaParamsSkel'ArchVileKParams'

}
