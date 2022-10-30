class Cherub extends Doom_Monster config(DoomMonsters);

var() Sound FlutterSounds[2];
var() Sound RandomTaunts[10];

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    SetTimer(RandRange(3.00,5.00),true);
}

simulated function Timer()
{
    bCanLunge = true;
    PlaySound(RandomTaunts[Rand(10)], SLOT_Interact, 8);
    Super.Timer();
    SetTimer(RandRange(3.00,12.00),true);
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

simulated function Flutter()
{
    PlaySound(FlutterSounds[Rand(2)], SLOT_Interact, 8);
}

function SetOverlayMaterial(Material mat, float time, bool bOverride)
{
}

simulated function BurnAway()
{
    if(BurnFX != None)
    {
        Skins[3] = BurnFX;
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
    else if(Level.TimeSeconds - LastTauntTime > TauntIntervalTime)
    {
        SetAnimAction(TauntAnim);
        PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
        LastTauntTime = Level.TimeSeconds;
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
    Skins[0] = InvisMat;
    Skins[1] = InvisMat;
    Skins[2] = InvisMat;
    Skins[4] = InvisMat;
    Skins[5] = InvisMat;
}

simulated function FadeSkins()
{
    if(FadeFX != None)
    {
        FadeFX.Reset();
        Skins[3] = FadeFX;
        HideSkinEffects();
    }
}

defaultproperties
{
     FlutterSounds(0)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_flutter_01'
     FlutterSounds(1)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_flutter_02'
     RandomTaunts(0)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_idle_01'
     RandomTaunts(1)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_chatter_combat_01'
     RandomTaunts(2)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_chatter_combat_02'
     RandomTaunts(3)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_idle_01'
     RandomTaunts(4)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_idle_02'
     RandomTaunts(5)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_idle_03'
     RandomTaunts(6)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_sight_03'
     RandomTaunts(7)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_sight_01'
     RandomTaunts(8)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_sight_02'
     RandomTaunts(9)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_sight_03'
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=12.000000
     NewHealth=75
     SpeciesName="Cherub"
     MeleeAnims(0)="Attack"
     MeleeAnims(1)="Attack"
     MeleeAnims(2)="Attack"
     MeleeAnims(3)="Attack"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain03"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     TauntAnim="Sight"
     FadeClass=Class'tK_DoomMonsterPackv3.Cherub_MaterialSequence'
     BurnAnimTime=0.150000
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_attack_01'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_attack_01'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_attack_01'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_attack_01'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_step2'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_step2'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_step2'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_step2'
     DodgeSkillAdjust=3.000000
     HitSound(0)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_pain_03a'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_pain_02a'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_pain_03a'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_pain_04a'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_death_01'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_death_02'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_death_01'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_death_02'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_sight_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_sight_02'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_sight_03'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.Cherub.Cherub_evillaugh2'
     ScoringValue=5
     WallDodgeAnims(0)="DodgeL"
     WallDodgeAnims(1)="DodgeR"
     WallDodgeAnims(2)="DodgeL"
     WallDodgeAnims(3)="DodgeR"
     IdleHeavyAnim="Play_Dead"
     IdleRifleAnim="Play_Dead"
     FireHeavyRapidAnim="Play_Dead"
     FireHeavyBurstAnim="Play_Dead"
     FireRifleRapidAnim="Play_Dead"
     FireRifleBurstAnim="Play_Dead"
     MeleeRange=80.000000
     GroundSpeed=400.000000
     Health=75
     MovementAnims(0)="Crawl1"
     MovementAnims(1)="Crawl1"
     MovementAnims(2)="Crawl2"
     MovementAnims(3)="Crawl2"
     TurnLeftAnim="Crawl2"
     TurnRightAnim="Crawl2"
     SwimAnims(0)="Crawl1"
     SwimAnims(1)="Crawl1"
     SwimAnims(2)="Crawl1"
     SwimAnims(3)="Crawl1"
     CrouchAnims(0)="Crawl1"
     CrouchAnims(1)="Crawl1"
     CrouchAnims(2)="Crawl1"
     CrouchAnims(3)="Crawl1"
     WalkAnims(0)="Crawl1"
     WalkAnims(1)="Crawl1"
     WalkAnims(2)="Crawl1"
     WalkAnims(3)="Crawl1"
     AirAnims(0)="Jump_Mid"
     AirAnims(1)="Jump_Mid"
     AirAnims(2)="Jump_Mid"
     AirAnims(3)="Jump_Mid"
     TakeoffAnims(0)="Jump_Start"
     TakeoffAnims(1)="Jump_Start"
     TakeoffAnims(2)="Jump_Start"
     TakeoffAnims(3)="Jump_Start"
     LandAnims(0)="Jump_Land"
     LandAnims(1)="Jump_Land"
     LandAnims(2)="Jump_Land"
     LandAnims(3)="Jump_Land"
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
     CrouchTurnRightAnim="Crawl1"
     CrouchTurnLeftAnim="Crawl1"
     IdleCrouchAnim="Play_Dead"
     IdleSwimAnim="Play_Dead"
     IdleWeaponAnim="Play_Dead"
     IdleRestAnim="Play_Dead"
     IdleChatAnim="Play_Dead"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.CherubMesh'
     DrawScale=1.500000
     PrePivot=(Z=-22.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(2)=Shader'tK_DoomMonsterPackv3.Cherub.Cherub_Teeth'
     Skins(3)=Texture'tK_DoomMonsterPackv3.Cherub.Cherub_Skin'
     Skins(4)=Shader'tK_DoomMonsterPackv3.Cherub.Cherub_Wing_Shader'
     Skins(5)=Shader'tK_DoomMonsterPackv3.Cherub.Cherub_Wing_Shader'
     CollisionHeight=20.000000
     Begin Object Class=KarmaParamsSkel Name=CherubKParams
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
     KParams=KarmaParamsSkel'CherubKParams'

}
