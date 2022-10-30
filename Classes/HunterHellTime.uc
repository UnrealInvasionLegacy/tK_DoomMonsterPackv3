class HunterHellTime extends Doom_Monster config(DoomMonsters);

var() config bool bHunterHellTimeCanTeleport;
var() config float MultiProjDamage;
var() config float TeleportIntervalTime;

var() MaterialSequence FadeFXTwo;
var() class<MaterialSequence> FadeClassTwo;
var() Emitter ChargeEffect;
var() Emitter Trails[8];
var() Emitter BodyEffect;
var() Sound ChestRipSound[3];
var() Sound PreFireSound;
var() Sound TeleportSound;
var() Sound TeleportStart;
var() Name RangedAttacks[3];

simulated function SpawnTeleEffects(vector OldLoc, vector NewLoc)
{
    local xEmitter xBeam, xBeamSmall[2];
    local Coords BoneLocation;
    local Emitter Portal;

    xBeam = Spawn(class'HunterHellTime_Beam',self,,OldLoc,);
    xBeam.mSpawnVecA = NewLoc;

    BoneLocation = GetBoneCoords('Ruparm_orbit');
    xBeamSmall[0] = Spawn(class'HunterHellTime_ThinBeam',self,,OldLoc,);
    xBeamSmall[0].mSpawnVecA = BoneLocation.Origin;

    BoneLocation = GetBoneCoords('Luparm_orbit');
    xBeamSmall[1] = Spawn(class'HunterHellTime_ThinBeam',self,,OldLoc,);
    xBeamSmall[1].mSpawnVecA = BoneLocation.Origin;

    Spawn(class'HunterHellTime_Flare',self,,OldLoc,);

    Portal = Spawn(class'HunterHellTime_Portal',self,,NewLoc,Rotation);
    Portal.SetBase(self);
}

function FireProjectile()
{
    local coords BoneLocation;

    if(Controller != None)
    {
        BoneLocation = GetBoneCoords('chunk1_joint');
        Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        BoneLocation = GetBoneCoords('chunk2_joint');
        Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        BoneLocation = GetBoneCoords('chunk3_joint');
        Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        BoneLocation = GetBoneCoords('chunk4_joint');
        Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        BoneLocation = GetBoneCoords('chunk5_joint');
        Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        BoneLocation = GetBoneCoords('chunk6_joint');
        Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        BoneLocation = GetBoneCoords('chunk7_joint');
        Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        BoneLocation = GetBoneCoords('chunk8_joint');
        Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        PlaySound(FireSound,SLOT_Interact);
    }
}

function FireLProjectile()
{
    local Projectile Proj;
    local Coords BoneLocation;

    if(Controller != None)
    {
        BoneLocation = GetBoneCoords('lmissile');
        Proj = Spawn(ProjectileClass[0],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

function FireRProjectile()
{
    local Projectile Proj;
    local Coords BoneLocation;

    if(Controller != None)
    {
        BoneLocation = GetBoneCoords('rmissile');
        Proj = Spawn(ProjectileClass[0],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function PlayDirectionalHit(Vector HitLoc)
{}

simulated function PlaySummonSound()
{
    PlaySound(PreFireSound,SLOT_Talk, 8);
}

simulated function RemoveEffects()
{
    local int i;

    for(i=0;i<8;i++)
    {
        if(Trails[i] != None)
        {
            DetachFromBone(Trails[i]);
            Trails[i].Kill();
        }
    }

    Super.RemoveEffects();
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    Trails[0] = Spawn(class'HunterHellTime_TrailEffect',self);
        AttachToBone(Trails[0],'chunk1_joint');
    Trails[1] = Spawn(class'HunterHellTime_TrailEffect',self);
        AttachToBone(Trails[1],'chunk2_joint');
    Trails[2] = Spawn(class'HunterHellTime_TrailEffect',self);
        AttachToBone(Trails[2],'chunk3_joint');
    Trails[3] = Spawn(class'HunterHellTime_TrailEffect',self);
        AttachToBone(Trails[3],'chunk4_joint');
    Trails[4] = Spawn(class'HunterHellTime_TrailEffect',self);
        AttachToBone(Trails[4],'chunk5_joint');
    Trails[5] = Spawn(class'HunterHellTime_TrailEffect',self);
        AttachToBone(Trails[5],'chunk6_joint');
    Trails[6] = Spawn(class'HunterHellTime_TrailEffect',self);
        AttachToBone(Trails[6],'chunk7_joint');
    Trails[7] = Spawn(class'HunterHellTime_TrailEffect',self);
        AttachToBone(Trails[7],'chunk8_joint');
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
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if(bHunterHellTimeCanTeleport && Dist > 650 && Level.TimeSeconds - LastTeleportTime > TeleportIntervalTime)
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
                Controller.bPreparingMove = true;
                Acceleration = vect(0,0,0);
            }
        }
    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime && (!Controller.bPreparingMove && Controller.InLatentExecution(Controller.LATENT_MOVETOWARD)) || Velocity == vect(0,0,0) )
    {
        PlaySound(PreFireSound,SLOT_Interact);
        SetAnimAction(RangedAttacks[Rand(3)]);
        LastRangedAttackTime = Level.TimeSeconds;
        bShotAnim = true;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
}

event GainedChild(Actor Other)
{
    if(bUseDamageConfig)
    {
        if(Other.Class == ProjectileClass[0])
        {
            Projectile(Other).Damage = ProjectileDamage;
        }

        if(Other.Class == ProjectileClass[1])
        {
            Projectile(Other).Damage = MultiProjDamage;
        }
    }

    Super(Monster).GainedChild(Other);
}

simulated function HideSkinEffects()
{
}

simulated function FadeSkins()
{
    if(FadeFX != None)
    {
        FadeFX.Reset();
        Skins[0] = FadeFXTwo;
        Skins[1] = FadeFX;
        HideSkinEffects();
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

simulated function AllocateBurningObjects()
{
    if(BurnClass != None && FadeClass != None && FadeClassTwo != None)
    {
        BurnFX = FinalBlend(Level.ObjectPool.AllocateObject(BurnClass));
        FadeFX = MaterialSequence(Level.ObjectPool.AllocateObject(FadeClass));
        FadeFXTwo = MaterialSequence(Level.ObjectPool.AllocateObject(FadeClassTwo));

        if(BurnFX != None && FadeFX != None && FadeFXTwo != None)
        {
            bMonsterHasBurnFX = True;
            SetUpFinalBlend(BurnFX);
        }
    }
}

simulated function FreeBurningObjects()
{
    Super.FreeBurningObjects();
    if(FadeFXTwo != None)
    {
        Level.ObjectPool.FreeObject(FadeFXTwo);
        FadeFXTwo = None;
    }
}

defaultproperties
{
     bHunterHellTimeCanTeleport=True
     MultiProjDamage=8.000000
     TeleportIntervalTime=5.000000
     FadeClassTwo=Class'tK_DoomMonsterPackv3.HunterHellTime_Meat_MaterialSequence'
     ChestRipSound(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_chestrip_01'
     ChestRipSound(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_chestrip_03'
     ChestRipSound(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_chestrip_04'
     PreFireSound=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_helltime_summon'
     TeleportSound=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_helltime_teleport1'
     TeleportStart=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_helltime_tpstart'
     RangedAttacks(0)="Attack1"
     RangedAttacks(1)="Attack2"
     RangedAttacks(2)="Attack3"
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=25.000000
     RangedAttackIntervalTime=2.000000
     NewHealth=500
     SpeciesName="HunterHellTime"
     MeleeAnims(0)="Attack4"
     MeleeAnims(1)="Attack5"
     MeleeAnims(2)="Attack6"
     MeleeAnims(3)="Attack6"
     HitAnims(0)="Idle"
     HitAnims(1)="Idle"
     HitAnims(2)="Idle"
     HitAnims(3)="Idle"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.HunterHellTime_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.HunterHellTime_ProjectileLesser'
     FadeClass=Class'tK_DoomMonsterPackv3.HunterHellTime_MaterialSequence'
     BurnAnimTime=0.250000
     TeleportRadius=1500.000000
     aimerror=10
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_attack_01'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_attack_07'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_attack_09'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_attack_11'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     DodgeSkillAdjust=2.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_pain_01'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_pain_02'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_pain_06'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_pain_08'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_death_03'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_death_05'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_death_03'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_death_05'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_helltime_chatter_03'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_sight_01'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_mono_growl_03'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_mono_growl_27'
     FireSound=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_fb_prefire_03'
     ScoringValue=15
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
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=70.000000
     GroundSpeed=300.000000
     Health=500
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
     DodgeAnims(0)="DodgeL"
     DodgeAnims(1)="DodgeR"
     DodgeAnims(2)="DodgeL"
     DodgeAnims(3)="DodgeR"
     AirStillAnim="Idle"
     TakeoffStillAnim="Idle"
     CrouchTurnRightAnim="Idle"
     CrouchTurnLeftAnim="Idle"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.HunterHellTimeMesh'
     DrawScale=1.200000
     PrePivot=(X=-10.000000,Z=-70.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.HunterHellTime.HunterHellTime_Meat_Skin'
     Skins(1)=Texture'tK_DoomMonsterPackv3.HunterHellTime.HunterHellTime_Skin'
     CollisionRadius=40.000000
     CollisionHeight=80.000000
     Begin Object Class=KarmaParamsSkel Name=HunterHellTimeKParams
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
     KParams=KarmaParamsSkel'HunterHellTimeKParams'

}
