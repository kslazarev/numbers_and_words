# Benchmarks

Run `bundle exec rake benchmark` to measure conversion throughput with [benchmark-ips](https://github.com/evanphx/benchmark-ips) and allocations with Ruby's `GC.stat`. The runner prints Ruby/I18n versions, warms translations before allocation sampling, and exercises small/large English integers, large Russian integers, Italian and British-English fractions, Brazilian-Portuguese ordinals, and arrays.

## Reproducible Comparisons

Use the same Ruby executable, dependencies, JIT settings, host, and environment for both revisions. Avoid concurrent builds or other CPU-intensive tasks. Report each workload's iterations/second and allocated objects/conversion; unlike workloads should not be compared to one another. Throughput includes locale switching; allocations are sampled inside the selected locale. These are warmed steady-state measurements, not process startup or first-translation latency.

Defaults are three seconds of measurement, one second of warmup per workload, and 1,000 allocation samples. Override `BENCHMARK_TIME`, `BENCHMARK_WARMUP`, and `BENCHMARK_ITERATIONS` for longer measurements or a quick smoke test, for example `BENCHMARK_TIME=0.1 BENCHMARK_WARMUP=0.1 BENCHMARK_ITERATIONS=10 bundle exec rake benchmark`. Allocation samples must be positive.

Capture a baseline on the benchmark PR before checking out the performance PR, then repeat the exact command and compare results. Do not enforce noisy wall-clock thresholds in CI. Correctness remains covered by the full conversion suite, targeted edge cases, and installed-package checks.
