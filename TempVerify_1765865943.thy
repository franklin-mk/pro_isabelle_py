theory TempVerify_1765865943
  imports Sugarcane_Diseases
begin


(* Generated Proof for BrownSpot *)
lemma treats_BrownSpot_with_Mancozeb:
  "treats_disease Mancozeb BrownSpot"
  unfolding treats_disease_def
  apply (rule exI[where x="FoliarFungus"])
  apply simp
  done


end
