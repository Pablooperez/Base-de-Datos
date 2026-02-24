/*
 Base Datos: dbEmpresa
 Autor: Pablo Pérez
 Descripción: Gestión de la empresa ( empleado, directivo, técnico, administrativo, proyecto y técnicosProyectos )*/

 /* ---------------------------------------------------------------------------------------
                        DDl ( Creación de la estructura dbAcademia
 -----------------------------------------------------------------------------------------*/
drop database if exists dbEmpresa; -- eliminar la db si existe en el motor de bd
create database dbEmpresa;         -- crear la db dbAcademia

use dbEmpresa;                     -- predetermina la db de trabajo. Hasta que no utilice el comando para asignar otra db

# -------------------- Tablas generales ------------------------


drop table if exists tblProvincias;
create table tblProvincias (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idprovincia  tinyint not null,
    provincia    varchar(300) not null,
    primary key (idprovincia)
);
create index idxProvincias on tblProvincias(provincia);

drop table if exists tblLocalidades;
create table tblLocalidades (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idlocalidad  int not null,
    localidad    varchar(300) not null,
    idprovincia  tinyint not null,
    primary key (idlocalidad),
    foreign key (idprovincia) references tblProvincias(idprovincia)
);
create index idxlocalidades on tblLocalidades (localidad,idprovincia);

drop table if exists tblSexos;
create table tblSexos (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idsexo      tinyint not null auto_increment,
    sexo        varchar(150) not null,
    primary key (idsexo)
);

drop table if exists tblVias;
create table tblVias (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idvia          tinyint not null auto_increment,
    via            varchar(50) not null,
    primary key (idvia)
);

drop table if exists tblClasificacion;
create table tblClasificacion (
    idclasificacion tinyint not null auto_increment,
    clasificacion   varchar(100) not null,
    primary key (idclasificacion)
);

drop table if exists tblEmpleados;
create table tblEmpleados
(
    -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idempleado      tinyint      not null auto_increment,
    idclasificacion tinyint      not null,
    dni             varchar(15)  not null,
    nombre          varchar(150) not null,
    apellido1       varchar(150) not null,
    apellido2       varchar(150) not null,
    nacimiento      int unsigned      not null,
    idsexo          tinyint      not null,
    fijo            int unsigned  not null,
    movil           int unsigned  not null,
    mail            varchar(100) not null,
    idvia           tinyint      not null,
    direccion          varchar(300) not null,
    idlocalidad     int          not null,
    primary key (idempleado),
    foreign key (idclasificacion) references tblClasificacion (idclasificacion),
    foreign key (idsexo) references tblSexos (idsexo),
    foreign key (idvia) references tblVias (idvia),
    foreign key (idlocalidad) references tblLocalidades (idlocalidad)
);

drop table if exists tblDirectivos;
create table tblDirectivos (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    coche        varchar(300) not null,
    idempleado   tinyint not null auto_increment,
    foreign key (idempleado) references tblEmpleados(idempleado)
);

drop table if exists tblTecnicos;
create table tblTecnicos (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    titulo       varchar(300) not null,
    idempleado   tinyint not null auto_increment,
    foreign key  (idempleado) references tblEmpleados(idempleado)
);

drop table if exists tblAdministrativos;
create table tblAdministrativos (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    antiguedad    varchar(50) not null,
    idempleado    tinyint not null auto_increment,
    foreign key   (idempleado) references tblEmpleados(idempleado)
);

drop table if exists tblProyectos;
create table tblProyectos (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idproyecto      tinyint not null auto_increment,
    proyecto        varchar(100) not null,
    finicio         int unsigned not null,
    fentrega        int unsigned not null,
    caracteristicas varchar(500) not null,
    primary key (idproyecto)
);

drop table if exists tblTecnicosProyectos;
create table tblTecnicosProyectos (
 -- Nombre campo    Atributos: Tipo_dato / Obligatoriedad / se genere valor automáticamente
    idproyecto      tinyint not null auto_increment,
    idemplempleado  tinyint not null,
    foreign key (idproyecto) references tblProyectos(idproyecto),
    foreign key (idemplempleado) references tblEmpleados(idempleado)
);

