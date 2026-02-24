/*
 Base de datos: dbEmpresa
 creación: 10/25
 Autor: Pablo Pérez Martínez
 SQL: DML (Gestión de la información)
 Descripción:   Ejercicios de BD: Registre el empleado, con la siguiente información: José María Pérez Gómez de la mancha, nacido el 24/06/2000 en Oviedo, Asturias.
                Numero móvil es el 600 111 222 y josemaria_gomez@institutotame.com La dirección es Ave Gran vía de Asturias numero 1 CP 33001, Oviedo, Asturias.
                Su Clasificación de empleado es “Ingeniero informático”, está registrado en la empresa como técnico José María trabaja en el proyecto de "Django Web" que comenzó el 01/09/2025 y termina el 30/60/2026
                El objetivo del proyecto es rediseñar la web actual del instituto tame, con las técnicas de programación del lenguaje pyton para aplicaciones web, utilizando el framework Django. El precio inicial es de 4500.00€, y puede ser que el coste varie al final del proyecto

--------------------------------------------------------------------------
                    DML ( Gestión de datos e información )
 ------------------------------------------------------------------------- */

insert into tblvias (via)
values (upper('Avenida')),
        (upper('calle')),
        (upper('glorieta'));
set @idvia = (select idvia
              from tblvias
              where via like 'avenida');
select @idvia;

insert into tblclasificacion (clasificacion)
values  (upper(trim('Ingeniero informatico'))),
        (upper(trim('Técnico de sistemas'))),
        (upper(trim('Desarrollo web')));
set @idclasificacion = (select idclasificacion
                        from tblclasificacion
                        where clasificacion like 'Ingeniero informatico');
select @idclasificacion;

alter table tblproyectos
    add precio_inicial float default 0.0,
    add precio_real    float default 0.0;


insert into tblsexos (sexo)
values (upper(trim('Masculino'))),
       (upper(trim('Femenino')));
set @idsexo = (select idsexo
               from tblsexos
                where sexo like 'masculino');
select @idsexo;

insert into tblprovincias(idprovincia, provincia)
values ('33',upper(trim('Asturias')));
set @idprovincia = (select idprovincia
                    from    tblprovincias
                    where provincia like 'Asturias');
select @idprovincia;

insert into tbllocalidades (idlocalidad, localidad,idprovincia)
values (33001,upper(trim('Oviedo')),@idprovincia);
set @idlocalidad = (select idlocalidad
                    from   tbllocalidades
                    where   localidad like 'Oviedo');
select @idlocalidad;

insert into tblempleados(idclasificacion, dni, nombre, apellido1, apellido2, nacimiento, idsexo, fijo, movil, mail, idvia, direccion, idlocalidad)
values  (@idclasificacion, '29221392F','Jose María','Pérez','Gómez de la mancha',24062000,@idsexo,'987654321','600111222','josemariagomez@institutotame.com',@idvia,'Gran via de asturias 01',@idlocalidad);

set @idempleado = last_insert_id();
select @idempleado;
insert into tbltecnicos (idempleado,titulo)
values  (@idempleado, 'Ingeniero');

insert into tblproyectos(proyecto,finicio, fentrega, caracteristicas, precio_inicial, precio_real)
values  ('Django',01092025,30062026, 'Rediseñar la web actual del instituto tame, con las tecnologias  de programación del lenguaje Python
       para aplicaciones web, utilizando el framework Django', 4500,0);

set @idproyecto=last_insert_id();
select @idproyecto;

insert into tbltecnicosproyectos(idproyecto, idemplempleado)
values  (@idproyecto,@idempleado);
















