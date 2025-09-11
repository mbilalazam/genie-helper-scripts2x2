# SLURM Command Cheat Sheet

## Job Submission
- `sbatch job.slurm` — Submit a batch job.
- `salloc -N 1 -C cpu -q debug -t 00:30:00` — Request an interactive session.
- `srun -n 4 ./program` — Run a command or program with SLURM (often used inside jobs).

## Job Monitoring
- `squeue` — List all jobs in the queue.
- `squeue -u $USER` — List your jobs only.
- `squeue -j JOBID` — Show details of a specific job.
- `scontrol show job JOBID` — Full job info (nodes, status, resources).

## Job Management
- `scancel JOBID` — Cancel a job.
- `scancel -u $USER` — Cancel all your jobs.
- `scontrol hold JOBID` — Put a job on hold.
- `scontrol release JOBID` — Release a held job.

## Output and Logs
- `tail -f slurm-JOBID.out` — Follow job output live.
- `cat slurm-JOBID.out` — Print job output after it finishes.

## Resource/Account Info
- `sacct` — Show job accounting information (after job ends).
- `sacct -j JOBID` — Detailed accounting for one job.
- `sinfo` — Show available partitions, nodes, and state.
- `scontrol show node NODENAME` — Detailed node information.
