class Pinky extends Doom_Monster config(DoomMonsters);

var() Sound MetalSteps[2];
var() Sound IdleGrunts[4];

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    SetTimer(5.00,true);
}

simulated function Timer()
{
    PlaySound(IdleGrunts[Rand(4)], SLOT_Interact,8);
}

simulated function MetalStep()
{
    PlaySound(MetalSteps[Rand(2)], SLOT_Talk,8);
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
        bShotAnim = true;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
}

simulated function HideSkinEffects()
{
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

defaultproperties
{
     MetalSteps(0)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_metalstep_test24'
     MetalSteps(1)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_metalstep_test24'
     IdleGrunts(0)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_idle_test1'
     IdleGrunts(1)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_idle_test2'
     IdleGrunts(2)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_idle_test3'
     IdleGrunts(3)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_idle_test4'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=155.000000
     NewHealth=220
     SpeciesName="Pinky"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack3"
     MeleeAnims(3)="Attack4"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain03"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Roar3"
     FadeClass=Class'tK_DoomMonsterPackv3.Pinky_MaterialSequence'
     BurnAnimTime=0.250000
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_melee_test2'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_melee_test2'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_melee_test2'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_melee_test2'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_fleshstep_test12'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_fleshstep_test12'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_fleshstep_test12'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_fleshstep_test12'
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_pain_test1'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_pain_test1'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_pain_test1'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_pain_test1'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_death_test3'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_death_test5'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_death_test3'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_death_test5'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_sight2_test2'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_sight2_test3'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_sight_test22'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Pinky.Pinky_idle_test1'
     ScoringValue=8
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
     MeleeRange=100.000000
     GroundSpeed=500.000000
     Health=220
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
     AirAnims(0)="Run"
     AirAnims(1)="Run"
     AirAnims(2)="Run"
     AirAnims(3)="Run"
     TakeoffAnims(0)="Run"
     TakeoffAnims(1)="Run"
     TakeoffAnims(2)="Run"
     TakeoffAnims(3)="Run"
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
     AirStillAnim="Run"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.PinkyMesh'
     PrePivot=(Z=-42.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Pinky.Pinky_Skin'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Pinky.Pinky_Skin'
     Skins(2)=Texture'tK_DoomMonsterPackv3.Pinky.Pinky_Teeth_Diffuse'
     Skins(3)=Shader'tK_DoomMonsterPackv3.Pinky.Pinky_Drool_Shader'
     Skins(4)=Shader'tK_DoomMonsterPackv3.Pinky.Pinky_Drool_Shader'
     CollisionRadius=30.000000
     Begin Object Class=KarmaParamsSkel Name=PinkyKParams
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
     KParams=KarmaParamsSkel'PinkyKParams'

}
