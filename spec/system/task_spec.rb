require 'rails_helper'
RSpec.describe 'Fonction de gestion des tâches', type: :system do
  before do
    # あらかじめタスク一覧のtestで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
  end
 
  describe "Nouvelle fonction de création" do
    context "Lors de la création d'une nouvelle tâche" do
      it "La tâche créée s'affiche" do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe "Fonction d'affichage de liste" do
    context "Lors de la transition vers l'écran de liste" do
      it "La liste des tâches créées s'affiche" do
      end
    end
  end
  describe "Fonction d'affichage détaillée" do
     context "Lors de la transition vers un écran de détails de tâche" do
       it "Le contenu de la tâche concernée s'affiche" do
       end
     end
  end
end