# coding: utf-8

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # Pruebas para las validaciones
  test "requiere nombre" do
    u = User.new
    assert_not u.save           # No guarda sin nada
    
    u.email = "mail-requiere-nombre@example.com"
    assert_not u.save           # No guarda con correo
    
    u.password = "pass"
    u.password_confirmation = "pass"
    assert_not u.save           # No guarda con correo y contraseña
    
    u.name = "name"
    assert u.save               # Con usuario ya guarda
  end

  
  test "requiere correo" do
    u = User.new
    assert_not u.save           # No guarda sin nada
    
    u.name = "name"
    assert_not u.save           # No guarda con nombre
    
    u.password = "pass"
    u.password_confirmation = "pass"
    assert_not u.save           # No guarda con nombre y contraseña
    
    u.email = "mail-requiere-correo@example.com"
    assert u.save               # Con correo ya guarda
  end


  test "correo único" do
    u1 = User.new
    u1.name = "name1"
    u1.password = u1.password_confirmation = "pass1"
    u1.email = "email_repetido@example.com"
    assert u1.save              # Debo poder guardar el primero
    
    u2 = User.new
    u2.name = "name2"
    u2.password = u2.password_confirmation = "pass2"
    u2.email = "email_repetido@example.com"
    assert_not u2.save          # Pero no el segundo
  end

  
end
