class HunterInvul extends Doom_Monster config(DoomMonsters);

var() config float ElectricProjectileBigDamage;
var() config float ElectricProjectileDamage;
var() config float GroundShockDamage;
var() config float GroundShockRadius;

var() Emitter HandBeams[2];
var() Emitter HandBeamsLong[2];
var() Sound PreFireSound;
var() float SavedHealth;
var() class<DamageType> ShockWaveDamageType;
var() Emitter ElecFX[11];

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(Role == Role_Authority)
    {
        SavedHealth = Health;
    }

    if(Level.NetMode != NM_DedicatedServer)
    {
         if(!Level.bDropDetail && (Level.DetailMode != DM_Low)) //high detail
         {
            ElecFX[0] = Spawn(class'HunterInvul_ElecAttachmentsLarge', self, , Location);
            AttachToBone(ElecFX[0],'Lloarm');
            ElecFX[1] = Spawn(class'HunterInvul_ElecAttachmentsLarge', self, , Location);
            AttachToBone(ElecFX[1],'Rloarm');
            ElecFX[2] = Spawn(class'HunterInvul_ElecAttachmentsMedium', self, , Location);
            AttachToBone(ElecFX[2],'Rpalm');
            ElecFX[3] = Spawn(class'HunterInvul_ElecAttachmentsMedium', self, , Location);
            AttachToBone(ElecFX[3],'Lpalm');
            ElecFX[4] = Spawn(class'HunterInvul_ElecAttachmentsMedium', self, , Location);
            AttachToBone(ElecFX[4],'LAnkleX');
            ElecFX[5] = Spawn(class'HunterInvul_ElecAttachmentsMedium', self, , Location);
            AttachToBone(ElecFX[5],'RAnkleX');
            ElecFX[6] = Spawn(class'HunterInvul_ElecAttachmentsMedium', self, , Location);
            AttachToBone(ElecFX[6],'HK_jaw_2');
            ElecFX[7] = Spawn(class'HunterInvul_ElecAttachmentsLarge', self, , Location);
            AttachToBone(ElecFX[7],'RlegX');
            ElecFX[8] = Spawn(class'HunterInvul_ElecAttachmentsLarge', self, , Location);
            AttachToBone(ElecFX[8],'LlegX');
            ElecFX[9] = Spawn(class'HunterInvul_ElecAttachmentsSuper', self, , Location);
            AttachToBone(ElecFX[9],'SpineX');
            ElecFX[10] = Spawn(class'HunterInvul_ElecAttachmentsSuper', self, , Location);
            AttachToBone(ElecFX[10],'BellyX');
        }
        else //low detail
        {
            ElecFX[0] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[0],'Lloarm');
            ElecFX[1] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[1],'Rloarm');
            ElecFX[2] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[2],'Rpalm');
            ElecFX[3] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[3],'Lpalm');
            ElecFX[4] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[4],'Lknee_bone');
            ElecFX[5] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[5],'Rknee_bone');
            ElecFX[6] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[6],'HK_jaw_2');
            ElecFX[7] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[7],'RlegX');
            ElecFX[8] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[8],'LlegX');
            ElecFX[9] = Spawn(class'HunterInvul_ElecAttachmentsLow', self, , Location);
            AttachToBone(ElecFX[9],'SpineX');
            ElecFX[10] = None;
        }
    }
}

simulated function PlayDirectionalHit(Vector HitLoc)
{
    local int i;


        for(i=0;i<2;i++)
        {
            if(HandBeams[i] != None)
            {
                DetachFromBone(HandBeams[i]);
                HandBeams[i].Destroy();
            }
            if(HandBeamsLong[i] != None)
            {
                DetachFromBone(HandBeamsLong[i]);
                HandBeamsLong[i].Destroy();
            }
        }

        PlayAnim(HitAnims[Rand(4)],, 0.1);
}

function FireRProjectile()
{
    local Projectile Proj;
    local coords BoneLocation;

    if(Controller != None && Controller.Target != None)
    {
        BoneLocation = GetBoneCoords('rmissile');
        Proj = Spawn(ProjectileClass[0],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Doom_Projectile(Proj) != None)
        {
            Doom_Projectile(Proj).Seeking = Controller.Target;
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function SpawnGiantElectro()
{
    local Rotator Rot;

    Rot.Roll = -20000;
    Rot.Yaw = -3000;
    Spawn(class'HunterInvul_ProjectileBigErupt',self,,Location + vect(0,0,-50),Rotation);
}

function FireHMissile()
{
    local coords BoneLocation;
    local Projectile Proj;

    if(Controller != None && Controller.Target != None)
    {
        BoneLocation = GetBoneCoords('HMissile');
        Proj = Spawn(ProjectileClass[1],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Doom_Projectile(Proj) != None)
        {
            Doom_Projectile(Proj).Seeking = Controller.Target;
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function RemoveEffects()
{
    local int i;

    for(i=0;i<2;i++)
    {
        if(HandBeams[i] != None)
        {
            DetachFromBone(HandBeams[i]);
            HandBeams[i].Destroy();
        }
        if(HandBeamsLong[i] != None)
        {
            DetachFromBone(HandBeamsLong[i]);
            HandBeamsLong[i].Destroy();
        }
    }

    for(i=0;i<11;i++)
    {
        if(ElecFX[i] != None)
        {
            DetachFromBone(ElecFX[i]);
            ElecFX[i].Destroy();
        }
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

function RangedAttack(Actor A)
{
    local float Dist;

    Super.RangedAttack(A);

    Dist = VSize(A.Location - Location);

    if(Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        SetAnimAction(MeleeAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        bShotAnim = true;
    }
    else if( (Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime) && (Velocity == vect(0,0,0) || (!Controller.bPreparingMove && Controller.InLatentExecution(Controller.LATENT_MOVETOWARD)) ) )
    {
        PlaySound(PreFireSound,SLOT_Interact);
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
        LastRangedAttackTime = Level.TimeSeconds;
    }
}

event GainedChild(Actor Other)
{
    if(bUseDamageConfig)
    {
        if(Other.Class == ProjectileClass[0])
        {
            Projectile(Other).Damage = ElectricProjectileDamage;
        }

        if(Other.Class == ProjectileClass[1])
        {
            Projectile(Other).Damage = ElectricProjectileBigDamage;
        }
    }

    Super(Monster).GainedChild(Other);
}

function ElectroWave()
{
    local xPawn P;
    local vector dir;
    local float damageScale, dist, Momentum, Shake;

    Spawn(class'HunterInvul_ElectroWave',self,,Location + vect(0,0,-70),Rotation);

    foreach VisibleCollidingActors(class'xPawn', P, GroundShockRadius, Location)
    {
        if(P != None && P.Health > 0 && P.Controller != None && !P.Controller.IsA('MonsterController'))
        {
            Shake = RandRange(2000,3000);
            P.Controller.ShakeView( vect(0.0,0.02,0.0)*Shake, vect(0,1000,0),0.003*Shake, vect(0.02,0.02,0.02)*Shake, vect(1000,1000,1000),0.003*Shake);
            Momentum = 100 * P.CollisionRadius;
            dir = P.Location - Location;
            dist = FMax(1,VSize(dir));
            dir = dir/dist;
            damageScale = 1 - FMax(0,(dist - P.CollisionRadius)/GroundShockRadius);
            P.TakeDamage(damageScale * GroundShockDamage,self,P.Location - 0.5 * (P.CollisionHeight + P.CollisionRadius) * dir,(damageScale * Momentum * dir), ShockWaveDamageType);
        }
    }
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

defaultproperties
{
     ElectricProjectileBigDamage=30.000000
     ElectricProjectileDamage=8.000000
     GroundShockDamage=35.000000
     GroundShockRadius=375.000000
     PreFireSound=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_fb_prefire_01'
     ShockWaveDamageType=Class'tK_DoomMonsterPackv3.DamType_HunterInvul_ShockWave'
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=30.000000
     RangedAttackIntervalTime=2.000000
     NewHealth=500
     SpeciesName="HunterInvul"
     MeleeAnims(0)="Attack3"
     MeleeAnims(1)="ShockWave"
     MeleeAnims(2)="Attack3"
     MeleeAnims(3)="ShockWave"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Summon"
     RangedAttackAnims(0)="Attack1"
     RangedAttackAnims(1)="Attack2"
     RangedAttackAnims(2)="Attack1"
     RangedAttackAnims(3)="Attack2"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.HunterInvul_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.HunterInvul_ProjectileBig'
     FadeClass=Class'tK_DoomMonsterPackv3.HunterInvul_MaterialSequence'
     BurnAnimTime=0.250000
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_attack_01'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_attack_07'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_attack_09'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_attack_11'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     bCanDodge=False
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_pain_01'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_pain_02'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_pain_06'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_pain_08'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_death_03'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_death_05'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_death_03'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_death_05'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_mono_growl_25'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_sight_01'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_mono_growl_03'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_mono_growl_27'
     FireSound=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_fb_prefire_03'
     ScoringValue=15
     WallDodgeAnims(0)="Walk"
     WallDodgeAnims(1)="Walk"
     WallDodgeAnims(2)="Walk"
     WallDodgeAnims(3)="Walk"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Walk"
     FireHeavyBurstAnim="Walk"
     FireRifleRapidAnim="Walk"
     FireRifleBurstAnim="Walk"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=80.000000
     GroundSpeed=400.000000
     Health=500
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
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.HunterInvulMesh'
     DrawScale=1.200000
     PrePivot=(X=-5.000000,Z=-80.000000)
     Skins(0)=Shader'tK_DoomMonsterPackv3.HunterInvulnerable.HunterInvul_Skin_Shader'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     CollisionRadius=30.000000
     CollisionHeight=80.000000
     Begin Object Class=KarmaParamsSkel Name=HunterInvulKParams
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
     KParams=KarmaParamsSkel'HunterInvulKParams'

}
