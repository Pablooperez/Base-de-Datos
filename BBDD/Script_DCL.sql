/* Usuario: Tame1 localhost 123456789asD
   Usuario: Tame2 192.168.3.56 123456789asD
   Usuario: Tame3 localhost 123456789asD
   Usuario_Juan  123456789asD
   Modificar Juan para ponerlo en localhost
    */

create user if not exists usuario1@localhost identified by '123456789asD';
create user if not exists usuario2@192.168.3.56 identified by '123456789asD';
create user if not exists usuario3@localhost identified by '123456789asD';

create user if not exists usuario_juan identified by '123456789';

update mysql.user
set Host='localhost' where User='usuario_juan';
flush privileges;

select user,host from mysql.user;

/* 1. Renombrar de usuario_juan@localhost a usuario_tame@localhost
   2. Cambiar la contraseña a 'NewPassword.123456'
   3. Ver todos los permisos que tengo el usuario root del @localhost
   */

rename user usuario_juan@localhost to usuario_tame@localhost;
alter user 'usuario_tame'@'localhost' identified by 'Newpassword.123456';
show grants for 'root'@'localhost';

grant all 'base de datos' to 'usuario';
revoke 'tipo de privilegio' on 'base de datos' from 'usuario';
show grants for 'usuario';

/* Crear dos usuarios, un usuario maria en el localhost y un usuario juan en el dominio 192.168.1.67, ambos contraseña: password
   a maria le quiero asignar todos los permisos de la base de datos supermercado.
   y que tenga un maximo de consultas por hora de 90
   al usuario juan le voy a otorgar los permisos de seleccionar insertar solamente para la base de datos de sakila
   mostrar los permisos otorgados para cada uno */

create user if not exists maria@localhost identified by 'password';
create user if not exists juan@localhost identified by 'password';
rename user juan@localhost to juan@192.168.1.67;

grant all privileges on dbsupermercado.* to maria@localhost;
alter user 'maria'@'localhost' with  max_queries_per_hour 90;
grant select,insert on sakila.* to juan@192.168.1.67;

show grants for maria@localhost;
show grants for juan@192.168.1.67;

drop user usuario2@192.168.3.56;