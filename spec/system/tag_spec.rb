require 'rails_helper'

def login
    visit new_session_path
    fill_in 'session[email]', with: 'test@mail.com'
    fill_in 'session[password]', with: '123456'
    click_on 'Log in'
end
RSpec.describe 'Fonction de gestion des étiquettes', type: :system do
    before do
        FactoryBot.create(:tag, name: 'tag1')
        FactoryBot.create(:tag, name: 'tag2')
        login()
    end
  describe "Nouvelle fonction de création de tâche" do
    context "Lors de la création d'une nouvelle tâche" do
      it "La tâche créée est attachée à des étiquettes" do
        visit new_task_path
        fill_in "task[name]",	with: "test"
        fill_in "task[content]",	with: "sometext"
        check 'tag1'
        click_on 'Create Task'
        expect(page).to have_content 'tag1'
      end
    end
    context "Lors de la recherche par une étiquette" do
      it "La tâche recherchée par tag s'affiche" do
        visit new_task_path
        fill_in "task[name]",	with: "test"
        fill_in "task[content]",	with: "sometext"
        check 'tag1'
        click_on 'Create Task'
        visit tasks_path
        select 'tag1', from: 'task[tag]'
        click_on 'Search'
        expect(page).to have_content 'test'
      end
    end
  end
end