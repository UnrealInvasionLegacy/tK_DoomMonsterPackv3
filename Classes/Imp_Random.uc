class Imp_Random extends Imp;

var() Material ImpSkins[6];
var() class<MaterialSequence> ImpFadeClass[6];

simulated function PostBeginPlay()
{
	local int i;

	i = Rand(6);
	Skins[0] = ImpSkins[i];
	FadeClass = ImpFadeClass[i];
	Super.PostBeginPlay();
}

defaultproperties
{
     ImpSkins(0)=Texture'tK_DoomMonsterPackv3.Imp.Imp_Skin_Purple'
     ImpSkins(1)=Texture'tK_DoomMonsterPackv3.Imp.Imp_Skin_Red'
     ImpSkins(2)=Texture'tK_DoomMonsterPackv3.Imp.Imp_Skin'
     ImpSkins(3)=Texture'tK_DoomMonsterPackv3.Imp.Imp_Skin_Blue'
     ImpSkins(4)=Texture'tK_DoomMonsterPackv3.Imp.Imp_Skin_Dark'
     ImpSkins(5)=Texture'tK_DoomMonsterPackv3.Imp.Imp_Skin_Green'
     ImpFadeClass(0)=Class'tK_DoomMonsterPackv3.Imp_Purple_MaterialSequence'
     ImpFadeClass(1)=Class'tK_DoomMonsterPackv3.Imp_Red_MaterialSequence'
     ImpFadeClass(2)=Class'tK_DoomMonsterPackv3.Imp_MaterialSequence'
     ImpFadeClass(3)=Class'tK_DoomMonsterPackv3.Imp_Blue_MaterialSequence'
     ImpFadeClass(4)=Class'tK_DoomMonsterPackv3.Imp_Dark_MaterialSequence'
     ImpFadeClass(5)=Class'tK_DoomMonsterPackv3.Imp_Green_MaterialSequence'
}
