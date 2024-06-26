require 'rails_helper'
require "factory"

RSpec.describe 'Hello world', type: :system do
  before do
    start_year = 2017
    current_year = start_year
    current_semester = 1

    ApplicationConfig.create(key: "year", value: current_year)
    ApplicationConfig.create(key: "semester", value: current_semester)

    Factory.create_admin

    faculty = Faculty.create!(name: "Sains dan Teknologi")
    department = Department.create!(name: "Teknik Informatika", faculty: faculty)
  end

  describe 'index page' do
    it 'shows the right content' do
      visit "/admin/login?email=admin@uinjkt.ac.id"
      expect(page).to have_content('Ais')
    end
  end
end
