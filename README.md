# arxiv-2603.23601
This repository is meant to provide public access to the data and code used in https://arxiv.org/abs/2603.23601

Authors: Everett A. Patterson, Sijia Wang, and Robert B. Mann

Title: Entanglement transference and non-inertial quantum reference frames

Last edited on: August 7, 2026

DOI 10.5281/zenodo.21843627

## What is included

There are two files in this repository:
(1) arxiv-2603.23601-Mathematica-Code.nb,
(2) EntanglementTransference_Example.m

These files are briefly described below:

(1) arxiv-2603.23601-Mathematica-Code.nb
- This .nb Mathematica Notebook was primarily used to generate the plots found in Figures 4 and 5 of arXiv:2603.23601.
- Figure 4 depicts the Entanglement Entropy and the Relative Entropy of Coherence for our system, across multiple quantum reference frames.
- Figure 5 is similar, but depicts the Linear Entropy of Entanglement (equivalent to the Tangle in our case) and the L2-Norm of Coherence.
- This .nb file was also used to plot Fig. 6, which depicts the Mutual Information for our system. We corrected an apparent error in the Mutual Information plots found in [arxiv:quant-ph/0603269](https://arxiv.org/abs/quant-ph/0603269).
- The file was also used to reproduce a number of other Figures found in arxiv:quant-ph/0603269. This includes some tests to compare our results to theirs.

(2) EntanglementTransference_Example.m
- This .m MATLAB script was used by the authors to help generate intuition around what initial pure 3-qubit states would satisfy the Entanglement Transference condition.
- This file makes extensive use of the QETLAB package: https://qetlab.com
- It computes the entanglement and coherence for both the perspectival and the global states, using the entanglement entropy and the relative entropy of coherence respectively.
