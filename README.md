# LostANDFound

*LostANDFound* es una aplicación para buscar cosas perdidas, pensada para la Facultad de Ciencias. Está hecha en Ruby on Rails, y usa como manejador de base de datos a SQLite en el entorno de desarrollo y PostgreSQL en producción.

## Uso

### Desarrollo

Para configurar la aplicación en el entorno de desarrollo, ejecuta

```
./bin/setup
export MAILER_PASSWORD=<contraseña de la cuenta de correo>
```

y para iniciarla

```
./bin/rails s
```

### Producción

Para usar la aplicación en el entorno de producción, hay que configurar la variable de entorno `RAILS_ENV` con

```
export RAILS_ENV=production
```

Además hay que iniciar PostgreSQL. Para eso, se necesita tener un usuario `postgres` sin contraseña, y con ese usuario ejecutar

```
initdb -D <directorio para los datos>
pg_ctl start -l <archivo para los logs> -D <directorio para los datos>
```
(`postgres` debe tener permisos de escritura sobre `<directorio para los datos>`, se recomienda `/usr/local/pgsql/data`).

Después, como un usuario normal ejecutar (dentro del directorio de la aplicación)

```
./bin/setup
export SECRET_KEY_BASE=`./bin/rake secret`
export MAILER_PASSWORD=<contraseña de la cuenta de correo>
./bin/rake assets:precompile
```

Si no estás usando Apache, NGINX o algo similar para servir archivos estáticos, ejecuta
```
export RAILS_SERVE_STATIC_FILES=1
```
para que lo haga Rails.

La aplicación ya está lista para iniciar con

```
./bin/rails s
```

## Moderadores

Los moderadores tienen privilegios especiales dentro de la aplicación, pero no se pueden crear desde la aplicación. Para crearlos
se debe crear desde la consola de Ruby on Rails. Para iniciar la consola, use

```
./bin/rails c
```

y dentro de la consola haga

```
User.create(name: <nombre del moderador>, email: <correo del moderador>,
            password: <contraseña>, password_confirmation: <contraseña>,
            verified: true, role: User::MOD)
```
(nota que la cuenta ya está verificada y no recibirá un correo de verificación)