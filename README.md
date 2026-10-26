# Tempo Network

Chronological networks and dependency scheduling for [Tempo](https://hexdocs.pm/ex_tempo): periods known only relative to one another, the relations between them, and what follows from what you know.

* `Tempo.Network` holds periods whose starts, ends and lengths may each be exact, one-sided, a range or unknown, with the sequences and relations that tie them. `Tempo.Network.Solver` says whether what you have stated can all be true, and gives the tightest dates each period can take.

* `Tempo.Schedule` plans tasks with lengths and dependencies: when each can start at the earliest and at the latest, which have slack, and the critical path.

* `Tempo.Interval.RelationNetwork` reasons with Allen's relations alone, where no date or length is known.

Before Tempo 2.0 these modules were part of `ex_tempo`. Their names are unchanged.

## Installation

```elixir
def deps do
  [
    {:ex_tempo, "~> 2.0"},
    {:ex_tempo_network, "~> 1.0"}
  ]
end
```

Tempo Network requires Elixir 1.17 or later and Erlang/OTP 27 or later.

## A plan

```elixir
iex> import Tempo.Sigils
iex> {:ok, plan} =
...>   Tempo.Schedule.new()
...>   |> Tempo.Schedule.task(:design, duration: ~o"P2D", start: ~o"2026-06-01")
...>   |> Tempo.Schedule.task(:build, duration: ~o"P3D", after: :design)
...>   |> Tempo.Schedule.task(:docs, duration: ~o"P1D", after: :design)
...>   |> Tempo.Schedule.task(:ship, duration: ~o"P2D", after: [:build, :docs], deadline: ~o"2026-06-08")
...>   |> Tempo.Schedule.solve()
iex> plan[:ship].early
~o"2026Y6M6D/7D"
iex> plan[:docs].critical?
false
iex> Tempo.Schedule.critical_path(plan)
[:design, :build, :ship]
```

> *"Design for two days from the first of June, then build and document, then ship by the eighth. Shipping takes the sixth and the seventh; the documentation has slack; the critical path is design, build, ship."*

## A chronology

```elixir
iex> import Tempo.Sigils
iex> alias Tempo.Network
iex> network =
...>   Network.new()
...>   |> Network.add_period(:k1, from: {:not_before, ~o"1200Y"}, duration: {:at_most, ~o"P10Y"})
...>   |> Network.add_period(:k2, to: {:not_after, ~o"1300Y"}, duration: {:at_least, ~o"P35Y"})
...>   |> Network.add_sequence([:k1, :k2])
iex> Network.Solver.consistent?(network)
true
iex> {:ok, solved} = Network.Solver.propagate(network)
iex> solved.periods[:k2].latest_start
~o"1265Y"
```

> *"King K1 began no earlier than 1200 and reigned at most ten years; K2 followed him, reigned at least thirty-five and was gone by 1300. So K2 came to the throne no later than 1265."*

The [Chronological networks](https://hexdocs.pm/ex_tempo_network/chronological-networks.html) guide takes a whole chronology through stating, checking, tightening and tracing.

## Written ends

Tempo writes an interval as it is said: an end written to a date is the date the interval runs through. A two-day task that starts on 1 June is therefore `~o"2026-06-01/2026-06-02"`, where `ex_tempo` 1.x wrote `2026-06-01/2026-06-03`. A network's own bounds (`earliest_start`, `latest_end` and the rest) are points and are unchanged.
