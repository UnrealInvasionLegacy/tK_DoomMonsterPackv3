class Sentry extends Doom_Monster config(DoomMonsters);

var() Sound ProjFireSounds[5];
var() Material FlashTextures[6];
var() int FlashTimer;
var() Actor Target;

Replication
{
    Reliable if(Role==Role_Authority)
        Target;
}

simulated function Tick(float deltatime)
{
    local int i;
    FlashTimer++;

    if(FlashTimer >= 7)
    {
        FlashTimer = 0;
        if(Target != None)
        {
            Skins[4] = FlashTextures[1];
            Skins[8] = FlashTextures[5];
            for(i=0;i<3;i++)
            {
                MovementAnims[i] = 'Walk_Beam';
            }
        }
        else
        {
            Skins[4] = default.Skins[4];
            Skins[8] = default.Skins[8];
            for(i=0;i<3;i++)
            {
                MovementAnims[i] = 'Walk';
            }
        }
    }
}

simulated function AssignInitialPose()
{
    TweenAnim('Folded',0.0);
}

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('barrel');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            Spawn(class'Sentry_WeaponFlash',self,,BoneLocation.Origin);
            PlaySound(ProjFireSounds[Rand(5)],SLOT_Interact);
        }
    }
}

simulated function StartDeRes()
{
    if( Level.NetMode == NM_DedicatedServer )
        return;

    AmbientGlow=254;
    MaxLights=0;

    SetCollision(false, false, false);
    Projectors.Remove(0, Projectors.Length);
    bAcceptsProjectors = false;
    if(PlayerShadow != None)
      PlayerShadow.bShadowActive = false;
    RemoveFlamingEffects();
    SetOverlayMaterial(None, 0.0f, true);
    bDeRes = true;
}

simulated function PostBeginPlay()
{
    Super(Monster).PostBeginPlay();

    if(Role == Role_Authority)
    {
        SetAnimAction('Un_Fold');
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }

    FlashTimer = 0;
}

function RangedAttack(Actor A)
{

    Super.RangedAttack(A);

    Target = A;
    if ( Velocity == vect(0,0,0) && Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        SetAnimAction(RangedAttackAnims[Rand(4)]);
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
}

simulated function HideSkinEffects()
{
     Skins[0] = InvisMat;
     Skins[1] = InvisMat;
     Skins[3] = InvisMat;
     Skins[4] = InvisMat;
     Skins[5] = InvisMat;
     Skins[6] = InvisMat;
     Skins[7] = InvisMat;
     Skins[8] = InvisMat;
}

simulated function FadeSkins()
{
    if(FadeFX != None)
    {
        FadeFX.Reset();
        Skins[2] = FadeFX;
        HideSkinEffects();
    }
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[2] = BurnFX;
        bBurning = true;
    }
}

defaultproperties
{
     ProjFireSounds(0)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_fire_01'
     ProjFireSounds(1)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_fire_02'
     ProjFireSounds(2)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_fire_03'
     ProjFireSounds(3)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_fire_04'
     ProjFireSounds(4)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_fire_05'
     FlashTextures(0)=Shader'tK_DoomMonsterPackv3.Sentry.Sentry_UpperWeaponFlash'
     FlashTextures(1)=Shader'tK_DoomMonsterPackv3.Sentry.Sentry_TorchLight'
     FlashTextures(2)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     FlashTextures(3)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     FlashTextures(4)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     FlashTextures(5)=Shader'tK_DoomMonsterPackv3.Sentry.Sentry_UpperWhiteFlash'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     RangedAttackIntervalTime=0.300000
     ProjectileDamage=10.000000
     NewHealth=200
     SpeciesName="Sentry"
     HitAnims(0)="Walk_Hit"
     HitAnims(1)="Walk_Hit"
     HitAnims(2)="Walk_Hit"
     HitAnims(3)="Walk_Hit"
     DeathAnims(0)="Fold"
     DeathAnims(1)="Fold"
     DeathAnims(2)="Fold"
     DeathAnims(3)="Fold"
     TauntAnim="Talk_Primary"
     RangedAttackAnims(0)="Ranged_Attack1"
     RangedAttackAnims(1)="Ranged_Attack1"
     RangedAttackAnims(2)="Ranged_Attack1"
     RangedAttackAnims(3)="Ranged_Attack1"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Sentry_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Sentry_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Sentry_MaterialSequence'
     BurnDustClass=Class'tK_DoomMonsterPackv3.Doom_Dust_Small'
     aimerror=300
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_sstep_01'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_sstep_02'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_sstep_03'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_sstep_04'
     bMeleeFighter=False
     bCanDodge=False
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_pain_01'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_pain_02'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_pain_03'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_pain_04'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_shutdown_01'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_destroyed_01'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_shutdown_01'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_destroyed_01'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_fight_enemy_02'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_activate_01'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_cant_reach_player_01'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Sentry.Sentry_cant_reach_player_02'
     ScoringValue=15
     GibGroupClass=Class'XEffects.xBotGibGroup'
     WallDodgeAnims(0)="Walk"
     WallDodgeAnims(1)="Walk"
     WallDodgeAnims(2)="Walk"
     WallDodgeAnims(3)="Walk"
     IdleHeavyAnim="Idle_Stand"
     IdleRifleAnim="Idle_Stand"
     FireHeavyRapidAnim="Walk"
     FireHeavyBurstAnim="Walk"
     FireRifleRapidAnim="Walk"
     FireRifleBurstAnim="Walk"
     bCanJump=False
     GroundSpeed=200.000000
     Health=500
     MovementAnims(0)="Walk"
     MovementAnims(1)="Walk"
     MovementAnims(2)="Walk"
     MovementAnims(3)="Walk"
     TurnLeftAnim="TurnL"
     TurnRightAnim="TurnR"
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
     IdleCrouchAnim="Idle_Stand"
     IdleSwimAnim="Idle_Stand"
     IdleWeaponAnim="Idle_Stand"
     IdleRestAnim="Idle_Stand"
     IdleChatAnim="Idle_Stand"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.SentryMesh'
     DrawScale=1.800000
     PrePivot=(Z=-32.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Sentry.Sentry_SpistonDiffuse'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Sentry.Sentry_FlapDiffuse'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Sentry.Sentry_Skin'
     Skins(3)=Shader'tK_DoomMonsterPackv3.Sentry.Sentry_UpperWeaponFlashSmall'
     Skins(4)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(5)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(6)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(7)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(8)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     CollisionRadius=30.000000
     CollisionHeight=32.000000
     Begin Object Class=KarmaParamsSkel Name=SentryKParams
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
     KParams=KarmaParamsSkel'SentryKParams'

}
