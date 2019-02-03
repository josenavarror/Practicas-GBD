--Práctica 28
--[1]

create table usuarios(
  id_u number(20) constraint usuarios_pk primary key,
  usuario varchar2(30) constraint usuarios_uk1 unique
    constraint usuarios_nn1 not null,
  e_mail varchar2(60) constraint usuarios_uk2 unique
    constraint usuarios_nn2 not null,
  nombre varchar2(30) constraint usuarios_nn3 not null,
  apellido1 varchar2(30) constraint usuarios_nn4 not null,
  apellido2 varchar2(30),
  passw varchar2(100) constraint usuarios_nn5 not null
);

create table contactos(
  id_u number(20) constraint contactos_fk1 references usuarios(id_u) on delete cascade,
  contacto number(20) constraint contactos_fk2 references usuarios(id_u),
  constraint contactos_pk primary key (id_u,contacto),
  constraints contactos_ck check(id_u<>contacto)
);

create table post(
  id_u number(20) constraint post_fk1 references usuarios (id_u) on delete cascade
      constraint post_nn2 not null,
  pid number(20) constraint post_pk primary key,
  texto varchar2(1000) constraint post_nn1 not null,
  pid_rel number(20) constraint post_fk2 references post (pid),
  publicacion date constraint post_nn3 not null
    constraint post_ck check(publicacion>to_date('02/02/2017','dd/mm/yyyy')),
  duracion interval day to second constraint post_nn4 not null
);

create table ser_visible(
  id_u number(20),
  contacto number(20),
  pid number(20) constraint ser_visible_fk2 references post (pid) on delete cascade,
  constraint ser_visible_fk1 foreign key (id_u,contacto) references contactos (id_u, contacto),
  constraint ser_visible_pk primary key (id_u, contacto, pid)
);

--[2]
--[2.1]
alter table post modify(
  duracion constraint post_ck3 check(duracion>'30')
  );
--[2.2]
alter table ser_visible rename to compartir;
--[2.3]
alter table usuarios rename constraint
  usuarios_pk to superclave_pk;
--[2.4]
alter table post modify(
  publicacion date default sysdate
  );
--[2.5]
alter table usuarios drop
  constraint usuarios_nn5 cascade;
--[2.6]
alter table post
  add (
    visible char(2) constraint post_ck2 check ( visible ='Sí' or visible ='No' )
    );

--[3]
--[3.1]
INSERT INTO usuarios(id_u,nombre,apellido1,apellido2,usuario,e_mail)
	VALUES(1,'Ramón','García','Ortigal','ramongar','ramon@hotmail.com');
INSERT INTO usuarios(id_u,nombre,apellido1,apellido2,usuario,e_mail)
	VALUES(2,'Lourdes','Atienza','null','lurdita','lurdita@bbc.co.uk');
INSERT INTO usuarios(id_u,nombre,apellido1,apellido2,usuario,e_mail)
	VALUES(3,'Marisol','Jiménez','del Oso','marioso','marioso19@yahoo.com');
INSERT INTO usuarios(id_u,nombre,apellido1,apellido2,usuario,e_mail)
	VALUES(4,'Francisco','Serrano','Calvo','sercal','sercal1980@gmail.com');

select * from usuarios;

--[3.2]
insert into post(pid,texto,publicacion,duracion,id_u,visible)
  values (1,'Hola','6/2/2017','7',2,'No');--revisar





   ( ),
--Por si ...
drop table usuarios cascade constraints;
drop table contactos cascade constraints;
drop table ser_visible cascade constraints;
drop table post cascade constraints;
--

