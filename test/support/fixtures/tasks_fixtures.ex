defmodule Helloworld.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Helloworld.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        due_date: ~D[2025-03-18],
        priority: 42,
        title: "some title"
      })
      |> Helloworld.Tasks.create_task()

    task
  end
end
