/*
 Base de datos: dbEmpresa
 creación: 10/25
 Autor: Pablo Pérez Martínez
 SQL: DML (Gestión de la información)
 Descripción: Gestión de la actividad de una empresa

--------------------------------------------------------------------------
                    DML ( Gestión de datos e información )
 ------------------------------------------------------------------------- */
 -- Insertar datos de las tablas generales: tblsexos, tblvias.

insert into tblsexos (sexo)
values  (lower('Masculino')),
        ( lower('Femenino'));

insert into tblvias (via)
values  ('Calle'),
        ('Avenida'),
        ('Glorieta'),
        ('Camino');

insert into tblproyectos (finicio, fentrega, caracteristicas)
values (16082025, 20102025, 'Gestión de BBDD');



/* Insertar localidad a provincias (Pasos);
   1. Insertar la provincia y obtener la PK.
   2. Insertar todas las localidades de esta provincia, pasando el PK como valor de FK
      Obtener la FK, a partir de una PK:
      - Si la PK es auto-increment generada: usar la función last_index_id() para obtener el valor de la PK.
 */


insert into tblprovincias (idprovincia, provincia)
values (46, upper('valencia')),
       (33, upper('asturias')),
       (28, upper('madrid')),
       (23, upper('jaen'));
set @idprovincia = (select idprovincia from tblprovincias where provincia like 'ASTURIAS');
select @idprovincia;
insert into tbllocalidades(idlocalidad, localidad, idprovincia)
values  (33001,'Oviedo', @idprovincia);

set @idprovincia = (select idprovincia from tblprovincias where provincia like 'VALENCIA');
select @idprovincia;
insert into tbllocalidades(idlocalidad, localidad, idprovincia)
values   (46020, 'Benimaclet', @idprovincia),
       (46940, 'Manises', @idprovincia),
       (46960, 'Aldaia',@idprovincia);


set @idprovincia = (select idprovincia from tblprovincias where provincia like 'MADRID');
select @idprovincia;
insert into tbllocalidades(idlocalidad, localidad, idprovincia)
values (28001, 'Madrid Centro', @idprovincia);