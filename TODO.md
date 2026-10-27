# TODO

The work before `ex_tempo_network`'s first release. Tempo's own list is in its repository.

## Done

* [x] **The lock on the published Tempo 2.0.0** — Tempo 2.0.0 was published again after its first release was reverted, so the lock's checksum for it was stale; `mix deps.unlock ex_tempo` and `mix deps.get` moved it, and the gates pass against it (230 tests, guides, Credo, docs). 2026-10-27.

* [x] **Tempo 2.0 from hex** — `mix.exs` names `{:ex_tempo, "~> 2.0"}` now that Tempo 2.0.0 is published, and 1.0.0 is dated. 2026-10-26.

* [x] **CI on Tempo from GitHub** — CI failed at `mix deps.get` because the sibling path `../tempo` is not checked out there; `mix.exs` takes Tempo from GitHub `main`, as Tempo's other companions do. 2026-10-26.
