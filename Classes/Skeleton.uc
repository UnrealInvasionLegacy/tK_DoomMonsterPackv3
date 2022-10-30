class Skeleton extends Boney;

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
}

simulated function HideSkinEffects()
{
     Skins[0] = InvisMat;
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
     bAllowOverlays=False
     MeleeDamage=15.000000
     NewHealth=50
     FadeClass=Class'tK_DoomMonsterPackv3.Skeleton_MaterialSequence'
     BurnAnimTime=0.250000
     MissSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_whoosh1'
     MissSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_whoosh2'
     MissSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_whoosh3'
     MissSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet01.zombie_whoosh2'
     MeleeAttackSounds(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.attack_04'
     MeleeAttackSounds(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.attack_05'
     MeleeAttackSounds(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.attack_04'
     MeleeAttackSounds(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.attack_05'
     HitSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_01'
     HitSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_02'
     HitSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_03'
     HitSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.pain_04'
     DeathSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.death_01'
     DeathSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.death_03'
     DeathSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.death_04'
     DeathSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.death_01'
     ChallengeSound(0)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_01'
     ChallengeSound(1)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_02'
     ChallengeSound(2)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.chatter_03'
     ChallengeSound(3)=Sound'tK_DoomMonsterPackv3.ZombieSoundSet02.sight_01'
     Skins(0)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     Skins(1)=Texture'tK_DoomMonsterPackv3.Boney.Skeleton_Skin'
}
