# Postgres benchmarks

Set of benchmarks focusing on Postgres performance optimization techniques.

All benchmarks are reproducible, local result and some thoughts are present in each.

All benchmarks were running on LINUX, Intel Core i7-8700, 16G RAM.

## Benchmarks:
- [Count and distinct](./count_distinct/results.md)

## How to run

To start postgres locally in docker:
```bash
./start.sh
```

To run benchmark:
```bash
./count_distinct/run.sh
```
