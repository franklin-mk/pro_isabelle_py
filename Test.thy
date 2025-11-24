theory Test
  imports Main
begin

lemma "1 + 1 = (2::nat)"
  by simp

lemma simple_test: "True"
  by simp

lemma another_test: "2 + 2 = (4::nat)"
  by simp

end