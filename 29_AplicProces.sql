--PRÁCTICA 29: APLICACIONES Y PROYECTOS

--[1]

create table tipos_apli(
  id_tipo number(2) constraint tipos_apli_pk primary key,
  tipo varchar2(25) constraint tipos_apli_uk1 unique
                       constraint tipos_apli_nn1 not null
);

create table aplicaciones(
  n_aplicacion number(4) constraint aplicaciones_pk primary key,
  nombre varchar2(25) constraint aplicaciones_uk1 unique
                         constraint aplicaciones_nn1 not null,
  extension number(11,2),
  id_tipo number(2) constraint aplicacioens_fk1
    references tipos_apli(id_tipo) on delete cascade
                         constraint aplicaciones_nn2 not null
);

create table procesos(
  n_aplicacion number(4) constraint procesos_fk1
                       references aplicaciones(n_aplicacion) on delete cascade,
  id_proceso number(3),
  nombre varchar2(25) constraint procesos_uk1 unique
                     constraint procesos_nn1 not null,
  mem_minima number(5,1) constraint procesos_ck check(mem_minima>0),
  id_proceso_lanz number(3),
  n_aplicacion_lanz number(4),
  constraint procesos_pk primary key(n_aplicacion,id_proceso),
  constraint procesos_fk2 foreign key(n_aplicacion_lanz,id_proceso_lanz)
                     references procesos(n_aplicacion,id_proceso)
                     on delete set null
);

create table maquinas(
  n_maquina number(3) constraint maquinas_pk primary key,
  ip1 number(3) constraint maquinas_nn1 not null,
  ip2 number(3) constraint maquinas_nn2 not null,
  ip3 number(3) constraint maquinas_nn3 not null,
  ip4 number(3) constraint maquinas_nn4 not null,
  nombre varchar2(45) constraint maquinas_uk2 unique
                     constraint maquinas_nn5 not null,
  memoria number(5,1),
  constraint maquinas_uk1 unique(ip1,ip2,ip3,ip4),
  constraint maquinas_ck1 check(
    ip1>=0 and ip1<=255 and
    ip2>=0 and ip2<=255 and
    ip3>=0 and ip3<=255 and
    ip4>=0 and ip4<=255)
);

create table procesos_lanzados(
  n_aplicacion number(4),
  id_proceso number(3),
  fecha_lanz timestamp,
  fecha_termino timestamp,
  bloqueado number(1) constraint procesos_lanzados_ck1
                              check(bloqueado=1 or bloqueado=0),
  n_maquina number(3) constraint procesos_lanzados_fk2
                              references maquinas(n_maquina) on delete cascade
                      constraint procesos_lanzados_nn1 not null,
  constraint procesos_lanzados_pk primary key(n_aplicacion,id_proceso,fecha_lanz),
  constraint procesos_lanzados_fk1 foreign key(n_aplicacion,id_proceso)
                              references procesos(n_aplicacion,id_proceso)
                              on delete cascade
);

--[2]

alter table maquinas add(
  hd number(5,2),
  tipo char(1) constraint maquinas_ck2 check(tipo='S' or tipo='C')
  );

--[3] Añadir datos

insert into maquinas(n_maquina,nombre,ip1,ip2,ip3,ip4,memoria,hd,tipo)
values(1,'ELECTRO',212,34,56,7,512,250,'S');

insert into maquinas(n_maquina,nombre,ip1,ip2,ip3,ip4,memoria,hd,tipo)
values(2,'MAGNUS',212,34,56,27,256,128,'C');

insert into maquinas(n_maquina,nombre,ip1,ip2,ip3,ip4,memoria,hd,tipo)
values(3,'GREGOR',97,23,45,6,1024,512,'S');

--Corrección error enunciado: extension varchar2(10)
alter table aplicaciones modify(
  extension varchar2(10)
  );

-- cont. añadiendo datos
insert into tipos_apli(id_tipo,tipo)
values(1,'Procesador Texto');

insert into aplicaciones(n_aplicacion,nombre,extension,id_tipo)
values(1,'Multiword','muti',1);

insert into procesos(n_aplicacion,id_proceso,nombre,mem_minima,id_proceso_lanz)
values(1,1,'WRD',250,NULL);

insert into procesos(n_aplicacion,id_proceso,nombre,mem_minima,id_proceso_lanz)
values(1,2,'WRHELP',250,1);

insert into procesos_lanzados(n_aplicacion,id_proceso,fecha_lanz,fecha_termino,bloqueado,n_maquina)
values(1,1,to_date('30/5/2016','dd/mm/yyyy'),to_date('1/6/2016','dd/mm/yyyy'),0,3);

insert into procesos_lanzados(n_aplicacion,id_proceso,fecha_lanz,fecha_termino,bloqueado,n_maquina)
values(1,1,to_date('30/5/2016','dd/mm/yyyy'),to_date('1/6/2016','dd/mm/yyyy'),0,1);
--está bien pero da error de restricción única

insert into procesos_lanzados(n_aplicacion,id_proceso,fecha_lanz,fecha_termino,bloqueado,n_maquina)
values(1,1,to_date('31/5/2016','dd/mm/yyyy'),to_date('2/6/2016','dd/mm/yyyy'),1,1);

insert into procesos_lanzados(n_aplicacion,id_proceso,fecha_lanz,fecha_termino,bloqueado,n_maquina)
values(1,1,to_date('1/6/2016','dd/mm/yyyy'),null,0,2);

insert into procesos_lanzados(n_aplicacion,id_proceso,fecha_lanz,fecha_termino,bloqueado,n_maquina)
values(1,2,to_date('30/5/2016','dd/mm/yyyy'),to_date('1/6/2016','dd/mm/yyyy'),0,1);

insert into procesos_lanzados(n_aplicacion,id_proceso,fecha_lanz,fecha_termino,bloqueado,n_maquina)
values(1,2,to_date('31/5/2016','dd/mm/yyyy'),null,1,2);
--...
--[4]
update maquinas
  set ip2=37
  where ip1=212;

--[5]
delete procesos_lanzados
  where fecha_lanz>='1/5/2016' and fecha_lanz<='31/5/2016' and bloqueado=1;


--
commit;

select * from aplicaciones;
select * from maquinas;
select * from procesos;
select * from procesos_lanzados;
