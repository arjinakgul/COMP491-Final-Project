Previously Used Machine Learning Models for Our Project

→ With efficient collected data and labels:
	Logistic Regression: Logistic Regression was used for fraud detection before. In this system, a logistic regression algorithm follows a rule and detects when a new case could not follow up this rule and label it as a “fraud”. In our project, the main idea behind this could be the same. We create a rule for logistic regression to follow and when a new case appears and could not follow up this rule, we could label it as an “anomaly”.

Related Paper: https://www.emerald.com/insight/content/doi/10.1108/AJAR-09-2018-0032/full/pdf

→ Without efficient collected data and labels:
We are using real time data in our anomaly detection algorithm. This usage will be efficient in a way that our data will be up-to-date, therefore our machine learning model for this problem will be up-to-date too. However, it can have a problem such that collected data could not have enough cases for training when enough anomalies did not happen. We can resolve this problem with using unsupervised machine learning models. For instance, we can create the fake anomaly data by ourselves and train the algorithm with these cases by making assumptions. By this way we can have enough anomaly cases for our training. 
Related paper: http://www.diva-portal.org/smash/get/diva2:1339906/FULLTEXT01.pdf

→ DBSCAN: DBSCAN is an example of unsupervised learning. While DBSCAN is a clustering algorithm, it successfully detects anomalies. Those anomalies are based on the parameters, neighboring radius Eps and minimum number of points, given by the user. When DBSCAN compared with the statistical method on the dataset of bitcoin price between 2012 and 2019, it was demonstrated that DBSCAN is so successful for detecting anomalies. In our project, we can use the DBSCAN algorithm with accurate neighboring radius and minimum number of points values. It can bring us a successful model. The values that we will select are the most important part of the algorithm. In the experiment carried out using the DBSCAN algorithm with the daily bitcoin price in percentage difference dataset, it was determined that the most efficient result is obtained when Eps value is equal to 0.16 and MinPts value is equal to 20 in the related paper. Thus, at the first step, we can use those values.

	Related paper: 
https://dergipark.org.tr/en/download/article-file/1027678

