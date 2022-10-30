class HunterBerserk extends Doom_Monster config(DoomMonsters);

var() Emitter ChargeEffect;
var() Emitter BodyEffect;
var() Sound ChestRipSound[3];
var() Sound PreFireSound;

simulated function PostBeginPlay()
{
    Super(Monster).PostBeginPlay();

    BodyEffect = Spawn(class'HunterBerserk_HeartEffect',self);
        AttachToBone(BodyEffect,'heart1');
}

function FireProjectile()
{
    local coords BoneLocation;
    local Projectile Proj;

    if(Controller != None)
    {
        BoneLocation = GetBoneCoords('mouth');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function SpawnAttackEffect()
{
    ChargeEffect = Spawn(class'HunterBerserk_ChargeEffect',self,,);
        AttachToBone(ChargeEffect,'mouth');
}

simulated function ChestRip()
{
    PlaySound(ChestRipSound[Rand(3)],SLOT_Talk,8);
}

simulated function RemoveEffects()
{
    if(BodyEffect != None)
    {
        DetachFromBone(BodyEffect);
        BodyEffect.Kill();
    }

    if(ChargeEffect != None)
    {
        DetachFromBone(ChargeEffect);
        ChargeEffect.Kill();
    }

    Super.RemoveEffects();
}

simulated function BurnAway()
{
    local int i;

    if(BurnFX != None)
    {
        for(i=0;i<Skins.Length;i++)
        {
            Skins[i] = BurnFX;
        }

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
    else if(Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        bShotAnim = true;
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
}

simulated function HideSkinEffects()
{
     Skins[1] = InvisMat;
     Skins[2] = InvisMat;
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
     ChestRipSound(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_chestrip_01'
     ChestRipSound(1)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_chestrip_03'
     ChestRipSound(2)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_chestrip_04'
     PreFireSound=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_fb_prefire_01'
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=25.000000
     RangedAttackIntervalTime=2.000000
     NewHealth=500
     SpeciesName="HunterBerserk"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack3"
     MeleeAnims(2)="Attack1"
     MeleeAnims(3)="Attack3"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain01"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Idle"
     RangedAttackAnims(0)="Attack2"
     RangedAttackAnims(1)="Attack2"
     RangedAttackAnims(2)="Attack2"
     RangedAttackAnims(3)="Attack2"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.HunterBerserk_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.HunterBerserk_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.HunterBerserk_MaterialSequence'
     BurnAnimTime=0.250000
     aimerror=50
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
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Hunter.Hunter_mono_growl_25'
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
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=120.000000
     GroundSpeed=400.000000
     Health=500
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
     AirAnims(0)="JumpMiddle"
     AirAnims(1)="JumpMiddle"
     AirAnims(2)="JumpMiddle"
     AirAnims(3)="JumpMiddle"
     TakeoffAnims(0)="JumpStart"
     TakeoffAnims(1)="JumpStart"
     TakeoffAnims(2)="JumpStart"
     TakeoffAnims(3)="JumpStart"
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
     AirStillAnim="JumpMiddle"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.HunterBerserkMesh'
     DrawScale=1.200000
     PrePivot=(X=-5.000000,Z=-80.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.HunterBerserk.HunterBerserk_Skin'
     Skins(1)=Texture'tK_DoomMonsterPackv3.HunterBerserk.HunterBerserk_Claws_Skin'
     Skins(2)=Shader'tK_DoomMonsterPackv3.HunterBerserk.HunterBerserk_Heart_Shader'
     CollisionRadius=30.000000
     CollisionHeight=80.000000
     Begin Object Class=KarmaParamsSkel Name=HunterBerserkKParams
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
     KParams=KarmaParamsSkel'HunterBerserkKParams'

}
