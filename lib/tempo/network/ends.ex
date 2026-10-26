defmodule Tempo.Network.Ends do
  @moduledoc false

  # A network counts on boundaries: where a span starts and where what
  # follows it starts. Tempo writes an interval as it is said, an end
  # written to a date being the date it runs through, so the two readings
  # are converted here and nowhere else.

  alias Tempo.Interval

  @doc """
  The start of the span a value or an interval names, and the start of what
  follows it.
  """
  @spec boundaries(Tempo.t()) :: {:ok, {Tempo.t(), Tempo.t()}} | {:error, term()} | :error
  def boundaries(%Tempo{} = value) do
    with {:ok, interval} <- Tempo.to_interval(value),
         {%Tempo{} = from, %Tempo{} = to} <- endpoints(interval),
         {:ok, next} <- following(to) do
      {:ok, {from, next}}
    end
  end

  # A set, a recurrence and an open end name no one span.
  defp endpoints(%Tempo{form: {:span, _from, _to}} = interval), do: Interval.endpoints(interval)
  defp endpoints(_no_one_span), do: :error

  @doc "The interval from one boundary to another, written as Tempo writes one, or `nil` when it has no length."
  @spec interval(Tempo.t(), Tempo.t()) :: Tempo.t() | nil
  def interval(%Tempo{} = from, %Tempo{} = to) do
    with {:ok, last} <- preceding(to),
         {:ok, interval} <- Interval.new(from: from, to: last) do
      interval
    else
      _no_length -> nil
    end
  end

  # An end written to a time of day is the boundary itself; one written to
  # a date is read through, so the boundary is one of its unit later.
  defp following(to), do: moved(to, Tempo.resolution(to), 1)
  defp preceding(to), do: moved(to, Tempo.resolution(to), -1)

  defp moved(to, unit, _by) when unit in [:hour, :minute, :second], do: {:ok, to}

  defp moved(to, unit, by) when unit in [:year, :month, :week, :day],
    do: Tempo.shift(to, [{unit, by}])

  defp moved(to, _day_label, by), do: Tempo.shift(to, day: by)
end
