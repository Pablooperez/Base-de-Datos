/*
 Base Datos: dbAcademia
 Autor: Pablo Pérez
 Descripción: Gestión de la actividad docente ( profesores, cursos, asiganturas y departamentos )

 */

/* ---------------------------------------------------------------------------------------
                        DDl ( Creación de la estructura dbAcademia
 -----------------------------------------------------------------------------------------*/
 drop database if exists dbAcademia; -- eliminar la db si existe en el motor de bd
create database dbAcademia;          -- crear la db dbAcademia

use dbAcademia;                      -- predetermina la db de trabajo. Hasta que no utilice el comando para asignar otra db


# -------------------- Tablas generales ------------------------

drop table if exists tblDepartamentos;
create table tblDepartamentos (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    iddepartamento    tinyint not null auto_increment,
    director          varchar(150) not null,
    suplente          varchar(150) not null,
    descripción       varchar(250) not null,
    area              tinyint not null,
    piso              tinyint not null,
    primary key (iddepartamento)
);

drop table if exists tblProfesor;
create table tblProfesor (
    -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idprofesor tinyint not null auto_increment,
    nombre varchar(150) not null,
    direccion varchar(300) not null,
    telefono varchar(15) not null,
    email varchar(250) not null,
    iddepartamento tinyint not null,
    primary key (idprofesor),
    foreign key (iddepartamento) references tblDepartamentos(iddepartamento)
);

drop table if exists tblAsignaturas;
create table tblAsignaturas (
    -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idasignatura tinyint not null auto_increment,
    nombre varchar(150) not null,
    creditos tinyint not null,
    horas tinyint not null,
    idprofesor tinyint not null,
    primary key (idasignatura),
    foreign key (idprofesor) references tblProfesor(idprofesor)
);

drop table if exists tblCurso;
create table tblCurso (
    -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idcurso tinyint not null,
    nombre varchar(150) not null,
    descripcion varchar(500) not null,
    idprofesor tinyint not null,
    primary key (idcurso),
    foreign key (idprofesor) references tblProfesor(idprofesor)
);