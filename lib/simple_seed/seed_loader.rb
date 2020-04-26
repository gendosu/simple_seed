module SimpleSeed
  class SeedLoader
    def self.load_seed
      module_eval open(Rails.root.join('db', 'seeds.rb')).read
    end

    def self.import_fixture(name, environments = nil)
      puts "Import #{name}..."
      fixtures_path = if environments
                        Rails.root.join('db', 'fixtures', environments.to_s)
                      else
                        Rails.root.join('db', 'fixtures')
                      end
      ActiveRecord::FixtureSet.create_fixtures \
      fixtures_path, name
    end
  end
end
