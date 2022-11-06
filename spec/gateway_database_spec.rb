# frozen_string_literal: false

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Integration Tests of Youtube API and Database' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_youtube
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store project' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should save all the categories in the dabase' do
      categories = UFeeling::Youtube::CategoryMapper
        .new(YOUTUBE_API_KEY)
        .categories(UFeeling::REGIONS[:MEXICO])

      categories.each { |category| UFeeling::Repository::For.klass(UFeeling::Entity::Category).find_or_create(category) }

      categories_db = UFeeling::Repository::For.klass(UFeeling::Entity::Category).find_by_region(UFeeling::REGIONS[:MEXICO])

      _(categories_db.size).must_equal(categories.size)
    end
  end
end
