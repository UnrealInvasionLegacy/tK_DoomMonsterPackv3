class Cyberdemon extends Doom_Monster config(DoomMonsters);

var() Material WeaponFlashLight[4];
var() Sound RocketSounds[3];
var() Emitter FireEffects[3];

simulated function Timer()
{
    PlaySound(ChallengeSound[Rand(4)],SLOT_Talk, 8);
    SetTimer(RandRange(5.00,30.00),true);
}

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None && Controller.Target != None)
    {
        BoneLocation = GetBoneCoords('cyber_barrel_smoke');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Doom_Projectile(Proj) != None)
        {
            Doom_Projectile(Proj).Seeking = Controller.Target;
            Spawn(class'Revenant_SmokePuffs',self,,BoneLocation.Origin);
            PlaySound(RocketSounds[Rand(3)],SLOT_Interact);
        }
    }
}

simulated function RocketFlashOn()
{
    Skins[1] = WeaponFlashLight[0];
    Skins[2] = WeaponFlashLight[1];
    Skins[3] = WeaponFlashLight[2];
    Skins[4] = WeaponFlashLight[3];
}

simulated function RocketFlashOff()
{
    Skins[1] = default.Skins[1];
    Skins[2] = default.Skins[2];
    Skins[3] = default.Skins[3];
    Skins[4] = default.Skins[4];
}

simulated function PlayDirectionalHit(Vector HitLoc)
{
    PlayAnim(HitAnims[Rand(4)],, 0.1);
    Controller.bPreparingMove = true;
    Acceleration = vect(0,0,0);
    bShotAnim = true;
}

simulated function RemoveEffects()
{
    local int i;

    for(i=0;i<3;i++)
    {
        if(FireEffects[i] != None)
        {
            DetachFromBone(FireEffects[i]);
            FireEffects[i].Kill();
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

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    FireEffects[0] = Spawn(class'Cyberdemon_MouthEffect',self);
        AttachToBone(FireEffects[0],'cyber_mouth_fire');
    FireEffects[1] = Spawn(class'Cyberdemon_MouthSideFire',self);
        AttachToBone(FireEffects[1],'LFire');
    FireEffects[2] = Spawn(class'Cyberdemon_MouthSideFire',self);
        AttachToBone(FireEffects[2],'RFire');

    SetTimer(RandRange(5.00,30.00),true);
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
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
}

simulated function HideSkinEffects()
{
    Skins[1] = InvisMat;
    Skins[2] = InvisMat;
    Skins[3] = InvisMat;
    Skins[4] = InvisMat;
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
     WeaponFlashLight(0)=Shader'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_WeaponTipGlow_Shader'
     WeaponFlashLight(1)=Shader'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_Flash_Shader'
     WeaponFlashLight(2)=Shader'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_WeaponTipGlow_Shader'
     WeaponFlashLight(3)=Shader'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_WeaponTipGlow_Shader'
     RocketSounds(0)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_rocket_fire_01'
     RocketSounds(1)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_rocket_fire_03'
     RocketSounds(2)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_rocket_fire_04'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=80.000000
     RangedAttackIntervalTime=2.000000
     NewHealth=500
     SpeciesName="Cyberdemon"
     MeleeAnims(0)="MeleeAttack"
     MeleeAnims(1)="MeleeAttack"
     MeleeAnims(2)="MeleeAttack"
     MeleeAnims(3)="MeleeAttack"
     HitAnims(0)="Pain"
     HitAnims(1)="Pain"
     HitAnims(2)="Pain"
     HitAnims(3)="Pain"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="Shot1"
     RangedAttackAnims(1)="Shot2"
     RangedAttackAnims(2)="Shot3"
     RangedAttackAnims(3)="Shot1"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Cyberdemon_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Cyberdemon_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Cyberdemon_MaterialSequence'
     BurnAnimTime=0.150000
     MissSound(0)=None
     MissSound(1)=None
     MissSound(2)=None
     MissSound(3)=None
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_step2'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_step3'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_step2'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_step3'
     bMeleeFighter=False
     bCanDodge=False
     DodgeSkillAdjust=0.100000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_pain1'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_pain2'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_pain3'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_pain4'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_sight3'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_sight2'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_sight3'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_sight2'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_sight1'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_chatter2'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_chatter1'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_sight1'
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
     MeleeRange=50.000000
     GroundSpeed=380.000000
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
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.CyberDemonMesh'
     DrawScale=1.200000
     PrePivot=(Z=-125.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Cyberdemon.CyberDemon_Skin'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(3)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(4)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     CollisionRadius=60.000000
     CollisionHeight=120.000000
     Begin Object Class=KarmaParamsSkel Name=CyberdemonKParams
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
     KParams=KarmaParamsSkel'CyberdemonKParams'

}
