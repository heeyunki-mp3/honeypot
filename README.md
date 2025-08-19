# Real-Time Risk Scoring of Ongoing Cyber Attacks

This repository provides an **end-to-end framework** for classifying and risk-scoring cyberattacks in real time using honeypot data.  
It combines **semantic command clustering**, **cluster-wise Markov chains**, and **Bayesian online classification** with entropy-based evaluation and **VirusTotal risk scoring**.  
The pipeline enables early, adaptive detection of attacker behavior while mapping each session to an external maliciousness score.


## Pipeline Overview

### 1. Preprocessing
- **Input**: Cowrie honeypot logs (`raw_data/`).
- **Notebook**: `raw_data/data_cleansing.ipynb`
- **Steps**:
  - Download `command_to_description.csv` from [CodeBERT Clustering Task](https://github.com/fabianzuluaga48/codeBERT-Clustering-Task).
  - Normalize and clean sessions → outputs `*_clean.csv` in `cleaned_csv/`.
  - Generate:
    - `Bayes/data/training_data.csv`
    - `Bayes/data/testing_data.csv`

---

### 2. Clustering & Training
- **Notebook**: `Cluster_Training_Data.ipynb`
- **Method**:  
  Cluster commands using semantic embeddings + normalized Levenshtein distance.  
  Produces formatted datasets for Bayesian classification.

---

### 3. Classification & Entropy Evaluation
- **Notebook**: `Bayes/bayes.ipynb`
- **Method**:  
  - Bayesian online classification over cluster-wise Markov chains.  
  - Entropy is tracked at each command step to evaluate confidence.
- **Outputs** (in `Bayes/results/`):
  - `entropy_over_steps.csv`: entropy progression per session.
  - `entropy_to_be_graphed.csv` / `.xlsx`: reformatted for visualization.
  - `right_value_moment.csv`: entropy at the step when the correct class was first reached.
  - `switched_ones.csv`: sessions initially misclassified but corrected later.
  - `ground_truth.csv`: true labels for test sessions.

---

### 4. Risk Scoring with VirusTotal
- **Notebook**: `scoring/ip_risk_score_scraping.ipynb`
  - Queries VirusTotal for IPs observed in honeypots.
  - Produces:
    - `ip_report_crm_testing.csv`
    - `ip_report_pending_testing.csv`
    - `ip_report_ebilling_testing.csv`

- **Notebook**: `scoring/levenshtein_for_testset.ipynb`
  - Requires:
    - The three VirusTotal CSVs above.
    - `TEST_all_normalized_IP_fk_ipip.csv` (normalized session/IP mapping).
    - `Bayes/data/{training_data.csv, testing_data.csv, ground_truth.csv}`
  - Computes **cluster-level risk scores**.

---

## Key Concepts

- **Markov Chains**: model the sequence of commands within each cluster.  
- **Bayesian Updating**: update posterior probabilities as each new command arrives.  
- **Entropy**: used as a stopping rule — low entropy = high confidence classification.  
- **VirusTotal Risk Scores**: provide external maliciousness scores, enabling session-level risk mapping.

---

## Requirements

- Python 3.10+
- Jupyter Notebook
- Dependencies:
  - `pandas`, `numpy`, `scikit-learn`, `tqdm`, `matplotlib`, `requests`
- VirusTotal API key (`VT_API_KEY`) for risk scoring.
