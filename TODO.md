# TODO

The work before `ex_tempo_network`'s first release. Tempo's own list is in its repository.

## Done

* [x] **Tempo 2.0 from hex** — `mix.exs` names `{:ex_tempo, "~> 2.0"}` now that Tempo 2.0.0 is published, and 1.0.0 is dated. 2026-10-26.

* [x] **CI on Tempo from GitHub** — CI failed at `mix deps.get` because the sibling path `../tempo` is not checked out there; `mix.exs` takes Tempo from GitHub `main`, as Tempo's other companions do. 2026-10-26.
