class Revenant extends Doom_Monster config(DoomMonsters);

var() Material WeaponFlashLight[3];

simulated function FireProjectile()
{
    FireRightProjectile();
    FireLeftProjectile();
}

function FireRightProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None && Controller.Target != None)
    {
        BoneLocation = GetBoneCoords('r_gun');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Doom_Projectile(Proj) != None)
        {
            Doom_Projectile(Proj).Seeking = Controller.Target;
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

function FireLeftProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None && Controller.Target != None)
    {
        BoneLocation = GetBoneCoords('l_gun');
        Proj = Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Doom_Projectile(Proj) != None)
        {
            Doom_Projectile(Proj).Seeking = Controller.Target;
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function RocketFlashOnL()
{
    local Emitter Puff;
    local Coords BoneLocation;

    BoneLocation = GetBoneCoords('LMissileBone');
    Puff = Spawn(class'Revenant_SmokePuffs',self,,BoneLocation.Origin);
    Skins[3] = WeaponFlashLight[0];
    Skins[4] = WeaponFlashLight[2];
    Skins[5] = WeaponFlashLight[1];
}

simulated function RocketFlashOnR()
{
    local Emitter Puff;
    local Coords BoneLocation;

    BoneLocation = GetBoneCoords('RMissileBone');
    Puff = Spawn(class'Revenant_SmokePuffs',self,,BoneLocation.Origin);
    Skins[6] = WeaponFlashLight[0];
    Skins[7] = WeaponFlashLight[2];
    Skins[8] = WeaponFlashLight[1];
}

simulated function RocketFlashOffL()
{
    Skins[3] = InvisMat;
    Skins[4] = InvisMat;
    Skins[5] = InvisMat;
}

simulated function RocketFlashOffR()
{
    Skins[6] = InvisMat;
    Skins[7] = InvisMat;
    Skins[8] = InvisMat;
}

simulated function RocketFlashOffBoth()
{
    RocketFlashOffL();
    RocketFlashOffR();
}

simulated function RocketFlashOnBoth()
{
    RocketFlashOnL();
    RocketFlashOnR();
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
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        LastRangedAttackTime = Level.TimeSeconds;
        bShotAnim = true;
    }
}

simulated function HideSkinEffects()
{
    Skins[0] = InvisMat;
    Skins[2] = InvisMat;
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
        Skins[1] = FadeFX;
        HideSkinEffects();
    }
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[1] = BurnFX;
        bBurning = true;
    }
}

defaultproperties
{
     WeaponFlashLight(0)=Shader'tK_DoomMonsterPackv3.Sentry.Sentry_LowerWeaponFlash'
     WeaponFlashLight(1)=Shader'tK_DoomMonsterPackv3.Revenant.Revenant_Flash'
     WeaponFlashLight(2)=Shader'tK_DoomMonsterPackv3.Revenant.Revenant_WeaponFlash3'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=16.000000
     NewHealth=270
     SpeciesName="Revenant"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack3"
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
     RangedAttackAnims(0)="RangedAttackLeft"
     RangedAttackAnims(1)="RangedAttackRight"
     RangedAttackAnims(2)="RangedAttackBoth"
     RangedAttackAnims(3)="RangedAttackBoth"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Revenant_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Revenant_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Revenant_MaterialSequence'
     BurnAnimTime=0.250000
     aimerror=600
     MissSound(0)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_melee5'
     MissSound(1)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_melee5'
     MissSound(2)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_melee5'
     MissSound(3)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_melee5'
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_chatter_combat2'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_chatter_combat3'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_chatter_combat2'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_chatter4'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_step1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_step4'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_step1'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_step4'
     DeResSound=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_burn'
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_pain1_alt1'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_pain3_alt1'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_pain1_alt1'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_pain3_alt1'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_die2_alt1'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_die2_alt1'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_die2_alt1'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_die2_alt1'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_sight1_1'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Revenant.Revenant_sight2_1_alt1'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Revenant.revenant_1'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Revenant.revenant_2'
     FireSound=Sound'tK_DoomMonsterPackv3.Revenant.revenant_rocket_fire'
     ScoringValue=8
     GibGroupClass=Class'tK_DoomMonsterPackv3.Revenant_GibGroup'
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
     MeleeRange=30.000000
     GroundSpeed=340.000000
     Health=270
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
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.RevenantMesh'
     DrawScale=1.200000
     PrePivot=(Z=-60.000000)
     Skins(0)=Shader'tK_DoomMonsterPackv3.Revenant.Revenant_Shader'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Revenant.Revenant_Bone_Shader'
     Skins(2)=Shader'tK_DoomMonsterPackv3.Revenant.Revenant_Eyes_Shader'
     Skins(3)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(4)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(5)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(6)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(7)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(8)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     CollisionHeight=60.000000
     Begin Object Class=KarmaParamsSkel Name=RevenantKParams
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
     KParams=KarmaParamsSkel'RevenantKParams'

}
