class Mancubus extends Doom_Monster config(DoomMonsters);

var() Sound ProjFireSounds[2];

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('lmissile');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(ProjFireSounds[Rand(2)],SLOT_Interact);
        }
    }
}

function FireRProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('rmissile');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(ProjFireSounds[Rand(2)],SLOT_Interact);
        }
    }
}

simulated function LFireGlow()
{
    local Emitter Puff;
    local Coords BoneLocation;

    BoneLocation = GetBoneCoords('lmissile');
    Puff = Spawn(class'Revenant_SmokePuffs',self,,BoneLocation.Origin);
}

simulated function RFireGlow()
{
    local Emitter Puff;
    local Coords BoneLocation;

    BoneLocation = GetBoneCoords('rmissile');
    Puff = Spawn(class'Revenant_SmokePuffs',self,,BoneLocation.Origin);
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
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime && !Controller.bPreparingMove && Controller.InLatentExecution(Controller.LATENT_MOVETOWARD))
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
     Skins[2] = InvisMat;
     Skins[3] = InvisMat;
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
     ProjFireSounds(0)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_ft_03'
     ProjFireSounds(1)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_ft_01'
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=75.000000
     RangedAttackIntervalTime=3.500000
     NewHealth=500
     SpeciesName="Mancubus"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack1"
     MeleeAnims(2)="Attack1"
     MeleeAnims(3)="Attack1"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="MultiFire"
     RangedAttackAnims(1)="MultiFire"
     RangedAttackAnims(2)="MultiFire"
     RangedAttackAnims(3)="MultiFire"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Mancubus_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Mancubus_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Mancubus_MaterialSequence'
     BurnAnimTime=0.200000
     aimerror=50
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_chatter_combat2'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_chatter_combat2'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_chatter_combat2'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_chatter_combat2'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_step5'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_step5'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_step5'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_step5'
     bCanDodge=False
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_pain5'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_pain6'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_pain5'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_pain6'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_die3'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_die1'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_die3'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_die1'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_Chatter1'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_chatter2'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_sight2'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Mancubus.Mancubus_sight1'
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
     MeleeRange=170.000000
     GroundSpeed=200.000000
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
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.MancubusMesh'
     DrawScale=1.200000
     PrePivot=(Z=-60.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Mancubus.Mancubus_Skin'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Mancubus.Mancubus_Skin'
     Skins(2)=Shader'tK_DoomMonsterPackv3.Mancubus.Mancubus_Pipe_Shader'
     Skins(3)=Texture'tK_DoomMonsterPackv3.Mancubus.Mancubus_Pipe'
     CollisionRadius=50.000000
     CollisionHeight=60.000000
     Begin Object Class=KarmaParamsSkel Name=MancubusKParams
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
     KParams=KarmaParamsSkel'MancubusKParams'

}
