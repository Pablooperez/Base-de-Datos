create table tblespecializaciontipo
(
    idespecializacion tinyint      not null
        primary key,
    especializacion   varchar(100) not null,
    descripcion       varchar(300) not null
)
    engine = InnoDB;

create table tblidiomastipo
(
    ididioma tinyint      not null
        primary key,
    idioma   varchar(300) null
)
    engine = InnoDB;

create table tblpagostipo
(
    idtipopago tinyint auto_increment
        primary key,
    modalidad  varchar(200) not null
)
    engine = InnoDB;

create table tblprovincias
(
    idprovincia int          not null
        primary key,
    provincia   varchar(300) not null
)
    engine = InnoDB;

create table tbllocalidades
(
    idlocalidad int          not null
        primary key,
    localidad   varchar(300) not null,
    idprovincia int          not null,
    constraint tbllocalidades_ibfk_1
        foreign key (idprovincia) references tblprovincias (idprovincia)
)
    engine = InnoDB;

create index idprovincia
    on tbllocalidades (idprovincia);

create table tblrutinas
(
    idrutina    tinyint auto_increment
        primary key,
    rutina      varchar(1000) not null,
    descripcion varchar(3000) not null
)
    engine = InnoDB;

create table tblserviciostipo
(
    idservicio  tinyint auto_increment
        primary key,
    servicios   varchar(300)  not null,
    descripcion varchar(1000) not null
)
    engine = InnoDB;

create table tblsesiones
(
    idsesiones  tinyint auto_increment
        primary key,
    sesiones    varchar(300)  not null,
    descripcion varchar(3000) not null
)
    engine = InnoDB;

create table tblsexos
(
    idsexo tinyint auto_increment
        primary key,
    sexo   varchar(150) not null
)
    engine = InnoDB;

create table tbltipodocumento
(
    idtipodoc tinyint auto_increment
        primary key,
    documento varchar(100) not null
)
    engine = InnoDB;

create table tbltiposempleados
(
    idtipo tinyint auto_increment
        primary key,
    tipo   varchar(25) not null
)
    engine = InnoDB;

create table tbltitulostipo
(
    idtitulo    tinyint       not null
        primary key,
    titulo      varchar(300)  not null,
    descripcion varchar(1000) not null
)
    engine = InnoDB;

create table tblubicaciontipo
(
    idubicacion tinyint auto_increment
        primary key,
    ubicacion   varchar(150) not null
)
    engine = InnoDB;

create table tblvias
(
    idvia tinyint auto_increment
        primary key,
    via   varchar(50) not null
)
    engine = InnoDB;

create table tblclientes
(
    idcliente   tinyint auto_increment
        primary key,
    idtipodoc   tinyint      not null,
    numero      varchar(15)  not null,
    nombre      varchar(150) not null,
    apellido1   varchar(150) not null,
    apellido2   varchar(150) not null,
    edad        tinyint      not null,
    idsexo      tinyint      not null,
    telefono    varchar(15)  not null,
    email       varchar(300) not null,
    idvia       tinyint      not null,
    calle       varchar(300) not null,
    cp          tinyint      not null,
    idlocalidad int          not null,
    constraint tblclientes_ibfk_1
        foreign key (idtipodoc) references tbltipodocumento (idtipodoc),
    constraint tblclientes_ibfk_2
        foreign key (idsexo) references tblsexos (idsexo),
    constraint tblclientes_ibfk_3
        foreign key (idvia) references tblvias (idvia),
    constraint tblclientes_ibfk_4
        foreign key (idlocalidad) references tbllocalidades (idlocalidad)
)
    engine = InnoDB;

create index idlocalidad
    on tblclientes (idlocalidad);

create index idsexo
    on tblclientes (idsexo);

create index idtipodoc
    on tblclientes (idtipodoc);

create index idvia
    on tblclientes (idvia);

create table tblempleados
(
    idempleado        tinyint auto_increment
        primary key,
    idtipodoc         tinyint      not null,
    numero            varchar(20)  not null,
    nombre            varchar(150) not null,
    apellido1         varchar(150) not null,
    apellido2         varchar(150) not null,
    edad              tinyint      not null,
    idsexo            tinyint      not null,
    telefono          varchar(15)  not null,
    email             varchar(300) not null,
    idvia             tinyint      not null,
    calle             varchar(300) not null,
    cp                int          not null,
    idlocalidad       int          not null,
    idtipo            tinyint      not null,
    idtitulo          tinyint      not null,
    ididioma          tinyint      not null,
    idespecializacion tinyint      not null,
    constraint tblempleados_ibfk_1
        foreign key (idtitulo) references tbltitulostipo (idtitulo),
    constraint tblempleados_ibfk_2
        foreign key (ididioma) references tblidiomastipo (ididioma),
    constraint tblempleados_ibfk_3
        foreign key (idespecializacion) references tblespecializaciontipo (idespecializacion),
    constraint tblempleados_ibfk_4
        foreign key (idtipodoc) references tbltipodocumento (idtipodoc),
    constraint tblempleados_ibfk_5
        foreign key (idsexo) references tblsexos (idsexo),
    constraint tblempleados_ibfk_6
        foreign key (idvia) references tblvias (idvia),
    constraint tblempleados_ibfk_7
        foreign key (idlocalidad) references tbllocalidades (idlocalidad),
    constraint tblempleados_ibfk_8
        foreign key (idtipo) references tbltiposempleados (idtipo)
)
    engine = InnoDB;

create index idespecializacion
    on tblempleados (idespecializacion);

create index ididioma
    on tblempleados (ididioma);

create index idlocalidad
    on tblempleados (idlocalidad);

create index idsexo
    on tblempleados (idsexo);

create index idtipo
    on tblempleados (idtipo);

create index idtipodoc
    on tblempleados (idtipodoc);

create index idtitulo
    on tblempleados (idtitulo);

create index idvia
    on tblempleados (idvia);

create table tblformacion
(
    idempleado        tinyint not null,
    idtitulo          tinyint not null,
    ididioma          tinyint not null,
    idespecializacion tinyint not null,
    constraint tblformacion_ibfk_1
        foreign key (idempleado) references tblempleados (idempleado),
    constraint tblformacion_ibfk_2
        foreign key (idtitulo) references tbltitulostipo (idtitulo),
    constraint tblformacion_ibfk_3
        foreign key (ididioma) references tblidiomastipo (ididioma),
    constraint tblformacion_ibfk_4
        foreign key (idespecializacion) references tblespecializaciontipo (idespecializacion)
)
    engine = InnoDB;

create index idempleado
    on tblformacion (idempleado);

create index idespecializacion
    on tblformacion (idespecializacion);

create index ididioma
    on tblformacion (ididioma);

create index idtitulo
    on tblformacion (idtitulo);

create table tblpagos
(
    idtransaccion tinyint auto_increment
        primary key,
    idcliente     tinyint not null,
    idtipopago    tinyint not null,
    fecha         int     not null,
    cantidad      int     not null,
    otros         int     not null,
    constraint tblpagos_ibfk_1
        foreign key (idcliente) references tblclientes (idcliente),
    constraint tblpagos_ibfk_2
        foreign key (idtipopago) references tblpagostipo (idtipopago)
)
    engine = InnoDB;

create index idcliente
    on tblpagos (idcliente);

create index idtipopago
    on tblpagos (idtipopago);

