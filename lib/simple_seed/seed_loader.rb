# frozen_string_literal: true

module SimpleSeed
  class SeedLoader
    def self.load_seed
      module_eval open(Rails.root.join('db', 'seeds.rb')).read
    end

    def self.import_fixture(name, environments = nil)
      env_list = if environments.is_a?(Array)
                   environments.map(&:to_s)
                 elsif !environments
                   []
                 else
                   [environments.to_s]
                 end

      return if environments && !env_list.include?(Rails.env.downcase)

      puts "Import #{name}..."

      if !environments
        ActiveRecord::FixtureSet.create_fixtures \
          Rails.root.join('db', 'fixtures'), name

      elsif env_list.include?(Rails.env.downcase)
        ActiveRecord::FixtureSet.create_fixtures \
          Rails.root.join('db', 'fixtures', Rails.env.downcase), name
      end
    end
  end
end
