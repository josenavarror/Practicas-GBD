create table articulos (
  cod_art char(7) constraint articulos_pk primary key,
  nombre  varchar2(40) constraint articulos_nn1 not null,
  marca   varchar(20)  constraint articulos_nn2 not null,
  modelo  varchar2(15) constraint articulos_nn3 not null
);

create table precios(
  fecha_inicio date,
  fecha_fin date,
  cod_art char(7) constraint precios_fk1 references articulos(cod_art) on delete cascade,
  --se eliminan todos los precios relacionados con un artículo
  precio number(7,2) constraint precios_ck1 check(precio>=0),
  --los precios tienen que ser números positivos
  constraint precios_pk primary key (fecha_inicio,cod_art),
  constraint precios_ck2 check(fecha_fin>fecha_inicio)
);

create table secciones (
  id_sec      number(3) constraint secciones_pk primary key,
  id_supersec number(3) constraint secciones_fk1 references secciones (id_sec),
  nombre      varchar2(40) constraint secciones_uk1 unique
    constraint secciones_nn1 not null
);

create table pertenecer(
  cod_art char(7) constraint pertenecer_fk1 references articulos(cod_art),
  id_sec number(3) constraint pertenecer_fk2 references secciones(id_sec),
  constraint pertenecer_pk primary key (cod_art,id_sec)
);

--Modificaciones - punto 2

alter table secciones ....

