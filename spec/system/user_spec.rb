require 'rails_helper'
RSpec.describe 'Fonction de gestion des tâches', type: :system do
  before do
    # Vous pouvez modifier le contenu des données de test selon vos besoins.
    FactoryBot.create(:user)
    FactoryBot.create(:another_user)
  end
 
  describe "Test d'enregistrement des utilisateurs" do
    context "Possibilité d'enregistrer de nouveaux utilisateurs." do
      it "L'utilisateur est créé" do
        visit new_user_path
        fill_in 'user[name]', with: 'tom'
        fill_in 'user[email]', with: 'tom@gmail.com'
        fill_in 'user[password]', with: '123456'
        click_on 'Create User'
        expect(page).to have_content 'User was successfully created.'
      end
    end
    context "Lorsque l'utilisateur essaie de passer à l'écran de la liste des tâches sans se connecter, passez à l'écran de connexion    " do
        it "L'utilisateur est redirigé vers la page de connexion" do
          visit tasks_path
          expect(page).to have_content 'Sign in'
        end
      end
  end
  describe "Test de la fonctionnalité de session" do
    context "Être capable de se connecter" do
      it "L'utilisateur créé s'est connecté" do
        visit new_session_path
        fill_in 'session[email]', with: 'test@mail.com'
        fill_in 'session[password]', with: '123456'
        click_on 'Log in'
        expect(page).to have_content 'Logout'
      end
    end
    context "Vous pouvez accéder à votre écran de détails (Ma page)" do
        it "L'utilisateur connecté peut accéder à ses taches" do
            visit new_session_path
            fill_in 'session[email]', with: 'test@mail.com'
            fill_in 'session[password]', with: '123456'
            click_on 'Log in'
            click_on 'My Tasks'
            expect(page).to have_content 'test'
        end
    end
    context "Lorsqu'un utilisateur général passe à l'écran des détails d'une autre personne, il passe à l'écran de la liste des tâches" do
        it "L'utilisateur connecté est redirigé vers la liste des tâches quand il essaie de voir les détails d'un autre utilisateur" do
            user = FactoryBot.create(:user, email: 'test_2@mail.com')
            visit new_session_path
            fill_in 'session[email]', with: 'test@mail.com'
            fill_in 'session[password]', with: '123456'
            click_on 'Log in'
            visit admin_user_path(user)
            expect(page).to have_content 'My Tasks'
        end
    end
    context "Être capable de se déconnecter" do
        it "L'utilisateur connecté peut se déconnecter" do
            visit new_session_path
            fill_in 'session[email]', with: 'test@mail.com'
            fill_in 'session[password]', with: '123456'
            click_on 'Log in'
            click_on 'Logout'
            expect(page).to have_content 'Déconnecté'
        end
    end
  end
  describe "Test de l'écran d'administration" do
    context "Les utilisateurs administrateurs doivent pouvoir accéder à l'écran d'administration" do
      it "L'utilisateur admin accède au pannel admin" do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@mail.com'
        fill_in 'session[password]', with: '123456'
        click_on 'Log in'
        click_on 'Admin pannel'
        expect(page).to have_content 'List Users'
      end
    end
    context "Les utilisateurs généraux ne peuvent pas accéder à l'écran de gestion" do
        it "L'utilisateur simple connecté ne peut accéder au pannel admin" do
            visit new_session_path
            fill_in 'session[email]', with: 'test@mail.com'
            fill_in 'session[password]', with: '123456'
            click_on 'Log in'
            visit admin_users_path
            expect(page).not_to have_content 'List Users'
        end
    end
    context "Les utilisateurs administrateurs peuvent enregistrer de nouveaux utilisateurs" do
        it "L'utilisateur admin peut ajouter un autre utilisateur" do
            visit new_session_path
            fill_in 'session[email]', with: 'admin@mail.com'
            fill_in 'session[password]', with: '123456'
            click_on 'Log in'
            visit admin_users_path
            click_on 'Add User'
            fill_in 'user[name]', with: 'tom'
            fill_in 'user[email]', with: 'tom@gmail.com'
            fill_in 'user[password]', with: '123456'
            click_on 'Create User'
            expect(page).to have_content 'User was successfully created.'
        end
    end
    context "Les utilisateurs administrateurs doivent pouvoir accéder à l'écran des détails de l'utilisateur" do
        it "L'utilisateur admin connecté peut voir les tasks d'un utilisateur" do
            user = FactoryBot.create(:user, email: 'test_2@mail.com')
            FactoryBot.create(:task, user: user)
            visit new_session_path
            fill_in 'session[email]', with: 'admin@mail.com'
            fill_in 'session[password]', with: '123456'
            click_on 'Log in'
            visit admin_user_path(user)
            expect(page).to have_content 'test_name'
        end
    end
    context "L'utilisateur administrateur peut modifier l'utilisateur à partir de l'écran d'édition de l'utilisateur" do
        it "L'utilisateur admin connecté peut modifier un utilisateur" do
            user = FactoryBot.create(:user, email: 'test_2@mail.com')
            visit new_session_path
            fill_in 'session[email]', with: 'admin@mail.com'
            fill_in 'session[password]', with: '123456'
            click_on 'Log in'
            visit edit_admin_user_path(user)
            fill_in 'user[name]', with: 'tom'
            fill_in 'user[email]', with: 'tom@gmail.com'
            fill_in 'user[password]', with: '123456'
            click_on 'Update User'
            expect(page).to have_content 'tom@gmail.com'
        end
    end
    context "Les utilisateurs administrateurs peuvent supprimer des utilisateurs" do
        it "L'utilisateur admin connecté peut supprimer un utilisateur" do
            visit new_session_path
            fill_in 'session[email]', with: 'admin@mail.com'
            fill_in 'session[password]', with: '123456'
            click_on 'Log in'
            visit admin_users_path
            all_btn_delete = all('.delete_list')
            find('.test').find('a').click
            page.driver.browser.switch_to.alert.accept
            expect(page).not_to have_content 'test'
        end
    end
  end
end