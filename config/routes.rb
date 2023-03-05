Rails.application.routes.draw do
  # Various Administrative Panels
  # (ordered alphabetically)

  # ActiveAdmin
  ActiveAdmin.routes(self) if Object.const_defined?('ActiveAdmin')

  # (ThoughtBot's Administrate is not yet included.  It behaves more like a scaffolding
  # engine than any of the others, and would require a little different approach to
  # integrate.)

  # Avo
  mount Avo::Engine, at: Avo.configuration.root_path if Object.const_defined?('Avo')

  # Brick
  # Thie one adds routes on its own during Rails' #finalize! process.

  # Forest Admin
  mount ForestLiana::Engine => '/forest' if Object.const_defined?('ForestLiana')

  # Motor Admin
  mount Motor::Admin => '/motor' if Object.const_defined?('Motor')

  # RailsAdmin
  mount RailsAdmin::Engine => '/ra', as: 'rails_admin' if Object.const_defined?('RailsAdmin')

  mount Spina::Engine => '/spina' if Object.const_defined?('Spina')

  # Trestle
  # By default its Rails Engine is auto-mounted into a path defined in the trestle.rb initializer file.

  # ==================================

  # API documentation
  mount Rswag::Ui::Engine => '/api-docs' if Object.const_defined?('Rswag')
end
