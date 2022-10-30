class Imp extends Doom_Monster config(DoomMonsters);

var() Sound FireBallCreate;
var() Sound Squeals[12];
var() Emitter FireTrail;

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None )
    {
        BoneLocation = GetBoneCoords('rmissile');
        Proj = Spawn(ProjectileClass[0],self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));
        if(Proj != None)
        {
            PlaySound(FireSound,SLOT_Interact);
        }
    }
}

simulated function OutGoingSmallFireBall()
{
    FireTrail = Spawn(class'Imp_HandTrail', self);
    AttachToBone(FireTrail, 'rhand');
    PlaySound(FireBallCreate,SLOT_Interact);
}

simulated function Squeal()
{
    PlaySound(Squeals[Rand(12)],SLOT_Talk,8);
}

simulated function RemoveEffects()
{
    if(FireTrail != None)
    {
        FireTrail.Kill();
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
    else if (Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        LastTauntTime = Level.TimeSeconds;
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        bShotAnim = true;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
    else if( (Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime) && (Velocity == vect(0,0,0) || (!Controller.bPreparingMove && Controller.InLatentExecution(Controller.LATENT_MOVETOWARD)) ) )
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
     FireBallCreate=Sound'tK_DoomMonsterPackv3.Imp.imp_fireball_create_02'
     Squeals(0)=Sound'tK_DoomMonsterPackv3.Imp.imp_1shot_attack_01'
     Squeals(1)=Sound'tK_DoomMonsterPackv3.Imp.imp_attack_test1'
     Squeals(2)=Sound'tK_DoomMonsterPackv3.Imp.imp_attack_test2'
     Squeals(3)=Sound'tK_DoomMonsterPackv3.Imp.imp_attack4'
     Squeals(4)=Sound'tK_DoomMonsterPackv3.Imp.imp_breath_test24'
     Squeals(5)=Sound'tK_DoomMonsterPackv3.Imp.imp_breath_test22'
     Squeals(6)=Sound'tK_DoomMonsterPackv3.Imp.imp_breath_test25'
     Squeals(7)=Sound'tK_DoomMonsterPackv3.Imp.imp_sight_02'
     Squeals(8)=Sound'tK_DoomMonsterPackv3.Imp.imp_sight_03'
     Squeals(9)=Sound'tK_DoomMonsterPackv3.Imp.imp_sight2_03'
     Squeals(10)=Sound'tK_DoomMonsterPackv3.Imp.imp_squeal_test12'
     Squeals(11)=Sound'tK_DoomMonsterPackv3.Imp.imp_squeal21'
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=12.000000
     RangedAttackIntervalTime=3.500000
     NewHealth=130
     SpeciesName="Imp"
     MeleeAnims(0)="Slash1"
     MeleeAnims(1)="Slash2"
     MeleeAnims(2)="Slash3"
     MeleeAnims(3)="Slash1"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     RangedAttackAnims(0)="RangedAttack2"
     RangedAttackAnims(1)="RangedAttack2"
     RangedAttackAnims(2)="RangedAttack5"
     RangedAttackAnims(3)="RangedAttack5"
     ProjectileClass(0)=Class'tK_DoomMonsterPackv3.Imp_Projectile'
     ProjectileClass(1)=Class'tK_DoomMonsterPackv3.Imp_Projectile'
     FadeClass=Class'tK_DoomMonsterPackv3.Imp_MaterialSequence'
     BurnAnimTime=0.250000
     aimerror=5
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Imp.imp_hit_05'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Imp.imp_hit_01'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Imp.imp_hit_05'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Imp.imp_hit_01'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Imp.imp_footstep_01'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Imp.imp_footstep_03'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Imp.imp_footstep_01'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Imp.imp_footstep_03'
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Imp.imp_pain_test3'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Imp.imp_pain_test5'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Imp.imp_pain_test5'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Imp.imp_pain_test3'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Imp.imp_death_02'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Imp.imp_death_03'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Imp.imp_death_04'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Imp.imp_death_03'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Imp.imp_sight_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Imp.imp_breath_test25'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Imp.imp_sight_02'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Imp.imp_boomer'
     FireSound=Sound'tK_DoomMonsterPackv3.Imp.imp_fireball_throw_01'
     ScoringValue=5
     WallDodgeAnims(0)="DodgeL"
     WallDodgeAnims(1)="DodgeR"
     WallDodgeAnims(2)="DodgeL"
     WallDodgeAnims(3)="DodgeR"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="WalkFast"
     FireHeavyBurstAnim="WalkFast"
     FireRifleRapidAnim="WalkFast"
     FireRifleBurstAnim="WalkFast"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=40.000000
     GroundSpeed=450.000000
     Health=130
     MovementAnims(0)="WalkFast"
     MovementAnims(1)="WalkFast"
     MovementAnims(2)="WalkFast"
     MovementAnims(3)="WalkFast"
     TurnLeftAnim="WalkFast"
     TurnRightAnim="WalkFast"
     SwimAnims(0)="Scurry"
     SwimAnims(1)="Scurry"
     SwimAnims(2)="Scurry"
     SwimAnims(3)="Scurry"
     CrouchAnims(0)="WalkFast"
     CrouchAnims(1)="WalkFast"
     CrouchAnims(2)="WalkFast"
     CrouchAnims(3)="WalkFast"
     WalkAnims(0)="WalkFast"
     WalkAnims(1)="WalkFast"
     WalkAnims(2)="WalkFast"
     WalkAnims(3)="WalkFast"
     AirAnims(0)="JumpMid"
     AirAnims(1)="JumpMid"
     AirAnims(2)="JumpMid"
     AirAnims(3)="JumpMid"
     TakeoffAnims(0)="WalkFast"
     TakeoffAnims(1)="WalkFast"
     TakeoffAnims(2)="WalkFast"
     TakeoffAnims(3)="WalkFast"
     LandAnims(0)="JumpEnd"
     LandAnims(1)="JumpEnd"
     LandAnims(2)="JumpEnd"
     LandAnims(3)="JumpEnd"
     DoubleJumpAnims(0)="Scurry"
     DoubleJumpAnims(1)="Scurry"
     DoubleJumpAnims(2)="Scurry"
     DoubleJumpAnims(3)="Scurry"
     DodgeAnims(0)="DodgeL"
     DodgeAnims(1)="DodgeR"
     DodgeAnims(2)="DodgeL"
     DodgeAnims(3)="DodgeR"
     AirStillAnim="JumpMid"
     TakeoffStillAnim="JumpMid"
     CrouchTurnRightAnim="WalkFast"
     CrouchTurnLeftAnim="WalkFast"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.ImpMesh'
     DrawScale=1.250000
     PrePivot=(Z=-50.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Imp.Imp_Skin'
     CollisionRadius=20.000000
     CollisionHeight=55.000000
     Begin Object Class=KarmaParamsSkel Name=ImpKParams
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
     KParams=KarmaParamsSkel'ImpKParams'

}
