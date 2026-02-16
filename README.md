# Machine Learning Benchmark for Clinical Diagnostics

## Overview
This repository contains the source code for a comparative study of Machine Learning classifiers used to predict malignant tumors. This work formed the computational basis for the research published in **The Lancet Digital Health**.
Link : https://www.sciencedirect.com/science/article/pii/S2589750023000948

The project focuses on the **statistical validation** of AI models in high-stakes environments, ensuring that false negatives are minimized through rigorous ensemble methods.

## Key Features
*   **Ensemble Learning:** Implementation of Bagged and Boosted Decision Trees (`trainClassifierEnsemble.m`) to improve predictive stability over single models.
*   **Comparative Analysis:** Automated benchmarking against Support Vector Machines (SVM) and Naive Bayes classifiers.
*   **Data Pipeline:** robust preprocessing and partitioning of clinical datasets (`PartitionDatasets.m`) to ensure valid Cross-Validation.
*   **Diagnostic Visualization:** Automated generation of Confusion Matrices and ROC Curves (`model_diagnostics.m`) to assess model sensitivity and specificity.

## Technology Stack
*   **Language:** MATLAB (Statistics and Machine Learning Toolbox).
*   **Algorithms:** RUSBoost, Bagged Trees, SVM (Linear/Gaussian Kernels).

## Context
*While this project utilizes MATLAB for its robust statistical toolboxes, the underlying principles of data partitioning, feature selection, and model validation are directly applicable to Python-based SciML workflows (Scikit-Learn/TensorFlow).*

## File Structure
*   `ML_main.m`: Main driver script for the benchmarking loop.
*   `trainClassifierEnsemble.m`: Configuration of ensemble hyperparameters.
*   `model_diagnostics.m`: Statistical evaluation of trained models.
