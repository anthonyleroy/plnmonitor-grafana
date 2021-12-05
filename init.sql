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
-- Name: plnmonitor; Type: SCHEMA; Schema: -; Owner: plnmonitor
--

CREATE SCHEMA plnmonitor;


ALTER SCHEMA plnmonitor OWNER TO plnmonitor;

--
-- Name: SCHEMA plnmonitor; Type: COMMENT; Schema: -; Owner: plnmonitor
--

COMMENT ON SCHEMA plnmonitor IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = plnmonitor, pg_catalog;

--
-- Name: new_au_insert(); Type: FUNCTION; Schema: plnmonitor; Owner: plnmonitor
--

CREATE FUNCTION new_au_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	 NEW.VERSION=1;
	 NEW.created_at = now();
	 INSERT INTO plnmonitor.au_version 
	 (name,plugin_name,tdb_year,access_type,content_size,recent_poll_agreement,creation_time,version, created_at, box, au_lockss_id, tdb_publisher, volume, disk_usage, last_completed_crawl, last_completed_poll, last_crawl, last_poll, crawl_pool, crawl_proxy, crawl_window, last_crawl_result, last_poll_result, publishing_platform, repository_path, subscription_status, substance_state, available_from_publisher)
	 VALUES
	 (NEW.name,NEW.plugin_name,NEW.tdb_year,NEW.access_type,NEW.content_size,NEW.recent_poll_agreement,NEW.creation_time,NEW.version,NEW.created_at,NEW.box, NEW.au_lockss_id, NEW.tdb_publisher, NEW.volume, NEW.disk_usage, NEW.last_completed_crawl, NEW.last_completed_poll, NEW.last_crawl, NEW.last_poll, NEW.crawl_pool, NEW.crawl_proxy, NEW.crawl_window, NEW.last_crawl_result, NEW.last_poll_result, NEW.publishing_platform, NEW.repository_path, NEW.subscription_status, NEW.substance_state, NEW.available_from_publisher);
	RETURN NEW;
END	$$;


ALTER FUNCTION plnmonitor.new_au_insert() OWNER TO plnmonitor;

--
-- Name: new_au_update_version(); Type: FUNCTION; Schema: plnmonitor; Owner: plnmonitor
--

CREATE FUNCTION new_au_update_version() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	NEW.version=OLD.version+1;
	NEW.updated_at = now();	 
	INSERT INTO plnmonitor.au_version
	 (name,plugin_name,tdb_year,access_type,content_size,recent_poll_agreement,creation_time,version, created_at, updated_at,  box, au_lockss_id, tdb_publisher, volume, disk_usage, last_completed_crawl, last_completed_poll, last_crawl, last_poll, crawl_pool, crawl_proxy, crawl_window, last_crawl_result, last_poll_result, publishing_platform, repository_path, subscription_status, substance_state, available_from_publisher)
	 VALUES
	 (NEW.name,NEW.plugin_name,NEW.tdb_year,NEW.access_type,NEW.content_size,NEW.recent_poll_agreement,NEW.creation_time,NEW.version,NEW.created_at, NEW.updated_at,NEW.box, NEW.au_lockss_id, NEW.tdb_publisher, NEW.volume, NEW.disk_usage, NEW.last_completed_crawl, NEW.last_completed_poll, NEW.last_crawl, NEW.last_poll, NEW.crawl_pool, NEW.crawl_proxy, NEW.crawl_window, NEW.last_crawl_result, NEW.last_poll_result, NEW.publishing_platform, NEW.repository_path, NEW.subscription_status, NEW.substance_state, NEW.available_from_publisher);
	RETURN NEW;
END$$;


ALTER FUNCTION plnmonitor.new_au_update_version() OWNER TO plnmonitor;

--
-- Name: new_box_data_insert(); Type: FUNCTION; Schema: plnmonitor; Owner: plnmonitor
--

CREATE FUNCTION new_box_data_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	 NEW.VERSION=1;
	 NEW.created_at = now();
	 INSERT INTO plnmonitor.lockss_box_data_version
	 (box,used,size,free,percentage,active_aus,version, created_at, repository_space_lockss_id, deleted_aus, inactive_aus, orphaned_aus)
	 VALUES
	 (NEW.box,NEW.used,NEW.size,NEW.free,NEW.percentage,NEW.active_aus,NEW.version,NEW.created_at, NEW.repository_space_lockss_id, NEW.deleted_aus, NEW.inactive_aus, NEW.orphaned_aus);
	RETURN NEW;
END$$;


ALTER FUNCTION plnmonitor.new_box_data_insert() OWNER TO plnmonitor;

--
-- Name: new_box_data_update_version(); Type: FUNCTION; Schema: plnmonitor; Owner: plnmonitor
--

CREATE FUNCTION new_box_data_update_version() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	NEW.version=OLD.version+1;
	NEW.updated_at = now();

	INSERT INTO plnmonitor.lockss_box_data_version
	 (box,used,size,free,percentage,active_aus,version, created_at, updated_at, repository_space_lockss_id, deleted_aus, inactive_aus, orphaned_aus)
	 VALUES
	 (NEW.box,NEW.used,NEW.size,NEW.free,NEW.percentage,NEW.active_aus,NEW.version,NEW.created_at, NEW.updated_at, NEW.repository_space_lockss_id, NEW.deleted_aus, NEW.inactive_aus, NEW.orphaned_aus);
	RETURN NEW;

END
$$;


ALTER FUNCTION plnmonitor.new_box_data_update_version() OWNER TO plnmonitor;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: au_current; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE au_current (
    name text,
    plugin_name text,
    tdb_year text,
    access_type text,
    content_size bigint,
    recent_poll_agreement double precision,
    creation_time bigint,
    version integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    box integer,
    au_lockss_id text,
    tdb_publisher text,
    volume text,
    disk_usage bigint,
    last_completed_crawl bigint,
    last_completed_poll bigint,
    last_crawl bigint,
    last_poll bigint,
    crawl_pool text,
    crawl_proxy text,
    crawl_window text,
    last_crawl_result text,
    last_poll_result text,
    publishing_platform text,
    repository_path text,
    subscription_status text,
    substance_state text,
    available_from_publisher boolean,
    id integer NOT NULL
);


ALTER TABLE au_current OWNER TO plnmonitor;

--
-- Name: AU_current_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "AU_current_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "AU_current_id_seq" OWNER TO plnmonitor;

--
-- Name: AU_current_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "AU_current_id_seq" OWNED BY au_current.id;


--
-- Name: institution; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE institution (
    address text,
    name text,
    id integer NOT NULL,
    shortname text
);


ALTER TABLE institution OWNER TO plnmonitor;

--
-- Name: Institutions_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "Institutions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Institutions_id_seq" OWNER TO plnmonitor;

--
-- Name: Institutions_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "Institutions_id_seq" OWNED BY institution.id;


--
-- Name: lockss_box_data_current; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE lockss_box_data_current (
    box integer NOT NULL,
    used bigint,
    size bigint,
    free bigint,
    percentage double precision,
    active_aus integer,
    version integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    repository_space_lockss_id text,
    deleted_aus integer,
    inactive_aus integer,
    orphaned_aus integer,
    id integer NOT NULL
);


ALTER TABLE lockss_box_data_current OWNER TO plnmonitor;

--
-- Name: LOCKSS_box_data_current_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "LOCKSS_box_data_current_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "LOCKSS_box_data_current_id_seq" OWNER TO plnmonitor;

--
-- Name: LOCKSS_box_data_current_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "LOCKSS_box_data_current_id_seq" OWNED BY lockss_box_data_current.id;


--
-- Name: lockss_box_data_version; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE lockss_box_data_version (
    box integer NOT NULL,
    version integer NOT NULL,
    used bigint,
    size bigint,
    free bigint,
    percentage double precision,
    active_aus integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    repository_space_lockss_id text,
    deleted_aus integer,
    inactive_aus integer,
    orphaned_aus integer,
    id integer NOT NULL,
    data_current integer
);


ALTER TABLE lockss_box_data_version OWNER TO plnmonitor;

--
-- Name: LOCKSS_box_data_version_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "LOCKSS_box_data_version_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "LOCKSS_box_data_version_id_seq" OWNER TO plnmonitor;

--
-- Name: LOCKSS_box_data_version_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "LOCKSS_box_data_version_id_seq" OWNED BY lockss_box_data_version.id;


--
-- Name: lockss_box; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE lockss_box (
    urldss text,
    ipaddress text NOT NULL,
    uiport text NOT NULL,
    pln integer,
    physical_address text,
    v3identity text,
    admin_email text,
    daemon_full_version text,
    java_version text,
    platform text,
    "current_time" bigint,
    uptime bigint,
    groups text,
    disks text,
    id integer NOT NULL
);


ALTER TABLE lockss_box OWNER TO plnmonitor;

--
-- Name: LOCKSS_box_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "LOCKSS_box_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "LOCKSS_box_id_seq" OWNER TO plnmonitor;

--
-- Name: LOCKSS_box_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "LOCKSS_box_id_seq" OWNED BY lockss_box.id;


--
-- Name: lockss_box_info; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE lockss_box_info (
    box integer,
    username text,
    password text,
    longitude double precision,
    latitude double precision,
    country text,
    institution integer,
    organizational_manager integer,
    technical_manager integer,
    physical_address text,
    id integer NOT NULL,
    name text
);


ALTER TABLE lockss_box_info OWNER TO plnmonitor;

--
-- Name: LOCKSS_box_info_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "LOCKSS_box_info_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "LOCKSS_box_info_id_seq" OWNER TO plnmonitor;

--
-- Name: LOCKSS_box_info_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "LOCKSS_box_info_id_seq" OWNED BY lockss_box_info.id;


--
-- Name: peer; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE peer (
    last_poll bigint,
    polls_called bigint,
    last_invitation bigint,
    last_vote bigint,
    box integer,
    peer_lockss_id text,
    last_message bigint,
    invitation_count bigint,
    message_count bigint,
    message_type text,
    polls_rejected bigint,
    votes_cast bigint,
    id integer NOT NULL
);


ALTER TABLE peer OWNER TO plnmonitor;

--
-- Name: Peers_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "Peers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Peers_id_seq" OWNER TO plnmonitor;

--
-- Name: Peers_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "Peers_id_seq" OWNED BY peer.id;


--
-- Name: person; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE person (
    name text,
    first_name text,
    email_address text,
    institution integer,
    id integer NOT NULL,
    phone text
);


ALTER TABLE person OWNER TO plnmonitor;

--
-- Name: Person_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "Person_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Person_id_seq" OWNER TO plnmonitor;

--
-- Name: Person_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "Person_id_seq" OWNED BY person.id;


--
-- Name: au_version; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE au_version (
    version integer NOT NULL,
    name text,
    plugin_name text,
    tdb_year text,
    access_type text,
    content_size bigint,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    box integer,
    recent_poll_agreement double precision,
    creation_time bigint,
    au_lockss_id text,
    tdb_publisher text,
    volume text,
    disk_usage bigint,
    last_completed_crawl bigint,
    last_completed_poll bigint,
    last_crawl bigint,
    last_poll bigint,
    crawl_pool text,
    crawl_proxy text,
    crawl_window text,
    last_crawl_result text,
    last_poll_result text,
    publishing_platform text,
    repository_path text,
    subscription_status text,
    substance_state text,
    available_from_publisher boolean,
    id integer NOT NULL,
    au_current integer
);


ALTER TABLE au_version OWNER TO plnmonitor;

--
-- Name: au_version_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE au_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE au_version_id_seq OWNER TO plnmonitor;

--
-- Name: au_version_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE au_version_id_seq OWNED BY au_version.id;


--
-- Name: pln; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE pln (
    name text,
    config_url text,
    id integer NOT NULL
);


ALTER TABLE pln OWNER TO plnmonitor;

--
-- Name: pln_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE pln_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pln_id_seq OWNER TO plnmonitor;

--
-- Name: pln_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE pln_id_seq OWNED BY pln.id;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO plnmonitor;

--
-- Name: user; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE "user" (
    name text,
    "passwordHash" text,
    role text,
    id integer DEFAULT nextval('user_id_seq'::regclass) NOT NULL
);


ALTER TABLE "user" OWNER TO plnmonitor;

--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY au_current ALTER COLUMN id SET DEFAULT nextval('"AU_current_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY au_version ALTER COLUMN id SET DEFAULT nextval('au_version_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY institution ALTER COLUMN id SET DEFAULT nextval('"Institutions_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box ALTER COLUMN id SET DEFAULT nextval('"LOCKSS_box_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_data_current ALTER COLUMN id SET DEFAULT nextval('"LOCKSS_box_data_current_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_data_version ALTER COLUMN id SET DEFAULT nextval('"LOCKSS_box_data_version_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_info ALTER COLUMN id SET DEFAULT nextval('"LOCKSS_box_info_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY peer ALTER COLUMN id SET DEFAULT nextval('"Peers_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY person ALTER COLUMN id SET DEFAULT nextval('"Person_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY pln ALTER COLUMN id SET DEFAULT nextval('pln_id_seq'::regclass);


--
-- Name: pkey_au_current; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY au_current
    ADD CONSTRAINT pkey_au_current PRIMARY KEY (id);


--
-- Name: pkey_au_version; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY au_version
    ADD CONSTRAINT pkey_au_version PRIMARY KEY (id);


--
-- Name: pkey_id; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT pkey_id PRIMARY KEY (id);


--
-- Name: pkey_institution; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY institution
    ADD CONSTRAINT pkey_institution PRIMARY KEY (id);


--
-- Name: pkey_lockss_box; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY lockss_box
    ADD CONSTRAINT pkey_lockss_box PRIMARY KEY (id);


--
-- Name: pkey_lockss_box_data_current; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY lockss_box_data_current
    ADD CONSTRAINT pkey_lockss_box_data_current PRIMARY KEY (id);


--
-- Name: pkey_lockss_box_data_version; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY lockss_box_data_version
    ADD CONSTRAINT pkey_lockss_box_data_version PRIMARY KEY (id);


--
-- Name: pkey_lockss_box_info; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY lockss_box_info
    ADD CONSTRAINT pkey_lockss_box_info PRIMARY KEY (id);


--
-- Name: pkey_peer; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY peer
    ADD CONSTRAINT pkey_peer PRIMARY KEY (id);


--
-- Name: pkey_person; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT pkey_person PRIMARY KEY (id);


--
-- Name: pkey_pln; Type: CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

ALTER TABLE ONLY pln
    ADD CONSTRAINT pkey_pln PRIMARY KEY (id);


--
-- Name: fki_LOCKSS_box_info_institution_ID_fkey; Type: INDEX; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE INDEX "fki_LOCKSS_box_info_institution_ID_fkey" ON lockss_box_info USING btree (institution);


--
-- Name: fki_LOCKSS_box_info_organizational_manager_ID; Type: INDEX; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE INDEX "fki_LOCKSS_box_info_organizational_manager_ID" ON lockss_box_info USING btree (organizational_manager);


--
-- Name: fki_LOCKSS_box_info_technical_manager_ID_fkey; Type: INDEX; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE INDEX "fki_LOCKSS_box_info_technical_manager_ID_fkey" ON lockss_box_info USING btree (technical_manager);


--
-- Name: new_insert; Type: TRIGGER; Schema: plnmonitor; Owner: plnmonitor
--

CREATE TRIGGER new_insert BEFORE INSERT ON lockss_box_data_current FOR EACH ROW EXECUTE PROCEDURE new_box_data_insert();


--
-- Name: new_insert; Type: TRIGGER; Schema: plnmonitor; Owner: plnmonitor
--

CREATE TRIGGER new_insert BEFORE INSERT ON au_current FOR EACH ROW EXECUTE PROCEDURE new_au_insert();


--
-- Name: new_update; Type: TRIGGER; Schema: plnmonitor; Owner: plnmonitor
--

CREATE TRIGGER new_update BEFORE UPDATE ON au_current FOR EACH ROW EXECUTE PROCEDURE new_au_update_version();


--
-- Name: new_version; Type: TRIGGER; Schema: plnmonitor; Owner: plnmonitor
--

CREATE TRIGGER new_version BEFORE UPDATE ON lockss_box_data_current FOR EACH ROW EXECUTE PROCEDURE new_box_data_update_version();


--
-- Name: fkey_au_current_box_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY au_current
    ADD CONSTRAINT fkey_au_current_box_id FOREIGN KEY (box) REFERENCES lockss_box(id);


--
-- Name: fkey_au_version_au_current_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY au_version
    ADD CONSTRAINT fkey_au_version_au_current_id FOREIGN KEY (au_current) REFERENCES au_current(id);


--
-- Name: fkey_au_version_box_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY au_version
    ADD CONSTRAINT fkey_au_version_box_id FOREIGN KEY (box) REFERENCES lockss_box(id);


--
-- Name: fkey_lockss_box_data_current_box_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_data_current
    ADD CONSTRAINT fkey_lockss_box_data_current_box_id FOREIGN KEY (box) REFERENCES lockss_box(id);


--
-- Name: fkey_lockss_box_data_version_box_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_data_version
    ADD CONSTRAINT fkey_lockss_box_data_version_box_id FOREIGN KEY (box) REFERENCES lockss_box(id);


--
-- Name: fkey_lockss_box_data_version_data_current_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_data_version
    ADD CONSTRAINT fkey_lockss_box_data_version_data_current_id FOREIGN KEY (data_current) REFERENCES lockss_box_data_current(id);


--
-- Name: fkey_lockss_box_info_box_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_info
    ADD CONSTRAINT fkey_lockss_box_info_box_id FOREIGN KEY (box) REFERENCES lockss_box(id);


--
-- Name: fkey_lockss_box_info_institution_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_info
    ADD CONSTRAINT fkey_lockss_box_info_institution_id FOREIGN KEY (institution) REFERENCES institution(id);


--
-- Name: fkey_lockss_box_info_org_man_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_info
    ADD CONSTRAINT fkey_lockss_box_info_org_man_id FOREIGN KEY (organizational_manager) REFERENCES person(id);


--
-- Name: fkey_lockss_box_info_tech_man_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_info
    ADD CONSTRAINT fkey_lockss_box_info_tech_man_id FOREIGN KEY (technical_manager) REFERENCES person(id);


--
-- Name: fkey_lockss_box_pln; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box
    ADD CONSTRAINT fkey_lockss_box_pln FOREIGN KEY (pln) REFERENCES pln(id);


--
-- Name: fkey_peer_lockss_box_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY peer
    ADD CONSTRAINT fkey_peer_lockss_box_id FOREIGN KEY (box) REFERENCES lockss_box(id);


--
-- Name: fkey_person_institution_id; Type: FK CONSTRAINT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY person
    ADD CONSTRAINT fkey_person_institution_id FOREIGN KEY (institution) REFERENCES institution(id);


--
-- Name: plnmonitor; Type: ACL; Schema: -; Owner: plnmonitor
--

REVOKE ALL ON SCHEMA plnmonitor FROM PUBLIC;
REVOKE ALL ON SCHEMA plnmonitor FROM plnmonitor;
GRANT ALL ON SCHEMA plnmonitor TO plnmonitor;
GRANT ALL ON SCHEMA plnmonitor TO PUBLIC;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--



--
-- CREATE USE grafana with readonly access
--
CREATE USER grafana WITH PASSWORD 'grafana';

CREATE ROLE readonly;
GRANT CONNECT ON DATABASE plnmonitor TO readonly;
GRANT USAGE ON SCHEMA plnmonitor TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA plnmonitor TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA plnmonitor GRANT SELECT ON TABLES TO readonly;
GRANT readonly TO grafana;

