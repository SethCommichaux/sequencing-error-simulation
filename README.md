# sequencing-error-simulation
This R script simulates sequencing error accumulation across a synthetic genome using a bootstrapped model. It estimates the number of genomic positions with a minimum depth of erroneous coverage, reflecting potential false variant calls under high-throughput conditions. The simulation incorporates user-defined genome length, error rate, sequencing depth, and number of bootstrap iterations. Useful for benchmarking downstream variant calling thresholds or modeling sequencing uncertainty in microbial genomics.

One example result, is that at 1000X sequencing depth of coverage, and a 0.1% error rate (typical for Illumina platforms), true biological variants are not distinguishable from false positive errors with less than 10X coverage.
