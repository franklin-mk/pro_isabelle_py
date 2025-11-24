theory Sugarcane_Diseases
  imports Main
begin

(* ============================================ *)
(* SECTION 1: Type Definitions *)
(* ============================================ *)

datatype disease = 
    RedRot | Smut | Wilt | SettRot | RatoonStuntingDisease |
    GrassyShoot | Mosaic | YellowLeafDisease | PokkahBoeng |
    LeafFleck | Rust | EyeSpot | BrownSpot | YellowSpot |
    BrownStripe | RingSpot | LeafScald | LeafBlast |
    CurvulariaLeafSpot | OrangeRust | FijiDisease | RustBrown |
    DeadHeart | LeafMines | BunchyTop | ConstrictedInternodes |
    Boreholes | LeafSheathDecay | PhloemSapFeeding | SootyMoldDevelopment |
    LeafYellowing | LeafPaling | SootyMold | SapSucking | DeadTissue |
    SugarcaneYellowLeafLuteovirus 

datatype symptom =
    (* Red Rot *)
    ReddenedAreasWithWhitePatches | AffectedParenchymatousTissues |
    HollowCavityWithGreyMycelium | DarkBrownishLesionsOnRind |
    NecrosisOnNodalRegion | CutEndsShowReddening | EntireStoolDries |
    (* Smut *)
    ExcessiveTilleringLanky | BlackWhipStructures | WhipLikeSorusBearingStructures |
    StuntedThinCanes | NarrowWeakLeaves | ProliferatingAxillaryBuds | StemOrLeafGalls |
    (* Wilt *)
    YellowishStoolsDrying | DullBrownishDiscolourationInternal |
    LinearPithCavities | DriedCanesDetoppedCrown | YellowishFoliage |
    (* Sett Rot *)
    PineappleOdor | SettsFailToGerminate | SettRotBeforeGermination |
    ShootDieAfterEmergence | StuntedChloroticShoots | SettBlackeningWithSpores |
    WiltingAndWithering |
    (* Ratoon Stunting *)
    StuntedGrowth | ReducedTillering | ThinStalksWithShortenedInternodes |
    VascularBundleDiscolourationNodes |
    (* Grassy Shoot *)
    NarrowLeaves | GrassLikeAppearance |
    (* Mosaic *)
    ChloroticAreasYoungLeaves | YellowishStripes | MildMottling | Stunting | Yellowing | Necrosis |
    (* Yellow Leaf Disease *)
    YellowishMidribLowerSurface | ReddishPinkishDiscolourationMidrib |
    ShorteningInternodesTop | BunchingLeavesTop | ReducedCaneThickness |
    (* Pokkah Boeng *)
    MalformedTwistedTop | WhiteMyceliumOnLeaves | WrinklingTwistingShortening |
    IrregularReddishStripesSpecks | KnifeCutSymptoms | TopRot |
    (* Leaf Fleck *)
    FlecksSpecksLeafLamina | PrematureLeafDrying | TinyChloroticFlecks |
    MottlingOnMiddleLeaves | ReddeningAndDrying | FleckCoalescence | ReducedPlantVigor |
    (* Rust *)
    RustPustules | SmallChloroticPuncta | BrownTawnyPustules | LesionCoalescence |
    ReducedCanopyDensity |
    (* Orange Rust *)
    OrangePowderyPustules | YellowOrangeStreaks | PustulesBetweenVeins | LeafYelowing |
    (* Eye Spot *)
    EyeShapedSpots | MinuteWaterSoakedSpots | ReddishBrownEllipticalLesions |
    Lesions05To4mmLong | GreyOrTanCenter | ReddishBrownYellowishRunners |
    LesionsMayCoalesce | SeedlingBlightAndTopRot |
    (* Brown Spot *)
    BrownSpots | RedBrownOvalLesions | LesionSize3To15mm | NarrowYellowHalo |
    SpotsMayCoalesce |
    (* Yellow Spot *)
    YellowSpots | SmallYellowLesions | LesionsEnlargeAndTurnBrown |
    SplotchyYellowLesions | GrayFuzzyDown |
    (* Brown Stripe *)
    BrownStripes | BrownLesionsAlongLeafBlades | NarrowDarkBrownStripes |
    LesionsMayMerge |
    (* Ring Spot *)
    RingShapedSpots | SmallElongatedSpots | LargerElongatedLesions |
    SmallBlackFruitingBodies |
    (* Leaf Blast *)
    YellowNarrowSpots | SmallYellowishSpots | SpotsTurnBrown | WholeLeafWithers |
    (* Curvularia Leaf Spot *)
    PaleYellowRibbon | RedChangesAroundLesion | SmallToMediumBrownLesions |
    ReddishMargin | LesionsMayCoalesceEarlySenescence |
    (* Leaf Scald *)
    WhiteStripesOnLeaves | LeafYellowingFromTip | CaneDeathInAdvancedInfection |
    (* Fiji Disease *)
    LeafRustBrownPatches | WiltingOfWholePlant

datatype pest =
    ColletotrichumFalcatum | SporisporiumScitamineum | FusariumSacchari |
    CeratocystisParadoxa | LeifsioniaXyli | SugarcaneGrassyShootPhytoplasma |
    SugarcaneMosaicVirus | SugarcaneYellowLeafVirus | FusariumVerticillioides |
    FusariumProliferatum | SugarcaneBacilliformVirus | FoliarFungus |
    XanthomonasAlbilineans | ParaphaeosphaeriaMichotii | CurvulariaLunata |
    Delphacidae | Aphididae | Coccidae | Pseudococcidae | Buprestidae |
    EarlyShootBorer | TopShootBorer | InterNodeBorer | StalkBorer | RootBorer |
    LeafHopper | WhiteFly | MealyBug | Termite | SugarcaneScale | Mites |
    Grasshopper | ShootBorer | TopBorer | RootGrub | CaneMoth | CaneWeevil |
    CaneMite | Earwig | CaneBug | BlackBeetle | ArmyWorm | SugarcaneBorer |
    WhiteGrub | SugarcaneAphid | RootKnotNematode | Thrips

datatype pesticide =
    ThiophanateMethyl | Carbendazim | Propiconazole | Mancozeb |
    CopperOxychloride | Triadimefon | Chlorpyrifos | OrganicPestController |
    Thiamethoxam | Imidacloprid | Fipronil | Oxamyl | Fenamiphos |
    Quinalphos | Cypermethrin | Phorate | Propargite | Carbaryl | Acaricides |
    IMD178 | Pyron | Chakrawarti | Sarvashakti | AshwamedhPlus | Diazinon | Bifenthrin

(* ============================================ *)
(* SECTION 2: Relations *)
(* ============================================ *)

fun has_symptom :: "disease \<Rightarrow> symptom \<Rightarrow> bool" where
  (* Red Rot *)
  "has_symptom RedRot ReddenedAreasWithWhitePatches = True" |
  "has_symptom RedRot AffectedParenchymatousTissues = True" |
  "has_symptom RedRot HollowCavityWithGreyMycelium = True" |
  "has_symptom RedRot DarkBrownishLesionsOnRind = True" |
  "has_symptom RedRot NecrosisOnNodalRegion = True" |
  "has_symptom RedRot CutEndsShowReddening = True" |
  "has_symptom RedRot EntireStoolDries = True" |
  
  (* Smut *)
  "has_symptom Smut ExcessiveTilleringLanky = True" |
  "has_symptom Smut BlackWhipStructures = True" |
  "has_symptom Smut WhipLikeSorusBearingStructures = True" |
  "has_symptom Smut StuntedThinCanes = True" |
  "has_symptom Smut NarrowWeakLeaves = True" |
  "has_symptom Smut ProliferatingAxillaryBuds = True" |
  "has_symptom Smut StemOrLeafGalls = True" |
  
  (* Wilt *)
  "has_symptom Wilt YellowishStoolsDrying = True" |
  "has_symptom Wilt DullBrownishDiscolourationInternal = True" |
  "has_symptom Wilt LinearPithCavities = True" |
  "has_symptom Wilt DriedCanesDetoppedCrown = True" |
  "has_symptom Wilt YellowishFoliage = True" |
  
  (* Sett Rot *)
  "has_symptom SettRot PineappleOdor = True" |
  "has_symptom SettRot SettsFailToGerminate = True" |
  "has_symptom SettRot SettRotBeforeGermination = True" |
  "has_symptom SettRot ShootDieAfterEmergence = True" |
  "has_symptom SettRot StuntedChloroticShoots = True" |
  "has_symptom SettRot SettBlackeningWithSpores = True" |
  "has_symptom SettRot WiltingAndWithering = True" |
  
  (* Ratoon Stunting Disease *)
  "has_symptom RatoonStuntingDisease StuntedGrowth = True" |
  "has_symptom RatoonStuntingDisease ReducedTillering = True" |
  "has_symptom RatoonStuntingDisease ThinStalksWithShortenedInternodes = True" |
  "has_symptom RatoonStuntingDisease YellowishFoliage = True" |
  "has_symptom RatoonStuntingDisease VascularBundleDiscolourationNodes = True" |
  
  (* Grassy Shoot *)
  "has_symptom GrassyShoot ExcessiveTilleringLanky = True" |
  "has_symptom GrassyShoot NarrowLeaves = True" |
  "has_symptom GrassyShoot GrassLikeAppearance = True" |
  "has_symptom GrassyShoot StuntedGrowth = True" |
  
  (* Mosaic *)
  "has_symptom Mosaic ChloroticAreasYoungLeaves = True" |
  "has_symptom Mosaic YellowishStripes = True" |
  "has_symptom Mosaic MildMottling = True" |
  "has_symptom Mosaic Stunting = True" |
  "has_symptom Mosaic Yellowing = True" |
  "has_symptom Mosaic Necrosis = True" |
  
  (* Yellow Leaf Disease *)
  "has_symptom YellowLeafDisease YellowishMidribLowerSurface = True" |
  "has_symptom YellowLeafDisease ReddishPinkishDiscolourationMidrib = True" |
  "has_symptom YellowLeafDisease ShorteningInternodesTop = True" |
  "has_symptom YellowLeafDisease BunchingLeavesTop = True" |
  "has_symptom YellowLeafDisease ReducedCaneThickness = True" |
  "has_symptom YellowLeafDisease StuntedGrowth = True" |
  "has_symptom YellowLeafDisease Necrosis = True" |
  "has_symptom YellowLeafDisease Yellowing = True" |
  
  (* Pokkah Boeng *)
  "has_symptom PokkahBoeng MalformedTwistedTop = True" |
  "has_symptom PokkahBoeng WhiteMyceliumOnLeaves = True" |
  "has_symptom PokkahBoeng WrinklingTwistingShortening = True" |
  "has_symptom PokkahBoeng IrregularReddishStripesSpecks = True" |
  "has_symptom PokkahBoeng KnifeCutSymptoms = True" |
  "has_symptom PokkahBoeng TopRot = True" |
  
  (* Leaf Fleck *)
  "has_symptom LeafFleck FlecksSpecksLeafLamina = True" |
  "has_symptom LeafFleck PrematureLeafDrying = True" |
  "has_symptom LeafFleck TinyChloroticFlecks = True" |
  "has_symptom LeafFleck MottlingOnMiddleLeaves = True" |
  "has_symptom LeafFleck ReddeningAndDrying = True" |
  "has_symptom LeafFleck FleckCoalescence = True" |
  "has_symptom LeafFleck ReducedPlantVigor = True" |
  
  (* Rust *)
  "has_symptom Rust RustPustules = True" |
  
  (* Rust Brown *)
  "has_symptom RustBrown SmallChloroticPuncta = True" |
  "has_symptom RustBrown BrownTawnyPustules = True" |
  "has_symptom RustBrown LesionCoalescence = True" |
  "has_symptom RustBrown ReducedCanopyDensity = True" |
  
  (* Orange Rust *)
  "has_symptom OrangeRust OrangePowderyPustules = True" |
  "has_symptom OrangeRust YellowOrangeStreaks = True" |
  "has_symptom OrangeRust PustulesBetweenVeins = True" |
  "has_symptom OrangeRust PrematureLeafDrying = True" |
  "has_symptom OrangeRust LeafYelowing = True" |
  "has_symptom OrangeRust ReducedTillering = True" |
  "has_symptom OrangeRust StuntedGrowth = True" |
  
  (* Eye Spot *)
  "has_symptom EyeSpot EyeShapedSpots = True" |
  "has_symptom EyeSpot MinuteWaterSoakedSpots = True" |
  "has_symptom EyeSpot ReddishBrownEllipticalLesions = True" |
  "has_symptom EyeSpot Lesions05To4mmLong = True" |
  "has_symptom EyeSpot GreyOrTanCenter = True" |
  "has_symptom EyeSpot ReddishBrownYellowishRunners = True" |
  "has_symptom EyeSpot LesionsMayCoalesce = True" |
  "has_symptom EyeSpot SeedlingBlightAndTopRot = True" |
  
  (* Brown Spot *)
  "has_symptom BrownSpot BrownSpots = True" |
  "has_symptom BrownSpot RedBrownOvalLesions = True" |
  "has_symptom BrownSpot LesionSize3To15mm = True" |
  "has_symptom BrownSpot NarrowYellowHalo = True" |
  "has_symptom BrownSpot SpotsMayCoalesce = True" |
  
  (* Yellow Spot *)
  "has_symptom YellowSpot YellowSpots = True" |
  "has_symptom YellowSpot SmallYellowLesions = True" |
  "has_symptom YellowSpot LesionsEnlargeAndTurnBrown = True" |
  "has_symptom YellowSpot SplotchyYellowLesions = True" |
  "has_symptom YellowSpot GrayFuzzyDown = True" |
  
  (* Brown Stripe *)
  "has_symptom BrownStripe BrownStripes = True" |
  "has_symptom BrownStripe BrownLesionsAlongLeafBlades = True" |
  "has_symptom BrownStripe NarrowDarkBrownStripes = True" |
  "has_symptom BrownStripe LesionsMayMerge = True" |
  
  (* Ring Spot *)
  "has_symptom RingSpot RingShapedSpots = True" |
  "has_symptom RingSpot SmallElongatedSpots = True" |
  "has_symptom RingSpot LargerElongatedLesions = True" |
  "has_symptom RingSpot SmallBlackFruitingBodies = True" |
  
  (* Leaf Blast *)
  "has_symptom LeafBlast YellowNarrowSpots = True" |
  "has_symptom LeafBlast SmallYellowishSpots = True" |
  "has_symptom LeafBlast SpotsTurnBrown = True" |
  "has_symptom LeafBlast WholeLeafWithers = True" |
  
  (* Curvularia Leaf Spot *)
  "has_symptom CurvulariaLeafSpot PaleYellowRibbon = True" |
  "has_symptom CurvulariaLeafSpot RedChangesAroundLesion = True" |
  "has_symptom CurvulariaLeafSpot SmallToMediumBrownLesions = True" |
  "has_symptom CurvulariaLeafSpot ReddishMargin = True" |
  "has_symptom CurvulariaLeafSpot LesionsMayCoalesceEarlySenescence = True" |
  
  (* Leaf Scald *)
  "has_symptom LeafScald WhiteStripesOnLeaves = True" |
  "has_symptom LeafScald LeafYellowingFromTip = True" |
  "has_symptom LeafScald StuntedGrowth = True" |
  "has_symptom LeafScald CaneDeathInAdvancedInfection = True" |
  
  (* Fiji Disease *)
  "has_symptom FijiDisease LeafRustBrownPatches = True" |
  "has_symptom FijiDisease StuntedGrowth = True" |
  "has_symptom FijiDisease WiltingOfWholePlant = True" |
  
  "has_symptom _ _ = False"

fun caused_by :: "disease \<Rightarrow> pest \<Rightarrow> bool" where
  "caused_by RedRot ColletotrichumFalcatum = True" |
  "caused_by Smut SporisporiumScitamineum = True" |
  "caused_by Wilt FusariumSacchari = True" |
  "caused_by SettRot CeratocystisParadoxa = True" |
  "caused_by RatoonStuntingDisease LeifsioniaXyli = True" |
  "caused_by GrassyShoot SugarcaneGrassyShootPhytoplasma = True" |
  "caused_by Mosaic SugarcaneMosaicVirus = True" |
  "caused_by YellowLeafDisease SugarcaneYellowLeafVirus = True" |
  "caused_by PokkahBoeng FusariumVerticillioides = True" |
  "caused_by PokkahBoeng FusariumProliferatum = True" |
  "caused_by LeafFleck SugarcaneBacilliformVirus = True" |
  "caused_by Rust FoliarFungus = True" |
  "caused_by EyeSpot FoliarFungus = True" |
  "caused_by BrownSpot FoliarFungus = True" |
  "caused_by YellowSpot FoliarFungus = True" |
  "caused_by BrownStripe FoliarFungus = True" |
  "caused_by RingSpot FoliarFungus = True" |
  "caused_by LeafScald XanthomonasAlbilineans = True" |
  "caused_by FijiDisease Delphacidae = True" |
  "caused_by LeafBlast ParaphaeosphaeriaMichotii = True" |
  "caused_by CurvulariaLeafSpot CurvulariaLunata = True" |
  "caused_by SugarcaneYellowLeafLuteovirus Coccidae = True" |
  "caused_by DeadTissue Buprestidae = True" |
  "caused_by DeadHeart EarlyShootBorer = True" |
  "caused_by DeadHeart RootBorer = True" |
  "caused_by LeafMines TopShootBorer = True" |
  "caused_by BunchyTop TopShootBorer = True" |
  "caused_by ConstrictedInternodes InterNodeBorer = True" |
  "caused_by Boreholes InterNodeBorer = True" |
  "caused_by LeafSheathDecay StalkBorer = True" |
  "caused_by PhloemSapFeeding LeafHopper = True" |
  "caused_by SootyMoldDevelopment LeafHopper = True" |
  "caused_by LeafYellowing WhiteFly = True" |
  "caused_by LeafPaling WhiteFly = True" |
  "caused_by SootyMold WhiteFly = True" |
  "caused_by SootyMold MealyBug = True" |
  "caused_by SapSucking MealyBug = True" |
  "caused_by _ _ = False"

fun controls :: "pesticide \<Rightarrow> pest \<Rightarrow> bool" where
  (* Fungicides *)
  "controls ThiophanateMethyl ColletotrichumFalcatum = True" |
  "controls ThiophanateMethyl CeratocystisParadoxa = True" |
  "controls Carbendazim ColletotrichumFalcatum = True" |
  "controls Carbendazim CeratocystisParadoxa = True" |
  "controls Propiconazole SporisporiumScitamineum = True" |
  "controls Triadimefon SporisporiumScitamineum = True" |
  "controls Mancozeb FoliarFungus = True" |
  "controls CopperOxychloride FoliarFungus = True" |
  "controls CopperOxychloride XanthomonasAlbilineans = True" |
  "controls Mancozeb XanthomonasAlbilineans = True" |
  
  (* Insecticides *)
  "controls Imidacloprid Aphididae = True" |
  "controls Thiamethoxam Aphididae = True" |
  "controls Chlorpyrifos Termite = True" |
  "controls Chlorpyrifos BlackBeetle = True" |
  "controls Chlorpyrifos ArmyWorm = True" |
  "controls Chlorpyrifos SugarcaneScale = True" |
  "controls Chlorpyrifos Grasshopper = True" |
  "controls Chlorpyrifos ShootBorer = True" |
  "controls Fenamiphos RootKnotNematode = True" |
  "controls Fenamiphos RootGrub = True" |
  "controls Oxamyl RootKnotNematode = True" |
  "controls OrganicPestController EarlyShootBorer = True" |
  "controls OrganicPestController TopShootBorer = True" |
  "controls Fipronil TopShootBorer = True" |
  "controls IMD178 WhiteFly = True" |
  "controls Chakrawarti LeafHopper = True" |
  "controls Sarvashakti MealyBug = True" |
  "controls AshwamedhPlus MealyBug = True" |
  "controls Acaricides Mites = True" |
  "controls Acaricides CaneMite = True" |
  "controls Quinalphos TopBorer = True" |
  "controls Cypermethrin CaneMoth = True" |
  "controls Phorate CaneWeevil = True" |
  "controls Propargite CaneMite = True" |
  "controls Carbaryl Earwig = True" |
  "controls Imidacloprid CaneBug = True" |
  "controls Imidacloprid SugarcaneAphid = True" |
  "controls Thiamethoxam SugarcaneAphid = True" |
  
  "controls _ _ = False"

(* ============================================ *)
(* SECTION 3: Inference Rules *)
(* ============================================ *)

definition treats_disease :: "pesticide \<Rightarrow> disease \<Rightarrow> bool" where
  "treats_disease p d \<equiv> \<exists>pest. caused_by d pest \<and> controls p pest"

(* ============================================ *)
(* SECTION 4: Sample Proofs *)
(* ============================================ *)

lemma treats_red_rot_carbendazim: "treats_disease Carbendazim RedRot"
  unfolding treats_disease_def
  apply (rule exI[where x="ColletotrichumFalcatum"])
  by simp

lemma treats_smut_propiconazole: "treats_disease Propiconazole Smut"
  unfolding treats_disease_def
  apply (rule exI[where x="SporisporiumScitamineum"])
  by simp

lemma treats_leaf_scald_copper: "treats_disease CopperOxychloride LeafScald"
  unfolding treats_disease_def
  apply (rule exI[where x="XanthomonasAlbilineans"])
  by simp

end