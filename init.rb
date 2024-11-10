require 'redmine'
require File.expand_path('lib/auto_watchers/hooks/auto_watchers_issue_hook', __dir__)

Redmine::Plugin.register :redmine_auto_watchers do
  name 'Automatic Watchers'
  author 'Robert Chady, Felix Schäfer'
  description 'Automatic Watchers is a Redmine project that automatically adds people that touch an issue as watchers."'
  version '1.0.0'

  requires_redmine '5.0'

  settings default:
    {'enable_watchers' => 'on'},
    partial: 'settings/auto_watchers'
end
