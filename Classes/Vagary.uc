class Vagary extends Doom_Monster config(DoomMonsters);

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('RFire');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

function FireLProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('LFire');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function ThrowBody()
{
    MeleeAttack();
}

simulated function GrabBody()
{
    MeleeAttack();
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
    else if ( Velocity == vect(0,0,0) && Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        SetAnimAction(RangedAttackAnims[1]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        SetAnimAction(RangedAttackAnims[0]);
        bShotAnim = true;
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
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=60.000000
     RangedAttackIntervalTime=2.500000
     NewHealth=500
     SpeciesName="Vagary"
     MeleeAnims(0)="Melee1"
     MeleeAnims(1)="PortalAttack"
     MeleeAnims(2)="Melee1"
     MeleeAnims(3)="PortalAttack"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathCurl"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="RangedAttack1"
     RangedAttackAnims(1)="RangedAttack2"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Vagary_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Vagary_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Vagary_MaterialSequence'
     BurnAnimTime=0.500000
     aimerror=10
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Attack1'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Attack2'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Attack3'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Attack2'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_footstep1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_footstep2'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_footstep3'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_footstep4'
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_pain_right_arm'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_pain_left_arm'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Pain_Head'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Pain'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Death'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Death'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Death'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_Death'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_caverns_scream'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_chatter_combat2'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_chatter_combat3'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_wake_solo'
     FireSound=Sound'tK_DoomMonsterPackv3.Vagary.Vagary_range_attack'
     ScoringValue=15
     WallDodgeAnims(0)="DodgeL"
     WallDodgeAnims(1)="DodgeR"
     WallDodgeAnims(2)="DodgeL"
     WallDodgeAnims(3)="DodgeR"
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
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.VagaryMesh'
     DrawScale=1.500000
     PrePivot=(Z=-55.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Vagary.Vagary_Skin'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Vagary.Vagary_Teeth_Shader'
     Skins(2)=Shader'tK_DoomMonsterPackv3.Vagary.Vagary_Sac_Shader'
     CollisionRadius=50.000000
     CollisionHeight=55.000000
     Begin Object Class=KarmaParamsSkel Name=VagaryKParams
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
     KParams=KarmaParamsSkel'VagaryKParams'

}
