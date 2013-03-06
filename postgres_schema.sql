--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.1
-- Dumped by pg_dump version 9.2.0
-- Started on 2013-03-06 14:20:20 CET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2191 (class 1262 OID 484077)
-- Name: lwshackday; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE lwshackday WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'de_DE.UTF-8' LC_CTYPE = 'de_DE.UTF-8';


ALTER DATABASE lwshackday OWNER TO postgres;

\connect lwshackday

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 170 (class 3079 OID 11995)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2194 (class 0 OID 0)
-- Dependencies: 170
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 169 (class 1259 OID 484080)
-- Name: hooks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hooks (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.hooks OWNER TO postgres;

--
-- TOC entry 168 (class 1259 OID 484078)
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hooks_id_seq OWNER TO postgres;

--
-- TOC entry 2195 (class 0 OID 0)
-- Dependencies: 168
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hooks_id_seq OWNED BY hooks.id;


--
-- TOC entry 2183 (class 2604 OID 484083)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hooks ALTER COLUMN id SET DEFAULT nextval('hooks_id_seq'::regclass);


--
-- TOC entry 2186 (class 2606 OID 484089)
-- Name: hooks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- TOC entry 2193 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: md
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM md;
GRANT ALL ON SCHEMA public TO md;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-03-06 14:20:20 CET

--
-- PostgreSQL database dump complete
--

