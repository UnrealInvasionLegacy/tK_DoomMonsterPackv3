class Doom_Monster extends Monster;

var() config bool bUseHealthConfig;
var() config bool bUseDamageConfig;
var() config bool bHasRagdoll;
var() config bool bSpawnDoomEffect;
var() config bool bAllowOverlays;

var() config float KillingForce;
var() config float UpKickForce;
var() config float MeleeDamage;
var() config float TauntIntervalTime;
var() config float RangedAttackIntervalTime;
var() config float ProjectileDamage;

var() config int NewHealth;

var() String SpeciesName;

var() Name MeleeAnims[4];
var() Name HitAnims[4];
var() Name DeathAnims[4];
var() Name TauntAnim;
var() Name RangedAttackAnims[4];

var() bool bLunging;
var() bool bMonsterHasBurnFX;
var() bool bBurning;
var() bool bCanLunge;
var() bool bSpecialDeath;

var() class<Projectile> ProjectileClass[2];
var() class<FinalBlend> BurnClass;
var() class<MaterialSequence> FadeClass;
var() class<Emitter> BurnDustClass;
var() class<Emitter> SpawnFXClass;

var() Material InvisMat;
var() MaterialSequence FadeFX;
var() FinalBlend BurnFX;

var() float LastTauntTime;
var() float BurnAnimTime;
var() float MinTimeBetweenPainAnims;
var() float LastPainAnimTime;
var() float LastRangedAttackTime;
var() float TeleportRadius;
var() float LastTeleportTime;

var() int AimError;
var() int BurnSpeed;

var() Emitter Sparks;

var() Sound MissSound[4];
var() Sound CollapseSound[2];
var() Sound MeleeAttackSounds[4];
var() sound FootStep[4];
var() Sound DeResSound;

var() NavigationPoint OldNode;

Replication
{
	Reliable if(Role==Role_Authority)
		bSpecialDeath, bAllowOverlays;
}

simulated function PostBeginPlay()
{
	local GameRules G, Doom_G;
	local bool bFoundRules;

	Super.PostBeginPlay();

	if(Role == Role_Authority)
	{
		bFoundRules = false;

		if(bSpawnDoomEffect)
		{
			Spawn(SpawnFXClass,Self,,Location);
		}

		if(bUseHealthConfig)
		{
			Health = NewHealth;
		}

		for(G = Level.Game.GameRulesModifiers; G != None; G = G.NextGameRules)
		{
			if(G.isA('Doom_GameRules'))
			{
				bFoundRules = true;
				break;
			}
		}

		if(!bFoundRules)
		{
			Doom_G = Spawn(class'Doom_GameRules');
			if( Level.Game.GameRulesModifiers == None )
			{
				Level.Game.GameRulesModifiers = Doom_G;
			}
			else
			{
				Level.Game.GameRulesModifiers.AddGameRules(Doom_G);
			}
		}
	}
}

simulated function SetOverlayMaterial(Material mat, float time, bool bOverride)
{
	if(bAllowOverlays)
	{
		Super.SetOverlayMaterial(mat,time,bOverride);
	}
}

function vector GetTeleLocation(vector OldLoc, vector TargetLocPoint)
{
	local int NodeCounter;
	local NavigationPoint NodeList[50];
	local NavigationPoint Node;

	foreach RadiusActors(class'NavigationPoint', Node, TeleportRadius, TargetLocPoint)
	{
		if(Node != None && Node.Region.ZoneNumber == Region.ZoneNumber)
		{
			if(NodeCounter < 50)
			{
				NodeList[NodeCounter] = Node;
				NodeCounter++;
			}
		}
	}

	Node = NodeList[RandRange(0, NodeCounter)];
	if(Node != None && Node != OldNode)
	{
		OldNode = Node;
		return Node.Location;
	}
	else
	{
		return OldLoc;
	}
}

simulated function RemoveEffects()
{
}

simulated function HideSkinEffects()
{
}

simulated function FadeSkins()
{
	if(FadeFX != None)
	{
		FadeFX.Reset();
		HideSkinEffects();
	}
}

simulated function BurnAway()
{
	if(BurnFX != None)
	{
		bBurning = true;
	}
}

simulated function Destroyed()
{
	RemoveEffects();
	FreeBurningObjects();

	if(Sparks != None)
	{
		Sparks.Kill();
	}

	Super.Destroyed();
}

simulated function FreeBurningObjects()
{
	local int i;

	bHidden = True;

	for(i=0;i<Skins.Length;i++)
	{
		Skins[i] = default.Skins[i];
	}

	if(FadeFX != None)
	{
		Level.ObjectPool.FreeObject(FadeFX);
		FadeFX = None;
	}

	if(BurnFX != None)
	{
		Level.ObjectPool.FreeObject(BurnFX);
		BurnFX = None;
	}
}

function MeleeAttack()
{
	if(Controller != None && Controller.Target != None)
	{
		if (MeleeDamageTarget(MeleeDamage, (30000 * Normal(Controller.Target.Location - Location))) )
		{
			bCanLunge = true;
			PlaySound(MeleeAttackSounds[Rand(4)], SLOT_Interact);
		}
		else
		{
			PlaySound(MissSound[Rand(4)], SLOT_Interact);
		}
	}
}

function RangedAttack(Actor A)
{
	if(bShotAnim || A == None || Controller == None)
	{
		return;
	}
}

function PlayMoverHitSound()
{
	PlaySound(HitSound[0], SLOT_Interact);
}

function bool SameSpeciesAs(Pawn P)
{
	return ( (Monster(P) != None) && Monster(P).Controller != None && (!Monster(P).Controller.IsA('FriendlyMonsterController')));
}

simulated function PlayDirectionalHit(Vector HitLoc)
{
 	PlayAnim(HitAnims[Rand(4)],, 0.1);
}

function Sound GetSound(xPawnSoundGroup.ESoundType soundType)
{
    return None;
}

function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType)
{
	if( Level.TimeSeconds - LastPainAnimTime < MinTimeBetweenPainAnims )
	{
		LastPainAnimTime = Level.TimeSeconds;
		PlayDirectionalHit(HitLocation);
	}

	if( Level.TimeSeconds - LastPainSound < MinTimeBetweenPainSounds )
	{
		return;
	}

	LastPainSound = Level.TimeSeconds;
	PlaySound(HitSound[Rand(4)], SLOT_Pain,2*TransientSoundVolume,,400);
}

simulated function RunStep()
{
   PlaySound(FootStep[Rand(4)], SLOT_Interact, FootStepVolume);
}

function AddVelocity( vector NewVelocity)
{
	if((Velocity.Z > 350) && (NewVelocity.Z > 1000))
        NewVelocity.Z *= 0.5;
    Velocity += NewVelocity;
}

simulated function SpawnSparks()
{
	if(bBurning)
	{
		Sparks = Spawn(BurnDustClass, self, , Location);
		if ( Sparks != None )
		{
			Sparks.SetBase(self);
		}
	}
}

simulated function StartDeRes()
{
	local int i;

    if( Level.NetMode == NM_DedicatedServer )
    {
        return;
	}

	for(i=0;i<Skins.Length;i++)
	{
		Skins[i] = DeResMat0;
	}

    AmbientSound = DeResSound;
    SoundRadius = 40.0;

    AmbientGlow=254;
    MaxLights=0;

    SetCollision(false, false, false);
    Projectors.Remove(0, Projectors.Length);
    bAcceptsProjectors = false;
    if(PlayerShadow != None)
    {
        PlayerShadow.bShadowActive = false;
	}

	RemoveFlamingEffects();
	SetOverlayMaterial(None, 0.0f, true);
	bDeRes = true;
}

simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
	local vector shotDir, hitLocRel, deathAngVel, shotStrength;
	local float maxDim;
	local string RagSkelName;
	local KarmaParamsSkel skelParams;
	local bool PlayersRagdoll;
	local PlayerController pc;

	AmbientSound = None;
    bCanTeleport = false;
    bReplicateMovement = false;
    bTearOff = true;
    bPlayedDeath = true;

    if (CurrentCombo != None)
        CurrentCombo.Destroy();

	HitDamageType = DamageType;
    TakeHitLocation = HitLoc;

    AnimBlendParams(1, 0.0);
    FireState = FS_None;
	LifeSpan = RagdollLifeSpan;

    GotoState('Dying');

	if ( Level.NetMode != NM_DedicatedServer && bHasRagdoll && !bSpecialDeath)
	{
		HideSkinEffects();
		RemoveEffects();
		AllocateBurningObjects();
		if(bMonsterHasBurnFX)
		{
			SetOverlayMaterial(None, 0.0f, true);
			SetCollision(false, false, false);
			Projectors.Remove(0, Projectors.Length);
			bAcceptsProjectors = false;
			if(PlayerShadow != None)
			{
				PlayerShadow.bShadowActive = false;
			}
			RemoveFlamingEffects();
			FadeSkins();
		}

		if(OldController != None)
			pc = PlayerController(OldController);
		if( pc != None && pc.ViewTarget == self )
			PlayersRagdoll = true;

		if(Level.PhysicsDetailLevel == PDL_Low && !PlayersRagdoll && (Level.TimeSeconds - LastRenderTime > 3) )
		{
			Destroy();
			return;
		}

		if(SpeciesName != "" && SpeciesName != "None")
		{
			RagSkelName = Species.static.GetRagSkelName(SpeciesName);
		}
		else
		{
			Log("No Species for: "@Self);
		}

		if( RagSkelName != "" )
		{
			KMakeRagdollAvailable();
		}

		if( KIsRagdollAvailable() && RagSkelName != "" )
		{
			skelParams = KarmaParamsSkel(KParams);
			skelParams.KSkeleton = RagSkelName;
			KParams = skelParams;

			StopAnimating(true);

			if(DamageType != None)
			{
				RagDeathVel = KillingForce;
				RagDeathUpKick = UpKickForce;
			}

			shotDir = Normal(TearOffMomentum);
			shotStrength = RagDeathVel * shotDir;

		    hitLocRel = TakeHitLocation - Location;

		    hitLocRel.X *= RagSpinScale;
		    hitLocRel.Y *= RagSpinScale;
		    deathAngVel = RagInvInertia * (hitLocRel Cross shotStrength);

			skelParams.KStartLinVel.X = 0.6 * Velocity.X;
			skelParams.KStartLinVel.Y = 0.6 * Velocity.Y;
			skelParams.KStartLinVel.Z = 1.0 * Velocity.Z;
    		skelParams.KStartLinVel += shotStrength;

			if(Velocity.Z > -10)
				skelParams.KStartLinVel.Z += RagDeathUpKick;

    		skelParams.KStartAngVel = deathAngVel;

			maxDim = Max(CollisionRadius, CollisionHeight);

    		skelParams.KShotStart = TakeHitLocation - (1 * shotDir);
    		skelParams.KShotEnd = TakeHitLocation + (2*maxDim*shotDir);
    		skelParams.KShotStrength = 10;

    		if(DamageType != None && DamageType.default.bCauseConvulsions)
    		{
    			RagConvulseMaterial=DamageType.default.DamageOverlayMaterial;
    			skelParams.bKDoConvulsions = true;
		    }

			KSetBlockKarma(true);

			SetPhysics(PHYS_KarmaRagdoll);
			if( PlayersRagdoll )
				skelParams.bKImportantRagdoll = true;

			return;
		}
	}

	Velocity += TearOffMomentum;
    BaseEyeHeight = Default.BaseEyeHeight;
    SetTwistLook(0, 0);
    SetInvisibility(0.0);
    PlayDirectionalDeath(HitLoc);
    SetPhysics(PHYS_Falling);
}

simulated function AllocateBurningObjects()
{
	if(BurnClass != None && FadeClass != None)
	{
		BurnFX = FinalBlend(Level.ObjectPool.AllocateObject(BurnClass));
		FadeFX = MaterialSequence(Level.ObjectPool.AllocateObject(FadeClass));

		if(BurnFX != None && FadeFX != None)
		{
			bMonsterHasBurnFX = True;
			SetUpFinalBlend(BurnFX);
		}
	}
}

simulated function SetUpFinalBlend(FinalBlend Mat)
{
	Mat.AlphaTest = True;
	Mat.AlphaRef = 0;
}

State Dying
{
ignores AnimEnd, Trigger, Bump, HitWall, HeadVolumeChange, PhysicsVolumeChange, Falling, BreathTimer;

   function Landed(vector HitNormal)
    {
        SetPhysics(PHYS_None);
        if ( !IsAnimating(0) )
            LandThump();
        Super.Landed(HitNormal);
    }

    simulated function Timer()
    {
        if ( !PlayerCanSeeMe() )
        {
            Destroy();
		}
        else if ( LifeSpan <= DeResTime && bDeRes == false )
        {
            StartDeRes();
		}
        else
        {
            SetTimer(1.0, false);
		}
    }

    simulated function Tick(float deltatime)
    {
		local int i;

		if(bBurning)
		{
			if(BurnFX != None)
			{
				if(BurnFX.AlphaRef != 255)
				{
					BurnFX.AlphaRef += BurnSpeed;
				}
				else
				{
					for(i=0;i<Skins.Length;i++)
					{
						Skins[i] = InvisMat;
					}

					bHidden = true;
					Disable('Tick');
				}
			}
		}
	}

Begin:
	PlayDyingSound();
	Sleep(0.5);
	if(bHasRagdoll && bMonsterHasBurnFX && !bSpecialDeath)
	{
		BurnAway();
	}

	Sleep(0.2);
	if(bHasRagdoll && bMonsterHasBurnFX && !bSpecialDeath)
	{
		SpawnSparks();
	}
}

simulated function PlayDirectionalDeath(Vector HitLoc)
{
	RemoveEffects();
	AllocateBurningObjects();
	if(bMonsterHasBurnFX && !bSpecialDeath)
	{
		HideSkinEffects();
		SetOverlayMaterial(None, 0.0f, true);
		SetCollision(false, false, false);
		Projectors.Remove(0, Projectors.Length);
		bAcceptsProjectors = false;
		if(PlayerShadow != None)
		{
			PlayerShadow.bShadowActive = false;
		}
		RemoveFlamingEffects();
 		PlayAnim(DeathAnims[Rand(4)],BurnAnimTime, 0.1);
	}
	else
	{
		FallBackDeath(HitLoc);
	}
}

simulated function FallBackDeath(vector HitLoc)
{
	PlayAnim(DeathAnims[Rand(4)],, 0.1);
}

//re-written slightly to take into account game rules
function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
    local int actualDamage;
    local Controller Killer;

    if ( damagetype == None )
    {
        if ( InstigatedBy != None )
            warn("No damagetype for damage by "$instigatedby$" with weapon "$InstigatedBy.Weapon);
        DamageType = class'DamageType';
    }

    if ( Role < ROLE_Authority )
    {
        log(self$" client damage type "$damageType$" by "$instigatedBy);
        return;
    }

    if ( Health <= 0 )
        return;

    if ((instigatedBy == None || instigatedBy.Controller == None) && DamageType.default.bDelayedDamage && DelayedDamageInstigatorController != None)
        instigatedBy = DelayedDamageInstigatorController.Pawn;

    if ( (Physics == PHYS_None) && (DrivenVehicle == None) )
        SetMovementPhysics();
    if (Physics == PHYS_Walking && damageType.default.bExtraMomentumZ)
        momentum.Z = FMax(momentum.Z, 0.4 * VSize(momentum));
    if ( instigatedBy == self )
        momentum *= 0.6;
    momentum = momentum/Mass;

    if (Weapon != None)
        Weapon.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType );
    if (DrivenVehicle != None)
            DrivenVehicle.AdjustDriverDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType );
    if ( (InstigatedBy != None) && InstigatedBy.HasUDamage() )
        Damage *= 2;
    actualDamage = Level.Game.ReduceDamage(Damage, self, instigatedBy, HitLocation, Momentum, DamageType);
    if( DamageType.default.bArmorStops && (actualDamage > 0) )
        actualDamage = ShieldAbsorb(actualDamage);

    //give game rules a chance
	if( Level.Game.GameRulesModifiers != None )
	{
		actualDamage = Level.Game.GameRulesModifiers.NetDamage( Damage, actualDamage,self,instigatedBy,HitLocation,Momentum,DamageType );
	}

    Health -= actualDamage;
    if ( HitLocation == vect(0,0,0) )
        HitLocation = Location;

    PlayHit(actualDamage,InstigatedBy, hitLocation, damageType, Momentum);
    if ( Health <= 0 )
    {
        // pawn died
        if ( DamageType.default.bCausedByWorld && (instigatedBy == None || instigatedBy == self) && LastHitBy != None )
            Killer = LastHitBy;
        else if ( instigatedBy != None )
            Killer = instigatedBy.GetKillerController();
        if ( Killer == None && DamageType.Default.bDelayedDamage )
            Killer = DelayedDamageInstigatorController;
        if ( bPhysicsAnimUpdate )
            TearOffMomentum = momentum;
        Died(Killer, damageType, HitLocation);
    }
    else
    {
        AddVelocity( momentum );
        if ( Controller != None )
            Controller.NotifyTakeHit(instigatedBy, HitLocation, actualDamage, DamageType, Momentum);
        if ( instigatedBy != None && instigatedBy != self )
            LastHitBy = instigatedBy.Controller;
    }
    MakeNoise(1.0);
}

event GainedChild(Actor Other)
{
	if(bUseDamageConfig)
	{
		if(Other.Class == ProjectileClass[0])
		{
			Projectile(Other).Damage = ProjectileDamage;
		}
		else if(Other.Class == ProjectileClass[1])
		{
			Projectile(Other).Damage = ProjectileDamage;
		}
	}

	Super.GainedChild(Other);
}

defaultproperties
{
     bUseHealthConfig=True
     bUseDamageConfig=True
     bSpawnDoomEffect=True
     bAllowOverlays=True
     KillingForce=100.000000
     UpKickForce=250.000000
     MeleeDamage=8.000000
     TauntIntervalTime=12.000000
     RangedAttackIntervalTime=3.000000
     ProjectileDamage=20.000000
     NewHealth=100
     SpeciesName="None"
     bCanLunge=True
     BurnClass=Class'tK_DoomMonsterPackv3.Doom_FinalBlend'
     FadeClass=Class'tK_DoomMonsterPackv3.Doom_MaterialSequence'
     BurnDustClass=Class'tK_DoomMonsterPackv3.Doom_Dust_Medium'
     SpawnFXClass=Class'tK_DoomMonsterPackv3.Doom_SpawnEffect'
     InvisMat=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     BurnAnimTime=1.000000
     MinTimeBetweenPainAnims=3.000000
     TeleportRadius=1000.000000
     BurnSpeed=1
     MissSound(0)=Sound'tK_DoomMonsterPackv3.Imp.imp_miss_01'
     MissSound(1)=Sound'tK_DoomMonsterPackv3.Imp.imp_miss_03'
     MissSound(2)=Sound'tK_DoomMonsterPackv3.Imp.imp_miss_01'
     MissSound(3)=Sound'tK_DoomMonsterPackv3.Imp.imp_miss_03'
     DodgeSkillAdjust=1.000000
     Species=Class'tK_DoomMonsterPackv3.Doom_Species'
     FootstepVolume=8.000000
     DeResTime=2.000000
     DeResGravScale=10.000000
}
