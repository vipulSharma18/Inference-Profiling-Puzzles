# Inference-Profiling-Puzzles
> Note: Project is in the ideation stage, with the creation of puzzles in progress.

Explore commonly faced profiling scenarios and develop an intuition for how to break down profiling problems and find the bottleneck.

## Profilers used:
1. Torch Profiler
2. NVIDIA Nsight Systems
3. NVIDIA Nsight Compute

## Puzzles (Curation in progress):

**Puzzle 1**: TorchAO's `Float8WeightOnlyConfig` on RTX 4090 and RTX 5090 is much slower than the eager baseline.      

**Puzzle 2**: More graphs, more problems: Understanding the impact of CUDAGraphs on GPU memory usage by profiling.      

**Puzzle 3**: What's my autotune up to?: Understand optimizations that the autotuner does by using GemLite's Triton GEMM kernels for RTX 4090 as an example.        

## References/Resources to learn the background:
1. Nsight Systems Docs: https://docs.nvidia.com/nsight-systems/index.html
2. Nsight Compute Docs: https://docs.nvidia.com/nsight-compute/index.html
3. CUDA Developer Tools Tutorials Playlist: https://www.youtube.com/playlist?list=PL5B692fm6--ukF8S7ul5NmceZhXLRv_lR
4. (Note: NASA has good HPC tutorials) NASA HECC Nsight Systems: https://www.nas.nasa.gov/hecc/support/kb/performance-analysis-of-your-gpu-applications-with-nsight-systems_701.html
5. NASA HECC Nsight Compute: https://www.nas.nasa.gov/hecc/support/kb/performance-analysis-of-your-gpu-cuda-kernels-with-nsight-compute-cli_706.html#url
6. (ptrblck's short tutorial) https://dev-discuss.pytorch.org/t/using-nsight-systems-to-profile-gpu-workload/59
7. (Disclaimer: Paid) Optimizing CUDA Machine Learning Codes With Nsight Profiling Tools: https://learn.nvidia.com/courses/course-detail?course_id=course-v1:DLI+S-AC-03+V2
8. (Disclaimer: Paid) Nsight Analysis System: Build Custom Python Analysis Scripts: https://learn.nvidia.com/courses/course-detail?course_id=course-v1:DLI+S-AC-13+V1
9. (Disclaimer: Paid) Find the Bottleneck: Optimize AI Pipelines With Nsight Systems: https://learn.nvidia.com/courses/course-detail?course_id=course-v1:DLI+S-AC-14+V1