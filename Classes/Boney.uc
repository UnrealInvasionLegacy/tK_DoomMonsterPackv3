class Boney extends Doom_Monster config(DoomMonsters);

var() Sound GroanSounds[12];

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(Role == ROLE_Authority)
    {
        SetTimer(RandRange(5.00,12.00),false);
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
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
        bShotAnim = true;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
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

function Timer()
{
    Super.Timer();
    PlaySound(GroanSounds[Rand(12)], SLOT_Interact,8);
    SetTimer(RandRange(5.00,12.00),false);
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
     GroanSounds(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.mmboy_01'
     GroanSounds(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.mmboy_02'
     GroanSounds(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_sight1'
     GroanSounds(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_sight2'
     GroanSounds(4)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_sight3'
     GroanSounds(5)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_sight4'
     GroanSounds(6)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_sight5'
     GroanSounds(7)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_sight6'
     GroanSounds(8)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_sight7'
     GroanSounds(9)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_01'
     GroanSounds(10)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_02'
     GroanSounds(11)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_03'
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=10.000000
     NewHealth=70
     SpeciesName="Boney"
     MeleeAnims(0)="MeleeAttack01"
     MeleeAnims(1)="MeleeAttack01"
     MeleeAnims(2)="MeleeAttack01"
     MeleeAnims(3)="MeleeAttack01"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     FadeClass=Class'tK_DoomMonsterPackv3.Boney_MaterialSequence'
     BurnAnimTime=0.500000
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_attack1'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_attack2'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_attack3'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_attack3'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step2'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step3'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step4'
     bCanDodge=False
     HitSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_pain1'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_pain2'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_pain3'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_pain1'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_death1'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_death2'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_death3'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_death4'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_combat_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_combat_02'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_combat_03'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.zombie_sight3'
     ScoringValue=3
     WallDodgeAnims(0)="Walk"
     WallDodgeAnims(1)="Walk"
     WallDodgeAnims(2)="Walk"
     WallDodgeAnims(3)="Walk"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Idle"
     FireHeavyBurstAnim="Idle"
     FireRifleRapidAnim="Idle"
     FireRifleBurstAnim="Idle"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=50.000000
     GroundSpeed=300.000000
     Health=70
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
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.BoneyMesh'
     DrawScale=1.200000
     PrePivot=(Z=-50.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Boney.Boney_Skin'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     CollisionRadius=15.000000
     CollisionHeight=50.000000
     Begin Object Class=KarmaParamsSkel Name=BoneyKParams
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
     KParams=KarmaParamsSkel'BoneyKParams'

}
