# Genome Error Simulation Script
# Purpose: Simulate sequencing error accumulation across a genome using bootstrap replicates

# ---- Parameters ----
genome_len <- 2000000      # Genome length in nucleotides
error_rate <- 0.001        # Sequencing error rate (e.g., 0.1% typical for Illumina)
min_depth <- 8             # Minimum depth threshold to consider a locus error-prone
depth_of_coverage <- 1000  # Total sequencing depth (number of simulated reads)
num_errors <- floor(error_rate * genome_len)  # Errors per read cycle (rounded to integer)
num_bootstraps <- 100       # Number of bootstrap simulations to estimate variability

# ---- Storage for results ----
results <- numeric()       # Holds counts of loci exceeding error threshold across bootstraps

# ---- Initialize progress bar ----
pb <- txtProgressBar(min = 0, max = num_bootstraps, style = 3)

# ---- Bootstrap Loop ----
for (b in 1:num_bootstraps) {
  genome <- integer(genome_len)  # Reset genome: zeroed vector representing loci
  
  # Simulate error introduction for each read in depth
  for (i in 1:depth_of_coverage) {
    # Randomly select loci to receive sequencing errors for one read
    error_positions <- sample(0:(genome_len - 1), size = num_errors, replace = TRUE)
    
    # Tabulate errors across loci and update cumulative error profile
    genome <- genome + tabulate(error_positions + 1, nbins = genome_len)
  }
  
  # Count loci where errors accumulate past the minimum depth threshold
  results <- c(results, sum(genome >= min_depth))
  
  # Update progress bar
  setTxtProgressBar(pb, b)
}

# ---- Output summary statistics ----
summary(results)  # Median, quartiles, min/max number of loci exceeding error threshold
