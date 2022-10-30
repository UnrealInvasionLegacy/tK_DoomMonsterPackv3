class Trite extends Doom_Monster config(DoomMonsters);

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(Role == Role_Authority)
    {
        bSpecialDeath = fRand() > 0.75;
    }

    SetTimer(RandRange(5.00,15.00),false);
}

simulated function Timer()
{
    bCanLunge = true;
    SetTimer(RandRange(4.00,12.00),false);
}

singular function Bump(actor Other)
{
    local name Anim;
    local float frame,rate;

    if ( bShotAnim && bLunging )
    {
        bCanLunge = true;
        bLunging = false;
        GetAnimParams(0, Anim,frame,rate);
        if ( Anim == 'Jump_Mid' )
        {
            MeleeAttack();
        }
    }
    Super.Bump(Other);
}

simulated function Landed(vector HitNormal)
{
    bLunging = false;
    Super.Landed(HitNormal);
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

    if(Dist > 350)
    {
        return;
    }
    else if(Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
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
    else if(!bLunging && bCanLunge)
    {
        bCanLunge = false;
        bLunging = true;
        Enable('Bump');
        SetAnimAction('Jump_Mid');
        bShotAnim = true;
        Velocity = 700 * Normal(A.Location + A.CollisionHeight * vect(0,0,0.75) - Location);
        if ( Dist > CollisionRadius + A.CollisionRadius + 35 )
        {
            Velocity.Z += 0.7 * Dist;
        }
        SetPhysics(PHYS_Falling);
    }
}

simulated function HideSkinEffects()
{
     Skins[1] = InvisMat;
}

simulated function Implode()
{
    PlaySound(SoundGroup'WeaponSounds.BioRifle.BioRifleGoo1');
    if(Level.NetMode != NM_DedicatedServer)
    {
        Spawn(class'Trite_Explode',self,,GetBoneCoords('Head').Origin);
    }

    bHidden = true;
}

simulated function FadeSkins()
{
    HideSkinEffects();
}

simulated function FallBackDeath(vector HitLoc)
{
    PlayAnim('DeathCurlExplode',1.00);
}

defaultproperties
{
     bHasRagdoll=True
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=12.000000
     NewHealth=80
     SpeciesName="Trite"
     MeleeAnims(0)="Attack1"
     MeleeAnims(1)="Attack2"
     MeleeAnims(2)="Attack1"
     MeleeAnims(3)="Attack2"
     HitAnims(0)="Pain_L"
     HitAnims(1)="Pain_R"
     HitAnims(2)="Pain_Head"
     HitAnims(3)="Pain_Head"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathCurlExplode"
     DeathAnims(3)="DeathF"
     TauntAnim="Sight"
     FadeClass=Class'tK_DoomMonsterPackv3.Trite_MaterialSequence'
     BurnDustClass=Class'tK_DoomMonsterPackv3.Doom_Dust_Small'
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Trite.Trite_attack18'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Trite.Trite_chomp1'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Trite.Trite_attack13'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Trite.Trite_attack11'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Trite.trite_walk1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Trite.trite_walk2'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Trite.trite_walk3'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Trite.trite_walk4'
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Trite.Trite_pain13'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Trite.Trite_pain21'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Trite.Trite_pain22'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Trite.Trite_pain10'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Trite.Trite_death21'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Trite.Trite_Death22'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Trite.Trite_death23'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Trite.Trite_death21'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Trite.Trite_sight3'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Trite.Trite_sight11'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Trite.Trite_sight13'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Trite.Trite_sight5'
     ScoringValue=5
     GibGroupClass=Class'XEffects.xAlienGibGroup'
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
     MeleeRange=80.000000
     GroundSpeed=400.000000
     Health=80
     MovementAnims(0)="Walk1"
     MovementAnims(1)="Walk1"
     MovementAnims(2)="Walk1"
     MovementAnims(3)="Walk1"
     TurnLeftAnim="Walk2"
     TurnRightAnim="Walk2"
     SwimAnims(0)="Walk1"
     SwimAnims(1)="Walk1"
     SwimAnims(2)="Walk1"
     SwimAnims(3)="Walk1"
     CrouchAnims(0)="Walk3"
     CrouchAnims(1)="Walk3"
     CrouchAnims(2)="Walk3"
     CrouchAnims(3)="Walk3"
     WalkAnims(0)="Walk1"
     WalkAnims(1)="Walk1"
     WalkAnims(2)="Walk1"
     WalkAnims(3)="Walk1"
     AirAnims(0)="Jump_Mid"
     AirAnims(1)="Jump_Mid"
     AirAnims(2)="Jump_Mid"
     AirAnims(3)="Jump_Mid"
     TakeoffAnims(0)="Jump_Start"
     TakeoffAnims(1)="Jump_Start"
     TakeoffAnims(2)="Jump_Start"
     TakeoffAnims(3)="Jump_Start"
     LandAnims(0)="Jump_Start"
     LandAnims(1)="Jump_Start"
     LandAnims(2)="Jump_Start"
     LandAnims(3)="Jump_Start"
     DoubleJumpAnims(0)="Jump_Start"
     DoubleJumpAnims(1)="Jump_Start"
     DoubleJumpAnims(2)="Jump_Start"
     DoubleJumpAnims(3)="Jump_Start"
     DodgeAnims(0)="DodgeL"
     DodgeAnims(1)="DodgeR"
     DodgeAnims(2)="DodgeL"
     DodgeAnims(3)="DodgeR"
     AirStillAnim="Jump_Mid"
     TakeoffStillAnim="Jump_Start"
     CrouchTurnRightAnim="Walk3"
     CrouchTurnLeftAnim="Walk3"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.TriteMesh'
     DrawScale=1.800000
     PrePivot=(Z=-30.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Trite.Trite_Skin'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     CollisionRadius=40.000000
     CollisionHeight=30.000000
     Begin Object Class=KarmaParamsSkel Name=TriteKParams
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
     KParams=KarmaParamsSkel'TriteKParams'

}
