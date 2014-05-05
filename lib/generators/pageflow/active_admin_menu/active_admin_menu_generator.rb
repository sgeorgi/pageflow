module Pageflow
  module Generators
    class ActiveAdminMenuGenerator < Rails::Generators::Base
      desc "Configure active admin utilitiy menu to contain profile link."

      def configure_active_admin
        inject_into_file 'config/initializers/active_admin.rb', after: "ActiveAdmin.setup do |config|\n" do
          <<-RUBY
  config.namespace :admin do |admin|
    admin.build_menu :utility_navigation do |menu|
      menu.add(:label => proc { display_name current_active_admin_user },
               :id => 'current_user',
               :if => proc { current_active_admin_user? },
               :url => '/admin/users/me')
      admin.add_logout_button_to_menu(menu)
    end
  end
RUBY
        end
      end
    end
  end
end
