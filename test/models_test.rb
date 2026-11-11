require 'test_helper'

# Loads every Visma model and queries its table in the SQL Server from
# docker-compose.yml, so a model pointing at a table or primary key that does
# not exist in db/visma_schema.rb fails here.
class ModelsTest < ActiveSupport::TestCase
  Rails.autoloaders.main.eager_load_dir(Visma::Engine.root.join('app/models/visma').to_s)

  MODELS = ActiveRecord::Base.descendants
                             .select { |model| model.name&.start_with?('Visma::') && !model.abstract_class? }
                             .reject { |model| model.table_name == VISMA_CONFIG['table_name_prefix'] } # Visma::Base, Visma::Address
                             .sort_by(&:name)

  test 'finds Visma models' do
    assert_operator MODELS.size, :>, 90
  end

  MODELS.each do |model|
    test "#{model.name} queries #{model.table_name}" do
      assert model.table_exists?, "#{model.table_name} is missing from db/visma_schema.rb"
      assert_equal 0, model.count
      # db/visma_schema.rb has no primary key constraints, so models relying on the
      # database to report one fall back to "id". Only check declared primary keys.
      if model.primary_key && model.primary_key != 'id'
        assert_includes model.column_names, model.primary_key, "primary key #{model.primary_key} is not a column"
      end
    end
  end
end
