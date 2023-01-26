-- on ne peut pas garantir que quelqu'un ne prete pas plusieurs fois son jeu a ses amis

DROP TABLE IF EXISTS jeu CASCADE;
DROP TABLE IF EXISTS entreprise CASCADE;
DROP TABLE IF EXISTS genre CASCADE;
DROP TABLE IF EXISTS succes CASCADE;
DROP TABLE IF EXISTS joueur CASCADE;
DROP TABLE IF EXISTS obtenir CASCADE;
DROP TABLE IF EXISTS posseder CASCADE;
DROP TABLE IF EXISTS preter CASCADE;
DROP TABLE IF EXISTS appartenir CASCADE;

create table entreprise(
   id int primary key,
   nom varchar(50) not null,
   pays varchar(50) not null
);

create table jeu(
    titre varchar(50),
    prix float not null,
    date_sortie date not null,
    age int default 3,
    description varchar(1000) not null,
    nb_vente int default 0,
    id_edit int not null,
    id_dev int not null,
    primary key(titre),
    foreign key(id_edit) references entreprise(id),
    foreign key(id_dev) references entreprise(id)
);

create table genre(
    nom varchar(50) primary key
);

create table succes(
    code int primary key,
    intitule varchar(50) not null,
    description varchar(1000),
    titre varchar(50) not null,
    foreign key(titre) references jeu(titre)
);

create table joueur(
    pseudo varchar(50) primary key,
    mdp varchar(50) not null,
    nom varchar(50),
    prenom varchar(50),
    mail varchar(50) unique not null,
    date_naissance date not null,
    portefeuille float default 0
);

create table obtenir(
    code int not null,
    pseudo varchar(50) not null,
    date_obt date default now(),
    primary key(code,pseudo),
    foreign key(code) references succes(code),
    foreign key(pseudo) references joueur(pseudo)
);

create table posseder(
    titre varchar(50) not null,
    pseudo varchar(50) not null,
    date_achat date default now(),
    note int,
    commentaire varchar(1000),
    primary key(titre,pseudo),
    foreign key(titre) references jeu(titre),
    foreign key(pseudo) references joueur(pseudo)
);

create table preter(
    donneur varchar(50) not null,
    receveur varchar(50) not null,
    titre varchar(50) not null,
    primary key(donneur,receveur,titre),
    foreign key(donneur) references joueur(pseudo),
    foreign key(receveur) references joueur(pseudo),
    foreign key(titre) references jeu(titre)
);

create table appartenir(
    nom varchar(50) not null,
    titre varchar(50) not null,
    primary key(nom,titre),
    foreign key(nom) references genre(nom),
    foreign key(titre) references jeu(titre)
);

-- INSERTION DES DONNEES

INSERT INTO entreprise (id, nom, pays) VALUES (1, 'Sony Interactive Entertainment', 'Etats-Unis');
INSERT INTO entreprise (id, nom, pays) VALUES (2, 'Naughty Dog', 'Etats-Unis');
INSERT INTO entreprise (id, nom, pays) VALUES (3, 'Rockstar Games', 'Etats-Unis');
INSERT INTO entreprise (id, nom, pays) VALUES (4, 'Rockstar North', 'Ecosse');

INSERT INTO jeu (titre, prix, date_sortie, description, id_edit, id_dev) VALUES ('The Last of Us Part II', 59.99, '2020-06-19', 'The Last of Us Part II raconte l''histoire de Ellie qui se lance dans une quête de vengeance à travers l''Amérique dévastée par les cordyceps.', 1, 2);
INSERT INTO jeu (titre, prix, date_sortie, description, id_edit, id_dev) VALUES ('Red Dead Redemption 2', 59.99, '2018-10-26', 'Red Dead Redemption 2 est un jeu d''aventure à la troisième personne situé dans l''Ouest américain, mettant en vedette Arthur Morgan, un membre de la bande de Dutch van der Linde.', 3, 4);

INSERT INTO genre (nom) VALUES ('Action-Aventure');
INSERT INTO genre (nom) VALUES ('Jeux de rôle');

INSERT INTO succes (code, intitule, titre) VALUES (1, 'Survivant', 'The Last of Us Part II');
INSERT INTO succes (code, intitule, titre) VALUES (2, 'Meneur de bande', 'Red Dead Redemption 2');

INSERT INTO joueur (pseudo, mdp, nom, prenom, mail, date_naissance) VALUES ('JohnDoe', 'password', 'John', 'Doe', 'johndoe@gmail.com', '1990-01-01');
INSERT INTO joueur (pseudo, mdp, nom, prenom, mail, date_naissance) VALUES ('JaneSmith', 'password', 'Jane', 'Smith', 'janesmith@gmail.com', '1995-01-01');

INSERT INTO obtenir (code, pseudo) VALUES (1, 'JohnDoe');
INSERT INTO obtenir (code, pseudo) VALUES (2, 'JaneSmith');

INSERT INTO posseder (titre, pseudo) VALUES ('The Last of Us Part II', 'JohnDoe');
INSERT INTO posseder (titre, pseudo) VALUES ('Red Dead Redemption 2', 'JaneSmith');

INSERT INTO preter (donneur, receveur, titre) VALUES ('JohnDoe', 'JaneSmith', 'The Last of Us Part II');

INSERT INTO appartenir (nom, titre) VALUES ('Action-Aventure', 'The Last of Us Part II');
INSERT INTO appartenir (nom, titre) VALUES ('Jeux de rôle', 'Red Dead Redemption 2');