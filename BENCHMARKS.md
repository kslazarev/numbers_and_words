# Benchmarks

Run `bundle exec rake benchmark` to measure conversion throughput with [benchmark-ips](https://github.com/evanphx/benchmark-ips) and allocations with Ruby's `GC.stat`. The runner prints Ruby/I18n versions, warms translations before allocation sampling, and exercises small/large English integers, large Russian integers, Italian and British-English fractions, Brazilian-Portuguese ordinals, and arrays.

## Reproducible Comparisons

Use the same Ruby executable, dependencies, JIT settings, host, and environment for both revisions. Avoid concurrent builds or other CPU-intensive tasks. Report each workload's iterations/second and allocated objects/conversion; unlike workloads should not be compared to one another. Throughput includes locale switching; allocations are sampled inside the selected locale. These are warmed steady-state measurements, not process startup or first-translation latency.

Defaults are three seconds of measurement, one second of warmup per workload, and 1,000 allocation samples. Override `BENCHMARK_TIME`, `BENCHMARK_WARMUP`, and `BENCHMARK_ITERATIONS` for longer measurements or a quick smoke test, for example `BENCHMARK_TIME=0.1 BENCHMARK_WARMUP=0.1 BENCHMARK_ITERATIONS=10 bundle exec rake benchmark`. Allocation samples must be positive.

Capture a baseline on the benchmark PR before checking out the performance PR, then repeat the exact command and compare results. Do not enforce noisy wall-clock thresholds in CI. Correctness remains covered by the full conversion suite, targeted edge cases, and installed-package checks.

## Measured Results

A back-to-back run on arm64 macOS, CRuby 4.0.9 without YJIT, and I18n 1.15.2 compared the benchmark layer (`c3167bf`) with the conversion optimizations, using the defaults above:

| Workload | Before, Conversions/s | After, Conversions/s | Before, Objects/Conversion | After, Objects/Conversion |
| --- | ---: | ---: | ---: | ---: |
| English Small Integer | 47,673 | 49,086 | 144 | 124 |
| English Large Integer | 8,801 | 11,478 | 821 | 388 |
| Russian Large Integer | 16,008 | 16,074 | 268 | 257 |
| Italian Fraction | 13,953 | 14,213 | 309 | 291 |
| British-English Fraction | 13,031 | 13,359 | 543 | 488 |
| Brazilian-Portuguese Ordinal | 44,674 | 47,771 | 162 | 124 |
| English Array | 4,746 | 5,517 | 1,527 | 960 |

These are single-host observations, not guarantees; small throughput differences can be noise. The clearest improvements are approximately 30% more large-English conversions/second with 53% fewer allocations, and 16% more array conversions/second with 37% fewer allocations. Every measured workload allocates less.

The option proxy reuses class-name strings only within that proxy and locale. It still resolves constants and creates fresh option objects, so changed options, runtime extensions, and locale switches remain visible. Integer conversion extracts digits without intermediate character strings while preserving the legacy leading-zero layout for negative values. Float wrappers split their source once per conversion and refresh the split when reused.
