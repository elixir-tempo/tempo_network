# TODO

The work before `ex_tempo_network`'s first release. Tempo's own list is in its repository.

## Blocked

* [ ] **Tempo 2.0 from hex** — `mix.exs` takes `ex_tempo` from GitHub `main`; once Tempo 2.0.0 is published it names `{:ex_tempo, "~> 2.0"}`, and 1.0.0 is dated and published. Blocked on `ex_tempo 2.0.0`.

## Done

* [x] **CI on Tempo from GitHub** — CI failed at `mix deps.get` because the sibling path `../tempo` is not checked out there; `mix.exs` takes Tempo from GitHub `main`, as Tempo's other companions do. 2026-10-26.
