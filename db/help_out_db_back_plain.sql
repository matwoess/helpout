--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7
-- Dumped by pg_dump version 12.7

-- Started on 2021-06-28 09:38:36

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
-- TOC entry 2856 (class 1262 OID 57354)
-- Name: helpout; Type: DATABASE; Schema: -; Owner: helpout
--

CREATE DATABASE helpout WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'German_Germany.1252' LC_CTYPE = 'German_Germany.1252';


ALTER DATABASE helpout OWNER TO helpout;

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
-- TOC entry 202 (class 1259 OID 57355)
-- Name: chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat (
    chatid integer NOT NULL,
    isread1 boolean,
    username1 character varying NOT NULL,
    username2 character varying NOT NULL,
    isread2 boolean
);


ALTER TABLE public.chat OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 57361)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    zipcode integer NOT NULL,
    name character varying
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 57367)
-- Name: gender; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gender (
    gid integer NOT NULL,
    name character varying(8)
);


ALTER TABLE public.gender OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 57370)
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
-- TOC entry 206 (class 1259 OID 57376)
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
    score integer,
    password character varying NOT NULL,
    isassist boolean
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 2846 (class 0 OID 57355)
-- Dependencies: 202
-- Data for Name: chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.chat (chatid, isread1, username1, username2, isread2) VALUES (0, true, 'joe.hinter', 'my_username', true);
INSERT INTO public.chat (chatid, isread1, username1, username2, isread2) VALUES (2, true, 'eddom', 'my_username', false);
INSERT INTO public.chat (chatid, isread1, username1, username2, isread2) VALUES (3, true, 'my_username', 'm.hauer', true);
INSERT INTO public.chat (chatid, isread1, username1, username2, isread2) VALUES (4, true, 'tanja.gruber', 'my_username', true);
INSERT INTO public.chat (chatid, isread1, username1, username2, isread2) VALUES (5, true, 'my_username', 'tbb', true);
INSERT INTO public.chat (chatid, isread1, username1, username2, isread2) VALUES (6, true, 'usr123', 'my_username', true);
INSERT INTO public.chat (chatid, isread1, username1, username2, isread2) VALUES (7, true, 'my_username', 'augernst', true);
INSERT INTO public.chat (chatid, isread1, username1, username2, isread2) VALUES (444, true, 'my_username', 'briggite.s', true);
INSERT INTO public.chat (chatid, isread1, username1, username2, isread2) VALUES (443, true, 'anna96', 'my_username', false);


--
-- TOC entry 2847 (class 0 OID 57361)
-- Dependencies: 203
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.city (zipcode, name) VALUES (4020, 'Linz');
INSERT INTO public.city (zipcode, name) VALUES (4030, 'Linz');
INSERT INTO public.city (zipcode, name) VALUES (4040, 'Linz');
INSERT INTO public.city (zipcode, name) VALUES (4050, 'Traun');
INSERT INTO public.city (zipcode, name) VALUES (4221, 'Steyregg');
INSERT INTO public.city (zipcode, name) VALUES (4600, 'Wels');
INSERT INTO public.city (zipcode, name) VALUES (4060, 'Leonding');


--
-- TOC entry 2848 (class 0 OID 57367)
-- Dependencies: 204
-- Data for Name: gender; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.gender (gid, name) VALUES (1, 'MALE');
INSERT INTO public.gender (gid, name) VALUES (2, 'FEMALE');
INSERT INTO public.gender (gid, name) VALUES (3, 'OTHER');


--
-- TOC entry 2849 (class 0 OID 57370)
-- Dependencies: 205
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 0, 'my_username', '2021-05-25 10:30:20', 'Hello ${other.name}!');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 1, 'my_username', '2021-05-25 10:30:50', 'I require assistance with something.\nCould you help?');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 2, 'joe.hinter', '2021-05-25 13:30:20', 'Yes, sure! :)');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 3, 'joe.hinter', '2021-05-25 10:31:20', 'What seems to be the problem?');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 4, 'my_username', '2021-05-25 14:30:20', 'I need help with <thing>?\nWhen do you have time?');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 5, 'my_username', '2021-06-12 12:30:45', 'test');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 6, 'my_username', '2021-06-16 11:26:16', 'Hi');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 7, 'my_username', '2021-06-16 11:26:18', '');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (0, 8, 'my_username', '2021-06-16 11:26:30', 'Test');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (444, 0, 'my_username', '2021-06-23 10:18:10', 'hey ');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (444, 1, 'my_username', '2021-06-23 10:18:17', 'hello?');
INSERT INTO public.message (chatid, msgid, username, "timestamp", content) VALUES (444, 2, 'my_username', '2021-06-23 10:18:22', '');


--
-- TOC entry 2850 (class 0 OID 57376)
-- Dependencies: 206
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('anna96', 'Anna', 'Steiner', 6, 'assets/avatars/female4.png', 'Recommend me to your friends!', 2, 4600, 1, 67, 'pw', true);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('augernst', 'Augustine', 'Ernst', 13, 'assets/avatars/female3.png', 'I can help out anytime.', 2, 4030, 1, 45, 'pw', true);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('briggite.s', 'Brigitte', 'Seitenschläger', 5, 'assets/avatars/female1.png', 'I love animals.', 2, 4040, 1, 20, 'pw', false);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('eddom', 'Eduardo', 'Domingo', 7, 'assets/avatars/male2.png', 'Several years of experience as a pet-sitter.', 1, 4600, 1, 33, 'pw', true);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('joe.hinter', 'Johannes', 'Hinterberger', 0, 'assets/avatars/male1.png', 'I am a helpful person.', 1, 4020, 1, 10, 'pw', true);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('m.hauer', 'Manuel', 'Hauer', 15, 'assets/avatars/male3.png', 'I have a lot of free time.', 1, 4600, 1, 44, 'pw', true);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('my_username', 'My', '', 5, 'assets/avatars/female4.png', 'This is my profile! Here I will tell about myself and give you a good impression.\nFor more information please contact me. Here a test message appears in the response.', 2, 4020, 1, 65, 'pw', true);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('tanja.gruber', 'Tanja', 'Gruber', 8, 'assets/avatars/female2.png', 'I am looking for someone to help my grandmother with shopping.', 2, 4221, 1, 44, 'pw', false);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('tbb', 'Thomas', 'Braunberger', 10, 'assets/avatars/male3.png', 'Male, 35 years old, education from FH Hagenberg, like to read, have 3 sisters and 1 brother. More information about me can be found on my website at http://person.me.com', 1, 4050, 1, 66, 'pw', false);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('usr123', 'Ano', 'Nymous', 9, 'assets/images/empty.png', '(no description)', 3, 4221, 1, 12, 'pw', true);
INSERT INTO public."user" (username, firstname, lastname, price, asset, description, gid, zipcode, level, score, password, isassist) VALUES ('nyquist', 'Alexander', 'Gindlhumer', 0, 'assets/avatars/male2.png', '', 1, 4060, 1, 0, 'alex1', true);


--
-- TOC entry 2706 (class 2606 OID 57383)
-- Name: chat chat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (chatid);


--
-- TOC entry 2708 (class 2606 OID 57385)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (zipcode);


--
-- TOC entry 2710 (class 2606 OID 57387)
-- Name: gender gender_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gender
    ADD CONSTRAINT gender_pkey PRIMARY KEY (gid);


--
-- TOC entry 2712 (class 2606 OID 57389)
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (chatid, msgid);


--
-- TOC entry 2714 (class 2606 OID 57391)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (username);


--
-- TOC entry 2717 (class 2606 OID 57392)
-- Name: message chatid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT chatid_fk FOREIGN KEY (chatid) REFERENCES public.chat(chatid) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 2718 (class 2606 OID 57397)
-- Name: user gid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT gid_fk FOREIGN KEY (gid) REFERENCES public.gender(gid) NOT VALID;


--
-- TOC entry 2715 (class 2606 OID 57402)
-- Name: chat username1_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username1_fk FOREIGN KEY (username1) REFERENCES public."user"(username) NOT VALID;


--
-- TOC entry 2716 (class 2606 OID 57407)
-- Name: chat username2_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username2_fk FOREIGN KEY (username2) REFERENCES public."user"(username) NOT VALID;


--
-- TOC entry 2719 (class 2606 OID 57412)
-- Name: user zip_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT zip_fk FOREIGN KEY (zipcode) REFERENCES public.city(zipcode) NOT VALID;


-- Completed on 2021-06-28 09:38:36

--
-- PostgreSQL database dump complete
--

