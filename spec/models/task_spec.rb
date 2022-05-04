require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Task model test' do
    context 'Si le Title la tâche est vide' do
      it "C'est difficile à Validation" do
        task = Task.new(name: '', content: 'content-test')
        expect(task).not_to be_valid
      end
    end
  end
  describe "fonction de validation taches vides" do
    context 'Si les détails de la tâche sont vides' do
      it 'Validation est intercepté' do
          # Écrivez du contenu ici
      end
    end
  end
    
  describe "fonction de validation des taches décrites" do
    context 'Si le Title et les détails de la tâche sont décrits' do
      it 'Validation passes' do
        # Écrivez du contenu ici
      end
    end
  end
  # -----------------------------------------------------------------------------
  describe 'Fonction de recherche' do
    # Vous pouvez modifier le contenu des données de test selon vos besoins.
    let!(:task) { FactoryBot.create(:task, name: 'task') }
    let!(:second_task) { FactoryBot.create(:second_task, name: "sample") }
    context "Lorsqu'une recherche ambiguë d'un Title la méthode scope" do
      it "Les tâches contenant des mots-clés de recherche sont réduites" do
        # title_seach est une méthode de recherche de Title Le nom de la méthode peut être arbitraire.
        expect(Task.search_by_name('task')).to include(task)
        expect(Task.search_by_name('task')).not_to include(second_task)
        expect(Task.search_by_name('task').count).to eq 1
      end
    end
    context "Lorsque l'état est recherché avec la méthode scope" do
      it "Les tâches qui correspondent exactement au statut sont réduites" do
        expect(Task.search_by_status('completed')).to include(task)
        expect(Task.search_by_status('completed')).not_to include(second_task)
        expect(Task.search_by_status('completed').count).to eq 1
      end
    end
    context "Lors de l'exécution d'une recherche floue et d'une recherche d'état Title" do
      it "Affinez les tâches qui incluent des mots clés de recherche dans le Title et correspondent exactement à l'état" do
        expect(Task.search_by_name_and_status('task', 'completed')).to include(task)
        expect(Task.search_by_name_and_status('task', 'completed')).not_to include(second_task)
        expect(Task.search_by_name_and_status('task', 'completed').count).to eq 1
      end
    end
  end
end