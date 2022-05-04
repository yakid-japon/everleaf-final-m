require 'rails_helper'
RSpec.describe 'Fonction de gestion des tâches', type: :system do
  before do
    # Vous pouvez modifier le contenu des données de test selon vos besoins.
    FactoryBot.create(:task, name: "task")
    FactoryBot.create(:second_task, name: "sample")
  end
 
  describe "Nouvelle fonction de création" do
    context "Lors de la création d'une nouvelle tâche" do
      it "La tâche créée s'affiche" do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
        expect(page).to have_content 'test_content'
      end
    end
    context "Lors de la création d'une nouvelle tâche" do
      it "La tâche est créée avec une deadline" do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content '2021-10-07'
      end
    end
  end
  describe "Fonction d'affichage de liste" do
    context "Lors de la transition vers l'écran de liste" do
      it "La liste des tâches créées s'affiche" do
      end
    end
    context "Lorsque les tâches sont organisées par ordre décroissant de date et d'heure de création" do
      it "La nouvelle tâche s'affiche en haut" do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'sample'
      end
    end
    context "Lorsque les tâches sont organisées par ordre décroissant de date de fin" do
      it "Les tâches sont triées par date de fin" do
        visit tasks_path
        click_on 'Sort by deadline'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task'
      end
    end
    context "Lorsque les tâches sont organisées par ordre décroissant de priorité" do
      it "La tâche avec une grande priorité s'affiche en haut" do
        visit tasks_path
        click_on 'Order by priority'
        task_list = all('.priority_row')
        expect(task_list[0]).to have_content 'high'
      end
    end
  end
  describe "Fonction d'affichage détaillée" do
     context "Lors de la transition vers un écran de détails de tâche" do
       it "Le contenu de la tâche concernée s'affiche" do
       end
     end
  end
  # Test de recherche-------------------------------------------------------
  describe "Fonction de recherche" do
    context "Si vous effectuez une recherche floue par Title" do
      it "Filtrer par tâches qui incluent des mots-clés de recherche" do
        visit tasks_path
        fill_in 'task[name]', with: 'task'
        click_on 'Search'
        expect(page).to have_content 'task'
      end
    end
    context "Lorsque vous recherchez un statut" do
      it "Les tâches qui correspondent exactement au statut sont réduites" do
        visit tasks_path
        select 'completed', from: 'task[status]'
        click_on 'Search'
        expect(page).to have_content 'task'
      end
    end
    context "Title une recherche floue du titre et d'une recherche d'état" do
      it "Affinez les tâches qui incluent des mots clés de recherche dans le Title et correspondent exactement à l'état" do
        visit tasks_path
        fill_in 'task[name]', with: 'task'
        select 'completed', from: 'task[status]'
        click_on 'Search'
        expect(page).to have_content 'task'
      end
    end
  end
end