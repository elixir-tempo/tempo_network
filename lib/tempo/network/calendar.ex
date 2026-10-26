defmodule Tempo.Network.Calendar do
  @moduledoc false

  # The questions a network asks of a calendar, and the one place in this
  # package that reaches into Tempo's engine: `Tempo.Calendar` answers each
  # for any calendar, `Calendar.ISO` included, as it does for Tempo itself.
  # No calendar arithmetic is done here.

  alias Tempo.Calendar, as: Engine

  @doc "The months every year of a calendar has, or `nil` when its years differ."
  @spec months_in_year(module()) :: pos_integer() | nil
  def months_in_year(calendar) do
    case Engine.months_in_year_bounds(calendar) do
      {months, months} when is_integer(months) -> months
      _years_differ -> nil
    end
  end

  @doc "The day number of a date."
  @spec iso_days(module(), integer(), pos_integer(), pos_integer()) :: integer()
  def iso_days(calendar, year, month, day), do: Engine.iso_days(calendar, year, month, day)

  @doc "The date a day number is, in a calendar."
  @spec date(module(), integer()) :: {:ok, Date.t()} | {:error, term()}
  def date(calendar, days) do
    {year, month, day} = Engine.date(calendar, days)
    Date.new(year, month, day, calendar)
  end

  @doc "The days a week of the calendar has."
  @spec days_in_week(module()) :: pos_integer()
  def days_in_week(calendar), do: Engine.days_in_week(calendar)

  @doc "The years after which a calendar's years come round again, or `nil`."
  @spec years_in_cycle(module()) :: pos_integer() | nil
  def years_in_cycle(calendar), do: Engine.years_in_cycle(calendar)

  @doc "The day number of a year's first day."
  @spec first_day_of_year(module(), integer()) :: {:ok, integer()} | {:error, term()}
  def first_day_of_year(calendar, year) do
    with {:ok, {first, _after_last}} <- Engine.period(calendar, :year, year, nil),
         do: {:ok, first}
  end
end
