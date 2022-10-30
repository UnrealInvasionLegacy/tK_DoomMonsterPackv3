class HellKnight extends Doom_Monster config(DoomMonsters);

var() Emitter HandFX;

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('RHandBone');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function RangedEffect()
{
    HandFX = Spawn(class'HellKnight_HandEffect',self);
    AttachToBone(HandFX,'RHandBone');
}

simulated function RemoveEffects()
{
    if(HandFX != None)
    {
        DetachFromBone(HandFX);
        HandFX.Kill();
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
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=20.000000
     RangedAttackIntervalTime=2.500000
     NewHealth=500
     SpeciesName="HellKnight"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack4"
     MeleeAnims(2)="Attack1"
     MeleeAnims(3)="Attack4"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Roar"
     RangedAttackAnims(0)="HighAttack"
     RangedAttackAnims(1)="HighAttack"
     RangedAttackAnims(2)="HighAttack"
     RangedAttackAnims(3)="HighAttack"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.HellKnight_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.HellKnight_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Hellknight_MaterialSequence'
     BurnAnimTime=0.500000
     aimerror=20
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_chomp1'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_chomp2'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_chomp3'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_chomp2'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_step1'
     bCanDodge=False
     DodgeSkillAdjust=0.100000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_hk_pain_01'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_hk_pain_02'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_hk_pain_03'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_hk_pain_03'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_die1'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_die2'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_die3'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_die2'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_sight1_2'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_sight2_1'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_sight3_1'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_hk_chatter_03'
     FireSound=Sound'tK_DoomMonsterPackv3.HellKnight.HellKnight_fb_create_02'
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
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.HellKnightMesh'
     DrawScale=1.200000
     PrePivot=(X=-10.000000,Y=-10.000000,Z=-75.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.HellKnight.HellKnight_Skin'
     Skins(1)=FinalBlend'tK_DoomMonsterPackv3.HellKnight.HellKnight_Gob_FinalBlend'
     Skins(2)=Shader'tK_DoomMonsterPackv3.HellKnight.HellKnight_Drool_Shader'
     Skins(3)=Texture'tK_DoomMonsterPackv3.HellKnight.HellKnight_Tongue_Skin'
     CollisionRadius=30.000000
     CollisionHeight=70.000000
     Begin Object Class=KarmaParamsSkel Name=HellKnightKParams
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
     KParams=KarmaParamsSkel'HellKnightKParams'

}
