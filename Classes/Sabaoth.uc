class Sabaoth extends Doom_Monster config(DoomMonsters);

var() config bool bSabaothNoTalk;
var() Sound Laughs[3];
var() Sound TauntSounds[11];
var() Sound PreFireSound;
var() Emitter Charge;

Replication
{
    reliable if(Role==Role_Authority)
        bSabaothNoTalk;
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(bSabaothNoTalk)
    {
        ChallengeSound[0] = Laughs[0];
        ChallengeSound[1] = Laughs[1];
        ChallengeSound[2] = Laughs[2];
        ChallengeSound[3] = Laughs[0];
    }
    else
    {
        SetTimer(RandRange(5.00,10.00),true);
    }
}

simulated function Timer()
{
    Super.Timer();
    PlaySound(TauntSounds[Rand(11)], SLOT_Talk,150);
    SetTimer(RandRange(10.00,30.00),true);
}

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('mech_bfg');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function ChargeBFG()
{
    local Coords BoneLocation;

    BoneLocation = GetBoneCoords('mech_bfg');
    Charge = Spawn(class'Sabaoth_ChargeEffect',self,,BoneLocation.Origin);
    AttachToBone(Charge,'mech_bfg');
}

simulated function RemoveEffects()
{
    if(Charge != None)
    {
        Charge.Kill();
    }

    Super.RemoveEffects();
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
    else if (Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        PlaySound(PreFireSound,SLOT_Interact);
        LastRangedAttackTime = Level.TimeSeconds;
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
}

simulated function HideSkinEffects()
{
    Skins[0] = InvisMat;
    Skins[1] = InvisMat;
    Skins[2] = InvisMat;
    Skins[3] = InvisMat;
    Skins[4] = InvisMat;
    Skins[7] = InvisMat;
    Skins[8] = InvisMat;
}

simulated function FadeSkins()
{
    if(FadeFX != None)
    {
        FadeFX.Reset();
        Skins[5] = FadeFX;
        HideSkinEffects();
    }

    RemoveEffects();
    ChargeBFG();
    Spawn(class'Sabaoth_ProjectileExplosionSmall',self,,GetBoneCoords('mech_bfg').Origin);
    Skins[6] = InvisMat;
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[5] = BurnFX;
        bBurning = true;
    }
}

defaultproperties
{
     bSabaothNoTalk=True
     Laughs(0)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_taunt_01'
     Laughs(1)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_taunt_02'
     Laughs(2)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_taunt_03'
     TauntSounds(0)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth__taunt_01English'
     TauntSounds(1)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_taunt_02English'
     TauntSounds(2)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_taunt_03English'
     TauntSounds(3)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_taunt_04English'
     TauntSounds(4)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_warning_01English'
     TauntSounds(5)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_warning_02English'
     TauntSounds(6)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_warning_03English'
     TauntSounds(7)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_warning_04English'
     TauntSounds(8)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_taunt_04English'
     TauntSounds(9)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_taunt_05English'
     TauntSounds(10)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_taunt_06English'
     PreFireSound=Sound'tK_DoomMonsterPackv3.BFG.bfg_firebegin'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=70.000000
     RangedAttackIntervalTime=2.000000
     ProjectileDamage=500.000000
     NewHealth=500
     SpeciesName="Sabaoth"
     MeleeAnims(0)="Attack2"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack2"
     MeleeAnims(3)="Attack2"
     HitAnims(0)="Travel"
     HitAnims(1)="Travel"
     HitAnims(2)="Travel"
     HitAnims(3)="Travel"
     DeathAnims(0)="Death"
     DeathAnims(1)="Death"
     DeathAnims(2)="Death"
     DeathAnims(3)="Death"
     TauntAnim="Sight"
     RangedAttackAnims(0)="Attack1"
     RangedAttackAnims(1)="Attack1"
     RangedAttackAnims(2)="Attack1"
     RangedAttackAnims(3)="Attack1"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Sabaoth_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Sabaoth_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Sabaoth_MaterialSequence'
     BurnAnimTime=1.250000
     aimerror=25
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_melee_attack'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_melee_attack'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_melee_attack'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_melee_attack'
     bCanDodge=False
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Death'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Death'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Death'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Death'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_taunt_03English'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth__taunt_01English'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_taunt_04English'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_sarge_taunt_02English'
     FireSound=Sound'tK_DoomMonsterPackv3.BFG.bfg_fire'
     ScoringValue=15
     WallDodgeAnims(0)="Travel"
     WallDodgeAnims(1)="Travel"
     WallDodgeAnims(2)="Travel"
     WallDodgeAnims(3)="Travel"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Travel"
     FireHeavyBurstAnim="Travel"
     FireRifleRapidAnim="Travel"
     FireRifleBurstAnim="Travel"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=170.000000
     GroundSpeed=400.000000
     Health=500
     MovementAnims(0)="Travel"
     MovementAnims(1)="Travel"
     MovementAnims(2)="Travel"
     MovementAnims(3)="Travel"
     TurnLeftAnim="Travel"
     TurnRightAnim="Travel"
     SwimAnims(0)="Travel"
     SwimAnims(1)="Travel"
     SwimAnims(2)="Travel"
     SwimAnims(3)="Travel"
     CrouchAnims(0)="Travel"
     CrouchAnims(1)="Travel"
     CrouchAnims(2)="Travel"
     CrouchAnims(3)="Travel"
     WalkAnims(0)="Travel"
     WalkAnims(1)="Travel"
     WalkAnims(2)="Travel"
     WalkAnims(3)="Travel"
     AirAnims(0)="Travel"
     AirAnims(1)="Travel"
     AirAnims(2)="Travel"
     AirAnims(3)="Travel"
     TakeoffAnims(0)="Travel"
     TakeoffAnims(1)="Travel"
     TakeoffAnims(2)="Travel"
     TakeoffAnims(3)="Travel"
     LandAnims(0)="Travel"
     LandAnims(1)="Travel"
     LandAnims(2)="Travel"
     LandAnims(3)="Travel"
     DoubleJumpAnims(0)="Travel"
     DoubleJumpAnims(1)="Travel"
     DoubleJumpAnims(2)="Travel"
     DoubleJumpAnims(3)="Travel"
     DodgeAnims(0)="Travel"
     DodgeAnims(1)="Travel"
     DodgeAnims(2)="Travel"
     DodgeAnims(3)="Travel"
     AirStillAnim="Travel"
     TakeoffStillAnim="Travel"
     CrouchTurnRightAnim="Travel"
     CrouchTurnLeftAnim="Travel"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     AmbientSound=Sound'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Walk'
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.SabaothMesh'
     DrawScale=1.200000
     PrePivot=(Z=-80.000000)
     Skins(0)=Shader'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Gear2_Shader'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Gear2_Shader'
     Skins(2)=Shader'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Gear3_Shader'
     Skins(3)=Shader'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Tread_Shader'
     Skins(4)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(5)=Texture'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Skin'
     Skins(6)=Texture'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_BFG_Skin'
     Skins(7)=Shader'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Eyes_Shader'
     Skins(8)=Shader'tK_DoomMonsterPackv3.Sabaoth.Sabaoth_Eyes_Shader'
     CollisionRadius=70.000000
     CollisionHeight=80.000000
     Begin Object Class=KarmaParamsSkel Name=SabaothKParams
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
     KParams=KarmaParamsSkel'SabaothKParams'

}
