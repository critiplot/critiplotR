
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17236600.svg)](https://doi.org/10.5281/zenodo.17236600)

**Critiplot** is an open-source Python tool and **interactive web app** for **visualizing risk-of-bias (RoB) assessments** across multiple evidence synthesis tools:

* **Newcastle-Ottawa Scale (NOS)**
* **JBI Critical Appraisal Checklists** (Case Report / Case Series)
* **GRADE certainty of evidence**
* **ROBIS for systematic reviews**
* **Mixed Methods Appraisal Tool (MMAT)**

It produces **publication-ready traffic-light plots** and **stacked bar charts**, allowing researchers to summarize study quality clearly in systematic reviews and meta-analyses.

---

* Unfortunately, for **critiplot**, I was really interested in releasing it as an R package for R users and publishing it on CRAN. I even implemented it using `reticulate`, carefully addressing CRAN concerns. However, there is a **fatal error** affecting **JBI case series**, **case reports**, and **GRADE plots**.

* The **v2.1.0 Python package**, along with **v2.1.0 of the Critiplot website**, handles the same input files gracefully without any errors in their respective environments. However, the same fails using the local R **v0.1.0 critiplotR** package.  

  * The particular error is that the Python package (only when called from R via `reticulate`) expects **numerical data** as input instead of categorical inputs like `"Not Applicable"`, `"Yes"`, `"No"`, `"Unclear"`.  
  * Ironically, the same Python package in a **Python environment** works perfectly with these input files.

* As of now, only **NOS**, **ROBIS**, and **MMAT** (MMAT all plots) work with this R package. As such, I am **archiving this repository**.

---

Please visit the main Critiplot repo: [https://github.com/aurumz-rgb/Critiplot-main](https://github.com/aurumz-rgb/Critiplot-main)