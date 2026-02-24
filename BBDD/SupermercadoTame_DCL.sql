/* Empresa: Supermercado Tame
Dominio IP: 192. 168.5.6
-----------------------------------------------------------------
| Empleados
-----------------------------------
| Jose Antonio Perez
| Maria Rosa Fernandez
| Juan Luis Lopez -----------------------------------------------------------------
Nota: Notifique por pantalla la gestión o resultado de cada uno.

1) Crear las credenciales correspondientes para los empleados anteriores, teniendo en cuenta las siguientes reglas para generar el nombre de usuario.
Reglas para creación de usuario y password. usuario:
|        Puesto          |
|  -----------------------
|        (Cajero)        |
|        (Supervisor)    |
|        (Gerente)       |
- letras en minúsculas
- [nombre del puesto]_[iniciales del nombre ][código ascii correspondiente a las 2 primeras letras]
password:
- Las password se generan con el valor [@Password] [ASCII de la
segunda letra en Mayúsculas)
ASCII (Letras): A=65 , J=74 , F=70, P=80, M=77, L=76, R=82
- Inicialmente se le permite trabajar desde el dominio de la empresa (192. 168.5.6) */
create user if not exists cajero_jap7465@192.168.5.6 identified by '@Password65';
select 'Usuario creado correctamente' as Resultado;
create user if not exists supervisor_mrf7782@192.168.5.6 identified by '@Password82';
select 'Usuario creado correctamente' as Resultado;
create user if not exists gerente_jll7476@192.168.5.6 identified by '@Password76';
select 'Usuario creado correctamente' as Resultado;

/*
2) Crear los perfiles:
     a) invitado:
- con nombre de usuario 'invitado' y contraseña: '@tame1GS' en el 'localhost' de la empresa.
         - Se le permite realizar 10 consultas por horas y 3
conexiones por hora.
b) consultor:
- nombre de usuario 'consultor' con la contraseña
'@Consultor24' cifrada con caching_sha2_password.
- Se le permite conectar por tiempo ilimitado desde
'localhost'
- Tiene que renovar las credenciales de acceso cada 90 días
- Dispone de 5 intentos de validar las credenciales, superado
este límite se le bloque la cuenta por 7 días */
create user if not exists invitado@localhost identified by '@tame1GS';
alter user invitado@localhost with max_queries_per_hour 10;
alter user invitado@localhost with max_connections_per_hour 3;
select 'Usuario creado y limitado correctamente' as Resultado;

create user if not exists consultor@localhost identified by '@Consultor24';
alter user consultor@localhost password expire interval 90 day;
alter user consultor@localhost failed_login_attempts 5 password_lock_time 10080;
select 'Usuario creado y limitado correctamente' as Resultado;
/* 3) Listar los usuarios creados de la empresa */
select user,host from mysql.user;
select 'Lista de los usuarios' as Resultado;

/* 4) Renombre el empleado que es gerente, por el nombre de usuario 'gerente_tienda7476' y la contraseña por '@PassKey#5029' */
rename user gerente_jll7476@192.168.5.6 to gerente_tienda7476@localhost;
alter user gerente_tienda7476@localhost identified by '@PassKey#5029';
select 'Gerente renombrado y cambiado la contraseña correctamente' as Resultado;

/* Usuarios, BBDD, Tablas, Campos, Atributos */

/* 5) Asignar los siguientes permisos y comprobar:
5.1. El usuario "gerente de tienda" es el administrador de la base "dbSupermercado" y tiene todos los privilegios sobre esta base.
5.2. El usuario "supervisor" es un usuario de la base "dbSupermercado" con los privilegios de leer, modificar y registrar, borrar y ejecución
5.3. Los empleados tiene los derechos de registrar, leer, modificar y ejecución
5.4. El usuario invitado, solo tiene permisos para leer sobre la tabla productos. */
grant all privileges on dbSupermercado.* to gerente_tienda7476@localhost;
show grants for gerente_tienda7476@localhost;
grant select,insert,update,delete,execute on dbSupermercado.* to supervisor_mrf7782@192.168.5.6;
show grants for supervisor_mrf7782@192.168.5.6;
grant insert,select,update,execute on dbSupermercado.* to cajero_jap7465@192.168.5.6;
show grants for cajero_jap7465@192.168.5.6;
grant select on dbSupermercado.tblProductos to invitado@localhost;
show grants for invitado@localhost;
select 'Privilegios modificados correctamente' as Resultado;

/* 6) Revocar al gerente los permisos sobre archivos */
revoke file on *.* from gerente_tienda7476@localhost;
show grants for gerente_tienda7476@localhost;
select 'Privilegios modificados correctamente' as Resultado;
/* UN SCRIPT ES UN OBJETO DE LAS BASES DE DATOS */
/* TEORIA DE "ROL"
    Un rol es una agrupación de permisos con un nombre identificativo, que se puede asignar a un usuario. Por tanto, todos los permisos que se agrupan en el rol se asignan simultaneamente al usuario.
   Un rol se puede asignar a otro rol.
   Un usuario puede tener varios roles. Se acumulan los roles.
   Un rol no pertenece a nadie.
   IMPLANTACIÓN:
   1. Creación del rol.
   2. Asignación de los permisos.
   3. Asignación del rol a los usuarios.
*/

/* 7) Crear los Roles: rol_gerenteconsulta, app_developer, app_read, app_write */
create role 'rol_gerenteconsulta';
create role 'app_developer';
create role 'app_read';
create role 'app_write';
select 'Roles creados correctamente' as Resultado;

/*
8) Asignar los siguientes permisos al 'rol_gerenteconsulta':
- Solo realizar consultas a la información sobre : Productos,
Proveedores y Ofertas
  - Eliminar ofertas
  Comprobar los permisos otorgados
 */
grant select on dbSupermercado.tblProductos to 'rol_gerenteconsulta';
grant select on dbSupermercado.tblProveedores to 'rol_gerenteconsulta';
grant select on dbSupermercado.tblOfertas to 'rol_gerenteconsulta';
show grants for 'rol_gerenteconsulta';
select 'Permisos asignados correctamente' as Resultado;

/* 9) Elimine el permiso otorgado al rol rol_gerenteconsulta de eliminar ofertas
    Comprobar los permisos otorgados */
revoke select on dbSupermercado.tblOfertas from 'rol_gerenteconsulta';
show grants for 'rol_gerenteconsulta';
select 'Permisos modificados correctamente' as Resultado;

/* 10) Crear un usuario nuevo llamado "director" y asignarle el rol "rol_gerenteconsulta".
Mostrar los permisos para el usuario director */
create user if not exists director@localhost identified by '12345';
grant 'rol_gerenteconsulta' to director@localhost;
show grants for director@localhost;
select 'Usuario creado correctamente' as Resultado;

/* 11) Eliminar los roles y usuarios creados */
select user,host from mysql.user;
drop role app_developer;
drop role app_read;
drop role app_write;
drop user cajero_jap7465@192.168.5.6;
drop user supervisor_mrf7782@192.168.5.6;
drop user consultor@localhost;
drop user director@localhost;
drop user gerente_tienda7476@localhost;
drop user invitado@localhost;
drop role rol_gerenteconsulta;
select 'Roles y usuarios eliminados correctamente' as Resultado;