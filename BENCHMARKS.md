# Benchmarks

Run `bundle exec rake benchmark` to measure conversion throughput with [benchmark-ips](https://github.com/evanphx/benchmark-ips) and allocations with Ruby's `GC.stat`. The runner prints the Ruby and I18n versions, warms translations first, and covers small and large English integers, large Russian, French, Arabic and Chinese integers, Japanese kana, Italian and British English fractions, Brazilian Portuguese and German ordinals, and arrays.

The rule engine compiles each locale's rule sets and resolves its words once per process, so the first conversion in a locale is slower than the measured, warmed ones. Storing translations or reloading I18n starts over.

## Comparing Revisions

Run both revisions with the same Ruby, dependencies, JIT settings and host, and nothing else CPU-intensive running. Compare each workload's conversions per second and objects allocated per conversion against itself, not against other workloads. These are warmed, steady-state measurements, not startup latency.

By default each workload measures for three seconds after a one-second warmup, with 1,000 allocation samples. Override `BENCHMARK_TIME`, `BENCHMARK_WARMUP` and `BENCHMARK_ITERATIONS`, for example `BENCHMARK_TIME=0.1 BENCHMARK_WARMUP=0.1 BENCHMARK_ITERATIONS=10 bundle exec rake benchmark` for a quick smoke test.

Capture a baseline before checking out a performance change, then rerun the same command. CI doesn't enforce timing thresholds, which are too noisy; correctness is covered by the test suite.
