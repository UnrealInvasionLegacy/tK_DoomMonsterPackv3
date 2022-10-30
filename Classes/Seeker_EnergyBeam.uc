class Seeker_EnergyBeam extends xEmitter;

var() xEmitter Child[2];

simulated function Tick(float deltaTime)
{
	local int i;

	if(Level.NetMode != NM_DedicatedServer && !Level.bDropDetail && Level.DetailMode != DM_Low)
	{
		for(i=0;i<2;i++)
		{
			if(Child[i] == None)
			{
				Child[i] = Spawn(class'Seeker_ChildEnergyBeam', self);
				Child[i].mSizeRange[0] = 2.0 + 4.0 * (2 - i);
			}
		}

		for (i=0;i<2;i++)
		{
			if ( Child[i] != None )
			{
				Child[i].SetLocation( Location );
				Child[i].SetRotation( Rotation );
				Child[i].mSpawnVecA     = mSpawnVecA;
				Child[i].mWaveShift     = mWaveShift*0.6;
				Child[i].mWaveAmplitude = (i+1)*4.0 + mWaveAmplitude*((16.0-(i+1)*4.0)/16.0);
				Child[i].mWaveLockEnd   = true;
			}
		}
	}

	Super.Tick(deltaTime);
}

simulated function Destroyed()
{
	local int i;

	for(i=0;i<2;i++)
	{
		if ( Child[i] != None )
		{
			Child[i].Destroy();
		}
	}

	Super.Destroyed();
}

defaultproperties
{
     mParticleType=PT_Beam
     mStartParticles=3
     mMaxParticles=3
     mLifeRange(1)=0.000000
     mRegenDist=65.000000
     mSpinRange(1)=47299.492188
     mSizeRange(0)=2.000000
     mSizeRange(1)=3.000000
     mColorRange(0)=(B=75,G=75,R=75)
     mColorRange(1)=(B=0,G=0,R=0,A=0)
     mAttenuate=False
     mAttenKa=0.000000
     mWaveFrequency=0.060000
     mWaveAmplitude=8.000000
     mWaveShift=100000.000000
     mBendStrength=3.000000
     mWaveLockEnd=True
     LightType=LT_Steady
     LightHue=17
     LightSaturation=101
     LightBrightness=176.000000
     LightRadius=4.000000
     bDynamicLight=True
     bNetTemporary=False
     bReplicateInstigator=True
     RemoteRole=ROLE_SimulatedProxy
     Skins(0)=FinalBlend'tK_DoomMonsterPackv3.Seeker.Seeker_EnergyEffect'
     Style=STY_Additive
}
