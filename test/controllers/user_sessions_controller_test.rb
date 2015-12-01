# coding: utf-8
class UserSessionsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  test "puede iniciar sesión si no lo ha hecho" do
    # No debe haber sesión
    assert_nil @controller.send(:current_user)
    assert_nil @controller.send(:current_user_session)

    # Debe recibir la página de inicio de sesión
    get :new
    assert_response :success
  end

  test "no puede iniciar sesión si ya hay" do
    # Inicio una sesión
    UserSession.create(users(:usuario))
    assert_not_nil @controller.send(:current_user)
    assert_not_nil @controller.send(:current_user_session)

    # La página de inicio de sesión debe redirigir
    get :new
    assert_response :redirect
  end
  
end
