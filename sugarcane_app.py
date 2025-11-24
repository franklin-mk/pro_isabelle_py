import streamlit as st
import subprocess
import os
import re

# ==========================================
# 1. DYNAMIC ISABELLE PARSER
# ==========================================
class IsabelleParser:
    def __init__(self, file_path):
        self.file_path = file_path
        self.raw_content = ""
        self.diseases = {}
        self.symptoms = {}
        self.pests = {}
        self.treatments = {}
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                self.raw_content = f.read()
            self._parse_theory()
        except FileNotFoundError:
            st.error(f"Could not find Isabelle file at: {file_path}")

    def _parse_theory(self):
        # 1. Parse Datatypes
        self.disease_list = self._extract_datatype("disease")
        self.symptom_list = self._extract_datatype("symptom")
        self.pest_list = self._extract_datatype("pest")
        self.treatment_list = self._extract_datatype("pesticide")

        # Initialize Dictionary Structure
        for d in self.disease_list:
            self.diseases[d] = {
                'name': self._camel_to_human(d),
                'isabelle_name': d,
                'symptoms': [],
                'caused_by': [],  # Changed to list to handle multiple causes
                'treatments': []
            }

        # 2. Parse Relations
        self._parse_has_symptom()
        self._parse_caused_by()
        self._parse_controls()

    def _extract_datatype(self, type_name):
        pattern = re.compile(rf"datatype {type_name}\s+=\s+(.*?)(?=\n\ndatatype|\n\nfun|\Z)", re.DOTALL)
        match = pattern.search(self.raw_content)
        if match:
            raw = re.sub(r'\(\*.*?\*\)', '', match.group(1), flags=re.DOTALL)
            items = [item.strip() for item in raw.replace('\n', ' ').split('|')]
            return [i for i in items if i]
        return []

    def _parse_has_symptom(self):
        pattern = re.compile(r'"has_symptom\s+(\w+)\s+(\w+)\s+=\s+True"')
        matches = pattern.findall(self.raw_content)
        for disease, symptom in matches:
            if disease in self.diseases:
                if symptom not in self.diseases[disease]['symptoms']:
                    self.diseases[disease]['symptoms'].append(symptom)

    def _parse_caused_by(self):
        pattern = re.compile(r'"caused_by\s+(\w+)\s+(\w+)\s+=\s+True"')
        matches = pattern.findall(self.raw_content)
        for disease, pest in matches:
            if disease in self.diseases:
                if pest not in self.diseases[disease]['caused_by']:
                    self.diseases[disease]['caused_by'].append(pest)

    def _parse_controls(self):
        pattern = re.compile(r'"controls\s+(\w+)\s+(\w+)\s+=\s+True"')
        matches = pattern.findall(self.raw_content)
        
        # Create a pest -> pesticide map
        pest_controls = {}
        for pesticide, pest in matches:
            if pest not in pest_controls:
                pest_controls[pest] = []
            if pesticide not in pest_controls[pest]:
                pest_controls[pest].append(pesticide)

        # Link to diseases
        for d_key, d_data in self.diseases.items():
            treatments = set()
            for pest in d_data['caused_by']:
                if pest and pest in pest_controls:
                    treatments.update(pest_controls[pest])
            d_data['treatments'] = list(treatments)

    def _camel_to_human(self, name):
        # Convert CamelCase to Human Readable
        result = re.sub(r'(?<!^)(?=[A-Z])', ' ', name)
        return result.replace('_', ' ').title()

# ==========================================
# 2. LOGIC & PROOF GENERATION
# ==========================================

def diagnose(kb, selected_symptoms):
    results = []
    for d_key, d_data in kb.diseases.items():
        if not d_data['symptoms']: 
            continue
        
        kb_symptoms = set(d_data['symptoms'])
        user_symptoms = set(selected_symptoms)
        
        matched = kb_symptoms.intersection(user_symptoms)
        if matched:
            match_score = (len(matched) / len(kb_symptoms)) * 100
            results.append({
                'id': d_key,
                'data': d_data,
                'score': match_score,
                'matched': matched
            })
    
    return sorted(results, key=lambda x: x['score'], reverse=True)

def generate_proof(disease_obj, pesticide_name):
    d_name = disease_obj['isabelle_name']
    pests = disease_obj['caused_by']
    
    # Handle multiple pests - use first one for proof
    if not pests:
        return "(* Error: No pest found for this disease *)"
    
    pest_name = pests[0]
    
    proof = f"""
(* Generated Proof for {d_name} *)
lemma treats_{d_name}_with_{pesticide_name}:
  "treats_disease {pesticide_name} {d_name}"
  unfolding treats_disease_def
  apply (rule exI[where x="{pest_name}"])
  apply simp
  done
"""
    return proof

def verify_with_isabelle(proof_text, thy_dir):
    """Verify proof by creating a child theory and running Isabelle"""
    import time
    temp_thy_name = f"TempVerify_{int(time.time())}"
    temp_path = os.path.join(thy_dir, f"{temp_thy_name}.thy")
    
    try:
        with open(temp_path, 'w') as f:
            content = f"""theory {temp_thy_name}
  imports Sugarcane_Diseases
begin

{proof_text}

end
"""
            f.write(content)
        
        cygwin_dir = thy_dir.replace('\\', '/').replace('C:', '/cygdrive/c').replace('D:', '/cygdrive/d')
        
        methods = [
            {'cmd': ['isabelle', 'process', '-T', temp_thy_name], 'cwd': thy_dir, 'shell': False},
            {'cmd': ['C:\\cygwin64\\bin\\bash.exe', '-l', '-c', 
                    f'cd "{cygwin_dir}" && isabelle process -T {temp_thy_name}'],
             'cwd': None, 'shell': False},
            {'cmd': ['C:\\cygwin\\bin\\bash.exe', '-l', '-c', 
                    f'cd "{cygwin_dir}" && isabelle process -T {temp_thy_name}'],
             'cwd': None, 'shell': False},
        ]
        
        last_error = ""
        
        for i, method in enumerate(methods):
            try:
                result = subprocess.run(
                    method['cmd'],
                    cwd=method['cwd'],
                    capture_output=True,
                    text=True,
                    timeout=30
                )
                
                output = result.stdout + result.stderr
                
                if result.returncode == 0 and "error" not in output.lower():
                    return True, f"✅ Verified by Isabelle/HOL (Method {i+1})"
                
                if "error" in output.lower() or "failed" in output.lower():
                    last_error = f"Method {i+1} - Isabelle Error:\n{output[:500]}"
                    continue
                    
            except FileNotFoundError:
                last_error = f"Method {i+1} - Executable not found"
                continue
            except subprocess.TimeoutExpired:
                last_error = f"Method {i+1} - Timeout (30s)"
                continue
            except Exception as e:
                last_error = f"Method {i+1} - {str(e)}"
                continue
        
        help_msg = f"""
Isabelle verification requires running from Cygwin terminal:

1. Open Cygwin Terminal
2. Navigate to: cd "{cygwin_dir}"
3. Run: streamlit run sugarcane_app.py
"""
        
        return False, f"{last_error}\n\n{help_msg}"
        
    except Exception as e:
        return False, f"System Error: {str(e)}"
    finally:
        if os.path.exists(temp_path):
            try:
                os.remove(temp_path)
            except:
                pass

# ==========================================
# 3. STREAMLIT INTERFACE
# ==========================================

def main():
    st.set_page_config(page_title="Sugarcane Expert System", layout="wide")
    
    st.title("🌾 Sugarcane Disease Expert System")
    st.caption("Powered by Isabelle/HOL 2025 • Dynamic .thy Parsing")

    thy_file = "Sugarcane_Diseases.thy"
    
    if os.path.isabs(thy_file):
        thy_path = thy_file
    else:
        thy_path = os.path.abspath(thy_file)
    
    thy_dir = os.path.dirname(thy_path)
    
    if 'kb' not in st.session_state:
        st.session_state.kb = IsabelleParser(thy_file)
    
    if 'thy_dir' not in st.session_state:
        st.session_state.thy_dir = thy_dir
    
    if 'diagnosis_results' not in st.session_state:
        st.session_state.diagnosis_results = None

    kb = st.session_state.kb
    
    # Sidebar
    with st.sidebar:
        st.header("📊 Knowledge Base Stats")
        st.success("✅ Theory File Loaded")
        
        col1, col2 = st.columns(2)
        with col1:
            st.metric("Diseases", len(kb.diseases))
            st.metric("Symptoms", len(kb.symptom_list))
        with col2:
            st.metric("Pests", len(kb.pest_list))
            st.metric("Pesticides", len(kb.treatment_list))
        
        st.divider()
        
        st.caption("🔧 Isabelle Status")
        try:
            result = subprocess.run(['isabelle', 'version'], 
                                  capture_output=True, text=True, timeout=5)
            if result.returncode == 0:
                st.success("✓ Isabelle accessible")
            else:
                st.warning("⚠ Isabelle not in PATH")
        except:
            st.error("✗ Run from Cygwin terminal")
        
        st.divider()
        
        if st.button("🔄 Reload Knowledge Base", use_container_width=True):
            st.session_state.kb = IsabelleParser(thy_file)
            st.session_state.diagnosis_results = None
            st.rerun()

    # Main Tabs
    tab1, tab2, tab3, tab4 = st.tabs(["🔍 Diagnosis", "📖 Knowledge Browser", "⚙️ Verification", "📈 Statistics"])

    with tab1:
        st.subheader("Symptom-Based Disease Diagnosis")
        
        symptom_map = {s: kb._camel_to_human(s) for s in kb.symptom_list}
        
        col1, col2 = st.columns([2, 1])
        
        with col1:
            selected = st.multiselect(
                "Select observed symptoms:", 
                options=sorted(kb.symptom_list, key=lambda x: symptom_map[x]),
                format_func=lambda x: symptom_map[x],
                help="Choose all symptoms you observe on the sugarcane plant"
            )

        with col2:
            st.write("**Quick Stats:**")
            st.write(f"Symptoms selected: {len(selected)}")
            st.write(f"Total available: {len(kb.symptom_list)}")

        if st.button("🔬 Diagnose Disease", type="primary", use_container_width=True):
            if not selected:
                st.warning("⚠️ Please select at least one symptom.")
            else:
                with st.spinner("Analyzing symptoms..."):
                    results = diagnose(kb, selected)
                    st.session_state.diagnosis_results = results
                    if not results:
                        st.error("❌ No matching diseases found for selected symptoms.")

        if st.session_state.diagnosis_results:
            results = st.session_state.diagnosis_results
            if results:
                st.success(f"✅ Found {len(results)} possible disease(s)")
                
                for idx, res in enumerate(results, 1):
                    with st.expander(f"#{idx} {res['data']['name']} ({res['score']:.1f}% Match)", expanded=(idx==1)):
                        colA, colB = st.columns(2)
                        
                        with colA:
                            st.write("**🔍 Matched Symptoms:**")
                            for s in sorted(res['matched'], key=lambda x: symptom_map[x]):
                                st.markdown(f"✓ {symptom_map[s]}")
                            
                            st.write("**🦠 Caused By:**")
                            pests = res['data']['caused_by']
                            if pests:
                                for pest in pests:
                                    st.markdown(f"• {kb._camel_to_human(pest)}")
                            else:
                                st.write("Unknown")
                        
                        with colB:
                            st.write("**💊 Recommended Treatment:**")
                            treatments = res['data']['treatments']
                            if treatments:
                                for t in treatments:
                                    st.success(f"🧪 {kb._camel_to_human(t)}")
                                    if st.button(f"Generate Proof for {t}", key=f"btn_{res['id']}_{t}"):
                                        st.session_state.proof_target = (res['data'], t)
                                        st.info("✅ Proof generated! Switch to **⚙️ Verification** tab.")
                            else:
                                st.warning("⚠️ No chemical control defined in theory.")

    with tab2:
        st.subheader("📚 Complete Disease Knowledge Base")
        
        # Search functionality
        search_term = st.text_input("🔍 Search diseases:", placeholder="Type disease name...")
        
        filtered_diseases = {k: v for k, v in kb.diseases.items() 
                            if not search_term or search_term.lower() in v['name'].lower()}
        
        st.write(f"Showing {len(filtered_diseases)} of {len(kb.diseases)} diseases")
        
        for disease_key, disease_data in sorted(filtered_diseases.items(), key=lambda x: x[1]['name']):
            with st.expander(f"🦠 {disease_data['name']}"):
                col1, col2, col3 = st.columns(3)
                
                with col1:
                    st.write("**📌 Isabelle ID:**")
                    st.code(disease_data['isabelle_name'])
                    
                    st.write("**🦠 Caused By:**")
                    pests = disease_data['caused_by']
                    if pests:
                        for pest in pests:
                            st.write(f"• {kb._camel_to_human(pest)}")
                    else:
                        st.write("Not defined")
                    
                with col2:
                    st.write("**🔬 Symptoms:**")
                    if disease_data['symptoms']:
                        for sym in disease_data['symptoms'][:5]:
                            st.write(f"• {kb._camel_to_human(sym)}")
                        if len(disease_data['symptoms']) > 5:
                            st.caption(f"...and {len(disease_data['symptoms']) - 5} more")
                    else:
                        st.write("None defined")
                    
                with col3:
                    st.write("**💊 Treatments:**")
                    if disease_data['treatments']:
                        for treat in disease_data['treatments']:
                            st.write(f"• {kb._camel_to_human(treat)}")
                    else:
                        st.write("None defined")

    with tab3:
        st.header("🔐 Formal Verification")
        
        if 'proof_target' in st.session_state:
            d_data, chem = st.session_state.proof_target
            
            st.success(f"🎯 **Goal:** Prove that `{chem}` treats `{d_data['isabelle_name']}`")
            
            with st.expander("📋 Logical Reasoning Strategy", expanded=True):
                st.write("**Proof Steps:**")
                for pest in d_data['caused_by']:
                    st.write(f"""
1. **Given:** `{d_data['isabelle_name']}` is caused by `{pest}`
2. **Given:** `{chem}` controls `{pest}`
3. **Therefore:** By definition of `treats_disease`, `{chem}` treats `{d_data['isabelle_name']}`
                    """)
            
            proof_code = generate_proof(d_data, chem)
            st.subheader("📝 Generated Isabelle Proof")
            st.code(proof_code, language="isabelle")
            
            col1, col2 = st.columns(2)
            
            with col1:
                if st.button("🚀 Verify with Isabelle", type="primary", use_container_width=True):
                    with st.spinner("Running Isabelle proof checker..."):
                        real_success, msg = verify_with_isabelle(proof_code, st.session_state.thy_dir)
                        
                        if real_success:
                            st.balloons()
                            st.success("✅ **Proof Verified by Isabelle/HOL!**")
                            st.info("The proof is mathematically sound and formally verified.")
                        else:
                            st.error("❌ Isabelle Verification Failed")
                            with st.expander("🔍 Error Details"):
                                st.text(msg)
            
            with col2:
                if st.button("📋 Copy to Theory File", use_container_width=True):
                    st.info("📌 Copy the proof below and paste into Sugarcane_Diseases.thy")
                    st.code(proof_code, language="isabelle")
        
        else:
            st.info("💡 **How to generate proofs:**")
            st.write("""
1. Go to **🔍 Diagnosis** tab
2. Select symptoms and diagnose
3. Click **Generate Proof** for any treatment
4. Return here to verify formally
            """)

    with tab4:
        st.subheader("📊 Knowledge Base Statistics")
        
        col1, col2, col3 = st.columns(3)
        
        with col1:
            st.metric("Total Diseases", len(kb.diseases))
            diseases_with_symptoms = sum(1 for d in kb.diseases.values() if d['symptoms'])
            st.metric("Diseases with Symptoms", diseases_with_symptoms)
            
        with col2:
            st.metric("Total Pests", len(kb.pest_list))
            st.metric("Total Pesticides", len(kb.treatment_list))
            
        with col3:
            diseases_with_treatment = sum(1 for d in kb.diseases.values() if d['treatments'])
            st.metric("Treatable Diseases", diseases_with_treatment)
            avg_symptoms = sum(len(d['symptoms']) for d in kb.diseases.values()) / max(len(kb.diseases), 1)
            st.metric("Avg Symptoms/Disease", f"{avg_symptoms:.1f}")
        
        st.divider()
        
        # Coverage Analysis
        st.subheader("📈 Coverage Analysis")
        
        col1, col2 = st.columns(2)
        
        with col1:
            st.write("**Diseases by Pest Coverage:**")
            diseases_by_pest = {}
            for d_data in kb.diseases.values():
                for pest in d_data['caused_by']:
                    if pest not in diseases_by_pest:
                        diseases_by_pest[pest] = []
                    diseases_by_pest[pest].append(d_data['name'])
            
            for pest, diseases in sorted(diseases_by_pest.items(), key=lambda x: len(x[1]), reverse=True)[:10]:
                st.write(f"• {kb._camel_to_human(pest)}: {len(diseases)} disease(s)")
        
        with col2:
            st.write("**Most Effective Pesticides:**")
            pesticide_coverage = {}
            for d_data in kb.diseases.values():
                for treat in d_data['treatments']:
                    if treat not in pesticide_coverage:
                        pesticide_coverage[treat] = []
                    pesticide_coverage[treat].append(d_data['name'])
            
            for pest, diseases in sorted(pesticide_coverage.items(), key=lambda x: len(x[1]), reverse=True)[:10]:
                st.write(f"• {kb._camel_to_human(pest)}: {len(diseases)} disease(s)")

if __name__ == "__main__":
    main()