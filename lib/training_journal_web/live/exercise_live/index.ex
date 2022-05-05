defmodule TrainingJournalWeb.ExerciseLive.Index do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Exercises
  alias TrainingJournal.Exercises.Exercise

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :exercises, list_exercises())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Exercise")
    |> assign(:exercise, Exercises.get_exercise!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Exercise")
    |> assign(:exercise, %Exercise{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Exercises")
    |> assign(:exercise, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    exercise = Exercises.get_exercise!(id)
    {:ok, _} = Exercises.delete_exercise(exercise)

    {:noreply, assign(socket, :exercises, list_exercises())}
  end

  defp list_exercises do
    Exercises.list_exercises()
  end
end
