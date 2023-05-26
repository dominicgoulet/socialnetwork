# frozen_string_literal: true

namespace :sorbet do
  namespace :update do
    desc 'Update Sorbet and Sorbet Rails RBIs.'

    task all: :environment do
      Bundler.with_unbundled_env do
        system('bundle exec tapioca gems --all')
        system('bundle exec tapioca annotations')
        system('bundle exec tapioca dsl')
        system('bundle exec srb rbi hidden-definitions')
        system('bundle exec tapioca todo')
      end
    end
  end
end
