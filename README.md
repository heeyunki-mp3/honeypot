# honeypot

Raw data from Cowrie honnypot is in `./raw_data`.

In order to replicate the procedure in the paper, follow this step:

Preprocessing:
1. run obtain command to description data file from https://github.com/fabianzuluaga48/codeBERT-Clustering-Task

2. run `./data_cleansing.ipynb` and make sure you obtained conversion data and named it `command_to_description.csv` in the same directory. This will create `cleaned_csv`. Here, we have done the preprocessing steps. This data is reformatted again and saved to `./data/testing_data.csv` and `./data/training_data.csv` and

Training:

3. Run `Cluster_Training_Data.ipynb`. Which represents the Training Steps. This will create `./all_normalized_fk.csv` which is post-processed to `./Bayes/data/training_data.csv`. Similar steps are done for testing sets, but wihtout classifying its cluster but formatted into similar structure to the training data and saved as `./Bayes/data/testing_data.csv`

Classification / Prediction Testing:

4. To test the classification method, run `bayes.ipynb`. This creates series of csv files:
`ground_truth.csv`: labels for each test data
`entropy_over_steps.csv`: each row represents one sessions's entropy over number of commands provided (each column represents steps more right- more commands provided)
`entropy_to_be_graphed.csv` : reformatted from `entropy_over_steps.csv`. First column is the number of command provided and second column is the entropy at the given number of command.
-> this is reformatted to `entropy_to_be_graphed.xlsx` to be graphed
`right_value_moment.csv`: For each session, the entropy that it first reached when the correct classification wa made
`switched_ones.csv`: similar format as `entropy_to_be_graphed.csv` but only contains those ones where it was classified as wrong group but later changed its classification to the correct ones. 


Risk Scoring:
Obtain the risk score data from Virus Total using `./scoring/ip_risk_score_scraping.ipynb`
This will create 3 csv files (`./scoring/ip_report_crm_testing.csv`, `./scoring/ip_report_pending_testing.csv`, `./scoring/ip_report_ebilling_testing`) for each honeypots that contains the ip caught on those honeypot's risk data from Virus Total. 

5. The risk score will be given using `./scoring/levenshtein_for_testset.ipynb`
- requires three ip report csv files from `./scoring/ip_risk_score_scraping.ipynb`
- `./scoring/TEST_all_normlized_IP_fk_ipip.csv` (sorry this was weird side output of some script but happened to use it for the final version)
- The risk score of each clusters are printed on the notebook.
