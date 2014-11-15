# Hook in to the Issues controller and update the watchers before it is
# saved.
class AutoWatchersIssuesControllerHook < Redmine::Hook::ViewListener
  def controller_issues_edit_before_save(context={})
    configuration = Setting.plugin_redmine_auto_watchers
    if configuration['enable_watchers']
      issue = context[:issue]
      # Add the current user if they are addable
      issue.add_watcher(User.current) unless issue.watched_by?(User.current)

      # Add the person the ticket is assigned to if it is assigned to
      # someone and they are addable.
      issue.add_watcher(issue.assigned_to) if
        issue.assigned_to &&
        issue.assigned_to != User.current && # works around addable_watcher_users not being updated by add_watcher
        !issue.watched_by?(issue.assigned_to)
    end
  end

  def controller_issues_new_before_save(context={})
    controller_issues_edit_before_save(context)
  end
end
