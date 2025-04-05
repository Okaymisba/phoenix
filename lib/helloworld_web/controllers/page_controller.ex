defmodule HelloworldWeb.PageController do
  use HelloworldWeb, :controller

  alias Helloworld.Tasks

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    if conn.assigns[:current_user] do
      user = conn.assigns[:current_user]
      tasks = Tasks.list_todays_tasks(user.id)
      overdue_tasks = Tasks.list_overdue_tasks()
      upcoming_tasks = Tasks.list_upcoming_tasks_except_today(user.id)
      render(conn, :home, tasks: tasks, overdue_tasks: overdue_tasks, upcoming_tasks: upcoming_tasks, layout: false)
    else
      redirect(conn, to: ~p"/users/log_in")
    end
  end

  def today(conn, _params) do
    if conn.assigns[:current_user] do
      user = conn.assigns[:current_user]
      tasks = Tasks.list_todays_tasks(user.id)
      overdue_tasks = Tasks.list_overdue_tasks()
      render(conn, :today, tasks: tasks, overdue_tasks: overdue_tasks, layout: false)
    else
      redirect(conn, to: ~p"/users/log_in")
    end
  end

  def upcoming(conn, _params) do
    if conn.assigns[:current_user] do
      user = conn.assigns[:current_user]
      tasks = Tasks.list_upcoming_tasks(user.id)
      overdue_tasks = Tasks.list_overdue_tasks()
      render(conn, :upcoming, tasks: tasks, overdue_tasks: overdue_tasks, layout: false)
    else
      redirect(conn, to: ~p"/users/log_in")
    end
  end

  def toggle_complete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, %{completed: !task.completed}) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: ~p"/")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Could not update task.")
        |> redirect(to: ~p"/")
    end
  end
end
