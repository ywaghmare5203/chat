ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Category" do
          ul do
            Category.all do |post|
                li link_to(post.title, admin_post_path(post.title))
                #t.column("Status") { |task| status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
                t.column("Due Date") { |task| task.due_date? ? l(task.due_date, :format => :long) : '-' }
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to TradeX."
        end
      end
    end
  end # content
end

