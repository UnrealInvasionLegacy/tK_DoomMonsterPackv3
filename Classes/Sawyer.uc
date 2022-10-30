class Sawyer extends Doom_Monster config(DoomMonsters);

var() config bool bSawyerCanDecapitate;

function RangedAttack(Actor A)
{
    local float Dist;

    Super.RangedAttack(A);

    Dist = VSize(A.Location - Location);

    if(Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        PlaySound(MeleeAttackSounds[Rand(4)], SLOT_Interact);
        SetAnimAction(MeleeAnims[Rand(4)]);
        bShotAnim = true;
    }
}

function TargetKilledBy(pawn EventInstigator, pawn Victim)
{
    local Controller Killer;

    Victim.Health = 0;
    if (EventInstigator != None)
    {
        Killer = EventInstigator.Controller;
    }
    Victim.Died( Killer, class'DamType_Sawyer_ChainSaw', Victim.Location);
}

function MeleeAttack()
{
    if(Controller != None && Controller.Target != None)
    {
        if (MeleeDamageTarget(MeleeDamage, (30000 * Normal(Controller.Target.Location - Location))) )
        {
            if(bSawyerCanDecapitate && xPawn(Controller.Target) != None)
            {
                xPawn(Controller.Target).HideBone('head');
                if(xPawn(Controller.Target).Health > 0)
                {
                    TargetKilledBy(self, xPawn(Controller.Target));
                }
            }
            bCanLunge = true;
        }
    }
}

simulated function HideSkinEffects()
{
     Skins[1] = InvisMat;
     Skins[2] = InvisMat;
     Skins[3] = InvisMat;
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
        Skins[3] = BurnFX;
        bBurning = true;
    }
}

defaultproperties
{
     bSawyerCanDecapitate=True
     bHasRagdoll=True
     bAllowOverlays=False
     KillingForce=200.000000
     UpKickForce=500.000000
     MeleeDamage=20.000000
     NewHealth=180
     SpeciesName="Sawyer"
     MeleeAnims(0)="MeleeWalk01"
     MeleeAnims(1)="MeleeWalk02"
     MeleeAnims(2)="MeleeWalk01"
     MeleeAnims(3)="MeleeWalk02"
     HitAnims(0)="Pain01"
     HitAnims(1)="Pain02"
     HitAnims(2)="Pain03"
     HitAnims(3)="Pain04"
     DeathAnims(0)="DeathF"
     DeathAnims(1)="DeathB"
     DeathAnims(2)="DeathF"
     DeathAnims(3)="DeathB"
     FadeClass=Class'tK_DoomMonsterPackv3.Sawyer_MaterialSequence'
     BurnAnimTime=0.150000
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chainsaw_attack_01'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chainsaw_attack_02'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chainsaw_attack_03'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chainsaw_attack_02'
     Footstep(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step1'
     Footstep(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step2'
     Footstep(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step3'
     Footstep(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.step4'
     bCanDodge=False
     HitSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_01'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_02'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_03'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_04'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.death_01'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.death_03'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.death_04'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.death_03'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_03'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_combat_01'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_combat_02'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_combat_03'
     ScoringValue=5
     WallDodgeAnims(0)="Run"
     WallDodgeAnims(1)="Run"
     WallDodgeAnims(2)="Run"
     WallDodgeAnims(3)="Run"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Idle"
     FireHeavyBurstAnim="Idle"
     FireRifleRapidAnim="Idle"
     FireRifleBurstAnim="Idle"
     bCanJump=False
     bCanWalkOffLedges=True
     MeleeRange=70.000000
     GroundSpeed=350.000000
     Health=180
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
     DodgeAnims(0)="Run"
     DodgeAnims(1)="Run"
     DodgeAnims(2)="Run"
     DodgeAnims(3)="Run"
     AirStillAnim="Run"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tK_DoomMonsterPackv3.SawyerMesh'
     DrawScale=1.200000
     PrePivot=(Z=-50.000000)
     Skins(0)=Texture'tK_DoomMonsterPackv3.Sawyer.Sawyer_Skin'
     Skins(1)=Shader'tK_DoomMonsterPackv3.Sawyer.Sawyer_Hair_Shader'
     Skins(2)=TexPanner'tK_DoomMonsterPackv3.Sawyer.Sawyer_Chain_Panner'
     Skins(3)=Texture'tK_DoomMonsterPackv3.Sawyer.Sawyer_Chainsaw'
     Skins(4)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     CollisionRadius=15.000000
     CollisionHeight=50.000000
     Begin Object Class=KarmaParamsSkel Name=SawyerKParams
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
     KParams=KarmaParamsSkel'SawyerKParams'

}
