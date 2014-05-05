require 'state_machine'
require 'state_machine_job'
require 'paperclip'
require 'aws-sdk'
require 'friendly_id'
require 'devise'
require 'cancan'
require 'jbuilder'

require 'resque_mailer'
require 'resque_scheduler'

require 'active_admin'
require 'active_admin/patches/views/attributes_table'
require 'active_admin/patches/views/table_for'

require 'jquery-layout-rails'
require 'videojs_rails'
require 'backbone-rails'
require 'marionette-rails'
require 'jquery-fileupload-rails'
require 'wysihtml5-rails'
require 'i18n-js'

module Pageflow
  # Rails integration
  class Engine < ::Rails::Engine
    isolate_namespace Pageflow

    config.autoload_paths << File.join(config.root, 'lib')

    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.yml').to_s]
    config.i18n.default_locale = :de

    # Supress deprecation warning. This is the future default value of the option.
    I18n.config.enforce_available_locales = true

    # FORCE RAILS TO MAKE I18N AVAILABLE TO ACTIVE ADMIN
    config.before_configuration do
      I18n.load_path += Dir[Engine.root.join('config', 'locales', '**', '*.yml').to_s]
      I18n.locale = :de
      I18n.default_locale = :de
      config.i18n.load_path += Dir[Engine.root.join('config', 'locales', '**', '*.yml').to_s]
      config.i18n.locale = :de
      # bypasses rails bug with i18n in production
      I18n.reload!
      config.i18n.reload!
    end

    # Make sure the configuration is recreated when classes are
    # reloded. Otherwise registered page types might still point to
    # unloaded classes in development mode.
    config.to_prepare do
      Pageflow.configure!
    end
  end
end
