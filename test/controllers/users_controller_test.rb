# coding: utf-8
class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic

  test "puede crear usuario si no hay sesión" do
    # No debe haber sesión
    assert_nil @controller.send(:current_user)
    assert_nil @controller.send(:current_user_session)

    # Checo que pueda ver la página
    get :new
    assert_response :success
    assert_not_nil assigns(:user)

    # Checo que pueda crear
    assert_difference ('User.count') do
      post :create, user: {name: 'Nombre',
                           email: 'mail-crear@example.com',
                           password: 'pass',
                           password_confirmation: 'pass'}
    end
  end

  test "no puede crear usuario si hay sesión" do
    # Inicio una sesión
    UserSession.create(users(:usuario))
    assert_not_nil @controller.send(:current_user)
    assert_not_nil @controller.send(:current_user_session)

    # La página de creación debe redirigir a otra
    get :new
    assert_response :redirect
  end
  
end
