# Changelog

## [v1.0.0] — Unreleased

### Highlights

* `Tempo.Network`, `Tempo.Network.Solver`, `Tempo.Schedule` and `Tempo.Interval.RelationNetwork`, moved from `ex_tempo` 1.x with their names and functions unchanged, on Tempo 2.0. See the [README](https://hexdocs.pm/ex_tempo_network/readme.html).

### Changed

* A scheduled task's `early` and `late` intervals, and `Tempo.Schedule.span/1`, are written as Tempo 2.0 writes an interval: a two-day task from 1 June is `2026-06-01/2026-06-02`.

* `Tempo.Schedule.span/1` of a plan with no span returns a `Tempo.ConversionError`, where it returned a `Tempo.IntervalEndpointsError`.

### Removed

* `Tempo.Interval.Relations`. `Tempo.Allen.relations/0` is the full set, and `Tempo.Interval.RelationNetwork.constrain/4` puts a set in Allen's order.
