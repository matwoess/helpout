--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7
-- Dumped by pg_dump version 12.7

-- Started on 2021-06-16 13:07:32

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE helpout;
--
-- TOC entry 2859 (class 1262 OID 32777)
-- Name: helpout; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE helpout WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'German_Germany.1252' LC_CTYPE = 'German_Germany.1252';


ALTER DATABASE helpout OWNER TO postgres;

\connect helpout

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 205 (class 1259 OID 32807)
-- Name: chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat (
    chatid integer NOT NULL,
    isread boolean,
    username1 character varying NOT NULL,
    username2 character varying NOT NULL
);


ALTER TABLE public.chat OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 40969)
-- Name: chat_chatid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.chat ALTER COLUMN chatid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.chat_chatid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 203 (class 1259 OID 32791)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    zipcode integer NOT NULL,
    name character varying
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 32786)
-- Name: gender; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gender (
    gid integer NOT NULL,
    name character varying(8)
);


ALTER TABLE public.gender OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 32815)
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    chatid integer NOT NULL,
    msgid integer NOT NULL,
    username character varying NOT NULL,
    "timestamp" timestamp without time zone,
    content character varying
);


ALTER TABLE public.message OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 32799)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    username character varying NOT NULL,
    firstname character varying NOT NULL,
    lastname character varying NOT NULL,
    price real,
    asset character varying,
    description character varying,
    gid integer,
    zipcode integer,
    level integer,
    score integer
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 2851 (class 0 OID 32807)
-- Dependencies: 205
-- Data for Name: chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.chat (chatid, isread, username1, username2) OVERRIDING SYSTEM VALUE VALUES (0, false, 'joe.hinter', 'my_username');
INSERT INTO public.chat (chatid, isread, username1, username2) OVERRIDING SYSTEM VALUE VALUES (1, true, 'my_username', 'briggite.s');
INSERT INTO public.chat (chatid, isread, username1, username2) OVERRIDING SYSTEM VALUE VALUES (2, true, 'eddom', 'my_username');
INSERT INTO public.chat (chatid, isread, username1, username2) OVERRIDING SYSTEM VALUE VALUES (3, false, 'my_username', 'm.hauer');
INSERT INTO public.chat (chatid, isread, username1, username2) OVERRIDING SYSTEM VALUE VALUES (4, true, 'tanja.gruber', 'my_username');
INSERT INTO public.chat (chatid, isread, username1, username2) OVERRIDING SYSTEM VALUE VALUES (5, true, 'my_username', 'tbb');
INSERT INTO public.chat (chatid, isread, username1, username2) OVERRIDING SYSTEM VALUE VALUES (6, true, 'usr123', 'my_username');
INSERT INTO public.chat (chatid, isread, username1, username2) OVERRIDING SYSTEM VALUE VALUES (7, true, 'my_username', 'augernst');
INSERT INTO public.chat (chatid, isread, username1, username2) OVERRIDING SYSTEM VALUE VALUES (443, true, 'anna96', 'my_username');


--
-- TOC entry 2849 (class 0 OID 32791)
-- Dependencies: 203
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.city (zipcode, name) VALUES (4020, 'Linz');
INSERT INTO public.city (zipcode, name) VALUES (4030, 'Linz');
INSERT INTO public.city (zipcode, name) VALUES (4040, 'Linz');
INSERT INTO public.city (zipcode, name) VALUES (4050, 'Traun');
INSERT INTO public.city (zipcode, name) VALUES (4221, 'Steyregg');
INSERT INTO public.city (zipcode, name) VALUES (4600, 'Wels');


--
-- TOC entry 2848 (class 0 OID 32786)
-- Dependencies: 202
-- Data for Name: gender; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.gender (gid, name) VALUES (1, 'MALE');
INSERT INTO public.gender (gid, name) VALUES (2, 'FEMALE');
INSERT INTO public.gender (gid, name) VALUES (3, 'OTHER');


--
-- TOC entry 2852 (class 0 OID 32815)
-- Dependencies: 206
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 0, 'my_username', '2021-05-25 10:30:20', 'Hello ${other.name}!');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 1, 'my_username', '2021-05-25 10:30:50', 'I require assistance with something.\nCould you help?');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 2, 'joe.hinter', '2021-05-25 13:30:20', 'Yes, sure! :)');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 3, 'joe.hinter', '2021-05-25 10:31:20', 'What seems to be the problem?');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 4, 'my_username', '2021-05-25 14:30:20', 'I need help with <thing>?\nWhen do you have time?');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 5, 'my_username', '2021-06-12 12:30:45', 'test');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (1, 0, 'my_username', '2021-06-12 12:48:11', 'test');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (1, 1, 'my_username', '2021-06-12 12:48:21', 'hoi');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (1, 2, 'my_username', '2021-06-12 12:48:41', 'Boom!');


--
-- TOC entry 2850 (class 0 OID 32799)
-- Dependencies: 204
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('joe.hinter', 'Johannes', 'Hinterberger', 0, 'assets/avatars/male1.png', 'I am a helpful person.', 1, 4020, 1, 10);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('briggite.s', 'Brigitte', 'Seitenschläger', 5, 'assets/avatars/female1.png', 'I love animals.', 2, 4040, 1, 20);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('eddom', 'Eduardo', 'Domingo', 7, 'assets/avatars/male2.png', 'Several years of experience as a pet-sitter.', 1, 4600, 1, 33);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('m.hauer', 'Manuel', 'Hauer', 15, 'assets/avatars/male3.png', 'I have a lot of free time.', 1, 4600, 1, 44);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('tanja.gruber', 'Tanja', 'Gruber', 8, 'assets/avatars/female2.png', 'I love animals.', 2, 4221, 1, 44);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('tbb', 'Thomas', 'Braunberger', 10, 'assets/avatars/male3.png', 'Male, 35 years old, education from FH Hagenberg, like to read, have 3 sisters and 1 brother. More information about me can be found on my website at http://person.me.com', 1, 4050, 1, 66);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('usr123', 'Ano', 'Nymous', 9, 'assets/images/empty.png', '(no description)', 3, 4221, 1, 12);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('augernst', 'Augustine', 'Ernst', 13, 'assets/avatars/female3.png', 'I can help out anytime.', 2, 4030, 1, 45);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('anna96', 'Anna', 'Steiner', 6, 'assets/avatars/female4.png', 'Recommend me to your friends!', 2, 4600, 1, 67);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES ('my_username', 'My', 'test', 5, 'assets/avatars/female4.png', 'This is my profile! Here I will tell about myself and give you a good impression.\nFor more information please contact me. Here a test message appears in the response.', 2, 4020, 1, 65);


--
-- TOC entry 2860 (class 0 OID 0)
-- Dependencies: 207
-- Name: chat_chatid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_chatid_seq', 1, false);


--
-- TOC entry 2714 (class 2606 OID 32814)
-- Name: chat chat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (chatid);


--
-- TOC entry 2710 (class 2606 OID 32798)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (zipcode);


--
-- TOC entry 2708 (class 2606 OID 32790)
-- Name: gender gender_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gender
    ADD CONSTRAINT gender_pkey PRIMARY KEY (gid);


--
-- TOC entry 2716 (class 2606 OID 49174)
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (chatid, msgid);


--
-- TOC entry 2712 (class 2606 OID 32806)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (username);


--
-- TOC entry 2721 (class 2606 OID 32853)
-- Name: message chatid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT chatid_fk FOREIGN KEY (chatid) REFERENCES public.chat(chatid) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 2717 (class 2606 OID 32828)
-- Name: user gid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT gid_fk FOREIGN KEY (gid) REFERENCES public.gender(gid) NOT VALID;


--
-- TOC entry 2719 (class 2606 OID 32838)
-- Name: chat username1_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username1_fk FOREIGN KEY (username1) REFERENCES public."user"(username) NOT VALID;


--
-- TOC entry 2720 (class 2606 OID 32843)
-- Name: chat username2_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username2_fk FOREIGN KEY (username2) REFERENCES public."user"(username) NOT VALID;


--
-- TOC entry 2718 (class 2606 OID 32833)
-- Name: user zip_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT zip_fk FOREIGN KEY (zipcode) REFERENCES public.city(zipcode) NOT VALID;


-- Completed on 2021-06-16 13:07:32

--
-- PostgreSQL database dump complete
--
