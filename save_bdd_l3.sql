--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: typeclient; Type: TYPE; Schema: public; Owner: vincent
--

CREATE TYPE typeclient AS ENUM (
    'entreprise',
    'particulier'
);


ALTER TYPE public.typeclient OWNER TO vincent;

--
-- Name: typeemploye; Type: TYPE; Schema: public; Owner: vincent
--

CREATE TYPE typeemploye AS ENUM (
    'commercial',
    'mecanicien',
    'responsable'
);


ALTER TYPE public.typeemploye OWNER TO vincent;

--
-- Name: typetravailleur; Type: TYPE; Schema: public; Owner: vincent
--

CREATE TYPE typetravailleur AS ENUM (
    'commercial',
    'mecanicien'
);


ALTER TYPE public.typetravailleur OWNER TO vincent;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Agence; Type: TABLE; Schema: public; Owner: vincent; Tablespace: 
--

CREATE TABLE "Agence" (
    idagence integer NOT NULL,
    nomagence character varying(80) NOT NULL,
    adresseagence character varying(80) NOT NULL
);


ALTER TABLE public."Agence" OWNER TO vincent;

--
-- Name: Agence_idagence_seq; Type: SEQUENCE; Schema: public; Owner: vincent
--

CREATE SEQUENCE "Agence_idagence_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Agence_idagence_seq" OWNER TO vincent;

--
-- Name: Agence_idagence_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vincent
--

ALTER SEQUENCE "Agence_idagence_seq" OWNED BY "Agence".idagence;


--
-- Name: Client; Type: TABLE; Schema: public; Owner: vincent; Tablespace: 
--

CREATE TABLE "Client" (
    idclient integer NOT NULL,
    nomclient character varying(80) NOT NULL,
    adresseclient character varying(80) NOT NULL,
    type typeclient NOT NULL
);


ALTER TABLE public."Client" OWNER TO vincent;

--
-- Name: Client_idclient_seq; Type: SEQUENCE; Schema: public; Owner: vincent
--

CREATE SEQUENCE "Client_idclient_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Client_idclient_seq" OWNER TO vincent;

--
-- Name: Client_idclient_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vincent
--

ALTER SEQUENCE "Client_idclient_seq" OWNED BY "Client".idclient;


--
-- Name: Employe; Type: TABLE; Schema: public; Owner: vincent; Tablespace: 
--

CREATE TABLE "Employe" (
    idemploye integer NOT NULL,
    nomemploye character varying(80) NOT NULL,
    adresseemploye character varying(80) NOT NULL,
    dateembauche date NOT NULL,
    type typeemploye NOT NULL,
    idagence integer NOT NULL
);


ALTER TABLE public."Employe" OWNER TO vincent;

--
-- Name: Employe_idemploye_seq; Type: SEQUENCE; Schema: public; Owner: vincent
--

CREATE SEQUENCE "Employe_idemploye_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Employe_idemploye_seq" OWNER TO vincent;

--
-- Name: Employe_idemploye_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vincent
--

ALTER SEQUENCE "Employe_idemploye_seq" OWNED BY "Employe".idemploye;


--
-- Name: Location; Type: TABLE; Schema: public; Owner: vincent; Tablespace: 
--

CREATE TABLE "Location" (
    idlocation integer NOT NULL,
    immatriculation character varying(8) NOT NULL,
    idclient integer NOT NULL,
    agencelocation integer NOT NULL,
    datelocation date NOT NULL,
    agencerestitution integer,
    daterestitution date,
    kilometrage integer,
    etatfinal boolean,
    tarif money
);


ALTER TABLE public."Location" OWNER TO vincent;

--
-- Name: Location_idlocation_seq; Type: SEQUENCE; Schema: public; Owner: vincent
--

CREATE SEQUENCE "Location_idlocation_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Location_idlocation_seq" OWNER TO vincent;

--
-- Name: Location_idlocation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vincent
--

ALTER SEQUENCE "Location_idlocation_seq" OWNED BY "Location".idlocation;


--
-- Name: Modele; Type: TABLE; Schema: public; Owner: vincent; Tablespace: 
--

CREATE TABLE "Modele" (
    nommodele character varying(20) NOT NULL,
    marque character varying(20) NOT NULL,
    tarifjournee money NOT NULL,
    tarifkilometre money NOT NULL,
    caution money NOT NULL
);


ALTER TABLE public."Modele" OWNER TO vincent;

--
-- Name: RespAgence; Type: TABLE; Schema: public; Owner: vincent; Tablespace: 
--

CREATE TABLE "RespAgence" (
    idemploye integer NOT NULL,
    idagence integer NOT NULL
);


ALTER TABLE public."RespAgence" OWNER TO vincent;

--
-- Name: Utilitaire; Type: TABLE; Schema: public; Owner: vincent; Tablespace: 
--

CREATE TABLE "Utilitaire" (
    nommodele character varying(20) NOT NULL,
    capacite numeric(2,1),
    chargemax integer
);


ALTER TABLE public."Utilitaire" OWNER TO vincent;

--
-- Name: Vehicule; Type: TABLE; Schema: public; Owner: vincent; Tablespace: 
--

CREATE TABLE "Vehicule" (
    immatriculation character varying(8) NOT NULL,
    dateachat date,
    kilometrage integer,
    nommodele character varying(20),
    idagence integer
);


ALTER TABLE public."Vehicule" OWNER TO vincent;

--
-- Name: idagence; Type: DEFAULT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Agence" ALTER COLUMN idagence SET DEFAULT nextval('"Agence_idagence_seq"'::regclass);


--
-- Name: idclient; Type: DEFAULT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Client" ALTER COLUMN idclient SET DEFAULT nextval('"Client_idclient_seq"'::regclass);


--
-- Name: idemploye; Type: DEFAULT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Employe" ALTER COLUMN idemploye SET DEFAULT nextval('"Employe_idemploye_seq"'::regclass);


--
-- Name: idlocation; Type: DEFAULT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Location" ALTER COLUMN idlocation SET DEFAULT nextval('"Location_idlocation_seq"'::regclass);


--
-- Data for Name: Agence; Type: TABLE DATA; Schema: public; Owner: vincent
--

INSERT INTO "Agence" VALUES (1, 'Agence1', '1 rue de l''agence');
INSERT INTO "Agence" VALUES (2, 'Agence2', '2 rue de l''agence');
INSERT INTO "Agence" VALUES (3, 'Agence3', '3 rue de l''agence');


--
-- Name: Agence_idagence_seq; Type: SEQUENCE SET; Schema: public; Owner: vincent
--

SELECT pg_catalog.setval('"Agence_idagence_seq"', 3, true);


--
-- Data for Name: Client; Type: TABLE DATA; Schema: public; Owner: vincent
--

INSERT INTO "Client" VALUES (1, 'Harry', '1 rue des particuliers', 'particulier');
INSERT INTO "Client" VALUES (2, 'Hermione', '2 rue des particuliers', 'particulier');
INSERT INTO "Client" VALUES (3, 'Ron', '3 rue des particuliers', 'particulier');
INSERT INTO "Client" VALUES (4, 'DHL', '1 rue des entreprises', 'entreprise');
INSERT INTO "Client" VALUES (5, 'FedEx', '2 rue des entreprises', 'entreprise');


--
-- Name: Client_idclient_seq; Type: SEQUENCE SET; Schema: public; Owner: vincent
--

SELECT pg_catalog.setval('"Client_idclient_seq"', 5, true);


--
-- Data for Name: Employe; Type: TABLE DATA; Schema: public; Owner: vincent
--

INSERT INTO "Employe" VALUES (1, 'Bob', '1 rue des mecaniciens', '2009-01-01', 'mecanicien', 1);
INSERT INTO "Employe" VALUES (2, 'Robert', '2 rue des mecaniciens', '2009-02-01', 'mecanicien', 1);
INSERT INTO "Employe" VALUES (3, 'Bertrand', '3 rue des mecaniciens', '2009-01-01', 'mecanicien', 1);
INSERT INTO "Employe" VALUES (4, 'Bernard', '1 rue des commerciaux', '2009-01-01', 'commercial', 1);
INSERT INTO "Employe" VALUES (5, 'Martin', '2 rue des commerciaux', '2009-03-01', 'commercial', 1);
INSERT INTO "Employe" VALUES (6, 'Gertrude', '1 rue des responsables', '2009-01-01', 'responsable', 1);
INSERT INTO "Employe" VALUES (7, 'Benoit', '4 rue des mecaniciens', '2010-01-01', 'mecanicien', 2);
INSERT INTO "Employe" VALUES (8, 'Stephane', '5 rue des mecaniciens', '2010-01-01', 'mecanicien', 2);
INSERT INTO "Employe" VALUES (9, 'Jean', '6 rue des mecaniciens', '2010-02-01', 'mecanicien', 2);
INSERT INTO "Employe" VALUES (10, 'Philippe', '3 rue des commerciaux', '2010-01-01', 'commercial', 2);
INSERT INTO "Employe" VALUES (11, 'Samy', '4 rue des commerciaux', '2010-02-01', 'commercial', 2);
INSERT INTO "Employe" VALUES (12, 'Samuel', '2 rue des responsables', '2010-01-01', 'responsable', 2);
INSERT INTO "Employe" VALUES (13, 'Bobby', '7 rue des mecaniciens', '2011-01-01', 'mecanicien', 3);
INSERT INTO "Employe" VALUES (14, 'Patrick', '8 rue des mecaniciens', '2011-01-01', 'mecanicien', 3);
INSERT INTO "Employe" VALUES (15, 'Victor', '9 rue des mecaniciens', '2011-02-01', 'mecanicien', 3);
INSERT INTO "Employe" VALUES (16, 'Stephanie', '5 rue des commerciaux', '2011-01-01', 'commercial', 3);
INSERT INTO "Employe" VALUES (17, 'Coralie', '6 rue des commerciaux', '2011-02-01', 'commercial', 3);
INSERT INTO "Employe" VALUES (18, 'Luc', '3 rue des responsables', '2011-01-01', 'responsable', 3);


--
-- Name: Employe_idemploye_seq; Type: SEQUENCE SET; Schema: public; Owner: vincent
--

SELECT pg_catalog.setval('"Employe_idemploye_seq"', 18, true);


--
-- Data for Name: Location; Type: TABLE DATA; Schema: public; Owner: vincent
--

INSERT INTO "Location" VALUES (1, 'AA111AA', 1, 1, '2010-01-01', 1, '2010-01-15', 650, true, '2 050,00 €');
INSERT INTO "Location" VALUES (2, 'ZZ111ZZ', 1, 2, '2010-01-01', 3, '2010-01-01', 150, true, '520,00 €');
INSERT INTO "Location" VALUES (3, 'AB111AB', 2, 2, '2010-01-01', 2, '2010-01-16', 120, true, '1 560,00 €');
INSERT INTO "Location" VALUES (4, 'AA111AD', 4, 1, '2010-01-01', 1, '2015-06-17', 350, false, '100 400,00 €');
INSERT INTO "Location" VALUES (6, 'ZZ112ZZ', 4, 3, '2015-06-05', 1, '2015-07-16', 654, true, '4 902,00 €');
INSERT INTO "Location" VALUES (5, 'AA111AA', 5, 1, '2010-01-03', 1, '2015-12-30', 19560, true, '148 520,00 €');
INSERT INTO "Location" VALUES (7, 'AA111AB', 5, 2, '2015-04-01', 2, '2015-08-17', 456, true, '7 862,00 €');
INSERT INTO "Location" VALUES (8, 'ZZ113ZZ', 1, 2, '2015-01-01', 1, '2015-11-01', 4567, true, '35 051,00 €');
INSERT INTO "Location" VALUES (9, 'AA111AB', 4, 2, '2015-06-01', NULL, NULL, NULL, NULL, NULL);


--
-- Name: Location_idlocation_seq; Type: SEQUENCE SET; Schema: public; Owner: vincent
--

SELECT pg_catalog.setval('"Location_idlocation_seq"', 9, true);


--
-- Data for Name: Modele; Type: TABLE DATA; Schema: public; Owner: vincent
--

INSERT INTO "Modele" VALUES ('Captur', 'Renault', '50,00 €', '2,50 €', '15 000,00 €');
INSERT INTO "Modele" VALUES ('Kangoo Express', 'Renault', '75,00 €', '3,50 €', '16 000,00 €');
INSERT INTO "Modele" VALUES ('Partner', 'Peugeot', '70,00 €', '3,00 €', '15 000,00 €');


--
-- Data for Name: RespAgence; Type: TABLE DATA; Schema: public; Owner: vincent
--

INSERT INTO "RespAgence" VALUES (6, 1);
INSERT INTO "RespAgence" VALUES (12, 2);
INSERT INTO "RespAgence" VALUES (18, 3);


--
-- Data for Name: Utilitaire; Type: TABLE DATA; Schema: public; Owner: vincent
--

INSERT INTO "Utilitaire" VALUES ('Kangoo Express', 3.0, 800);
INSERT INTO "Utilitaire" VALUES ('Partner', 3.0, 800);


--
-- Data for Name: Vehicule; Type: TABLE DATA; Schema: public; Owner: vincent
--

INSERT INTO "Vehicule" VALUES ('AA111AC', '2011-06-01', 0, 'Captur', 3);
INSERT INTO "Vehicule" VALUES ('AB111AA', '2011-07-01', 0, 'Kangoo Express', 1);
INSERT INTO "Vehicule" VALUES ('AB111AC', '2011-07-01', 0, 'Kangoo Express', 3);
INSERT INTO "Vehicule" VALUES ('ZZ111ZZ', '2011-09-01', 150, 'Partner', 3);
INSERT INTO "Vehicule" VALUES ('AB111AB', '2011-06-01', 120, 'Kangoo Express', 2);
INSERT INTO "Vehicule" VALUES ('AA111AD', '2011-07-01', 350, 'Captur', 1);
INSERT INTO "Vehicule" VALUES ('ZZ112ZZ', '2011-09-01', 654, 'Partner', 1);
INSERT INTO "Vehicule" VALUES ('AA111AA', '2011-06-01', 20210, 'Captur', 1);
INSERT INTO "Vehicule" VALUES ('AA111AB', '2011-06-01', 456, 'Captur', 2);
INSERT INTO "Vehicule" VALUES ('ZZ113ZZ', '2011-09-02', 4567, 'Partner', 1);


--
-- Name: Agence_pkey; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "Agence"
    ADD CONSTRAINT "Agence_pkey" PRIMARY KEY (idagence);


--
-- Name: Client_pkey; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (idclient);


--
-- Name: Employe_pkey; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "Employe"
    ADD CONSTRAINT "Employe_pkey" PRIMARY KEY (idemploye);


--
-- Name: Location_pkey; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY (idlocation);


--
-- Name: Modele_pkey; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "Modele"
    ADD CONSTRAINT "Modele_pkey" PRIMARY KEY (nommodele);


--
-- Name: RespAgence_idagence_key; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "RespAgence"
    ADD CONSTRAINT "RespAgence_idagence_key" UNIQUE (idagence);


--
-- Name: RespAgence_idemploye_key; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "RespAgence"
    ADD CONSTRAINT "RespAgence_idemploye_key" UNIQUE (idemploye);


--
-- Name: RespAgence_pkey; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "RespAgence"
    ADD CONSTRAINT "RespAgence_pkey" PRIMARY KEY (idemploye, idagence);


--
-- Name: Utilitaire_pkey; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "Utilitaire"
    ADD CONSTRAINT "Utilitaire_pkey" PRIMARY KEY (nommodele);


--
-- Name: Vehicule_pkey; Type: CONSTRAINT; Schema: public; Owner: vincent; Tablespace: 
--

ALTER TABLE ONLY "Vehicule"
    ADD CONSTRAINT "Vehicule_pkey" PRIMARY KEY (immatriculation);


--
-- Name: Employe_idagence_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Employe"
    ADD CONSTRAINT "Employe_idagence_fkey" FOREIGN KEY (idagence) REFERENCES "Agence"(idagence);


--
-- Name: Location_agencelocation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Location"
    ADD CONSTRAINT "Location_agencelocation_fkey" FOREIGN KEY (agencelocation) REFERENCES "Agence"(idagence);


--
-- Name: Location_agencerestitution_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Location"
    ADD CONSTRAINT "Location_agencerestitution_fkey" FOREIGN KEY (agencerestitution) REFERENCES "Agence"(idagence);


--
-- Name: Location_idclient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Location"
    ADD CONSTRAINT "Location_idclient_fkey" FOREIGN KEY (idclient) REFERENCES "Client"(idclient);


--
-- Name: Location_immatriculation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Location"
    ADD CONSTRAINT "Location_immatriculation_fkey" FOREIGN KEY (immatriculation) REFERENCES "Vehicule"(immatriculation);


--
-- Name: RespAgence_idagence_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "RespAgence"
    ADD CONSTRAINT "RespAgence_idagence_fkey" FOREIGN KEY (idagence) REFERENCES "Agence"(idagence);


--
-- Name: RespAgence_idemploye_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "RespAgence"
    ADD CONSTRAINT "RespAgence_idemploye_fkey" FOREIGN KEY (idemploye) REFERENCES "Employe"(idemploye);


--
-- Name: Utilitaire_nommodele_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Utilitaire"
    ADD CONSTRAINT "Utilitaire_nommodele_fkey" FOREIGN KEY (nommodele) REFERENCES "Modele"(nommodele);


--
-- Name: Vehicule_idagence_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Vehicule"
    ADD CONSTRAINT "Vehicule_idagence_fkey" FOREIGN KEY (idagence) REFERENCES "Agence"(idagence);


--
-- Name: Vehicule_nommodele_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vincent
--

ALTER TABLE ONLY "Vehicule"
    ADD CONSTRAINT "Vehicule_nommodele_fkey" FOREIGN KEY (nommodele) REFERENCES "Modele"(nommodele);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

