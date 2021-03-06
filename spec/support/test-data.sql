--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.location DROP CONSTRAINT location_user_id_fkey;
ALTER TABLE ONLY public.location_sharing DROP CONSTRAINT location_sharing_shared_to_id_fkey;
ALTER TABLE ONLY public.location_sharing DROP CONSTRAINT location_sharing_shared_by_id_fkey;
ALTER TABLE ONLY public.itinerary_waypoint DROP CONSTRAINT itinerary_waypoint_itinerary_id_fkey;
ALTER TABLE ONLY public.itinerary DROP CONSTRAINT itinerary_user_id_fkey;
ALTER TABLE ONLY public.itinerary_track_segment DROP CONSTRAINT itinerary_track_segment_itinerary_track_id_fkey;
ALTER TABLE ONLY public.itinerary_track_point DROP CONSTRAINT itinerary_track_point_itinerary_track_segment_id_fkey;
ALTER TABLE ONLY public.itinerary_track DROP CONSTRAINT itinerary_track_itinerary_id_fkey;
ALTER TABLE ONLY public.itinerary_sharing DROP CONSTRAINT itinerary_sharing_shared_to_id_fkey;
ALTER TABLE ONLY public.itinerary_sharing DROP CONSTRAINT itinerary_sharing_itinerary_id_fkey;
ALTER TABLE ONLY public.itinerary_route_point DROP CONSTRAINT itinerary_route_point_itinerary_route_id_fkey;
ALTER TABLE ONLY public.itinerary_route DROP CONSTRAINT itinerary_route_itinerary_id_fkey;
DROP INDEX public.idx_time_inverse;
ALTER TABLE ONLY public.waypoint_symbol DROP CONSTRAINT waypoint_symbol_value_key;
ALTER TABLE ONLY public.waypoint_symbol DROP CONSTRAINT waypoint_symbol_pkey;
ALTER TABLE ONLY public.usertable DROP CONSTRAINT usertable_uuid_key;
ALTER TABLE ONLY public.usertable DROP CONSTRAINT usertable_pkey;
ALTER TABLE ONLY public.usertable DROP CONSTRAINT usertable_nickname_key;
ALTER TABLE ONLY public.usertable DROP CONSTRAINT usertable_email_key;
ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_pkey;
ALTER TABLE ONLY public.path_color DROP CONSTRAINT track_color_value_key;
ALTER TABLE ONLY public.path_color DROP CONSTRAINT track_color_pkey;
ALTER TABLE ONLY public.tile DROP CONSTRAINT tile_pkey;
ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
ALTER TABLE ONLY public.role DROP CONSTRAINT role_name_key;
ALTER TABLE ONLY public.location_sharing DROP CONSTRAINT location_sharing_pkey;
ALTER TABLE ONLY public.location DROP CONSTRAINT location_pkey;
ALTER TABLE ONLY public.itinerary_waypoint DROP CONSTRAINT itinerary_waypoint_pkey;
ALTER TABLE ONLY public.itinerary_track_segment DROP CONSTRAINT itinerary_track_segment_pkey;
ALTER TABLE ONLY public.itinerary_track_point DROP CONSTRAINT itinerary_track_point_pkey;
ALTER TABLE ONLY public.itinerary_track DROP CONSTRAINT itinerary_track_pkey;
ALTER TABLE ONLY public.itinerary_sharing DROP CONSTRAINT itinerary_sharing_pkey;
ALTER TABLE ONLY public.itinerary_route_point DROP CONSTRAINT itinerary_route_point_pkey;
ALTER TABLE ONLY public.itinerary_route DROP CONSTRAINT itinerary_route_pkey;
ALTER TABLE ONLY public.itinerary DROP CONSTRAINT itinerary_pkey;
ALTER TABLE ONLY public.georef_format DROP CONSTRAINT georef_format_value_key;
ALTER TABLE ONLY public.georef_format DROP CONSTRAINT georef_format_pkey;
ALTER TABLE public.role ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.itinerary_waypoint ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.itinerary_track_segment ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.itinerary_track_point ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.itinerary_track ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.itinerary_route_point ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.itinerary_route ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.itinerary ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.waypoint_symbol;
DROP TABLE public.usertable;
DROP SEQUENCE public.usertable_seq;
DROP TABLE public.user_role;
DROP TABLE public.tile_metric;
DROP SEQUENCE public.tile_download_seq;
DROP TABLE public.tile;
DROP SEQUENCE public.role_seq;
DROP TABLE public.role;
DROP TABLE public.path_color;
DROP TABLE public.location_sharing;
DROP TABLE public.location;
DROP SEQUENCE public.location_seq;
DROP SEQUENCE public.itinerary_waypoint_seq;
DROP TABLE public.itinerary_waypoint;
DROP SEQUENCE public.itinerary_track_seq;
DROP SEQUENCE public.itinerary_track_segment_seq;
DROP TABLE public.itinerary_track_segment;
DROP SEQUENCE public.itinerary_track_point_seq;
DROP TABLE public.itinerary_track_point;
DROP TABLE public.itinerary_track;
DROP TABLE public.itinerary_sharing;
DROP SEQUENCE public.itinerary_seq;
DROP SEQUENCE public.itinerary_route_seq;
DROP SEQUENCE public.itinerary_route_point_seq;
DROP TABLE public.itinerary_route_point;
DROP TABLE public.itinerary_route;
DROP TABLE public.itinerary;
DROP TABLE public.georef_format;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: georef_format; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE georef_format (
    key text NOT NULL,
    value text NOT NULL,
    ord integer NOT NULL
);


--
-- Name: itinerary; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE itinerary (
    id integer NOT NULL,
    title text NOT NULL,
    description text,
    user_id integer NOT NULL,
    archived boolean DEFAULT false,
    start timestamp with time zone,
    finish timestamp with time zone
);


--
-- Name: itinerary_route; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE itinerary_route (
    id integer NOT NULL,
    itinerary_id integer NOT NULL,
    name text,
    distance numeric(12,2),
    ascent numeric(9,1),
    descent numeric(9,1),
    lowest numeric(8,1),
    highest numeric(8,1),
    color text
);


--
-- Name: itinerary_route_point; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE itinerary_route_point (
    id integer NOT NULL,
    itinerary_route_id integer NOT NULL,
    "position" point NOT NULL,
    name text,
    comment text,
    description text,
    symbol text,
    altitude numeric(11,5)
);


--
-- Name: itinerary_route_point_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE itinerary_route_point_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: itinerary_route_point_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE itinerary_route_point_seq OWNED BY itinerary_route_point.id;


--
-- Name: itinerary_route_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE itinerary_route_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: itinerary_route_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE itinerary_route_seq OWNED BY itinerary_route.id;


--
-- Name: itinerary_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE itinerary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: itinerary_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE itinerary_seq OWNED BY itinerary.id;


--
-- Name: itinerary_sharing; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE itinerary_sharing (
    itinerary_id integer NOT NULL,
    shared_to_id integer NOT NULL,
    active boolean
);


--
-- Name: itinerary_track; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE itinerary_track (
    id integer NOT NULL,
    itinerary_id integer NOT NULL,
    name text,
    color text,
    distance numeric(12,2),
    ascent numeric(9,1),
    descent numeric(9,1),
    lowest numeric(8,1),
    highest numeric(8,1)
);


--
-- Name: itinerary_track_point; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE itinerary_track_point (
    id integer NOT NULL,
    itinerary_track_segment_id integer NOT NULL,
    "position" point NOT NULL,
    "time" timestamp with time zone,
    hdop numeric(6,1),
    altitude numeric(11,5)
);


--
-- Name: itinerary_track_point_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE itinerary_track_point_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: itinerary_track_point_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE itinerary_track_point_seq OWNED BY itinerary_track_point.id;


--
-- Name: itinerary_track_segment; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE itinerary_track_segment (
    id integer NOT NULL,
    itinerary_track_id integer NOT NULL,
    distance numeric(12,2),
    ascent numeric(9,1),
    descent numeric(9,1),
    lowest numeric(8,1),
    highest numeric(8,1)
);


--
-- Name: itinerary_track_segment_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE itinerary_track_segment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: itinerary_track_segment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE itinerary_track_segment_seq OWNED BY itinerary_track_segment.id;


--
-- Name: itinerary_track_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE itinerary_track_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: itinerary_track_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE itinerary_track_seq OWNED BY itinerary_track.id;


--
-- Name: itinerary_waypoint; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE itinerary_waypoint (
    id integer NOT NULL,
    itinerary_id integer NOT NULL,
    name text,
    "position" point NOT NULL,
    "time" timestamp with time zone,
    comment text,
    symbol text,
    altitude numeric(11,5),
    description text,
    color text,
    type text,
    avg_samples integer
);


--
-- Name: itinerary_waypoint_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE itinerary_waypoint_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: itinerary_waypoint_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE itinerary_waypoint_seq OWNED BY itinerary_waypoint.id;


--
-- Name: location_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE location_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: location; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE location (
    id integer DEFAULT nextval('location_seq'::regclass) NOT NULL,
    user_id integer NOT NULL,
    location point NOT NULL,
    "time" timestamp with time zone DEFAULT now() NOT NULL,
    hdop numeric(6,1),
    altitude numeric(11,5),
    speed numeric(6,1),
    bearing numeric(11,5),
    sat smallint,
    provider text,
    battery numeric(4,1),
    note text
);


--
-- Name: location_sharing; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE location_sharing (
    shared_by_id integer NOT NULL,
    shared_to_id integer NOT NULL,
    recent_minutes integer,
    max_minutes integer,
    active boolean
);


--
-- Name: path_color; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE path_color (
    key text NOT NULL,
    value text NOT NULL,
    html_code text
);


--
-- Name: role; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: role_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE role_seq OWNED BY role.id;


--
-- Name: tile; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tile (
    server_id integer DEFAULT 0 NOT NULL,
    x integer NOT NULL,
    y integer NOT NULL,
    z smallint NOT NULL,
    image bytea,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    expires timestamp without time zone NOT NULL
);


--
-- Name: tile_download_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tile_download_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tile_metric; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tile_metric (
    "time" timestamp with time zone DEFAULT now() NOT NULL,
    count integer NOT NULL
);


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_role (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


--
-- Name: usertable_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE usertable_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: usertable; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE usertable (
    id integer DEFAULT nextval('usertable_seq'::regclass) NOT NULL,
    firstname text NOT NULL,
    lastname text NOT NULL,
    email text NOT NULL,
    uuid uuid NOT NULL,
    password text NOT NULL,
    nickname text NOT NULL
);


--
-- Name: waypoint_symbol; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE waypoint_symbol (
    key text NOT NULL,
    value text NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary ALTER COLUMN id SET DEFAULT nextval('itinerary_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_route ALTER COLUMN id SET DEFAULT nextval('itinerary_route_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_route_point ALTER COLUMN id SET DEFAULT nextval('itinerary_route_point_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_track ALTER COLUMN id SET DEFAULT nextval('itinerary_track_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_track_point ALTER COLUMN id SET DEFAULT nextval('itinerary_track_point_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_track_segment ALTER COLUMN id SET DEFAULT nextval('itinerary_track_segment_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_waypoint ALTER COLUMN id SET DEFAULT nextval('itinerary_waypoint_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_seq'::regclass);


--
-- Data for Name: georef_format; Type: TABLE DATA; Schema: public; Owner: -
--

COPY georef_format (key, value, ord) FROM stdin;
%d°%M′%S″%c	DMS+	1
%d°%M′%c	DM+	2
%d°%c	D+	3
%i%d	D	4
%p%d	±D	5
plus+code	OLC plus+code	6
osgb36	OS GB 1936 (BNG)	7
%dd%M'%S"%c	Proj4	8
%c%D° %M	QLandkarte GT	9
%c%d°%M′%S″	+DMS	10
%c%d°%M′\\	+DM	11
%c%d°	+D	12
%d° %M′ %S″ %c	D M S +	13
%d° %M′ %c	D M +	14
%d° %c	D +	15
%c %d° %M′ %S″	+ D M S	16
%c %d° %M′	+ D M	17
%c %d°	+ D	18
%d %m %s%c	Plain DMS+	18
%d %m%c	Plain DM+	19
%d%c	Plain D+	20
%c%d %m %s	Plain +DMS	21
%c%d %m	Plain +DM	22
%c%d	Plain +D	23
IrishGrid	Irish Grid	24
ITM	Irish Transverse Mercator	25
\.


--
-- Data for Name: itinerary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY itinerary (id, title, description, user_id, archived, start, finish) FROM stdin;
929	Itinerary for tests - DO NOT DELETE	# Test modified Itinerary\n\n## Lorem ipsum modified too\n\nSo this is my nice little *itinerary description*.\n\n - *Action one*\n - Action two\n\n    Code **indented**\n\n---\n\n\n    <script>alert('xss'); </script>\n\n> Block quote\n\nend\n	29	f	2015-11-22 00:00:00+00	\N
1744	Test itinerary - DO NOT DELETE	## Note\n\nUsed to add waypoints to.  The waypoints can be deleted.\n	29	f	2016-10-31 00:00:00+00	\N
982	Owned by admin	Test	1	f	2016-10-30 00:00:00+01	\N
983	Owned by orange	test	791	f	2016-10-30 00:00:00+01	\N
2419	Eiffel Tower	\N	29	f	\N	\N
2333	Test modified title	# Test modified Itinerary\n\n## Lorem ipsum modified too	29	f	\N	\N
2425	Test Itinerary - DO NOT DELETE	Tests for editing tracks	29	f	\N	\N
\.


--
-- Data for Name: itinerary_route; Type: TABLE DATA; Schema: public; Owner: -
--

COPY itinerary_route (id, itinerary_id, name, distance, ascent, descent, lowest, highest, color) FROM stdin;
8303	929	Test One	\N	\N	\N	\N	\N	\N
8309	983	Test One	\N	\N	\N	\N	\N	\N
8310	983	Modified route name	\N	\N	\N	\N	\N	\N
8304	929	Modified route name	\N	\N	\N	\N	\N	\N
8312	2425	Test route 01	60.33	1194.0	1445.2	41.4	420.2	Green
8313	2425	Test route 02	60.33	1445.2	1194.0	41.4	420.2	Blue
\.


--
-- Data for Name: itinerary_route_point; Type: TABLE DATA; Schema: public; Owner: -
--

COPY itinerary_route_point (id, itinerary_route_id, "position", name, comment, description, symbol, altitude) FROM stdin;
91539	8309	(-67.0383450000000067,62.788058999999997)	001	p1	p1	Small City	100.00000
91540	8309	(93.8014979999999952,64.0464020000000005)	002	p2	p2	Small City	\N
91541	8309	(143.371811000000008,-32.0394519999999972)	003	p3	p3	Small City	\N
91542	8309	(25.5842209999999994,-37.4278789999999972)	004	p4	p4	Small City	\N
91543	8309	(-61.0759350000000012,-51.6085589999999996)	005	p5	p5	Small City	\N
91544	8309	(-116.622810000000001,59.8965760000000031)	006	p6	p6	Small City	\N
91545	8310	(-43.953795999999997,30.5388090000000005)	001	p1	p1	Small City	\N
91546	8310	(11.4172960000000003,-33.6372950000000017)	002	p2	p2	Small City	\N
91547	8310	(74.5227660000000043,18.9117029999999993)	003	p3	p3	Small City	\N
91548	8310	(89.1126100000000037,56.1303750000000008)	004	p4	p4	Small City	\N
91549	8310	(27.061827000000001,17.7436770000000017)	005	p5	p5	Small City	\N
91506	8303	(-67.0383450000000067,62.788058999999997)	001	p1	p1	Small City	100.00000
91507	8303	(93.8014979999999952,64.0464020000000005)	002	p2	p2	Small City	\N
91508	8303	(143.371811000000008,-32.0394519999999972)	003	p3	p3	Small City	\N
91509	8303	(25.5842209999999994,-37.4278789999999972)	004	p4	p4	Small City	\N
91510	8303	(-61.0759350000000012,-51.6085589999999996)	005	p5	p5	Small City	\N
91511	8303	(-116.622810000000001,59.8965760000000031)	006	p6	p6	Small City	\N
91512	8304	(-43.953795999999997,30.5388090000000005)	001	p1	p1	Small City	\N
91513	8304	(11.4172960000000003,-33.6372950000000017)	002	p2	p2	Small City	\N
91514	8304	(74.5227660000000043,18.9117029999999993)	003	p3	p3	Small City	\N
91515	8304	(89.1126100000000037,56.1303750000000008)	004	p4	p4	Small City	\N
91516	8304	(27.061827000000001,17.7436770000000017)	005	p5	p5	Small City	\N
91573	8312	(-4.06256799999999973,50.5579449999999966)	001	p1	p1	Small City	292.60000
91574	8312	(-4.06428499999999993,50.5736470000000011)	002	p2	p2	Small City	170.60000
91575	8312	(-4.04934999999999956,50.5881460000000018)	003	p3	p3	Small City	177.60000
91576	8312	(-4.02643299999999993,50.5926130000000001)	004	p4	p4	Small City	284.00000
91577	8312	(-4.00471800000000044,50.5969729999999984)	005	p5	p5	Small City	150.30000
91578	8312	(-3.98128700000000002,50.5966450000000023)	006	p6	p6	Small City	244.10000
91579	8312	(-3.95897100000000002,50.5912509999999997)	007	p7	p7	Small City	217.20000
91580	8312	(-3.93948700000000018,50.5844379999999987)	008	p8	p8	Small City	385.90000
91581	8312	(-3.91107700000000014,50.5782809999999969)	009	p9	p9	Small City	326.20000
91582	8312	(-3.89545599999999981,50.5689050000000009)	010	p10	p10	Small City	102.40000
91583	8312	(-3.86507200000000006,50.5858569999999972)	011	p11	p11	Small City	56.40000
91584	8312	(-3.85245499999999996,50.6010059999999982)	012	p12	p12	Small City	121.60000
91585	8312	(-3.85159699999999994,50.6243709999999965)	013	p13	p13	Small City	410.50000
91586	8312	(-3.86181000000000019,50.6482120000000009)	014	p14	p14	Small City	317.60000
91587	8312	(-3.8619819999999998,50.6962430000000026)	015	p15	p15	Small City	420.20000
91588	8312	(-3.87923399999999985,50.7177700000000016)	016	p16	p16	Small City	218.90000
91589	8312	(-3.89708699999999997,50.7541659999999979)	017	p17	p17	Small City	283.70000
91590	8312	(-3.92747100000000016,50.714343999999997)	018	p18	p18	Small City	162.70000
91591	8312	(-3.93794200000000005,50.6660079999999979)	019	p19	p19	Small City	336.40000
91592	8312	(-3.96137400000000017,50.6465800000000002)	020	p20	p20	Small City	339.20000
91593	8312	(-4.00729299999999977,50.6246950000000027)	021	p21	p21	Small City	62.00000
91594	8312	(-4.04917899999999964,50.6343880000000013)	022	p22	p22	Small City	182.10000
91595	8312	(-4.04583099999999973,50.6151120000000034)	023	p23	p23	Small City	41.40000
91596	8313	(-4.04583099999999973,50.6151120000000034)	023	p23	p23	Small City	41.40000
91597	8313	(-4.04917899999999964,50.6343880000000013)	022	p22	p22	Small City	182.10000
91598	8313	(-4.00729299999999977,50.6246950000000027)	021	p21	p21	Small City	62.00000
91599	8313	(-3.96137400000000017,50.6465800000000002)	020	p20	p20	Small City	339.20000
91600	8313	(-3.93794200000000005,50.6660079999999979)	019	p19	p19	Small City	336.40000
91601	8313	(-3.92747100000000016,50.714343999999997)	018	p18	p18	Small City	162.70000
91602	8313	(-3.89708699999999997,50.7541659999999979)	017	p17	p17	Small City	283.70000
91603	8313	(-3.87923399999999985,50.7177700000000016)	016	p16	p16	Small City	218.90000
91604	8313	(-3.8619819999999998,50.6962430000000026)	015	p15	p15	Small City	420.20000
91605	8313	(-3.86181000000000019,50.6482120000000009)	014	p14	p14	Small City	317.60000
91606	8313	(-3.85159699999999994,50.6243709999999965)	013	p13	p13	Small City	410.50000
91607	8313	(-3.85245499999999996,50.6010059999999982)	012	p12	p12	Small City	121.60000
91608	8313	(-3.86507200000000006,50.5858569999999972)	011	p11	p11	Small City	56.40000
91609	8313	(-3.89545599999999981,50.5689050000000009)	010	p10	p10	Small City	102.40000
91610	8313	(-3.91107700000000014,50.5782809999999969)	009	p9	p9	Small City	326.20000
91611	8313	(-3.93948700000000018,50.5844379999999987)	008	p8	p8	Small City	385.90000
91612	8313	(-3.95897100000000002,50.5912509999999997)	007	p7	p7	Small City	217.20000
91613	8313	(-3.98128700000000002,50.5966450000000023)	006	p6	p6	Small City	244.10000
91614	8313	(-4.00471800000000044,50.5969729999999984)	005	p5	p5	Small City	150.30000
91615	8313	(-4.02643299999999993,50.5926130000000001)	004	p4	p4	Small City	284.00000
91616	8313	(-4.04934999999999956,50.5881460000000018)	003	p3	p3	Small City	177.60000
91617	8313	(-4.06428499999999993,50.5736470000000011)	002	p2	p2	Small City	170.60000
91618	8313	(-4.06256799999999973,50.5579449999999966)	001	p1	p1	Small City	292.60000
\.


--
-- Name: itinerary_route_point_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('itinerary_route_point_seq', 91618, true);


--
-- Name: itinerary_route_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('itinerary_route_seq', 8313, true);


--
-- Name: itinerary_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('itinerary_seq', 2425, true);


--
-- Data for Name: itinerary_sharing; Type: TABLE DATA; Schema: public; Owner: -
--

COPY itinerary_sharing (itinerary_id, shared_to_id, active) FROM stdin;
2333	1	t
2333	791	t
2333	456	t
982	29	t
983	29	t
\.


--
-- Data for Name: itinerary_track; Type: TABLE DATA; Schema: public; Owner: -
--

COPY itinerary_track (id, itinerary_id, name, color, distance, ascent, descent, lowest, highest) FROM stdin;
1015	929	Test track one	Green	\N	\N	\N	\N	\N
1025	983	Test track one	Green	\N	\N	\N	\N	\N
1026	983	Test track name	Yellow	\N	\N	\N	\N	\N
1016	929	Test track name	Yellow	\N	\N	\N	\N	\N
1027	2425	Test track 01	Blue	60.33	1481.9	1688.6	54.1	436.5
1028	2425	Test track 02	Green	60.33	1481.9	1688.6	54.1	436.5
\.


--
-- Data for Name: itinerary_track_point; Type: TABLE DATA; Schema: public; Owner: -
--

COPY itinerary_track_point (id, itinerary_track_segment_id, "position", "time", hdop, altitude) FROM stdin;
1323736	5756	(-64.4521408100000031,18.494869229999999)	1970-01-01 01:00:01+01	140.0	100.00000
1323737	5756	(-105.497062679999999,45.40974808)	1970-01-01 01:00:02+01	\N	100.00000
1323738	5756	(-133.709945680000004,-3.32189083000000007)	1970-01-01 01:00:03+01	\N	100.00000
1323739	5756	(-90.7314376799999991,-0.599133249999999951)	1970-01-01 01:00:04+01	\N	100.00000
1323740	5756	(-6.7958893800000002,4.05566787999999967)	1970-01-01 01:00:05+01	\N	100.00000
1323741	5756	(13.4189539,-9.08620834000000066)	1970-01-01 01:00:06+01	\N	100.00000
1323742	5757	(17.8134841900000005,-33.3446197499999997)	1970-01-01 01:00:07+01	\N	100.00000
1323743	5757	(26.0752029400000005,-34.8005905200000001)	1970-01-01 01:00:08+01	\N	100.00000
1323744	5757	(44.2685623200000009,-25.9435768099999997)	1970-01-01 01:00:09+01	\N	100.00000
1323745	5757	(51.1240310700000009,11.7970762300000001)	1970-01-01 01:00:10+01	\N	100.00000
1323746	5757	(-5.82909249999999979,36.1153755200000006)	1970-01-01 01:00:11+01	\N	100.00000
1323747	5757	(-27.8896389000000013,38.6294403099999997)	1970-01-01 01:00:12+01	\N	100.00000
1323748	5757	(-61.2001838699999965,11.7970762300000001)	1970-01-01 01:00:13+01	\N	100.00000
1323749	5758	(-54.4521408100000031,17.494869229999999)	1970-01-01 01:00:01+01	140.0	100.00000
1323750	5758	(-75.4970626799999991,42.40974808)	1970-01-01 01:00:02+01	\N	100.00000
1323937	5771	(-64.4521408100000031,18.494869229999999)	1970-01-01 01:00:01+01	140.0	100.00000
1323938	5771	(-105.497062679999999,45.40974808)	1970-01-01 01:00:02+01	\N	100.00000
1323939	5771	(-133.709945680000004,-3.32189083000000007)	1970-01-01 01:00:03+01	\N	100.00000
1323940	5771	(-90.7314376799999991,-0.599133249999999951)	1970-01-01 01:00:04+01	\N	100.00000
1323941	5771	(-6.7958893800000002,4.05566787999999967)	1970-01-01 01:00:05+01	\N	100.00000
1323942	5771	(13.4189539,-9.08620834000000066)	1970-01-01 01:00:06+01	\N	100.00000
1323943	5772	(17.8134841900000005,-33.3446197499999997)	1970-01-01 01:00:07+01	\N	100.00000
1323944	5772	(26.0752029400000005,-34.8005905200000001)	1970-01-01 01:00:08+01	\N	100.00000
1323945	5772	(44.2685623200000009,-25.9435768099999997)	1970-01-01 01:00:09+01	\N	100.00000
1323946	5772	(51.1240310700000009,11.7970762300000001)	1970-01-01 01:00:10+01	\N	100.00000
1323947	5772	(-5.82909249999999979,36.1153755200000006)	1970-01-01 01:00:11+01	\N	100.00000
1323948	5772	(-27.8896389000000013,38.6294403099999997)	1970-01-01 01:00:12+01	\N	100.00000
1323949	5772	(-61.2001838699999965,11.7970762300000001)	1970-01-01 01:00:13+01	\N	100.00000
1323950	5773	(-54.4521408100000031,17.494869229999999)	1970-01-01 01:00:01+01	140.0	100.00000
1323951	5773	(-75.4970626799999991,42.40974808)	1970-01-01 01:00:02+01	\N	100.00000
1323998	5777	(-4.06256819000000036,50.5579452500000031)	1970-01-01 01:00:01+01	14.8	349.80000
1323999	5777	(-4.06428480000000025,50.5736465499999994)	1970-01-01 01:00:02+01	38.3	161.70000
1324000	5777	(-4.04935025999999976,50.5881462099999979)	1970-01-01 01:00:03+01	33.1	296.50000
1324001	5777	(-4.02643346999999974,50.5926132199999969)	1970-01-01 01:00:04+01	98.9	215.90000
1324002	5777	(-4.0047183000000004,50.5969734199999976)	1970-01-01 01:00:05+01	102.7	312.60000
1324003	5777	(-3.98128676000000015,50.5966453599999966)	1970-01-01 01:00:06+01	30.8	61.80000
1324004	5777	(-3.95897078999999996,50.5912513700000019)	1970-01-01 01:00:07+01	14.7	274.10000
1324005	5777	(-3.93948722000000018,50.5844383199999967)	1970-01-01 01:00:08+01	90.2	283.90000
1324006	5777	(-3.91107725999999989,50.5782814000000016)	1970-01-01 01:00:09+01	83.4	80.90000
1324007	5777	(-3.89545608000000021,50.5689048799999981)	1970-01-01 01:00:10+01	52.0	387.30000
1324008	5777	(-3.86507201,50.585857390000001)	1970-01-01 01:00:11+01	46.4	376.40000
1324009	5777	(-3.85245490000000013,50.6010055500000036)	1970-01-01 01:00:12+01	56.4	436.50000
1324010	5777	(-3.85159659000000021,50.6243705700000035)	1970-01-01 01:00:13+01	67.6	358.20000
1324011	5777	(-3.86181045000000012,50.6482124300000009)	1970-01-01 01:00:14+01	57.9	59.60000
1324012	5777	(-3.86198211000000002,50.6962432899999982)	1970-01-01 01:00:15+01	11.0	55.40000
1324013	5777	(-3.87923407999999981,50.7177696199999986)	1970-01-01 01:00:16+01	87.4	279.20000
1324014	5777	(-3.89708685999999993,50.7541656499999974)	1970-01-01 01:00:17+01	86.5	353.30000
1324015	5777	(-3.9274709200000002,50.7143440199999986)	1970-01-01 01:00:18+01	39.2	223.50000
1324016	5777	(-3.93794227000000019,50.6660079999999979)	1970-01-01 01:00:19+01	26.2	424.90000
1324017	5777	(-3.96137403999999993,50.64657974)	1970-01-01 01:00:20+01	92.1	139.00000
1324018	5777	(-4.00729322000000021,50.624694820000002)	1970-01-01 01:00:21+01	19.1	54.10000
1324019	5777	(-4.04917860000000029,50.6343879699999988)	1970-01-01 01:00:22+01	95.3	216.60000
1324020	5777	(-4.04583120000000029,50.6151122999999998)	1970-01-01 01:00:23+01	66.1	143.10000
1324021	5778	(-4.06256819000000036,50.5579452500000031)	1970-01-01 01:00:01+01	14.8	349.80000
1324022	5778	(-4.06428480000000025,50.5736465499999994)	1970-01-01 01:00:02+01	38.3	161.70000
1324023	5778	(-4.04935025999999976,50.5881462099999979)	1970-01-01 01:00:03+01	33.1	296.50000
1324024	5778	(-4.02643346999999974,50.5926132199999969)	1970-01-01 01:00:04+01	98.9	215.90000
1324025	5778	(-4.0047183000000004,50.5969734199999976)	1970-01-01 01:00:05+01	102.7	312.60000
1324026	5778	(-3.98128676000000015,50.5966453599999966)	1970-01-01 01:00:06+01	30.8	61.80000
1324027	5778	(-3.95897078999999996,50.5912513700000019)	1970-01-01 01:00:07+01	14.7	274.10000
1324028	5778	(-3.93948722000000018,50.5844383199999967)	1970-01-01 01:00:08+01	90.2	283.90000
1324029	5778	(-3.91107725999999989,50.5782814000000016)	1970-01-01 01:00:09+01	83.4	80.90000
1324030	5778	(-3.89545608000000021,50.5689048799999981)	1970-01-01 01:00:10+01	52.0	387.30000
1324031	5778	(-3.86507201,50.585857390000001)	1970-01-01 01:00:11+01	46.4	376.40000
1324032	5778	(-3.85245490000000013,50.6010055500000036)	1970-01-01 01:00:12+01	56.4	436.50000
1324033	5778	(-3.85159659000000021,50.6243705700000035)	1970-01-01 01:00:13+01	67.6	358.20000
1324034	5778	(-3.86181045000000012,50.6482124300000009)	1970-01-01 01:00:14+01	57.9	59.60000
1324035	5778	(-3.86198211000000002,50.6962432899999982)	1970-01-01 01:00:15+01	11.0	55.40000
1324036	5778	(-3.87923407999999981,50.7177696199999986)	1970-01-01 01:00:16+01	87.4	279.20000
1324037	5778	(-3.89708685999999993,50.7541656499999974)	1970-01-01 01:00:17+01	86.5	353.30000
1324038	5778	(-3.9274709200000002,50.7143440199999986)	1970-01-01 01:00:18+01	39.2	223.50000
1324039	5778	(-3.93794227000000019,50.6660079999999979)	1970-01-01 01:00:19+01	26.2	424.90000
1324040	5778	(-3.96137403999999993,50.64657974)	1970-01-01 01:00:20+01	92.1	139.00000
1324041	5778	(-4.00729322000000021,50.624694820000002)	1970-01-01 01:00:21+01	19.1	54.10000
1324042	5778	(-4.04917860000000029,50.6343879699999988)	1970-01-01 01:00:22+01	95.3	216.60000
1324043	5778	(-4.04583120000000029,50.6151122999999998)	1970-01-01 01:00:23+01	66.1	143.10000
\.


--
-- Name: itinerary_track_point_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('itinerary_track_point_seq', 1324043, true);


--
-- Data for Name: itinerary_track_segment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY itinerary_track_segment (id, itinerary_track_id, distance, ascent, descent, lowest, highest) FROM stdin;
5756	1015	\N	\N	\N	\N	\N
5757	1015	\N	\N	\N	\N	\N
5758	1016	\N	\N	\N	\N	\N
5771	1025	\N	\N	\N	\N	\N
5772	1025	\N	\N	\N	\N	\N
5773	1026	\N	\N	\N	\N	\N
5777	1027	\N	\N	\N	\N	\N
5778	1028	\N	\N	\N	\N	\N
\.


--
-- Name: itinerary_track_segment_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('itinerary_track_segment_seq', 5778, true);


--
-- Name: itinerary_track_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('itinerary_track_seq', 1028, true);


--
-- Data for Name: itinerary_waypoint; Type: TABLE DATA; Schema: public; Owner: -
--

COPY itinerary_waypoint (id, itinerary_id, name, "position", "time", comment, symbol, altitude, description, color, type, avg_samples) FROM stdin;
10861	983	London	(-0.134833339999999996,51.5174331699999968)	2016-11-02 19:28:50+00	Test Comment 1	City (Capitol)	100.00000	Test description 1	#b400842b	My Type	1
10862	983	Montpellier	(3.86420012000000002,43.6143836999999976)	2016-11-02 19:29:08+00	Test Comment 2	City (Large)	\N	Test description 2	\N	\N	2
10863	983	Paris	(2.3315999500000002,48.8594512900000026)	2016-11-02 19:28:15+00	Test Comment 3	City (Capitol)	\N	Test description 3	#b400842b	\N	\N
10864	983	Test waypoint modification	(-3,50)	2015-12-12 10:48:00+00	Test comment	Flag, Blue	450.00000	Test description	#ff0000	Restaurant	99
10865	983	Test waypoint modification	(-3,50)	2015-12-12 10:48:00+00	test mutli-line\n\ncomment\n\nover many lines\n\nthat goes and and on and on.  A very verbose comment that is boring to read and even more boring to write.	Restaurant	450.00000	Test description	#ff0000	Restaurant	99
10795	929	Test waypoint modification	(-3,50)	2015-12-12 10:48:00+00	test mutli-line\n\ncomment\n\nover many lines\n\nthat goes and and on and on.  A very verbose comment that is boring to read and even more boring to write.	Restaurant	450.00000	Test description	#ff0000	Restaurant	99
10587	929	London	(-0.134833339999999996,51.5174331699999968)	2016-11-02 19:28:50+00	Test Comment 1	City (Capitol)	100.00000	Test description 1	#b400842b	My Type	1
10588	929	Montpellier	(3.86420012000000002,43.6143836999999976)	2016-11-02 19:29:08+00	Test Comment 2	City (Large)	\N	Test description 2	\N	\N	2
10589	929	Paris	(2.3315999500000002,48.8594512900000026)	2016-11-02 19:28:15+00	Test Comment 3	City (Capitol)	\N	Test description 3	#b400842b	\N	\N
10867	1744	Test new waypoint	(2.29450000000000021,48.8582219999999978)	2015-12-10 17:48:00+00	Test comment	Flag, Blue	9000.45000	Test description	#ff0000	Restaurant	99
10866	1744	Test new waypoint	(2.29450000000000021,48.8582219999999978)	\N	\N	\N	\N	\N	\N	\N	\N
10868	1744	Test new waypoint	(2.29450000000000021,48.8582219999999978)	\N	\N	\N	\N	\N	\N	\N	\N
10869	1744	Test new waypoint	(2.29450000000000021,48.8582219999999978)	2015-12-10 17:48:00+00	Test comment	Flag, Blue	9000.45000	Test description	#ff0000	Restaurant	99
10870	1744	Test new waypoint	(2.29450000000000021,48.8582219999999978)	\N	\N	\N	\N	\N	\N	\N	\N
10871	1744	Test new waypoint	(2.29450000000000021,48.8582219999999978)	2015-12-10 17:48:00+00	Test comment	Flag, Blue	9000.45000	Test description	#ff0000	Restaurant	99
10872	2419	Eiffel Tower	(2.29450000000000021,48.8582222200000018)	1889-03-15 23:59:59+00	\N	Tall Tower	\N	\N	\N	\N	\N
9356	929	Test waypoint modification	(-3,50)	2015-12-12 10:48:00+00	Test comment	Flag, Blue	450.00000	Test description	#ff0000	Restaurant	99
10873	1744	Test new waypoint	(2.29450000000000021,48.8582219999999978)	\N	\N	\N	\N	\N	\N	\N	\N
10874	1744	Test new waypoint	(2.29450000000000021,48.8582219999999978)	2015-12-10 17:48:00+00	Test comment	Flag, Blue	9000.45000	Test description	#ff0000	Restaurant	99
\.


--
-- Name: itinerary_waypoint_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('itinerary_waypoint_seq', 10874, true);


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY location (id, user_id, location, "time", hdop, altitude, speed, bearing, sat, provider, battery, note) FROM stdin;
1	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:48:45.678+00	28.0	0.00000	0.0	\N	\N	\N	\N	\N
2	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:49:02.811+00	48.0	-47.59584	0.0	\N	\N	\N	\N	\N
3	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:49:18.267+00	8.0	36.43140	0.0	\N	\N	\N	\N	\N
4	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:49:34.235+00	8.0	48.38307	0.0	\N	\N	\N	\N	\N
5	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:49:49.287+00	8.0	48.23096	0.0	\N	\N	\N	\N	\N
6	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:50:04.3+00	8.0	48.09041	0.0	\N	\N	\N	\N	\N
7	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:50:20.241+00	8.0	47.97643	0.0	\N	\N	\N	\N	\N
8	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:50:36.241+00	8.0	47.91262	0.0	\N	\N	\N	\N	\N
9	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:50:52.496+00	12.0	47.40576	0.0	\N	\N	\N	\N	\N
10	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:51:08.283+00	16.0	47.04527	0.0	\N	\N	\N	\N	\N
11	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:51:24.38+00	12.0	46.86332	0.0	\N	\N	\N	\N	\N
12	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:51:40.268+00	12.0	46.74418	0.0	\N	\N	\N	\N	\N
13	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:51:55.457+00	24.0	46.61090	0.0	\N	\N	\N	\N	\N
14	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:52:11.23+00	8.0	46.90281	0.0	\N	\N	\N	\N	\N
15	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:52:27.18+00	6.0	47.25555	0.0	\N	\N	\N	\N	\N
16	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:52:43.156+00	12.0	47.60045	0.0	\N	\N	\N	\N	\N
17	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:52:58.178+00	6.0	47.48304	0.0	\N	\N	\N	\N	\N
18	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:53:13.196+00	8.0	47.22823	0.0	\N	\N	\N	\N	\N
19	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:53:28.202+00	6.0	47.14187	0.0	\N	\N	\N	\N	\N
20	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:53:43.216+00	8.0	47.09595	0.0	\N	\N	\N	\N	\N
21	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:53:58.256+00	12.0	47.04038	0.0	\N	\N	\N	\N	\N
22	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:54:13.368+00	6.0	47.34203	0.0	\N	\N	\N	\N	\N
23	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:54:29.262+00	6.0	48.48309	0.0	\N	\N	\N	\N	\N
24	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:54:44.317+00	6.0	49.00377	0.0	\N	\N	\N	\N	\N
25	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:55:00.306+00	6.0	49.12439	0.0	\N	\N	\N	\N	\N
26	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:55:16.247+00	6.0	49.16155	0.0	\N	\N	\N	\N	\N
27	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:55:32.371+00	6.0	49.29865	0.0	\N	\N	\N	\N	\N
28	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:55:48.41+00	6.0	49.48713	0.0	\N	\N	\N	\N	\N
29	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:56:04.22+00	6.0	49.71073	0.0	\N	\N	\N	\N	\N
30	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:56:19.346+00	6.0	49.81036	0.0	\N	\N	\N	\N	\N
31	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:56:35.333+00	6.0	49.77771	0.0	\N	\N	\N	\N	\N
32	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:56:51.321+00	6.0	49.74463	0.0	\N	\N	\N	\N	\N
33	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:57:06.42+00	6.0	49.83752	0.0	\N	\N	\N	\N	\N
34	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 17:57:22.342+00	12.0	49.75256	0.0	\N	\N	\N	\N	\N
35	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 18:11:24.198+00	48.0	64.03132	0.0	\N	\N	\N	\N	\N
36	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 18:11:40.134+00	16.0	48.20074	0.0	\N	\N	\N	\N	\N
37	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 18:21:10.717+00	32.0	26.53609	0.0	\N	\N	\N	\N	\N
38	29	(2.29450000000000021,48.8582222200000018)	2015-12-10 18:21:26.419+00	24.0	48.63949	0.0	\N	\N	\N	\N	\N
39	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 09:51:11.595+00	20.0	0.00000	0.0	\N	\N	\N	\N	\N
40	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 09:51:41.792+00	32.0	42.87444	0.0	\N	\N	\N	\N	\N
41	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 09:52:57.174+00	16.0	61.71730	0.0	\N	\N	\N	\N	\N
42	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 09:53:55.825+00	16.0	48.61009	0.0	\N	\N	\N	\N	\N
43	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 09:54:57.976+00	32.0	69.69874	0.0	\N	\N	\N	\N	\N
44	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 09:55:56.379+00	16.0	55.45817	0.0	\N	\N	\N	\N	\N
45	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 09:58:55.388+00	48.0	46.83736	0.0	\N	\N	\N	\N	\N
46	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 09:59:57.047+00	32.0	77.21889	0.0	\N	\N	\N	\N	\N
47	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:00:54.788+00	32.0	54.66311	0.0	\N	\N	\N	\N	\N
48	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:01:55.336+00	48.0	48.63861	0.0	\N	\N	\N	\N	\N
49	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:02:38.97+00	26.3	0.00000	0.0	\N	\N	\N	\N	\N
50	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:03:13.296+00	6.0	47.02446	0.0	\N	\N	\N	\N	\N
51	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:04:28.743+00	48.0	53.04834	0.0	\N	\N	\N	\N	\N
52	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:06:26.433+00	32.0	54.68237	0.0	\N	\N	\N	\N	\N
53	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:08:27.273+00	48.0	67.54256	0.0	\N	\N	\N	\N	\N
54	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:11:28.04+00	32.0	69.71392	0.0	\N	\N	\N	\N	\N
55	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:13:26.586+00	48.0	45.86022	0.0	\N	\N	\N	\N	\N
56	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:14:25.223+00	48.0	51.78368	0.0	\N	\N	\N	\N	\N
57	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:15:27.167+00	32.0	57.36875	0.0	\N	\N	\N	\N	\N
58	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:16:27.177+00	32.0	69.13952	0.0	\N	\N	\N	\N	\N
59	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:17:05.568+00	28.8	0.00000	0.0	\N	\N	\N	\N	\N
60	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:17:36.165+00	12.0	57.10656	0.0	\N	\N	\N	\N	\N
61	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:18:07.14+00	6.0	53.18243	0.0	\N	\N	\N	\N	\N
62	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:18:37.181+00	6.0	53.54308	0.0	\N	\N	\N	\N	\N
63	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:19:22.122+00	48.0	53.49065	0.0	\N	\N	\N	\N	\N
64	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:19:52.176+00	8.0	53.11393	0.0	\N	\N	\N	\N	\N
65	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:20:23.165+00	6.0	53.32507	0.3	\N	\N	\N	\N	\N
66	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:20:53.416+00	8.0	52.95678	0.0	\N	\N	\N	\N	\N
67	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:21:24.169+00	6.0	53.30026	0.0	\N	\N	\N	\N	\N
68	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:21:55.146+00	12.0	53.39958	0.0	\N	\N	\N	\N	\N
69	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:22:40.27+00	32.0	48.52645	0.0	\N	\N	\N	\N	\N
70	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:23:39.323+00	32.0	29.15632	0.0	\N	\N	\N	\N	\N
71	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:24:40.276+00	48.0	54.28622	0.0	\N	\N	\N	\N	\N
72	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:25:40.472+00	32.0	44.67345	0.0	\N	\N	\N	\N	\N
73	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:26:39.01+00	48.0	47.83597	0.0	\N	\N	\N	\N	\N
74	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:28:39.702+00	32.0	37.33819	0.0	\N	\N	\N	\N	\N
75	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:30:39.569+00	24.0	28.04690	0.0	\N	\N	\N	\N	\N
76	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:33:38.489+00	32.0	53.25307	0.0	\N	\N	\N	\N	\N
77	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:34:38.435+00	32.0	54.81836	0.0	\N	\N	\N	\N	\N
78	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:35:41.144+00	32.0	44.48648	0.0	\N	\N	\N	\N	\N
79	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:36:38.343+00	32.0	64.17602	0.0	\N	\N	\N	\N	\N
80	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:38:39.151+00	32.0	52.19923	0.0	\N	\N	\N	\N	\N
81	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:39:38.143+00	32.0	76.90907	0.0	\N	\N	\N	\N	\N
82	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:41:38.086+00	48.0	71.12769	0.0	\N	\N	\N	\N	\N
83	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:42:38.523+00	32.0	54.51712	0.0	\N	\N	\N	\N	\N
84	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:43:38.107+00	32.0	56.49540	0.0	\N	\N	\N	\N	\N
85	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:44:40.545+00	32.0	65.15405	0.0	\N	\N	\N	\N	\N
86	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:45:38.09+00	48.0	35.53558	0.0	\N	\N	\N	\N	\N
87	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:47:15.536+00	26.0	0.00000	0.0	\N	\N	\N	\N	\N
88	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:49:21.791+00	32.0	55.06961	0.0	\N	\N	\N	\N	\N
89	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:52:22.032+00	32.0	78.93964	0.0	\N	\N	\N	\N	\N
90	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:54:20.142+00	32.0	76.58849	0.0	\N	\N	\N	\N	\N
91	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 10:56:23.336+00	32.0	51.82863	0.0	\N	\N	\N	\N	\N
92	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:01:21.88+00	32.0	-6.24129	0.0	\N	\N	\N	\N	\N
93	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:03:23.315+00	32.0	62.37791	0.0	\N	\N	\N	\N	\N
94	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:06:22.442+00	48.0	88.36466	0.0	\N	\N	\N	\N	\N
95	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:08:22.271+00	48.0	97.85030	0.0	\N	\N	\N	\N	\N
96	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:10:23.354+00	32.0	19.09373	0.0	\N	\N	\N	\N	\N
97	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:12:23.476+00	32.0	53.69154	0.0	\N	\N	\N	\N	\N
98	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:13:53.621+00	12.0	44.22003	0.0	\N	\N	\N	\N	\N
99	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:16:22.627+00	32.0	75.08372	0.0	\N	\N	\N	\N	\N
100	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:19:21.258+00	48.0	63.11445	0.0	\N	\N	\N	\N	\N
101	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:21:20.559+00	32.0	81.66652	0.0	\N	\N	\N	\N	\N
102	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:26:22.218+00	32.0	69.92747	0.0	\N	\N	\N	\N	\N
103	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:28:21.251+00	48.0	62.59260	0.0	\N	\N	\N	\N	\N
104	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:30:23.284+00	48.0	29.78206	0.0	\N	\N	\N	\N	\N
105	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:32:21.238+00	48.0	57.56276	0.0	\N	\N	\N	\N	\N
106	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:35:22.413+00	32.0	78.62145	0.0	\N	\N	\N	\N	\N
107	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:37:21.181+00	48.0	45.62373	0.0	\N	\N	\N	\N	\N
108	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:39:22.146+00	32.0	36.07670	0.0	\N	\N	\N	\N	\N
109	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:40:52.676+00	23.0	0.00000	0.0	\N	\N	\N	\N	\N
110	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:43:06.212+00	37.5	0.00000	0.0	\N	\N	\N	\N	\N
111	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:44:18.846+00	48.0	55.46568	0.0	\N	\N	\N	\N	\N
112	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:50:23.553+00	64.0	38.99793	0.0	\N	\N	\N	\N	\N
113	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:55:24.638+00	32.0	19.80232	0.0	\N	\N	\N	\N	\N
114	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:57:22.142+00	32.0	40.39003	0.0	\N	\N	\N	\N	\N
115	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 11:59:11.162+00	24.0	43.51300	0.0	\N	\N	\N	\N	\N
116	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:01:11.424+00	32.0	52.49714	0.0	\N	\N	\N	\N	\N
117	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:03:23.128+00	24.0	43.89343	9.3	\N	\N	\N	\N	\N
118	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:05:13.405+00	24.0	48.60447	0.0	\N	\N	\N	\N	\N
119	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:07:13.484+00	32.0	55.04909	0.0	\N	\N	\N	\N	\N
120	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:09:14.075+00	32.0	93.48613	17.1	\N	\N	\N	\N	\N
121	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:11:13.263+00	32.0	42.27463	0.0	\N	\N	\N	\N	\N
122	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:12:14.467+00	32.0	52.00989	8.8	\N	\N	\N	\N	\N
123	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:14:12.986+00	32.0	42.48766	11.6	\N	\N	\N	\N	\N
124	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:15:13.114+00	32.0	39.03815	9.3	\N	\N	\N	\N	\N
125	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:17:12.311+00	48.0	38.30399	0.0	\N	\N	\N	\N	\N
126	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:18:14.04+00	32.0	46.82231	10.6	\N	\N	\N	\N	\N
127	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:20:15.166+00	32.0	76.10866	17.2	\N	\N	\N	\N	\N
128	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:22:12.982+00	32.0	131.98329	0.0	\N	\N	\N	\N	\N
129	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:23:13.202+00	32.0	108.75279	21.7	\N	\N	\N	\N	\N
130	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:25:14.066+00	32.0	95.78659	22.7	\N	\N	\N	\N	\N
131	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:27:13.579+00	32.0	107.45828	0.0	\N	\N	\N	\N	\N
132	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:29:13.005+00	32.0	119.42396	0.0	\N	\N	\N	\N	\N
133	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:30:14.033+00	32.0	115.29700	8.4	\N	\N	\N	\N	\N
134	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:35:48.148+00	32.0	209.02303	0.0	\N	\N	\N	\N	\N
135	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:37:09.576+00	48.0	148.07036	0.0	\N	\N	\N	\N	\N
136	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:39:11.765+00	32.0	201.50960	0.0	\N	\N	\N	\N	\N
137	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:41:08.009+00	32.0	180.67780	0.0	\N	\N	\N	\N	\N
138	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:42:21.773+00	32.0	175.38809	0.0	\N	\N	\N	\N	\N
139	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:44:08.325+00	32.0	185.96610	0.0	\N	\N	\N	\N	\N
140	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:47:11.595+00	32.0	156.26035	0.0	\N	\N	\N	\N	\N
141	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:52:15.464+00	48.0	242.36570	0.0	\N	\N	\N	\N	\N
142	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:54:09.705+00	48.0	201.01941	0.0	\N	\N	\N	\N	\N
143	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:56:10.206+00	48.0	192.19493	0.0	\N	\N	\N	\N	\N
144	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:57:11.89+00	32.0	202.57794	0.0	\N	\N	\N	\N	\N
145	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 12:59:11.084+00	32.0	208.88437	0.0	\N	\N	\N	\N	\N
146	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:03:13.669+00	32.0	192.08371	0.0	\N	\N	\N	\N	\N
147	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:09:13.509+00	32.0	191.41160	0.0	\N	\N	\N	\N	\N
148	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:11:15.562+00	32.0	170.93626	0.0	\N	\N	\N	\N	\N
149	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:13:12.472+00	32.0	223.34088	0.0	\N	\N	\N	\N	\N
150	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:17:13.172+00	32.0	217.57617	0.0	\N	\N	\N	\N	\N
151	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:18:14.573+00	32.0	289.06497	0.0	\N	\N	\N	\N	\N
152	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:20:12.616+00	48.0	209.21999	0.0	\N	\N	\N	\N	\N
153	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:21:14.654+00	32.0	241.64606	0.0	\N	\N	\N	\N	\N
154	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:30:15.711+00	32.0	103.28391	0.0	\N	\N	\N	\N	\N
155	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:33:11.239+00	48.0	90.76464	0.0	\N	\N	\N	\N	\N
156	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:35:11.324+00	48.0	98.27842	0.0	\N	\N	\N	\N	\N
157	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:36:14.343+00	48.0	98.20610	0.0	\N	\N	\N	\N	\N
158	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:38:12.354+00	48.0	85.77583	0.0	\N	\N	\N	\N	\N
159	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:40:12.734+00	32.0	143.53433	0.0	\N	\N	\N	\N	\N
160	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:42:12.557+00	32.0	120.57677	2.1	\N	\N	\N	\N	\N
161	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 13:48:22.773+00	48.0	118.34061	0.0	\N	\N	\N	\N	\N
162	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 14:04:21.545+00	32.0	202.96760	0.0	\N	\N	\N	\N	\N
163	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 14:06:16.791+00	48.0	127.53669	0.0	\N	\N	\N	\N	\N
164	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 14:10:23.03+00	32.0	185.30704	0.0	\N	\N	\N	\N	\N
165	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 14:13:22.091+00	32.0	182.84906	0.0	\N	\N	\N	\N	\N
166	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 14:15:25.016+00	24.0	249.56033	0.0	\N	\N	\N	\N	\N
167	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 14:26:20.995+00	24.0	182.24167	0.0	\N	\N	\N	\N	\N
168	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 14:51:19.721+00	32.0	98.35738	0.0	\N	\N	\N	\N	\N
169	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 14:54:22.236+00	32.0	137.81354	0.0	\N	\N	\N	\N	\N
170	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 14:59:21.587+00	48.0	147.85168	0.0	\N	\N	\N	\N	\N
171	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:01:18.499+00	24.0	137.89601	0.0	\N	\N	\N	\N	\N
172	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:03:18.27+00	24.0	130.12164	0.0	\N	\N	\N	\N	\N
173	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:04:18.704+00	24.0	145.95910	0.0	\N	\N	\N	\N	\N
174	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:08:18.852+00	24.0	125.10513	0.0	\N	\N	\N	\N	\N
175	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:09:18.954+00	32.0	113.08754	0.0	\N	\N	\N	\N	\N
176	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:11:19.943+00	48.0	157.09558	0.0	\N	\N	\N	\N	\N
177	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:14:19.485+00	48.0	131.28253	0.0	\N	\N	\N	\N	\N
178	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:17:18.415+00	32.0	136.99191	0.0	\N	\N	\N	\N	\N
179	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:18:21.181+00	16.0	196.47145	0.0	\N	\N	\N	\N	\N
180	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:21:18.526+00	32.0	198.02995	0.0	\N	\N	\N	\N	\N
181	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:23:18.444+00	32.0	153.72289	0.0	\N	\N	\N	\N	\N
182	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:25:55.093+00	24.0	193.42218	0.0	\N	\N	\N	\N	\N
183	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:27:20.832+00	48.0	170.05359	0.0	\N	\N	\N	\N	\N
184	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:32:21.582+00	32.0	195.08154	0.0	\N	\N	\N	\N	\N
185	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:34:21.948+00	24.0	213.91872	0.0	\N	\N	\N	\N	\N
186	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:35:22.19+00	24.0	192.09543	0.0	\N	\N	\N	\N	\N
187	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:36:22.695+00	48.0	326.36200	0.0	\N	\N	\N	\N	\N
188	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:38:22.303+00	24.0	162.89967	0.0	\N	\N	\N	\N	\N
189	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:43:23.192+00	16.0	230.22588	0.0	\N	\N	\N	\N	\N
190	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:45:22.371+00	32.0	203.55461	0.0	\N	\N	\N	\N	\N
191	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:48:21.848+00	24.0	186.35120	0.0	\N	\N	\N	\N	\N
192	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:50:20.269+00	16.0	195.03079	0.0	\N	\N	\N	\N	\N
193	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:51:22.565+00	16.0	203.91286	0.0	\N	\N	\N	\N	\N
194	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:53:21.99+00	32.0	209.50278	0.0	\N	\N	\N	\N	\N
195	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:55:19.497+00	24.0	171.56012	0.0	\N	\N	\N	\N	\N
196	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:58:21.18+00	16.0	159.48364	0.0	\N	\N	\N	\N	\N
197	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 15:59:21.254+00	32.0	167.97330	0.0	\N	\N	\N	\N	\N
198	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:00:23.36+00	24.0	190.18776	0.0	\N	\N	\N	\N	\N
199	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:02:21.09+00	48.0	176.73099	0.0	\N	\N	\N	\N	\N
200	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:05:20.923+00	48.0	153.72902	0.0	\N	\N	\N	\N	\N
201	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:09:27.029+00	48.0	221.57588	0.0	\N	\N	\N	\N	\N
202	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:14:24.915+00	48.0	184.65305	8.5	\N	\N	\N	\N	\N
203	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:15:28.46+00	32.0	242.18759	0.0	\N	\N	\N	\N	\N
204	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:18:19.116+00	48.0	135.89049	0.0	\N	\N	\N	\N	\N
205	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:23:26.578+00	8.0	96.48116	11.9	\N	\N	\N	\N	\N
206	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:24:33.93+00	32.0	76.14261	0.0	\N	\N	\N	\N	\N
207	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:26:26.488+00	16.0	95.28863	21.0	\N	\N	\N	\N	\N
208	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:27:26.508+00	32.0	79.98546	0.0	\N	\N	\N	\N	\N
209	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:29:27.471+00	48.0	68.60552	19.9	\N	\N	\N	\N	\N
210	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:31:28.834+00	48.0	73.17284	0.0	\N	\N	\N	\N	\N
211	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:33:25.615+00	32.0	46.13934	0.0	\N	\N	\N	\N	\N
212	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:34:26.293+00	32.0	30.34253	0.0	\N	\N	\N	\N	\N
213	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:36:25.469+00	32.0	34.62601	12.3	\N	\N	\N	\N	\N
214	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:37:28.278+00	12.0	19.91737	0.0	\N	\N	\N	\N	\N
215	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:39:26.278+00	16.0	31.68205	0.0	\N	\N	\N	\N	\N
216	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:41:26.378+00	8.0	24.93663	0.0	\N	\N	\N	\N	\N
217	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:43:26.301+00	32.0	42.32409	8.1	\N	\N	\N	\N	\N
218	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:45:26.655+00	16.0	55.57928	0.0	\N	\N	\N	\N	\N
219	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:47:26.737+00	12.0	41.92464	0.0	\N	\N	\N	\N	\N
220	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:49:26.603+00	24.0	57.10860	0.0	\N	\N	\N	\N	\N
221	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:51:26.387+00	48.0	39.60604	0.0	\N	\N	\N	\N	\N
222	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:52:27.437+00	32.0	16.62996	9.9	\N	\N	\N	\N	\N
223	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:54:31.387+00	48.0	49.68448	11.5	\N	\N	\N	\N	\N
224	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:56:26.489+00	48.0	31.34053	9.9	\N	\N	\N	\N	\N
225	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:58:25.516+00	48.0	42.46823	0.0	\N	\N	\N	\N	\N
226	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 16:59:28.799+00	32.0	83.27123	0.0	\N	\N	\N	\N	\N
227	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 17:01:12.285+00	32.0	30.93250	0.0	\N	\N	\N	\N	\N
228	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 17:02:40.517+00	48.0	31.10194	0.0	\N	\N	\N	\N	\N
229	29	(2.29450000000000021,48.8582222200000018)	2015-12-11 17:04:30.759+00	32.0	65.42360	0.0	\N	\N	\N	\N	\N
230	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 08:58:13.979+00	32.0	38.21114	0.0	\N	\N	\N	\N	\N
231	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 09:03:15.029+00	16.0	55.83433	0.0	\N	\N	\N	\N	\N
232	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 09:10:08.456+00	32.0	16.26899	0.0	\N	\N	\N	\N	\N
233	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 09:15:08.651+00	48.0	71.54320	0.0	\N	\N	\N	\N	\N
234	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 09:25:05.52+00	48.0	21.43515	0.0	\N	\N	\N	\N	\N
235	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 09:30:07.946+00	48.0	94.27336	0.0	\N	\N	\N	\N	\N
236	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 09:35:08.445+00	32.0	72.15678	0.0	\N	\N	\N	\N	\N
237	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 09:45:04.506+00	32.0	91.65360	0.0	\N	\N	\N	\N	\N
238	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 09:55:03.268+00	32.0	60.51390	0.0	\N	\N	\N	\N	\N
239	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:00:03.465+00	32.0	57.81730	0.0	\N	\N	\N	\N	\N
240	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:10:02.464+00	48.0	37.76046	0.0	\N	\N	\N	\N	\N
241	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:15:04.363+00	32.0	51.91887	0.0	\N	\N	\N	\N	\N
242	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:25:04.322+00	32.0	64.11037	0.0	\N	\N	\N	\N	\N
243	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:35:10.454+00	32.0	90.66716	0.0	\N	\N	\N	\N	\N
244	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:38:22.557+00	25.0	0.00000	0.0	\N	\N	\N	\N	\N
245	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:43:55.028+00	32.0	57.93975	7.4	\N	\N	\N	\N	\N
246	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:48:37.809+00	32.0	64.25047	0.0	\N	\N	\N	\N	\N
247	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:53:37.685+00	48.0	45.11510	0.0	\N	\N	\N	\N	\N
248	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 10:58:37.134+00	48.0	66.80489	0.0	\N	\N	\N	\N	\N
249	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:03:38.22+00	12.0	50.84784	0.0	\N	\N	\N	\N	\N
250	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:08:35.176+00	48.0	57.56392	0.0	\N	\N	\N	\N	\N
251	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:13:35.257+00	48.0	52.44290	0.0	\N	\N	\N	\N	\N
252	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:18:37.243+00	24.0	50.46099	0.0	\N	\N	\N	\N	\N
253	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:23:34.826+00	24.0	41.50254	0.0	\N	\N	\N	\N	\N
254	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:28:35.221+00	32.0	52.18317	0.0	\N	\N	\N	\N	\N
255	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:30:35.895+00	8.0	50.30246	0.0	\N	\N	\N	\N	\N
256	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:31:34.108+00	8.0	47.15113	0.0	\N	\N	\N	\N	\N
257	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:36:51.599+00	24.0	56.17534	0.0	\N	\N	\N	\N	\N
258	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:41:50.285+00	32.0	38.34210	0.0	\N	\N	\N	\N	\N
259	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 11:51:49.554+00	32.0	73.41370	0.0	\N	\N	\N	\N	\N
260	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 12:01:51.204+00	24.0	45.75670	0.0	\N	\N	\N	\N	\N
261	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 12:06:51.131+00	32.0	45.60718	0.0	\N	\N	\N	\N	\N
262	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 12:11:52.109+00	16.0	39.68103	0.0	\N	\N	\N	\N	\N
263	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 12:16:52.35+00	16.0	48.50514	0.0	\N	\N	\N	\N	\N
264	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 12:26:49.564+00	32.0	24.73082	0.0	\N	\N	\N	\N	\N
265	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 12:31:49.503+00	32.0	36.81975	0.0	\N	\N	\N	\N	\N
266	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 12:36:51.075+00	32.0	48.90233	0.0	\N	\N	\N	\N	\N
267	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 12:51:54.043+00	32.0	60.62560	0.0	\N	\N	\N	\N	\N
268	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 12:57:01.321+00	64.0	148.10701	0.0	\N	\N	\N	\N	\N
269	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 13:01:58.197+00	32.0	66.95023	0.0	\N	\N	\N	\N	\N
270	29	(2.29450000000000021,48.8582222200000018)	2015-12-12 13:06:53.331+00	32.0	79.76540	0.0	\N	\N	\N	\N	\N
271	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 09:35:04.642+00	27.0	0.00000	0.0	\N	\N	\N	\N	\N
272	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 09:40:24.443+00	48.0	58.69737	0.0	\N	\N	\N	\N	\N
273	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 09:50:24.808+00	32.0	55.22186	0.0	\N	\N	\N	\N	\N
274	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 10:00:23.402+00	32.0	37.63217	0.0	\N	\N	\N	\N	\N
275	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 10:10:22.097+00	32.0	64.08286	0.0	\N	\N	\N	\N	\N
276	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 10:15:22.555+00	48.0	44.59169	0.0	\N	\N	\N	\N	\N
277	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 10:20:23.435+00	32.0	35.66340	0.0	\N	\N	\N	\N	\N
278	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 10:30:24.214+00	32.0	55.06210	0.0	\N	\N	\N	\N	\N
279	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 10:40:26.275+00	32.0	68.36991	0.0	\N	\N	\N	\N	\N
280	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 10:50:23.307+00	32.0	7.66711	0.0	\N	\N	\N	\N	\N
281	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 11:00:25.369+00	32.0	63.20491	0.0	\N	\N	\N	\N	\N
282	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 11:05:27.327+00	32.0	69.61248	0.0	\N	\N	\N	\N	\N
283	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 11:15:22.868+00	32.0	45.95520	12.7	\N	\N	\N	\N	\N
284	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 11:20:24.457+00	32.0	89.76048	12.5	\N	\N	\N	\N	\N
285	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 11:30:20.724+00	32.0	64.89808	11.4	\N	\N	\N	\N	\N
286	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 11:50:19.595+00	32.0	39.25189	7.9	\N	\N	\N	\N	\N
287	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 11:55:20.162+00	32.0	39.90793	17.8	\N	\N	\N	\N	\N
288	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 12:00:22.521+00	32.0	20.81333	15.2	\N	\N	\N	\N	\N
289	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 12:05:23.789+00	32.0	42.26985	21.7	\N	\N	\N	\N	\N
290	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 12:15:21.412+00	32.0	12.07505	0.0	\N	\N	\N	\N	\N
291	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 12:20:22.065+00	24.0	10.09207	0.0	\N	\N	\N	\N	\N
292	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 13:10:35.532+00	32.0	-22.49849	0.0	\N	\N	\N	\N	\N
293	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 13:20:31.842+00	48.0	27.18262	0.0	\N	\N	\N	\N	\N
294	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 13:30:34.363+00	48.0	25.73611	0.0	\N	\N	\N	\N	\N
295	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 13:40:34.503+00	32.0	9.32047	0.0	\N	\N	\N	\N	\N
296	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 13:55:32.659+00	32.0	-29.52485	0.0	\N	\N	\N	\N	\N
297	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 14:05:34.664+00	24.0	15.63666	0.0	\N	\N	\N	\N	\N
298	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 14:15:40.57+00	64.0	9.87296	0.0	\N	\N	\N	\N	\N
299	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 14:25:35.384+00	48.0	-7.78778	0.0	\N	\N	\N	\N	\N
300	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 14:30:35.537+00	64.0	21.98872	0.0	\N	\N	\N	\N	\N
301	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 14:45:35.307+00	64.0	34.55123	0.0	\N	\N	\N	\N	\N
302	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 14:50:36.154+00	64.0	43.26713	0.0	\N	\N	\N	\N	\N
303	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 15:20:34.33+00	48.0	-25.04693	0.0	\N	\N	\N	\N	\N
304	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 15:30:37.432+00	32.0	-11.98732	0.0	\N	\N	\N	\N	\N
305	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 15:40:21.795+00	12.0	2.85720	15.0	\N	\N	\N	\N	\N
306	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 15:45:31.094+00	48.0	31.17911	0.0	\N	\N	\N	\N	\N
307	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 15:55:30.413+00	24.0	104.62197	0.0	\N	\N	\N	\N	\N
308	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 16:00:35.681+00	24.0	259.90982	0.0	\N	\N	\N	\N	\N
309	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 16:25:34.511+00	24.0	106.15839	0.0	\N	\N	\N	\N	\N
310	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 16:35:37.486+00	24.0	70.08753	0.0	\N	\N	\N	\N	\N
311	29	(2.29450000000000021,48.8582222200000018)	2015-12-13 16:50:41.133+00	64.0	72.65694	0.0	\N	\N	\N	\N	\N
312	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:04:58.36+00	16.0	51.09192	0.0	\N	\N	\N	\N	\N
313	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:10:06.514+00	32.0	125.56415	0.0	\N	\N	\N	\N	\N
314	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:15:10.64+00	48.0	49.37104	11.9	\N	\N	\N	\N	\N
315	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:25:08.381+00	48.0	109.73980	0.0	\N	\N	\N	\N	\N
316	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:30:09.154+00	48.0	83.58111	0.0	\N	\N	\N	\N	\N
317	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:40:11.156+00	24.0	66.52248	8.5	\N	\N	\N	\N	\N
318	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:50:06.515+00	48.0	48.34206	0.0	\N	\N	\N	\N	\N
319	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:00:03.189+00	48.0	111.46332	30.3	\N	\N	\N	\N	\N
320	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:10:03.251+00	24.0	206.32573	30.9	\N	\N	\N	\N	\N
321	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:20:00.955+00	32.0	97.54374	22.7	\N	\N	\N	\N	\N
322	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:25:04.288+00	24.0	87.00727	30.9	\N	\N	\N	\N	\N
323	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:35:01.882+00	24.0	94.24696	30.0	\N	\N	\N	\N	\N
324	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:40:10.616+00	32.0	170.12395	26.9	\N	\N	\N	\N	\N
325	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:50:01.38+00	48.0	17.60809	16.3	\N	\N	\N	\N	\N
326	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:55:03.442+00	16.0	16.94053	0.0	\N	\N	\N	\N	\N
327	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 12:05:03.349+00	32.0	11.81109	0.0	\N	\N	\N	\N	\N
328	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 12:10:06.537+00	32.0	19.34044	0.0	\N	\N	\N	\N	\N
329	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 12:20:07.55+00	16.0	32.07724	0.0	\N	\N	\N	\N	\N
330	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:10:09.334+00	24.0	23.29288	0.0	\N	\N	\N	\N	\N
331	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:20:28.425+00	64.0	17.89340	0.0	\N	\N	\N	\N	\N
332	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:43:27.46+00	64.0	20.78518	0.0	\N	\N	\N	\N	\N
333	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:48:27.82+00	32.0	24.14507	0.0	\N	\N	\N	\N	\N
334	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:53:28.792+00	24.0	21.19114	0.0	\N	\N	\N	\N	\N
335	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:58:29.3+00	12.0	21.12493	1.5	\N	\N	\N	\N	\N
336	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:03:29.92+00	12.0	14.91000	1.5	\N	\N	\N	\N	\N
337	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:08:30.416+00	16.0	14.16052	3.4	\N	\N	\N	\N	\N
338	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:13:30.629+00	16.0	31.10615	31.4	\N	\N	\N	\N	\N
339	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:18:31.649+00	16.0	46.47290	26.4	\N	\N	\N	\N	\N
340	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:23:32.52+00	24.0	178.95087	26.1	\N	\N	\N	\N	\N
341	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:28:32.988+00	24.0	123.36554	25.1	\N	\N	\N	\N	\N
342	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:33:33.173+00	16.0	72.06099	25.7	\N	\N	\N	\N	\N
343	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:38:33.696+00	24.0	50.52177	26.4	\N	\N	\N	\N	\N
344	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:43:34+00	24.0	114.15440	27.0	\N	\N	\N	\N	\N
345	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:48:34.876+00	32.0	91.05626	25.8	\N	\N	\N	\N	\N
346	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:53:35.945+00	24.0	172.98328	27.4	\N	\N	\N	\N	\N
347	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:58:36.853+00	24.0	224.66151	27.5	\N	\N	\N	\N	\N
348	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:08:37.654+00	24.0	117.04468	27.4	\N	\N	\N	\N	\N
349	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:18:37.77+00	32.0	91.70271	27.1	\N	\N	\N	\N	\N
350	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:23:38.264+00	48.0	37.52547	19.6	\N	\N	\N	\N	\N
351	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:28:39.234+00	12.0	41.92637	6.0	\N	\N	\N	\N	\N
352	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:33:50.132+00	48.0	78.80940	24.4	\N	\N	\N	\N	\N
353	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:38:50.798+00	16.0	75.52290	22.5	\N	\N	\N	\N	\N
354	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:43:51.704+00	24.0	68.09069	10.9	\N	\N	\N	\N	\N
355	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:53:52.854+00	16.0	58.24796	5.3	\N	\N	\N	\N	\N
356	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:59:58.571+00	48.0	51.63332	5.0	\N	\N	\N	\N	\N
357	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 17:04:58.702+00	24.0	40.75135	10.2	\N	\N	\N	\N	\N
358	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 17:09:59.035+00	8.0	36.48204	0.0	\N	\N	\N	\N	\N
359	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 17:14:59.739+00	8.0	38.30668	0.0	\N	\N	\N	\N	\N
360	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:19:07.139+00	23.0	0.00000	0.0	\N	\N	\N	\N	\N
361	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:20:07.444+00	28.0	0.00000	0.0	\N	\N	\N	\N	\N
362	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:20:27.395+00	21.0	0.00000	0.0	\N	\N	\N	\N	\N
363	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:20:32.541+00	16.0	35.29953	0.0	\N	\N	\N	\N	\N
364	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:21:41.363+00	20.0	0.00000	0.0	\N	\N	\N	\N	\N
365	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:21:52.355+00	32.0	68.84431	0.0	\N	\N	\N	\N	\N
366	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:21:57.812+00	24.0	67.74007	0.0	\N	\N	\N	\N	\N
367	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:22:03.822+00	16.0	70.75603	0.0	\N	\N	\N	\N	\N
368	29	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:22:12.777+00	48.0	76.91284	2.0	\N	\N	\N	\N	\N
369	29	(2.29450000000000021,48.8582222200000018)	2015-12-15 22:24:30.075+00	23.0	0.00000	0.0	\N	\N	\N	\N	\N
370	29	(2.29450000000000021,48.8582222200000018)	2015-12-15 22:24:45.28+00	12.0	60.92278	0.0	\N	\N	\N	\N	\N
371	29	(2.29450000000000021,48.8582222200000018)	2015-12-15 22:25:01.244+00	12.0	51.82348	0.0	\N	\N	\N	\N	\N
372	29	(2.29450000000000021,48.8582222200000018)	2015-12-15 22:25:16.248+00	12.0	52.28553	0.0	\N	\N	\N	\N	\N
373	29	(2.29450000000000021,48.8582222200000018)	2015-12-15 22:25:32.216+00	12.0	51.92226	0.0	\N	\N	\N	\N	\N
374	29	(2.29450000000000021,48.8582222200000018)	2015-12-16 17:07:38.382+00	42.0	0.00000	0.0	0.00000	\N	\N	\N	\N
375	29	(2.29450000000000021,48.8582222200000018)	2015-12-16 17:07:53.56+00	12.0	35.75677	0.0	0.00000	\N	\N	\N	\N
376	29	(2.29450000000000021,48.8582222200000018)	2015-12-16 17:24:51.349+00	30.0	0.00000	0.0	0.00000	\N	\N	\N	\N
377	29	(2.29450000000000021,48.8582222200000018)	2015-12-16 20:14:59.351+00	12.0	43.61799	0.0	0.00000	\N	\N	\N	\N
378	29	(2.29450000000000021,48.8582222200000018)	2015-12-17 19:39:15.655+00	27.0	0.00000	0.0	0.00000	\N	\N	\N	\N
379	29	(2.29450000000000021,48.8582222200000018)	2015-12-17 19:41:04.928+00	12.0	42.89621	0.0	0.00000	\N	\N	\N	\N
380	29	(2.29450000000000021,48.8582222200000018)	2015-12-17 19:41:38.748+00	24.0	52.74421	0.0	0.00000	\N	\N	\N	\N
381	29	(2.29450000000000021,48.8582222200000018)	2015-12-17 19:42:40.035+00	25.0	0.00000	0.0	0.00000	\N	\N	\N	\N
382	29	(2.29450000000000021,48.8582222200000018)	2015-12-18 21:37:39.17+00	36.0	0.00000	0.0	0.00000	\N	\N	\N	\N
383	29	(2.29450000000000021,48.8582222200000018)	2015-12-18 21:38:09.404+00	8.0	59.28322	0.0	0.00000	\N	\N	\N	\N
384	29	(2.29450000000000021,48.8582222200000018)	2015-12-18 21:38:40.383+00	6.0	58.76510	0.0	0.00000	\N	\N	\N	\N
385	29	(2.29450000000000021,48.8582222200000018)	2015-12-19 08:28:21.031+00	32.0	1.46047	0.0	0.00000	\N	\N	\N	\N
386	29	(2.29450000000000021,48.8582222200000018)	2015-12-19 21:07:38.239+00	42.0	0.00000	0.0	0.00000	\N	\N	\N	\N
387	29	(2.29450000000000021,48.8582222200000018)	2015-12-19 22:17:13.534+00	12.0	45.46613	0.0	0.00000	\N	\N	\N	\N
388	29	(2.29450000000000021,48.8582222200000018)	2015-12-19 22:22:14.463+00	6.0	44.86626	0.0	0.00000	\N	\N	\N	\N
389	29	(2.29450000000000021,48.8582222200000018)	2015-12-19 22:27:14.474+00	6.0	46.84125	0.0	0.00000	\N	\N	\N	\N
390	29	(2.29450000000000021,48.8582222200000018)	2015-12-20 09:58:58.122+00	48.0	35.73564	0.0	0.00000	\N	\N	\N	\N
391	29	(2.29450000000000021,48.8582222200000018)	2015-12-20 10:02:31.883+00	22.0	0.00000	0.0	0.00000	\N	\N	\N	\N
392	29	(2.29450000000000021,48.8582222200000018)	2015-12-20 10:02:47.15+00	12.0	64.94439	0.0	0.00000	\N	\N	\N	\N
393	29	(2.29450000000000021,48.8582222200000018)	2015-12-20 10:03:03.144+00	8.0	56.78054	0.0	0.00000	\N	\N	\N	\N
394	29	(2.29450000000000021,48.8582222200000018)	2015-12-20 10:03:19.131+00	8.0	54.96450	0.0	0.00000	\N	\N	\N	\N
395	29	(2.29450000000000021,48.8582222200000018)	2015-12-20 10:05:39.996+00	26.0	0.00000	0.0	0.00000	\N	\N	\N	\N
396	29	(2.29450000000000021,48.8582222200000018)	2015-12-20 10:05:55.359+00	24.0	23.36083	0.0	0.00000	\N	\N	\N	\N
397	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:31:00.269+00	12.0	59.52934	0.0	0.00000	\N	\N	\N	\N
398	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:31:15.855+00	8.0	67.82288	0.0	0.00000	\N	\N	\N	\N
399	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:31:30.859+00	12.0	75.93587	0.0	0.00000	\N	\N	\N	\N
400	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:31:46.845+00	12.0	75.96442	0.0	0.00000	\N	\N	\N	\N
401	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:32:02.844+00	12.0	76.00072	0.0	0.00000	\N	\N	\N	\N
402	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:32:18.845+00	8.0	75.93427	0.0	0.00000	\N	\N	\N	\N
403	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:32:33.85+00	8.0	75.76672	0.0	0.00000	\N	\N	\N	\N
404	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:32:48.858+00	8.0	75.50338	0.0	0.00000	\N	\N	\N	\N
405	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:33:04.83+00	12.0	75.03023	0.0	0.00000	\N	\N	\N	\N
406	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:33:19.857+00	6.0	74.45409	0.0	0.00000	\N	\N	\N	\N
407	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:33:35.85+00	8.0	73.76765	0.0	0.00000	\N	\N	\N	\N
408	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:33:50.862+00	8.0	73.16711	0.0	0.00000	\N	\N	\N	\N
409	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:34:05.867+00	8.0	72.67265	0.0	0.00000	\N	\N	\N	\N
410	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:34:21.843+00	12.0	72.32136	0.0	0.00000	\N	\N	\N	\N
411	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:34:36.848+00	8.0	72.00974	0.0	0.00000	\N	\N	\N	\N
412	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 16:34:52.859+00	8.0	71.58588	0.0	0.00000	\N	\N	\N	\N
413	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 18:16:23.32+00	32.0	56.18089	0.0	0.00000	\N	\N	\N	\N
414	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 18:21:40.283+00	32.0	92.94215	0.0	0.00000	\N	\N	\N	\N
415	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 18:26:41.484+00	32.0	20.95719	0.0	0.00000	\N	\N	\N	\N
416	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 18:36:41.518+00	24.0	-21.08389	0.0	0.00000	\N	\N	\N	\N
417	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 18:46:42.527+00	32.0	91.37353	0.0	0.00000	\N	\N	\N	\N
418	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 18:56:40.473+00	32.0	60.97258	0.0	0.00000	\N	\N	\N	\N
419	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 19:11:40.209+00	48.0	59.03462	0.0	0.00000	\N	\N	\N	\N
420	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 19:16:40.523+00	48.0	58.00333	0.0	0.00000	\N	\N	\N	\N
421	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 19:26:40.005+00	24.0	48.13316	0.0	0.00000	\N	\N	\N	\N
422	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 19:31:42.828+00	16.0	66.78339	0.0	0.00000	\N	\N	\N	\N
423	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 19:36:43.093+00	32.0	1.15085	0.0	0.00000	\N	\N	\N	\N
424	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 19:41:44.97+00	24.0	-18.28673	0.0	0.00000	\N	\N	\N	\N
425	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 19:51:48.991+00	48.0	95.00512	0.0	0.00000	\N	\N	\N	\N
426	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 20:11:44.446+00	32.0	96.63160	0.0	0.00000	\N	\N	\N	\N
427	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 20:16:46.23+00	48.0	64.96918	0.0	0.00000	\N	\N	\N	\N
428	29	(2.29450000000000021,48.8582222200000018)	2015-12-22 20:21:48.654+00	48.0	57.84803	0.0	0.00000	\N	\N	\N	\N
429	29	(2.29450000000000021,48.8582222200000018)	2015-12-23 14:11:33.957+00	8.0	59.62280	0.0	0.00000	\N	\N	\N	\N
430	29	(2.29450000000000021,48.8582222200000018)	2015-12-23 14:46:49.497+00	32.0	46.40158	0.0	0.00000	\N	\N	\N	\N
431	29	(2.29450000000000021,48.8582222200000018)	2015-12-23 14:51:52.435+00	32.0	55.47532	0.0	0.00000	\N	\N	\N	\N
432	29	(2.29450000000000021,48.8582222200000018)	2015-12-23 14:54:15.425+00	32.0	24.64706	0.0	0.00000	\N	\N	\N	\N
433	29	(2.29450000000000021,48.8582222200000018)	2015-12-24 17:47:27.523+00	33.0	0.00000	0.0	0.00000	\N	\N	\N	\N
434	29	(2.29450000000000021,48.8582222200000018)	2015-12-24 17:48:23.141+00	24.0	-61.01693	0.0	0.00000	\N	\N	\N	\N
435	29	(2.29450000000000021,48.8582222200000018)	2015-12-24 17:48:53.189+00	48.0	64.97853	0.0	0.00000	\N	\N	\N	\N
436	29	(2.29450000000000021,48.8582222200000018)	2015-12-24 17:49:24.14+00	12.0	58.09876	0.0	0.00000	\N	\N	\N	\N
437	29	(2.29450000000000021,48.8582222200000018)	2015-12-24 17:49:56.329+00	32.0	2.99484	0.0	0.00000	\N	\N	\N	\N
438	29	(2.29450000000000021,48.8582222200000018)	2015-12-24 17:50:54.167+00	48.0	65.26011	0.0	0.00000	\N	\N	\N	\N
439	29	(2.29450000000000021,48.8582222200000018)	2015-12-24 17:51:51.283+00	28.4	0.00000	0.0	0.00000	\N	\N	\N	\N
440	29	(2.29450000000000021,48.8582222200000018)	2015-12-24 17:52:39.669+00	26.0	0.00000	0.0	0.00000	\N	\N	\N	\N
441	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:35:31.714+00	22.0	0.00000	0.0	0.00000	\N	\N	\N	\N
442	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:36:49.506+00	48.0	28.66817	0.0	0.00000	\N	\N	\N	\N
443	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:37:50.975+00	32.0	-4.76729	0.0	0.00000	\N	\N	\N	\N
444	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:38:50.552+00	48.0	41.59878	0.0	0.00000	\N	\N	\N	\N
445	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:39:47.665+00	32.0	86.95091	0.0	0.00000	\N	\N	\N	\N
446	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:40:48.109+00	16.0	66.32393	0.0	0.00000	\N	\N	\N	\N
447	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:41:18.218+00	16.0	58.59505	0.0	0.00000	\N	\N	\N	\N
448	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:42:15.62+00	24.0	46.49828	0.0	0.00000	\N	\N	\N	\N
449	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:42:46.191+00	32.0	67.85534	0.0	0.00000	\N	\N	\N	\N
450	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:43:18.14+00	16.0	57.02107	0.0	0.00000	\N	\N	\N	\N
451	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:44:15.299+00	48.0	83.80691	0.0	0.00000	\N	\N	\N	\N
452	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:44:47.973+00	24.0	96.44309	0.0	0.00000	\N	\N	\N	\N
453	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:45:45.063+00	32.0	52.93426	0.0	0.00000	\N	\N	\N	\N
454	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:46:16.04+00	32.0	75.86124	0.0	0.00000	\N	\N	\N	\N
455	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:47:13.587+00	32.0	63.52615	0.0	0.00000	\N	\N	\N	\N
456	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:47:44.513+00	16.0	83.49238	0.0	0.00000	\N	\N	\N	\N
457	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:48:46.357+00	32.0	69.47086	0.0	0.00000	\N	\N	\N	\N
458	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:49:45.125+00	32.0	75.41890	0.0	0.00000	\N	\N	\N	\N
459	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:50:16.395+00	48.0	31.37599	0.0	0.00000	\N	\N	\N	\N
460	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:50:48.389+00	32.0	51.64155	0.0	0.00000	\N	\N	\N	\N
461	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:51:48.614+00	24.0	73.57741	0.0	0.00000	\N	\N	\N	\N
462	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:52:48+00	24.0	34.15645	0.0	0.00000	\N	\N	\N	\N
463	29	(2.29450000000000021,48.8582222200000018)	2015-12-25 12:53:19.153+00	24.0	68.59747	0.0	0.00000	\N	\N	\N	\N
464	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:10:41.908+00	30.0	0.00000	0.0	0.00000	\N	\N	\N	\N
465	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:12:54.195+00	32.0	61.49048	0.0	0.00000	\N	\N	\N	\N
466	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:18:52.077+00	48.0	51.05518	0.0	0.00000	\N	\N	\N	\N
467	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:20:55.424+00	32.0	46.82989	0.0	0.00000	\N	\N	\N	\N
468	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:24:53.012+00	48.0	61.21843	0.0	0.00000	\N	\N	\N	\N
469	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:30:55.512+00	32.0	57.95098	0.0	0.00000	\N	\N	\N	\N
470	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:34:54.31+00	48.0	54.45792	0.0	0.00000	\N	\N	\N	\N
471	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:42:55.297+00	48.0	8.35631	0.0	0.00000	\N	\N	\N	\N
472	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:44:57.306+00	48.0	37.73977	0.0	0.00000	\N	\N	\N	\N
473	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:47:03.156+00	24.0	41.68557	0.0	0.00000	\N	\N	\N	\N
474	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:52:55.925+00	48.0	61.45026	0.0	0.00000	\N	\N	\N	\N
475	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 11:56:56.181+00	32.0	47.46818	0.0	0.00000	\N	\N	\N	\N
476	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:00:56.466+00	32.0	57.52032	0.0	0.00000	\N	\N	\N	\N
477	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:06:56.269+00	8.0	48.48909	0.0	0.00000	\N	\N	\N	\N
478	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:10:54.362+00	32.0	39.61931	0.0	0.00000	\N	\N	\N	\N
479	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:14:54.321+00	48.0	32.17470	0.0	0.00000	\N	\N	\N	\N
480	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:18:52.278+00	32.0	38.46262	0.0	0.00000	\N	\N	\N	\N
481	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:20:52.506+00	24.0	66.82124	0.0	0.00000	\N	\N	\N	\N
482	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:22:53.686+00	32.0	44.62138	0.0	0.00000	\N	\N	\N	\N
483	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:26:54.293+00	24.0	87.73309	0.0	0.00000	\N	\N	\N	\N
484	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:30:52.174+00	32.0	41.60340	0.0	0.00000	\N	\N	\N	\N
485	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:32:54.589+00	48.0	47.86173	0.0	0.00000	\N	\N	\N	\N
486	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:40:52.259+00	24.0	60.40864	0.0	0.00000	\N	\N	\N	\N
487	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:42:52.299+00	32.0	56.73466	0.0	0.00000	\N	\N	\N	\N
488	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:44:52.677+00	32.0	43.75743	0.0	0.00000	\N	\N	\N	\N
489	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:46:53.997+00	16.0	72.95448	0.0	0.00000	\N	\N	\N	\N
490	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:50:52.06+00	16.0	56.58908	0.0	0.00000	\N	\N	\N	\N
491	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:52:52.251+00	32.0	44.38452	0.0	0.00000	\N	\N	\N	\N
492	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:54:52.422+00	24.0	49.63868	0.0	0.00000	\N	\N	\N	\N
493	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 12:58:52.397+00	24.0	51.17323	0.0	0.00000	\N	\N	\N	\N
494	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:02:53.008+00	32.0	91.43155	0.0	0.00000	\N	\N	\N	\N
495	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:08:52.15+00	32.0	78.74835	0.0	0.00000	\N	\N	\N	\N
496	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:12:52.183+00	16.0	46.42150	0.0	0.00000	\N	\N	\N	\N
497	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:16:52.211+00	48.0	72.36871	0.0	0.00000	\N	\N	\N	\N
498	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:18:52.429+00	48.0	20.82112	0.0	0.00000	\N	\N	\N	\N
499	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:20:54.528+00	48.0	41.50605	10.7	69.95966	\N	\N	\N	\N
500	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:24:52.586+00	48.0	72.64179	0.0	0.00000	\N	\N	\N	\N
501	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:28:55.374+00	48.0	39.97746	0.0	0.00000	\N	\N	\N	\N
502	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:30:57.193+00	16.0	44.70972	0.0	0.00000	\N	\N	\N	\N
503	29	(2.29450000000000021,48.8582222200000018)	2015-12-26 13:34:56.358+00	12.0	48.06781	0.0	0.00000	\N	\N	\N	\N
504	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 18:58:34.133+00	22.0	0.00000	0.0	0.00000	\N	\N	\N	\N
505	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 18:58:49.27+00	16.0	60.68766	0.0	0.00000	\N	\N	\N	\N
506	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 18:59:04.3+00	12.0	63.45384	0.0	0.00000	\N	\N	\N	\N
507	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 18:59:19.357+00	12.0	62.04665	0.0	0.00000	\N	\N	\N	\N
508	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 18:59:35.338+00	12.0	59.71859	0.0	0.00000	\N	\N	\N	\N
509	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 18:59:51.336+00	6.0	58.86255	0.0	0.00000	\N	\N	\N	\N
510	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:00:06.415+00	6.0	56.75504	0.0	0.00000	\N	\N	\N	\N
511	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:00:22.631+00	8.0	55.17710	2.9	37.29703	\N	\N	\N	\N
512	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:00:38.233+00	12.0	52.25099	3.2	55.66007	\N	\N	\N	\N
513	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:00:53.915+00	8.0	44.98589	12.9	44.96957	\N	\N	\N	\N
514	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:01:10.214+00	8.0	49.85167	7.2	140.19835	\N	\N	\N	\N
515	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:01:25.946+00	8.0	50.02886	9.9	160.66223	\N	\N	\N	\N
516	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:01:42.58+00	12.0	50.34922	11.8	135.72716	\N	\N	\N	\N
517	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:01:58.128+00	12.0	42.33200	12.8	165.12656	\N	\N	\N	\N
518	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:02:13.242+00	12.0	38.89161	8.3	87.55173	\N	\N	\N	\N
519	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:02:28.254+00	12.0	35.65596	14.3	75.60296	\N	\N	\N	\N
520	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:02:43.331+00	8.0	44.74694	12.0	74.01862	\N	\N	\N	\N
521	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:02:59.264+00	8.0	53.31741	6.9	102.88773	\N	\N	\N	\N
522	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:03:15.286+00	8.0	49.78724	12.3	94.52775	\N	\N	\N	\N
523	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:03:31.211+00	8.0	41.27602	10.2	47.78511	\N	\N	\N	\N
524	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:03:46.948+00	12.0	39.57319	14.6	18.74424	\N	\N	\N	\N
525	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:04:01.966+00	12.0	35.66655	14.3	16.37471	\N	\N	\N	\N
526	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:04:17.224+00	16.0	25.47463	10.2	172.61760	\N	\N	\N	\N
527	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:04:32.32+00	12.0	25.93860	18.9	131.27495	\N	\N	\N	\N
528	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:04:48.311+00	12.0	23.74626	22.7	75.76370	\N	\N	\N	\N
529	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:05:04.268+00	12.0	19.83653	21.9	61.59423	\N	\N	\N	\N
530	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:05:20.293+00	12.0	28.74027	19.1	63.53622	\N	\N	\N	\N
531	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:05:51.306+00	12.0	21.61056	15.0	98.28293	\N	\N	\N	\N
532	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:06:06.335+00	8.0	27.16256	19.3	79.00328	\N	\N	\N	\N
533	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:06:22.556+00	12.0	29.39015	18.5	73.39742	\N	\N	\N	\N
534	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:06:38.301+00	8.0	33.49453	16.1	62.79849	\N	\N	\N	\N
535	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:06:53.342+00	8.0	30.22892	15.8	50.60549	\N	\N	\N	\N
536	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:07:09.29+00	6.0	28.85266	0.0	50.75093	\N	\N	\N	\N
537	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:07:24.302+00	8.0	21.14451	10.9	62.42473	\N	\N	\N	\N
538	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:07:40.274+00	8.0	25.86852	12.4	67.27278	\N	\N	\N	\N
539	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:07:56.293+00	12.0	28.79032	14.0	35.21406	\N	\N	\N	\N
540	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:08:12.297+00	8.0	28.35691	10.7	204.87569	\N	\N	\N	\N
541	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:08:28.332+00	16.0	28.48543	6.0	257.91595	\N	\N	\N	\N
542	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:08:44.326+00	12.0	27.40632	8.3	231.17052	\N	\N	\N	\N
543	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:09:00.416+00	12.0	28.01915	4.8	226.13675	\N	\N	\N	\N
544	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:09:16.287+00	8.0	27.83067	0.0	44.78188	\N	\N	\N	\N
545	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:09:31.333+00	8.0	27.87499	0.0	30.24948	\N	\N	\N	\N
546	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:09:47.276+00	6.0	27.88807	0.0	30.24948	\N	\N	\N	\N
547	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:10:03.31+00	8.0	27.90675	0.0	30.24948	\N	\N	\N	\N
548	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:10:19.279+00	16.0	28.04763	0.0	342.08610	\N	\N	\N	\N
549	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:10:35.233+00	16.0	27.46269	4.7	121.69164	\N	\N	\N	\N
550	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:10:50.33+00	24.0	28.07331	6.6	55.70721	\N	\N	\N	\N
551	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:11:06.342+00	12.0	26.82648	3.0	63.58348	\N	\N	\N	\N
552	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:11:22.325+00	12.0	25.70874	10.1	29.10553	\N	\N	\N	\N
553	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:11:38.365+00	16.0	25.99204	9.6	243.23288	\N	\N	\N	\N
554	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:11:54.35+00	24.0	26.99503	9.3	251.15445	\N	\N	\N	\N
555	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:12:10.325+00	16.0	26.15957	0.0	239.10196	\N	\N	\N	\N
556	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:12:26.196+00	16.0	25.65520	9.0	245.12622	\N	\N	\N	\N
557	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:12:42.287+00	16.0	25.45186	5.1	240.38004	\N	\N	\N	\N
558	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:12:57.315+00	24.0	26.10557	9.3	233.88603	\N	\N	\N	\N
559	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:13:13.526+00	12.0	23.98460	0.0	203.47646	\N	\N	\N	\N
560	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:13:29.167+00	24.0	27.53084	15.9	243.75533	\N	\N	\N	\N
561	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:13:44.45+00	24.0	24.10330	19.8	250.48195	\N	\N	\N	\N
562	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:14:00.32+00	48.0	28.44375	16.8	252.91609	\N	\N	\N	\N
563	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:14:16.281+00	32.0	28.22846	7.5	235.32870	\N	\N	\N	\N
564	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:14:47.156+00	32.0	30.57108	6.4	259.05948	\N	\N	\N	\N
565	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:15:02.305+00	24.0	29.90948	15.8	253.28413	\N	\N	\N	\N
566	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:15:18.292+00	16.0	32.19093	20.1	243.99867	\N	\N	\N	\N
567	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:15:33.323+00	24.0	32.48703	20.2	244.07164	\N	\N	\N	\N
568	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:15:49.284+00	24.0	35.02841	20.4	271.57272	\N	\N	\N	\N
569	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:16:04.288+00	16.0	33.78060	17.0	320.37485	\N	\N	\N	\N
570	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:16:20.386+00	16.0	32.49971	8.6	258.74924	\N	\N	\N	\N
571	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:16:36.14+00	32.0	38.53527	14.9	198.79997	\N	\N	\N	\N
572	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:16:51.32+00	16.0	46.87510	7.9	195.76926	\N	\N	\N	\N
573	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:17:07.32+00	16.0	46.65443	11.8	273.37045	\N	\N	\N	\N
574	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:17:23.288+00	16.0	52.38820	12.0	274.39954	\N	\N	\N	\N
575	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:17:38.319+00	16.0	56.95247	11.2	270.36542	\N	\N	\N	\N
576	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:17:53.34+00	24.0	56.76741	12.8	252.48685	\N	\N	\N	\N
577	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:18:09.228+00	32.0	51.52308	11.8	252.65186	\N	\N	\N	\N
578	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:18:24.275+00	16.0	44.47821	13.3	305.89627	\N	\N	\N	\N
579	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:18:40.282+00	16.0	47.83183	11.7	8.00156	\N	\N	\N	\N
580	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:18:56.256+00	48.0	55.54773	8.6	258.31003	\N	\N	\N	\N
581	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:19:11.325+00	24.0	57.39480	11.9	342.92514	\N	\N	\N	\N
582	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:19:27.371+00	12.0	56.66677	8.0	268.48404	\N	\N	\N	\N
583	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:19:43.355+00	24.0	54.73785	12.4	235.77750	\N	\N	\N	\N
584	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:19:59.215+00	12.0	53.35223	2.7	175.58206	\N	\N	\N	\N
585	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:20:14.32+00	12.0	53.18863	0.0	232.65341	\N	\N	\N	\N
586	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:20:30.34+00	6.0	53.13678	0.0	213.50432	\N	\N	\N	\N
587	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:20:46.301+00	4.0	52.73538	0.0	213.50432	\N	\N	\N	\N
588	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:21:17.23+00	6.0	52.36872	0.0	213.50432	\N	\N	\N	\N
589	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:21:33.2+00	4.0	52.17041	0.0	213.50432	\N	\N	\N	\N
590	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:21:48.67+00	8.0	52.16385	0.0	213.50432	\N	\N	\N	\N
591	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:22:04.255+00	8.0	52.19759	0.0	213.50432	\N	\N	\N	\N
592	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:22:19.395+00	8.0	52.23678	0.0	213.50432	\N	\N	\N	\N
593	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:22:35.347+00	8.0	52.43679	0.0	213.50432	\N	\N	\N	\N
594	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:22:51.341+00	8.0	52.54030	0.0	213.50432	\N	\N	\N	\N
595	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:23:06.41+00	12.0	52.75093	0.0	213.50432	\N	\N	\N	\N
596	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:23:21.505+00	8.0	52.80119	0.0	213.50432	\N	\N	\N	\N
597	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:23:37.428+00	12.0	52.83962	0.0	213.50432	\N	\N	\N	\N
598	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:23:53.266+00	8.0	52.82950	0.0	213.50432	\N	\N	\N	\N
599	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:24:08.444+00	8.0	52.70419	0.0	213.50432	\N	\N	\N	\N
600	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:24:24.211+00	12.0	52.63033	0.0	213.50432	\N	\N	\N	\N
601	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:24:39.378+00	8.0	52.55034	0.0	213.50432	\N	\N	\N	\N
602	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:24:55.466+00	8.0	51.67596	0.0	130.26242	\N	\N	\N	\N
603	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:25:11.426+00	12.0	50.87975	0.0	174.55066	\N	\N	\N	\N
604	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:25:27.386+00	12.0	51.23303	0.0	130.62035	\N	\N	\N	\N
605	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:25:43.328+00	8.0	50.88473	0.0	282.67868	\N	\N	\N	\N
606	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:25:58.38+00	12.0	50.60935	0.0	273.56146	\N	\N	\N	\N
607	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:26:13.404+00	16.0	50.68444	0.0	128.82123	\N	\N	\N	\N
608	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:26:29.311+00	32.0	50.76697	0.0	128.82123	\N	\N	\N	\N
609	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:26:44.345+00	12.0	50.42823	0.0	128.82123	\N	\N	\N	\N
610	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:26:59.424+00	12.0	50.05824	0.0	128.82123	\N	\N	\N	\N
611	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:27:15.371+00	16.0	50.03130	0.0	128.82123	\N	\N	\N	\N
612	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:27:31.39+00	12.0	50.10886	0.0	128.82123	\N	\N	\N	\N
613	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:27:46.474+00	12.0	50.20060	0.0	128.82123	\N	\N	\N	\N
614	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:28:02.245+00	12.0	50.01968	0.0	128.82123	\N	\N	\N	\N
615	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:28:17.284+00	8.0	49.88567	0.0	128.82123	\N	\N	\N	\N
616	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:28:32.399+00	8.0	49.85743	0.0	128.82123	\N	\N	\N	\N
617	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:28:48.23+00	16.0	49.91802	0.0	128.82123	\N	\N	\N	\N
618	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:29:03.405+00	8.0	49.89310	0.0	128.82123	\N	\N	\N	\N
619	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:29:19.463+00	8.0	50.10871	0.0	128.82123	\N	\N	\N	\N
620	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:29:35.426+00	8.0	50.46055	0.0	128.82123	\N	\N	\N	\N
621	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:29:51.284+00	24.0	51.12246	0.0	128.82123	\N	\N	\N	\N
622	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:30:06.299+00	16.0	52.20332	2.9	234.32622	\N	\N	\N	\N
623	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:30:21.3+00	12.0	51.68419	2.0	177.58028	\N	\N	\N	\N
624	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:30:36.321+00	24.0	43.37743	0.0	203.40420	\N	\N	\N	\N
625	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:30:52.273+00	16.0	44.01061	1.8	186.66296	\N	\N	\N	\N
626	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:31:07.37+00	12.0	44.03626	0.0	186.66296	\N	\N	\N	\N
627	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:31:22.62+00	12.0	44.15576	0.0	186.66296	\N	\N	\N	\N
628	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:31:38.353+00	12.0	44.58693	0.0	186.66296	\N	\N	\N	\N
629	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:31:54.315+00	12.0	44.90333	0.0	186.66296	\N	\N	\N	\N
630	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:32:09.351+00	12.0	44.93216	0.0	186.66296	\N	\N	\N	\N
631	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:32:24.356+00	12.0	44.93433	0.0	186.66296	\N	\N	\N	\N
632	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:32:40.147+00	16.0	45.49559	3.3	161.05066	\N	\N	\N	\N
633	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:32:55.363+00	24.0	47.59728	5.5	170.79306	\N	\N	\N	\N
634	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:33:11.636+00	16.0	43.35880	2.8	173.93713	\N	\N	\N	\N
635	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:33:27.385+00	16.0	38.01938	0.0	168.47680	\N	\N	\N	\N
636	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:33:43.35+00	16.0	37.98977	0.0	168.47680	\N	\N	\N	\N
637	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:33:59.267+00	16.0	37.91713	0.0	139.15237	\N	\N	\N	\N
638	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:34:14.348+00	12.0	38.69164	0.0	137.01091	\N	\N	\N	\N
639	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:34:30.203+00	16.0	38.78814	0.0	137.01091	\N	\N	\N	\N
640	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:34:45.246+00	8.0	38.94848	0.0	137.01091	\N	\N	\N	\N
641	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:35:00.52+00	8.0	39.12641	0.0	137.01091	\N	\N	\N	\N
642	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:35:16.257+00	12.0	38.94560	0.0	137.01091	\N	\N	\N	\N
643	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:35:31.33+00	12.0	38.86179	0.0	137.01091	\N	\N	\N	\N
644	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:35:47.314+00	12.0	38.69490	0.0	137.01091	\N	\N	\N	\N
645	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:36:03.31+00	8.0	38.84739	0.0	137.01091	\N	\N	\N	\N
646	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:36:19.328+00	8.0	39.13962	0.0	137.01091	\N	\N	\N	\N
647	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:36:34.349+00	12.0	39.41392	0.0	137.01091	\N	\N	\N	\N
648	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:36:50.256+00	12.0	39.49723	0.0	137.01091	\N	\N	\N	\N
649	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:37:05.335+00	8.0	39.60170	0.0	137.01091	\N	\N	\N	\N
650	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:37:21.341+00	8.0	39.71822	0.0	137.01091	\N	\N	\N	\N
651	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:37:36.372+00	8.0	40.13572	0.0	137.01091	\N	\N	\N	\N
652	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:37:52.384+00	16.0	40.35423	0.0	137.01091	\N	\N	\N	\N
653	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:38:08.308+00	8.0	40.77082	0.0	137.01091	\N	\N	\N	\N
654	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:38:23.436+00	12.0	41.39934	0.0	137.01091	\N	\N	\N	\N
655	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:38:39.307+00	16.0	41.89282	0.0	137.01091	\N	\N	\N	\N
656	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:38:54.368+00	16.0	42.40798	0.0	137.01091	\N	\N	\N	\N
657	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:39:10.263+00	16.0	42.79907	0.0	137.01091	\N	\N	\N	\N
658	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:39:26.304+00	12.0	43.33110	0.0	137.01091	\N	\N	\N	\N
659	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:39:41.369+00	12.0	43.45848	0.0	137.01091	\N	\N	\N	\N
660	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:39:57.37+00	8.0	43.96554	0.0	137.01091	\N	\N	\N	\N
661	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:40:12.419+00	8.0	44.79893	0.0	137.01091	\N	\N	\N	\N
662	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:40:28.177+00	8.0	45.68182	0.0	137.01091	\N	\N	\N	\N
663	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:40:43.288+00	8.0	46.31176	0.0	137.01091	\N	\N	\N	\N
664	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:40:58.348+00	12.0	46.86580	0.0	137.01091	\N	\N	\N	\N
665	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:41:14.298+00	12.0	46.90165	0.0	137.01091	\N	\N	\N	\N
666	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:41:29.35+00	8.0	46.85236	0.0	137.01091	\N	\N	\N	\N
667	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:41:45.342+00	12.0	46.50966	0.0	137.01091	\N	\N	\N	\N
668	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:42:00.56+00	12.0	45.74682	0.0	137.01091	\N	\N	\N	\N
669	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:42:16.345+00	12.0	45.02172	0.0	137.01091	\N	\N	\N	\N
670	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:42:32.388+00	12.0	45.04919	0.0	137.01091	\N	\N	\N	\N
671	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:42:48.368+00	12.0	45.34910	0.0	137.01091	\N	\N	\N	\N
672	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:43:03.552+00	16.0	45.86478	0.0	137.01091	\N	\N	\N	\N
673	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:43:19.338+00	12.0	46.16041	0.0	137.01091	\N	\N	\N	\N
674	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:43:34.434+00	12.0	46.71217	0.0	137.01091	\N	\N	\N	\N
675	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:43:50.375+00	8.0	47.07751	0.0	137.01091	\N	\N	\N	\N
676	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:44:05.404+00	12.0	47.55789	0.0	137.01091	\N	\N	\N	\N
677	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:44:21.381+00	16.0	48.41185	0.0	137.01091	\N	\N	\N	\N
678	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:44:37.339+00	16.0	48.72405	0.0	137.01091	\N	\N	\N	\N
679	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:44:52.361+00	16.0	48.87465	0.0	137.01091	\N	\N	\N	\N
680	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:45:07.421+00	16.0	48.75277	0.0	137.01091	\N	\N	\N	\N
681	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:45:22.451+00	8.0	48.70481	0.0	137.01091	\N	\N	\N	\N
682	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:45:38.467+00	6.0	48.48373	0.0	137.01091	\N	\N	\N	\N
683	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:45:53.58+00	8.0	48.07052	0.0	137.01091	\N	\N	\N	\N
684	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:46:09.415+00	8.0	47.48498	0.0	137.01091	\N	\N	\N	\N
685	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:46:25.397+00	12.0	46.71521	0.0	351.83124	\N	\N	\N	\N
686	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:46:40.595+00	12.0	49.62165	6.7	104.03716	\N	\N	\N	\N
687	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:46:56.4+00	16.0	65.34327	0.0	97.43012	\N	\N	\N	\N
688	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:47:11.415+00	24.0	66.46587	0.0	92.91924	\N	\N	\N	\N
689	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:47:27.325+00	32.0	55.69388	25.2	316.50378	\N	\N	\N	\N
690	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:47:45.491+00	48.0	96.01053	19.4	318.69420	\N	\N	\N	\N
691	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:48:01.189+00	48.0	66.61261	0.0	317.03530	\N	\N	\N	\N
692	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:48:16.361+00	48.0	74.72964	9.0	323.94055	\N	\N	\N	\N
693	29	(2.29450000000000021,48.8582222200000018)	2015-12-27 19:49:37.34+00	24.0	0.00000	0.0	0.00000	\N	\N	\N	\N
694	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:03:34.778+00	32.0	43.89668	0.0	0.00000	\N	\N	\N	\N
695	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:05:56.517+00	48.0	47.73327	0.0	0.00000	\N	\N	\N	\N
696	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:09:57.725+00	32.0	22.69975	0.0	0.00000	\N	\N	\N	\N
697	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:11:59.296+00	32.0	-14.82987	0.0	0.00000	\N	\N	\N	\N
698	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:15:57.461+00	32.0	44.07845	0.0	0.00000	\N	\N	\N	\N
699	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:19:59.522+00	32.0	16.56501	0.0	0.00000	\N	\N	\N	\N
700	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:23:57.438+00	32.0	85.30985	0.0	0.00000	\N	\N	\N	\N
701	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:25:59.971+00	32.0	37.33904	0.0	0.00000	\N	\N	\N	\N
702	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:29:57.544+00	32.0	96.42571	0.0	0.00000	\N	\N	\N	\N
703	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:34:00.308+00	32.0	62.08532	0.0	0.00000	\N	\N	\N	\N
704	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:37:59.716+00	32.0	0.09263	0.0	0.00000	\N	\N	\N	\N
705	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:41:55.302+00	32.0	37.41966	0.0	0.00000	\N	\N	\N	\N
706	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:43:58.592+00	48.0	-49.38285	0.0	0.00000	\N	\N	\N	\N
707	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:47:56.547+00	32.0	34.11043	0.0	0.00000	\N	\N	\N	\N
708	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:49:57.416+00	48.0	34.06884	0.0	0.00000	\N	\N	\N	\N
709	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 13:53:58.417+00	48.0	62.67263	0.0	0.00000	\N	\N	\N	\N
710	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:03:57.234+00	48.0	55.82478	0.0	0.00000	\N	\N	\N	\N
711	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:07:55.448+00	48.0	79.32532	0.0	0.00000	\N	\N	\N	\N
712	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:09:58.16+00	12.0	13.75795	0.0	0.00000	\N	\N	\N	\N
713	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:13:55.496+00	48.0	50.23887	0.0	0.00000	\N	\N	\N	\N
714	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:21:55.506+00	48.0	43.02741	0.0	0.00000	\N	\N	\N	\N
715	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:23:58.166+00	32.0	53.03992	0.0	0.00000	\N	\N	\N	\N
716	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:31:58.553+00	32.0	54.99439	0.0	0.00000	\N	\N	\N	\N
717	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:35:59.259+00	16.0	31.03718	0.0	0.00000	\N	\N	\N	\N
718	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:45:59.775+00	32.0	70.35561	0.0	0.00000	\N	\N	\N	\N
719	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:51:57.278+00	48.0	29.25918	0.0	0.00000	\N	\N	\N	\N
720	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 14:55:58.378+00	32.0	73.13023	0.0	0.00000	\N	\N	\N	\N
721	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 15:00:01.229+00	48.0	46.37135	0.0	0.00000	\N	\N	\N	\N
722	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 15:04:01.903+00	32.0	77.80850	0.0	0.00000	\N	\N	\N	\N
723	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 15:06:03.35+00	24.0	67.17477	0.0	0.00000	\N	\N	\N	\N
724	29	(2.29450000000000021,48.8582222200000018)	2015-12-28 15:07:17.746+00	12.0	33.30769	0.0	0.00000	\N	\N	\N	\N
725	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 10:56:12.532+00	48.0	-19.23927	0.0	0.00000	\N	\N	\N	\N
726	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:00:25.276+00	24.0	9.14863	19.2	175.75208	\N	\N	\N	\N
727	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:04:05.408+00	16.0	22.53330	17.1	86.47602	\N	\N	\N	\N
728	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:08:06.774+00	12.0	36.86933	29.1	40.41695	\N	\N	\N	\N
729	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:14:05.454+00	24.0	17.36401	25.2	119.05540	\N	\N	\N	\N
730	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:18:05.412+00	16.0	50.99930	28.5	159.00995	\N	\N	\N	\N
731	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:20:05.415+00	24.0	100.88471	27.4	106.13985	\N	\N	\N	\N
732	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:22:05.434+00	32.0	147.40341	13.9	154.09792	\N	\N	\N	\N
733	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:28:05.368+00	24.0	203.69566	0.0	114.89567	\N	\N	\N	\N
734	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:32:13.578+00	32.0	234.30661	0.0	0.00000	\N	\N	\N	\N
735	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:38:05.904+00	24.0	159.11835	3.2	64.46730	\N	\N	\N	\N
736	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:40:13.521+00	48.0	77.04108	0.0	0.00000	\N	\N	\N	\N
737	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:44:11.299+00	64.0	47.90634	0.0	0.00000	\N	\N	\N	\N
738	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:48:04.901+00	48.0	75.34510	0.0	0.00000	\N	\N	\N	\N
739	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:51:57.211+00	16.0	58.57417	31.6	184.07329	\N	\N	\N	\N
740	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:54:11.305+00	48.0	127.77965	0.0	0.00000	\N	\N	\N	\N
741	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:57:27.053+00	64.0	139.11833	0.0	0.00000	\N	\N	\N	\N
742	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 11:59:43.561+00	48.0	82.18646	28.3	165.35275	\N	\N	\N	\N
743	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 12:08:22.556+00	16.0	38.81181	23.0	174.32205	\N	\N	\N	\N
744	29	(2.29450000000000021,48.8582222200000018)	2015-12-29 12:12:23.608+00	24.0	77.88330	26.5	276.27790	\N	\N	\N	\N
745	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 11:32:38.92+00	24.0	38.25745	0.0	0.00000	\N	\N	\N	\N
746	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 11:35:11.323+00	48.0	86.08278	0.0	0.00000	\N	\N	\N	\N
747	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 11:39:07.496+00	32.0	61.11193	0.0	0.00000	\N	\N	\N	\N
748	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 11:43:06.881+00	32.0	63.07462	0.0	0.00000	\N	\N	\N	\N
749	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 14:01:07.389+00	32.0	32.12226	0.0	0.00000	\N	\N	\N	\N
750	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 14:03:12.16+00	32.0	67.52602	0.0	0.00000	\N	\N	\N	\N
751	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 14:07:10.709+00	32.0	34.73475	0.0	0.00000	\N	\N	\N	\N
752	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 14:23:07.321+00	48.0	63.40863	0.0	0.00000	\N	\N	\N	\N
753	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 14:29:08.109+00	48.0	53.12887	0.0	0.00000	\N	\N	\N	\N
754	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:02:51+00	\N	84.71484	0.0	0.00000	\N	\N	\N	\N
755	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:03:28+00	\N	77.93015	0.0	0.00000	\N	\N	\N	\N
756	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:04:07+00	\N	77.30872	0.0	0.00000	\N	\N	\N	\N
757	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:04:46+00	\N	104.98045	0.0	0.00000	\N	\N	\N	\N
758	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:05:26+00	\N	90.83052	0.0	0.00000	\N	\N	\N	\N
759	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:06:04+00	\N	82.58931	0.0	0.00000	\N	\N	\N	\N
760	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:06:44+00	\N	119.70312	0.0	0.00000	\N	\N	\N	\N
761	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:07:22+00	\N	48.11849	0.0	0.00000	\N	\N	\N	\N
762	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:07:52+00	\N	93.50633	0.0	0.00000	\N	\N	\N	\N
763	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:08:29+00	\N	129.78873	0.0	0.00000	\N	\N	\N	\N
764	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:09:11+00	\N	96.79946	0.0	0.00000	\N	\N	\N	\N
765	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:11:20+00	\N	81.27746	0.0	0.00000	\N	\N	\N	\N
766	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:12:15+00	\N	87.35889	0.0	0.00000	\N	\N	\N	\N
767	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:14:24+00	\N	97.62527	0.0	0.00000	\N	\N	\N	\N
768	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:16:30+00	\N	107.43945	0.0	0.00000	\N	\N	\N	\N
769	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:17:18+00	\N	77.87727	0.0	0.00000	\N	\N	\N	\N
770	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:22:23+00	\N	99.93629	0.0	0.00000	\N	\N	\N	\N
771	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:27:38+00	\N	114.63865	0.0	0.00000	\N	\N	\N	\N
772	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:32:42+00	\N	67.70257	0.0	0.00000	\N	\N	\N	\N
773	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:37:51+00	\N	136.76742	0.0	0.00000	\N	\N	\N	\N
774	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:42:59+00	\N	96.36082	0.0	0.00000	\N	\N	\N	\N
775	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:48:07+00	\N	95.98762	0.0	0.00000	\N	\N	\N	\N
776	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:53:14+00	\N	132.58105	0.0	0.00000	\N	\N	\N	\N
777	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 18:58:24+00	\N	120.23367	0.0	0.00000	\N	\N	\N	\N
778	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:03:34+00	\N	151.17033	0.0	0.00000	\N	\N	\N	\N
779	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:08:43+00	\N	95.35309	0.0	0.00000	\N	\N	\N	\N
780	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:15:17+00	\N	102.21885	0.0	0.00000	\N	\N	\N	\N
781	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:20:31+00	\N	86.99603	0.0	0.00000	\N	\N	\N	\N
782	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:25:48+00	\N	106.56925	0.0	0.00000	\N	\N	\N	\N
783	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:31:08+00	\N	100.00000	0.0	0.00000	\N	\N	\N	\N
784	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:36:23+00	\N	94.57875	0.0	0.00000	\N	\N	\N	\N
785	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:42:12+00	\N	103.11874	0.0	0.00000	\N	\N	\N	\N
786	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:47:30+00	\N	91.06199	0.0	0.00000	\N	\N	\N	\N
787	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:52:50+00	\N	177.73153	0.0	0.00000	\N	\N	\N	\N
788	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 19:58:05+00	\N	113.28399	0.0	0.00000	\N	\N	\N	\N
789	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 20:03:20+00	\N	120.21846	0.0	0.00000	\N	\N	\N	\N
790	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 20:08:32+00	\N	143.60157	0.0	0.00000	\N	\N	\N	\N
791	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 20:13:42+00	\N	167.69812	0.0	0.00000	\N	\N	\N	\N
792	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 20:18:56+00	\N	97.97532	0.0	0.00000	\N	\N	\N	\N
793	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 20:24:00+00	\N	119.07131	0.0	0.00000	\N	\N	\N	\N
794	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 20:29:06+00	\N	118.99351	0.0	0.00000	\N	\N	\N	\N
795	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 20:34:21+00	\N	102.21700	0.0	0.00000	\N	\N	\N	\N
796	29	(2.29450000000000021,48.8582222200000018)	2015-12-31 20:39:31+00	\N	68.26466	0.0	0.00000	\N	\N	\N	\N
797	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:13:56.259+00	23.6	0.00000	0.0	0.00000	\N	\N	\N	\N
798	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:15:14+00	\N	103.72891	0.0	0.00000	\N	\N	\N	\N
799	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:16:26.256+00	64.0	54.82844	0.0	0.00000	\N	\N	\N	\N
800	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:18:15+00	\N	95.64636	0.7	0.00000	\N	\N	\N	\N
801	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:18:27.125+00	8.0	49.18659	0.0	0.00000	\N	\N	\N	\N
802	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:20:42.337+00	48.0	60.09279	0.0	0.00000	\N	\N	\N	\N
803	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:21:29+00	\N	115.20720	0.0	0.00000	\N	\N	\N	\N
804	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:24:43.052+00	32.0	83.31264	0.0	0.00000	\N	\N	\N	\N
805	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:27:02+00	\N	105.14166	0.0	0.00000	\N	\N	\N	\N
806	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:38:37+00	\N	88.85650	0.0	0.00000	\N	\N	\N	\N
807	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:38:55+00	\N	119.35534	0.0	0.00000	\N	\N	\N	\N
808	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:39:10+00	\N	106.23346	0.0	0.00000	\N	\N	\N	\N
809	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:39:25+00	\N	105.70174	0.0	0.00000	\N	\N	\N	\N
810	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:39:40+00	\N	105.55708	0.0	0.00000	\N	\N	\N	\N
811	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:39:55+00	\N	105.41982	0.0	0.00000	\N	\N	\N	\N
812	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:40:10+00	\N	105.18460	0.8	0.00000	\N	\N	\N	\N
813	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:40:25+00	\N	104.05629	0.0	0.00000	\N	\N	\N	\N
814	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:40:44+00	\N	105.24868	0.0	0.00000	\N	\N	\N	\N
815	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:41:02+00	\N	106.79251	0.0	0.00000	\N	\N	\N	\N
816	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:41:20+00	\N	107.32100	0.0	0.00000	\N	\N	\N	\N
817	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:41:39+00	\N	107.02503	0.0	0.00000	\N	\N	\N	\N
818	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:41:54+00	\N	104.95693	0.0	0.00000	\N	\N	\N	\N
819	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:42:15+00	\N	98.21052	0.0	0.00000	\N	\N	\N	\N
820	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:42:33+00	\N	101.56217	0.0	0.00000	\N	\N	\N	\N
821	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:42:51+00	\N	100.40762	0.0	0.00000	\N	\N	\N	\N
822	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:43:21+00	\N	97.90541	0.0	0.00000	\N	\N	\N	\N
823	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:43:39+00	\N	97.42490	0.0	0.00000	\N	\N	\N	\N
824	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:44:07+00	\N	95.40940	0.0	0.00000	\N	\N	\N	\N
825	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:44:25+00	\N	93.69285	0.0	0.00000	\N	\N	\N	\N
826	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:44:43+00	\N	94.46699	0.0	0.00000	\N	\N	\N	\N
827	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:45:01+00	\N	92.87899	0.0	0.00000	\N	\N	\N	\N
828	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:45:19+00	\N	91.58654	0.0	0.00000	\N	\N	\N	\N
829	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:45:37+00	\N	90.64891	0.0	0.00000	\N	\N	\N	\N
830	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:45:55+00	\N	87.15052	0.0	0.00000	\N	\N	\N	\N
831	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:46:13+00	\N	88.55298	0.0	0.00000	\N	\N	\N	\N
832	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:46:28+00	\N	88.36182	0.0	0.00000	\N	\N	\N	\N
833	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:46:43+00	\N	88.10625	0.0	0.00000	\N	\N	\N	\N
834	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:46:58+00	\N	88.76196	0.7	0.00000	\N	\N	\N	\N
835	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:47:13+00	\N	90.14410	0.0	0.00000	\N	\N	\N	\N
836	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:47:28+00	\N	89.66119	0.0	0.00000	\N	\N	\N	\N
837	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:47:43+00	\N	88.92446	0.0	0.00000	\N	\N	\N	\N
838	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:47:58+00	\N	87.84929	0.0	0.00000	\N	\N	\N	\N
839	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:48:13+00	\N	85.82938	0.0	0.00000	\N	\N	\N	\N
840	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:48:27+00	\N	84.25893	0.0	0.00000	\N	\N	\N	\N
841	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:48:42+00	\N	81.93400	0.0	0.00000	\N	\N	\N	\N
842	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:49:02+00	\N	84.49463	0.0	0.00000	\N	\N	\N	\N
843	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:49:18+00	\N	84.55841	0.0	0.00000	\N	\N	\N	\N
844	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:49:33+00	\N	81.79946	0.0	0.00000	\N	\N	\N	\N
845	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:49:48+00	\N	76.25225	0.0	0.00000	\N	\N	\N	\N
846	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:50:03+00	\N	74.14014	0.0	0.00000	\N	\N	\N	\N
847	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:50:10.06+00	12.0	26.92282	0.0	0.00000	\N	\N	\N	\N
848	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:50:18+00	\N	72.84532	0.0	0.00000	\N	\N	\N	\N
849	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:50:33+00	\N	72.28451	0.0	0.00000	\N	\N	\N	\N
850	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:50:48+00	\N	74.70120	0.0	0.00000	\N	\N	\N	\N
851	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:51:03+00	\N	74.05787	0.0	0.00000	\N	\N	\N	\N
852	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:51:28+00	\N	83.37496	0.0	0.00000	\N	\N	\N	\N
853	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:51:46+00	\N	83.10632	0.0	0.00000	\N	\N	\N	\N
854	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:52:01+00	\N	81.44581	0.0	0.00000	\N	\N	\N	\N
855	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:52:10.897+00	8.0	33.49028	0.0	0.00000	\N	\N	\N	\N
856	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:52:16+00	\N	79.34047	0.0	0.00000	\N	\N	\N	\N
857	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:52:31+00	\N	77.24599	0.0	0.00000	\N	\N	\N	\N
858	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:52:46+00	\N	76.30943	0.0	0.00000	\N	\N	\N	\N
859	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:53:01+00	\N	75.52296	0.0	0.00000	\N	\N	\N	\N
860	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:53:16+00	\N	74.00829	0.0	0.00000	\N	\N	\N	\N
861	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:53:31+00	\N	73.51501	0.0	0.00000	\N	\N	\N	\N
862	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:53:46+00	\N	72.15622	0.0	0.00000	\N	\N	\N	\N
863	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:54:01+00	\N	70.97341	0.0	0.00000	\N	\N	\N	\N
864	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:54:12.13+00	24.0	21.25564	0.0	0.00000	\N	\N	\N	\N
865	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:54:16+00	\N	68.03928	0.0	0.00000	\N	\N	\N	\N
866	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:54:31+00	\N	69.98235	0.0	0.00000	\N	\N	\N	\N
867	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:55:02+00	\N	77.59098	0.0	0.00000	\N	\N	\N	\N
868	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:55:19+00	\N	84.04702	0.0	0.00000	\N	\N	\N	\N
869	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:55:34+00	\N	87.15496	0.0	0.00000	\N	\N	\N	\N
870	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:55:49+00	\N	87.77798	0.0	0.00000	\N	\N	\N	\N
871	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:56:04+00	\N	87.55398	0.0	0.00000	\N	\N	\N	\N
872	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:56:12.879+00	16.0	40.94341	0.0	0.00000	\N	\N	\N	\N
873	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:56:19+00	\N	87.96684	0.0	0.00000	\N	\N	\N	\N
874	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:56:34+00	\N	88.38706	0.0	0.00000	\N	\N	\N	\N
875	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:56:49+00	\N	88.35222	0.0	0.00000	\N	\N	\N	\N
876	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:57:04+00	\N	88.76730	0.0	0.00000	\N	\N	\N	\N
877	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:57:19+00	\N	92.87817	0.0	0.00000	\N	\N	\N	\N
878	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:57:34+00	\N	97.38050	0.0	0.00000	\N	\N	\N	\N
879	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:57:49+00	\N	97.25747	0.0	0.00000	\N	\N	\N	\N
880	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:58:04+00	\N	95.89807	0.0	0.00000	\N	\N	\N	\N
881	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:58:13.947+00	12.0	47.75124	0.0	0.00000	\N	\N	\N	\N
882	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:58:19+00	\N	93.49800	0.0	0.00000	\N	\N	\N	\N
883	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:58:34+00	\N	90.30449	0.0	0.00000	\N	\N	\N	\N
884	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:58:49+00	\N	88.77781	0.0	0.00000	\N	\N	\N	\N
885	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:59:04+00	\N	85.43896	0.0	0.00000	\N	\N	\N	\N
886	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:59:19+00	\N	85.57717	0.0	0.00000	\N	\N	\N	\N
887	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:59:34+00	\N	85.76270	0.0	0.00000	\N	\N	\N	\N
888	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 10:59:49+00	\N	86.15657	0.0	0.00000	\N	\N	\N	\N
889	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:00:04+00	\N	86.27400	0.0	0.00000	\N	\N	\N	\N
890	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:00:14.876+00	16.0	39.28996	1.0	0.00000	\N	\N	\N	\N
891	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:00:19+00	\N	85.99360	0.0	0.00000	\N	\N	\N	\N
892	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:00:34+00	\N	86.65596	0.0	0.00000	\N	\N	\N	\N
893	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:00:49+00	\N	87.17948	0.0	0.00000	\N	\N	\N	\N
894	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:01:11+00	\N	88.44300	2.2	0.00000	\N	\N	\N	\N
895	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:01:31+00	\N	88.97601	2.0	0.00000	\N	\N	\N	\N
896	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:03:02.938+00	8.0	94.13098	0.7	0.00000	\N	\N	\N	\N
897	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:04:03.939+00	6.0	86.03655	0.0	0.00000	\N	\N	\N	\N
898	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:09:34.33+00	44.0	0.00000	0.0	0.00000	\N	\N	\N	\N
899	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:09:44.924+00	8.0	55.30780	0.0	0.00000	\N	\N	\N	\N
900	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:09:55.933+00	8.0	41.03169	0.0	0.00000	\N	\N	\N	\N
901	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:10:05.935+00	8.0	39.20149	0.0	0.00000	\N	\N	\N	\N
902	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:10:16.884+00	8.0	39.21520	0.0	0.00000	\N	\N	\N	\N
903	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:10:26.898+00	8.0	39.46058	0.0	0.00000	\N	\N	\N	\N
904	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:10:37.906+00	8.0	40.67218	0.0	0.00000	\N	\N	\N	\N
905	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:10:48.869+00	6.0	40.97235	0.4	0.00000	\N	\N	\N	\N
906	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:10:58.973+00	8.0	41.04717	0.0	0.00000	\N	\N	\N	\N
907	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:11:09.872+00	8.0	41.36585	0.0	0.00000	\N	\N	\N	\N
908	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:11:19.918+00	8.0	42.41612	0.0	0.00000	\N	\N	\N	\N
909	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:11:30.017+00	12.0	43.33885	0.0	0.00000	\N	\N	\N	\N
910	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:11:52.877+00	6.0	43.81131	0.6	0.00000	\N	\N	\N	\N
911	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:12:02.882+00	8.0	43.74182	0.0	0.00000	\N	\N	\N	\N
912	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:12:13.883+00	12.0	43.72879	0.0	0.00000	\N	\N	\N	\N
913	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:12:24.888+00	8.0	43.95903	0.0	0.00000	\N	\N	\N	\N
914	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:12:34.896+00	8.0	44.23501	0.0	0.00000	\N	\N	\N	\N
915	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:13:11.892+00	8.0	44.62970	0.0	0.00000	\N	\N	\N	\N
916	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:13:21.955+00	8.0	45.01395	0.6	0.00000	\N	\N	\N	\N
917	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:13:32.925+00	6.0	45.52939	0.0	0.00000	\N	\N	\N	\N
918	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:13:43.906+00	8.0	45.61084	0.0	0.00000	\N	\N	\N	\N
919	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:13:54.895+00	12.0	46.05201	0.0	0.00000	\N	\N	\N	\N
920	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:04.91+00	8.0	46.17645	0.0	0.00000	\N	\N	\N	\N
921	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:15.911+00	8.0	46.26345	0.0	0.00000	\N	\N	\N	\N
922	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:25+00	\N	92.90170	0.0	0.00000	\N	\N	\N	\N
923	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:26.914+00	6.0	46.15984	0.0	0.00000	\N	\N	\N	\N
924	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:35+00	\N	92.79153	0.0	0.00000	\N	\N	\N	\N
925	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:37.897+00	8.0	46.06043	0.0	0.00000	\N	\N	\N	\N
926	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:45+00	\N	92.86856	0.0	0.00000	\N	\N	\N	\N
927	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:48.897+00	8.0	46.18546	0.0	0.00000	\N	\N	\N	\N
928	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:55+00	\N	92.92262	0.0	0.00000	\N	\N	\N	\N
929	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:14:58.916+00	8.0	46.19397	0.0	0.00000	\N	\N	\N	\N
930	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:15:05+00	\N	92.88761	0.0	0.00000	\N	\N	\N	\N
931	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:15:09.899+00	6.0	46.03903	0.5	0.00000	\N	\N	\N	\N
932	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:15:15+00	\N	92.73641	0.0	0.00000	\N	\N	\N	\N
933	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:15:20.899+00	12.0	46.20415	0.0	0.00000	\N	\N	\N	\N
934	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:15:25+00	\N	92.99724	0.0	0.00000	\N	\N	\N	\N
935	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:15:31.868+00	8.0	46.39662	0.0	0.00000	\N	\N	\N	\N
936	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:15:35+00	\N	93.13539	0.0	0.00000	\N	\N	\N	\N
937	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:15:41.879+00	12.0	46.57607	0.0	0.00000	\N	\N	\N	\N
938	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 11:15:51.975+00	8.0	46.79798	0.0	0.00000	\N	\N	\N	\N
939	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 20:14:46.875+00	12.0	63.16280	0.0	0.00000	\N	\N	\N	\N
940	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 20:14:57.77+00	8.0	62.83837	0.0	0.00000	\N	\N	\N	\N
941	29	(2.29450000000000021,48.8582222200000018)	2016-01-01 20:15:07.775+00	16.0	62.55710	0.0	0.00000	\N	\N	\N	\N
942	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 10:31:20+00	\N	102.44797	0.0	0.00000	\N	\N	\N	\N
943	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 10:32:43.225+00	32.0	85.11007	0.0	0.00000	\N	\N	\N	\N
944	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 10:34:48+00	\N	186.31479	0.0	0.00000	\N	\N	\N	\N
945	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 10:34:51.046+00	32.0	139.59479	0.0	0.00000	\N	\N	\N	\N
946	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 10:36:48+00	\N	84.50124	0.0	0.00000	\N	\N	\N	\N
947	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 10:36:51.093+00	16.0	37.78124	0.0	0.00000	\N	\N	\N	\N
948	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:34:55.259+00	12.0	47.85017	0.0	0.00000	\N	\N	\N	\N
949	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:35:38+00	\N	98.07515	0.0	0.00000	\N	\N	\N	\N
950	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:37:46+00	\N	73.90377	0.0	0.00000	\N	\N	\N	\N
951	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:39:55+00	\N	151.91796	0.0	0.00000	\N	\N	\N	\N
952	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:42:02+00	\N	113.08551	0.0	0.00000	\N	\N	\N	\N
953	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:44:08+00	\N	134.96581	0.0	0.00000	\N	\N	\N	\N
954	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:46:23+00	\N	89.03582	0.0	0.00000	\N	\N	\N	\N
955	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:48:43+00	\N	101.91478	0.0	0.00000	\N	\N	\N	\N
956	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:50:58+00	\N	83.06095	0.0	0.00000	\N	\N	\N	\N
957	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:53:13+00	\N	42.54574	0.0	0.00000	\N	\N	\N	\N
958	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:55:24+00	\N	69.52161	0.0	0.00000	\N	\N	\N	\N
959	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 11:57:40+00	\N	96.51217	0.0	0.00000	\N	\N	\N	\N
960	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:00:04+00	\N	97.96144	0.0	0.00000	\N	\N	\N	\N
961	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:02:33+00	\N	52.49905	0.0	0.00000	\N	\N	\N	\N
962	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:07:43+00	\N	88.93618	0.0	0.00000	\N	\N	\N	\N
963	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:09:50+00	\N	113.76635	0.0	0.00000	\N	\N	\N	\N
964	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:11:56+00	\N	63.21127	0.0	0.00000	\N	\N	\N	\N
965	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:14:03+00	\N	100.91017	0.0	0.00000	\N	\N	\N	\N
966	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:16:12+00	\N	102.69606	0.0	0.00000	\N	\N	\N	\N
967	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:18:19+00	\N	91.63101	0.0	0.00000	\N	\N	\N	\N
968	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:20:24+00	\N	126.48672	0.0	0.00000	\N	\N	\N	\N
969	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:22:28+00	\N	81.72165	0.0	0.00000	\N	\N	\N	\N
970	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:24:36+00	\N	84.53339	0.0	0.00000	\N	\N	\N	\N
971	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:26:41+00	\N	86.35169	0.0	0.00000	\N	\N	\N	\N
972	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:28:49+00	\N	94.69863	24.3	190.87131	\N	\N	\N	\N
973	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:30:57+00	\N	37.80397	40.2	113.92345	\N	\N	\N	\N
974	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:33:04+00	\N	149.53684	0.0	0.00000	\N	\N	\N	\N
975	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:35:04+00	\N	70.25115	0.0	0.00000	\N	\N	\N	\N
976	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:38:30+00	\N	117.75079	0.0	0.00000	\N	\N	\N	\N
977	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:41:18+00	\N	67.92863	0.0	0.00000	\N	\N	\N	\N
978	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:43:24+00	\N	73.70491	0.0	0.00000	\N	\N	\N	\N
979	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:45:29+00	\N	59.97286	23.2	117.73526	\N	\N	\N	\N
980	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:47:34+00	\N	100.62561	22.8	181.21526	\N	\N	\N	\N
981	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:49:38+00	\N	137.58123	0.0	0.00000	\N	\N	\N	\N
982	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:51:44+00	\N	158.14335	43.5	61.22478	\N	\N	\N	\N
983	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:53:46+00	\N	124.44320	19.8	97.15928	\N	\N	\N	\N
984	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:55:52+00	\N	163.81118	0.0	0.00000	\N	\N	\N	\N
985	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 12:57:57+00	\N	169.54551	27.6	57.37896	\N	\N	\N	\N
986	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:00:02+00	\N	224.36984	26.5	147.97006	\N	\N	\N	\N
987	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:02:07+00	\N	230.46612	0.0	0.00000	\N	\N	\N	\N
988	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:04:12+00	\N	298.83108	0.0	0.00000	\N	\N	\N	\N
989	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:07:45+00	\N	226.93615	0.0	0.00000	\N	\N	\N	\N
990	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:09:48+00	\N	217.32303	0.0	0.00000	\N	\N	\N	\N
991	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:11:53+00	\N	255.23929	0.0	0.00000	\N	\N	\N	\N
992	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:13:55+00	\N	248.30711	0.0	0.00000	\N	\N	\N	\N
993	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:15:58+00	\N	249.24375	0.0	0.00000	\N	\N	\N	\N
994	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:18:01+00	\N	252.01648	0.0	0.00000	\N	\N	\N	\N
995	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:20:04+00	\N	226.69557	0.0	0.00000	\N	\N	\N	\N
996	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:22:06+00	\N	243.92635	0.0	0.00000	\N	\N	\N	\N
997	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:24:11+00	\N	305.41377	0.0	0.00000	\N	\N	\N	\N
998	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:26:20+00	\N	247.10500	0.0	0.00000	\N	\N	\N	\N
999	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:28:23+00	\N	279.99140	0.0	0.00000	\N	\N	\N	\N
1000	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:30:29+00	\N	273.80503	0.0	0.00000	\N	\N	\N	\N
1001	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:32:34+00	\N	264.89522	0.0	0.00000	\N	\N	\N	\N
1002	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:34:39+00	\N	267.13610	0.0	0.00000	\N	\N	\N	\N
1003	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:36:42+00	\N	225.33664	0.0	0.00000	\N	\N	\N	\N
1004	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:36:42+00	\N	225.33664	0.0	0.00000	\N	\N	\N	\N
1005	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:38:45+00	\N	227.51379	0.0	0.00000	\N	\N	\N	\N
1006	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:40:47+00	\N	258.67123	0.0	0.00000	\N	\N	\N	\N
1007	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:42:50+00	\N	216.51687	0.0	0.00000	\N	\N	\N	\N
1008	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:44:54+00	\N	235.41350	0.0	0.00000	\N	\N	\N	\N
1009	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:46:56+00	\N	286.05620	0.0	0.00000	\N	\N	\N	\N
1010	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:49:02+00	\N	244.69718	0.0	0.00000	\N	\N	\N	\N
1011	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:51:06+00	\N	233.72783	0.0	0.00000	\N	\N	\N	\N
1012	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:53:08+00	\N	195.56067	0.0	0.00000	\N	\N	\N	\N
1013	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:55:13+00	\N	282.87399	0.0	0.00000	\N	\N	\N	\N
1014	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:57:18+00	\N	236.38981	0.0	0.00000	\N	\N	\N	\N
1015	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 13:59:23+00	\N	271.54054	0.0	0.00000	\N	\N	\N	\N
1016	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:01:27+00	\N	251.58247	0.0	0.00000	\N	\N	\N	\N
1017	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:03:33+00	\N	233.30807	0.0	0.00000	\N	\N	\N	\N
1018	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:05:39+00	\N	273.63668	0.0	0.00000	\N	\N	\N	\N
1019	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:07:44+00	\N	257.12771	0.0	0.00000	\N	\N	\N	\N
1020	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:09:49+00	\N	279.12454	0.0	0.00000	\N	\N	\N	\N
1021	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:11:54+00	\N	244.97400	0.0	0.00000	\N	\N	\N	\N
1022	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:13:59+00	\N	290.74574	0.0	0.00000	\N	\N	\N	\N
1023	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:16:01+00	\N	214.17355	0.0	0.00000	\N	\N	\N	\N
1024	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:18:04+00	\N	257.21550	0.0	0.00000	\N	\N	\N	\N
1025	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:20:12+00	\N	275.23661	0.0	0.00000	\N	\N	\N	\N
1026	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:22:18+00	\N	222.58593	0.0	0.00000	\N	\N	\N	\N
1027	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:24:23+00	\N	205.49427	0.0	0.00000	\N	\N	\N	\N
1028	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:26:25+00	\N	253.67329	0.0	0.00000	\N	\N	\N	\N
1029	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:28:31+00	\N	247.81950	0.0	0.00000	\N	\N	\N	\N
1030	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:30:34+00	\N	237.72348	0.0	0.00000	\N	\N	\N	\N
1031	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:32:39+00	\N	233.65380	0.0	0.00000	\N	\N	\N	\N
1032	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:34:42+00	\N	202.86176	0.0	0.00000	\N	\N	\N	\N
1033	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:36:45+00	\N	214.96731	0.0	0.00000	\N	\N	\N	\N
1034	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:38:50+00	\N	207.54488	0.0	0.00000	\N	\N	\N	\N
1035	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:40:52+00	\N	191.94246	0.0	0.00000	\N	\N	\N	\N
1036	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:42:56+00	\N	199.59629	0.0	0.00000	\N	\N	\N	\N
1037	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:44:59+00	\N	220.77509	0.0	0.00000	\N	\N	\N	\N
1038	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:47:02+00	\N	218.89741	0.0	0.00000	\N	\N	\N	\N
1039	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:49:05+00	\N	238.73344	0.0	0.00000	\N	\N	\N	\N
1040	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:51:08+00	\N	199.66349	0.0	0.00000	\N	\N	\N	\N
1041	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:53:12+00	\N	262.08432	0.0	0.00000	\N	\N	\N	\N
1042	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:55:18+00	\N	236.57222	0.0	0.00000	\N	\N	\N	\N
1043	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:57:23+00	\N	257.06422	0.0	0.00000	\N	\N	\N	\N
1044	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 14:59:26+00	\N	270.60444	0.0	0.00000	\N	\N	\N	\N
1045	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:01:29+00	\N	231.62178	0.0	0.00000	\N	\N	\N	\N
1046	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:03:33+00	\N	216.08794	0.0	0.00000	\N	\N	\N	\N
1047	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:05:39+00	\N	226.26481	0.0	0.00000	\N	\N	\N	\N
1048	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:07:41+00	\N	210.77808	0.0	0.00000	\N	\N	\N	\N
1049	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:09:45+00	\N	230.56601	0.0	0.00000	\N	\N	\N	\N
1050	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:11:51+00	\N	239.44472	0.0	0.00000	\N	\N	\N	\N
1051	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:13:55+00	\N	171.69057	0.0	0.00000	\N	\N	\N	\N
1052	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:16:00+00	\N	246.14861	0.0	0.00000	\N	\N	\N	\N
1053	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:18:04+00	\N	237.82735	0.0	0.00000	\N	\N	\N	\N
1054	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:20:07+00	\N	206.99433	0.0	0.00000	\N	\N	\N	\N
1055	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:22:09+00	\N	223.15715	0.0	0.00000	\N	\N	\N	\N
1056	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:24:12+00	\N	217.68707	0.0	0.00000	\N	\N	\N	\N
1057	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:26:15+00	\N	230.66645	0.0	0.00000	\N	\N	\N	\N
1058	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:28:19+00	\N	220.72351	0.0	0.00000	\N	\N	\N	\N
1059	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:30:24+00	\N	196.67872	0.0	0.00000	\N	\N	\N	\N
1060	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:32:29+00	\N	274.81798	0.0	0.00000	\N	\N	\N	\N
1061	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:32:29+00	\N	274.81798	0.0	0.00000	\N	\N	\N	\N
1062	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:34:32+00	\N	215.20088	0.0	0.00000	\N	\N	\N	\N
1063	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:36:37+00	\N	201.44526	0.0	0.00000	\N	\N	\N	\N
1064	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:38:40+00	\N	206.94360	0.0	0.00000	\N	\N	\N	\N
1065	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:40:43+00	\N	190.24880	0.0	0.00000	\N	\N	\N	\N
1066	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:42:47+00	\N	215.13023	0.0	0.00000	\N	\N	\N	\N
1067	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:44:50+00	\N	194.43021	0.0	0.00000	\N	\N	\N	\N
1068	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:46:52+00	\N	142.66752	0.0	0.00000	\N	\N	\N	\N
1069	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:48:55+00	\N	151.19657	0.0	0.00000	\N	\N	\N	\N
1070	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:50:59+00	\N	154.09112	0.0	0.00000	\N	\N	\N	\N
1071	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:53:04+00	\N	165.13690	0.0	0.00000	\N	\N	\N	\N
1072	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:53:04+00	\N	165.13690	0.0	0.00000	\N	\N	\N	\N
1073	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:55:07+00	\N	147.13285	0.0	0.00000	\N	\N	\N	\N
1074	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:57:08+00	\N	186.14003	0.0	0.00000	\N	\N	\N	\N
1075	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 15:59:14+00	\N	180.83206	0.0	0.00000	\N	\N	\N	\N
1076	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:01:16+00	\N	208.96862	0.0	0.00000	\N	\N	\N	\N
1077	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:03:21+00	\N	244.69379	0.0	0.00000	\N	\N	\N	\N
1078	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:05:24+00	\N	256.01325	0.0	0.00000	\N	\N	\N	\N
1079	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:07:26+00	\N	243.18406	0.0	0.00000	\N	\N	\N	\N
1080	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:07:26+00	\N	243.18406	0.0	0.00000	\N	\N	\N	\N
1081	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:09:32+00	\N	207.20037	0.0	0.00000	\N	\N	\N	\N
1082	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:11:33+00	\N	238.25050	0.0	0.00000	\N	\N	\N	\N
1083	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:13:37+00	\N	229.47497	0.0	0.00000	\N	\N	\N	\N
1084	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:15:40+00	\N	228.73789	0.0	0.00000	\N	\N	\N	\N
1085	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:17:42+00	\N	249.81380	0.0	0.00000	\N	\N	\N	\N
1086	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:19:45+00	\N	226.39725	0.0	0.00000	\N	\N	\N	\N
1087	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:21:48+00	\N	225.74959	0.0	0.00000	\N	\N	\N	\N
1088	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:23:50+00	\N	200.82072	0.0	0.00000	\N	\N	\N	\N
1089	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:23:50+00	\N	200.82072	0.0	0.00000	\N	\N	\N	\N
1090	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:25:54+00	\N	250.98892	0.0	0.00000	\N	\N	\N	\N
1091	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:27:56+00	\N	182.84237	0.0	0.00000	\N	\N	\N	\N
1092	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:29:59+00	\N	218.21863	0.0	0.00000	\N	\N	\N	\N
1093	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:32:03+00	\N	192.75283	0.0	0.00000	\N	\N	\N	\N
1094	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:34:11+00	\N	243.65528	0.0	0.00000	\N	\N	\N	\N
1095	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:36:21+00	\N	431.24809	0.0	0.00000	\N	\N	\N	\N
1096	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:38:26+00	\N	231.03518	0.0	0.00000	\N	\N	\N	\N
1097	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:40:30+00	\N	255.32106	19.9	278.08167	\N	\N	\N	\N
1098	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:42:33+00	\N	243.57562	0.0	0.00000	\N	\N	\N	\N
1099	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:44:38+00	\N	175.12152	23.1	20.67682	\N	\N	\N	\N
1100	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:46:45+00	\N	150.30129	23.1	282.78796	\N	\N	\N	\N
1101	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:48:49+00	\N	135.03043	43.8	242.33344	\N	\N	\N	\N
1102	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:50:53+00	\N	133.25389	20.9	248.24103	\N	\N	\N	\N
1103	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:52:56+00	\N	116.76248	0.0	0.00000	\N	\N	\N	\N
1104	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:55:02+00	\N	63.37064	0.0	0.00000	\N	\N	\N	\N
1105	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:57:08+00	\N	117.39612	19.3	296.69064	\N	\N	\N	\N
1106	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 16:59:13+00	\N	55.99736	31.8	267.01938	\N	\N	\N	\N
1107	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:01:17+00	\N	65.67040	0.0	281.45883	\N	\N	\N	\N
1108	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:03:25+00	\N	60.15053	13.0	221.46315	\N	\N	\N	\N
1109	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:05:30+00	\N	74.41574	0.0	0.00000	\N	\N	\N	\N
1110	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:05:30+00	\N	74.41574	0.0	0.00000	\N	\N	\N	\N
1111	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:07:36+00	\N	76.36022	26.1	351.15918	\N	\N	\N	\N
1112	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:09:42+00	\N	75.74526	0.0	0.00000	\N	\N	\N	\N
1113	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:11:48+00	\N	100.62975	21.5	0.86420	\N	\N	\N	\N
1114	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:13:50+00	\N	89.70458	17.8	327.73724	\N	\N	\N	\N
1115	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:15:56+00	\N	106.17295	0.0	0.00000	\N	\N	\N	\N
1116	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:18:31+00	\N	106.36825	0.0	0.00000	\N	\N	\N	\N
1117	29	(2.29450000000000021,48.8582222200000018)	2016-01-04 17:20:40+00	\N	75.60469	0.0	0.00000	\N	\N	\N	\N
1118	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:50:04+00	\N	147.74690	0.0	0.00000	\N	\N	\N	\N
1119	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:50:22+00	\N	125.58043	0.0	0.00000	\N	\N	\N	\N
1120	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:51:54+00	\N	-4.15637	0.0	0.00000	\N	\N	\N	\N
1121	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:53:02+00	\N	96.13438	0.0	0.00000	\N	\N	\N	\N
1122	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:54:08+00	\N	93.72961	0.0	0.00000	\N	\N	\N	\N
1123	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:55:14+00	\N	86.92156	0.0	0.00000	\N	\N	\N	\N
1124	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:56:20+00	\N	125.05798	0.0	0.00000	\N	\N	\N	\N
1125	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:57:28+00	\N	88.98485	0.0	0.00000	\N	\N	\N	\N
1126	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:58:34+00	\N	107.24376	0.0	0.00000	\N	\N	\N	\N
1127	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 11:59:36+00	\N	107.18677	0.0	0.00000	\N	\N	\N	\N
1128	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:00:42+00	\N	97.91015	0.0	0.00000	\N	\N	\N	\N
1129	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:01:51+00	\N	70.88727	0.0	0.00000	\N	\N	\N	\N
1130	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:03:00+00	\N	92.11080	0.0	0.00000	\N	\N	\N	\N
1131	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:04:14+00	\N	96.02550	0.0	0.00000	\N	\N	\N	\N
1132	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:05:32+00	\N	85.68190	0.0	0.00000	\N	\N	\N	\N
1133	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:06:40+00	\N	108.75128	0.0	0.00000	\N	\N	\N	\N
1134	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:07:55+00	\N	76.94068	0.0	0.00000	\N	\N	\N	\N
1135	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:09:09+00	\N	123.89051	0.0	0.00000	\N	\N	\N	\N
1136	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:10:20+00	\N	100.39020	0.0	0.00000	\N	\N	\N	\N
1137	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:11:30+00	\N	62.47655	0.0	0.00000	\N	\N	\N	\N
1138	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:12:37+00	\N	58.58135	0.0	0.00000	\N	\N	\N	\N
1139	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:13:49+00	\N	52.60635	0.0	0.00000	\N	\N	\N	\N
1140	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:14:54+00	\N	69.16012	0.0	0.00000	\N	\N	\N	\N
1141	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:15:58+00	\N	84.61882	0.0	0.00000	\N	\N	\N	\N
1142	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:17:00+00	\N	116.57516	0.0	0.00000	\N	\N	\N	\N
1143	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:18:15+00	\N	53.79803	0.0	0.00000	\N	\N	\N	\N
1144	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:19:36+00	\N	80.19436	0.0	0.00000	\N	\N	\N	\N
1145	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:23:28+00	\N	91.26908	0.0	0.00000	\N	\N	\N	\N
1146	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:24:42+00	\N	123.42405	0.0	0.00000	\N	\N	\N	\N
1147	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:26:06+00	\N	154.60605	0.0	0.00000	\N	\N	\N	\N
1148	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:27:41+00	\N	100.00000	0.0	0.00000	\N	\N	\N	\N
1149	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:29:00+00	\N	82.53234	0.0	0.00000	\N	\N	\N	\N
1150	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:30:16+00	\N	136.04441	0.0	0.00000	\N	\N	\N	\N
1151	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:31:46+00	\N	99.99999	0.0	0.00000	\N	\N	\N	\N
1152	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:33:05+00	\N	100.00000	0.0	0.00000	\N	\N	\N	\N
1153	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:34:22+00	\N	82.31340	0.0	0.00000	\N	\N	\N	\N
1154	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:36:17+00	\N	77.59457	0.0	0.00000	\N	\N	\N	\N
1155	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:37:31+00	\N	139.36145	0.0	0.00000	\N	\N	\N	\N
1156	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:38:43+00	\N	128.16359	0.0	0.00000	\N	\N	\N	\N
1157	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:39:58+00	\N	105.37958	0.0	0.00000	\N	\N	\N	\N
1158	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:41:52+00	\N	81.20392	0.0	0.00000	\N	\N	\N	\N
1159	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:50:56+00	\N	75.52187	0.0	0.00000	\N	\N	\N	\N
1160	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:52:10+00	\N	47.26170	0.0	0.00000	\N	\N	\N	\N
1161	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:53:24+00	\N	42.30058	0.0	0.00000	\N	\N	\N	\N
1162	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:55:16+00	\N	84.29400	0.0	0.00000	\N	\N	\N	\N
1163	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:56:30+00	\N	156.91299	0.0	0.00000	\N	\N	\N	\N
1164	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:57:40+00	\N	146.88391	0.0	0.00000	\N	\N	\N	\N
1165	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 12:59:08+00	\N	80.74908	0.0	0.00000	\N	\N	\N	\N
1166	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:00:24+00	\N	5.68500	0.0	0.00000	\N	\N	\N	\N
1167	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:01:36+00	\N	157.96519	0.0	0.00000	\N	\N	\N	\N
1168	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:02:51+00	\N	129.83854	0.0	0.00000	\N	\N	\N	\N
1169	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:03:59+00	\N	129.96871	0.0	0.00000	\N	\N	\N	\N
1170	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:06:28+00	\N	81.77106	0.0	0.00000	\N	\N	\N	\N
1171	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:07:44+00	\N	88.30156	0.0	0.00000	\N	\N	\N	\N
1172	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:10:57+00	\N	86.37008	0.0	0.00000	\N	\N	\N	\N
1173	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:50:50+00	\N	81.04124	0.0	0.00000	\N	\N	\N	\N
1174	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:52:13+00	\N	70.68377	0.0	0.00000	\N	\N	\N	\N
1175	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:53:18+00	\N	80.50749	0.0	0.00000	\N	\N	\N	\N
1176	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:54:24+00	\N	115.34611	0.0	0.00000	\N	\N	\N	\N
1177	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:55:33+00	\N	45.93501	0.0	0.00000	\N	\N	\N	\N
1178	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:56:40+00	\N	54.80794	0.0	0.00000	\N	\N	\N	\N
1179	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:57:52+00	\N	66.86456	0.0	0.00000	\N	\N	\N	\N
1180	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 13:58:59+00	\N	86.61428	0.0	0.00000	\N	\N	\N	\N
1181	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:00:06+00	\N	39.76008	0.0	0.00000	\N	\N	\N	\N
1182	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:01:18+00	\N	0.98466	0.0	0.00000	\N	\N	\N	\N
1183	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:02:36+00	\N	91.64072	0.0	0.00000	\N	\N	\N	\N
1184	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:03:50+00	\N	120.98810	0.0	0.00000	\N	\N	\N	\N
1185	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:05:02+00	\N	105.82990	0.0	0.00000	\N	\N	\N	\N
1186	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:06:16+00	\N	161.98278	0.0	0.00000	\N	\N	\N	\N
1187	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:07:32+00	\N	35.35733	0.0	0.00000	\N	\N	\N	\N
1188	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:07:32+00	\N	35.35733	0.0	0.00000	\N	\N	\N	\N
1189	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:08:55+00	\N	124.73500	0.0	0.00000	\N	\N	\N	\N
1190	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:10:10+00	\N	60.00069	0.0	0.00000	\N	\N	\N	\N
1191	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:11:26+00	\N	83.77897	0.0	0.00000	\N	\N	\N	\N
1192	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:12:36+00	\N	127.60348	0.0	0.00000	\N	\N	\N	\N
1193	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:13:42+00	\N	88.73791	0.0	0.00000	\N	\N	\N	\N
1194	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:14:57+00	\N	168.28591	0.0	0.00000	\N	\N	\N	\N
1195	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:18:05+00	\N	90.20344	0.0	0.00000	\N	\N	\N	\N
1196	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:19:16+00	\N	73.63163	0.0	0.00000	\N	\N	\N	\N
1197	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:20:28+00	\N	78.68925	0.0	0.00000	\N	\N	\N	\N
1198	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:23:42+00	\N	59.50851	0.0	0.00000	\N	\N	\N	\N
1199	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:24:58+00	\N	99.58352	0.0	0.00000	\N	\N	\N	\N
1200	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:26:11+00	\N	63.85021	0.0	0.00000	\N	\N	\N	\N
1201	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:27:28+00	\N	121.40115	0.0	0.00000	\N	\N	\N	\N
1202	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:28:46+00	\N	169.52134	0.0	0.00000	\N	\N	\N	\N
1203	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:29:58+00	\N	52.15126	0.0	0.00000	\N	\N	\N	\N
1204	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:31:07+00	\N	111.84171	0.0	0.00000	\N	\N	\N	\N
1205	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:32:23+00	\N	31.30662	0.0	0.00000	\N	\N	\N	\N
1206	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:33:33+00	\N	127.31145	0.0	0.00000	\N	\N	\N	\N
1207	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:34:48+00	\N	123.36702	0.0	0.00000	\N	\N	\N	\N
1208	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:35:57+00	\N	101.13660	0.0	0.00000	\N	\N	\N	\N
1209	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:37:09+00	\N	94.36497	0.0	0.00000	\N	\N	\N	\N
1210	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:38:21+00	\N	108.59214	0.0	0.00000	\N	\N	\N	\N
1211	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:39:33+00	\N	121.81434	0.0	0.00000	\N	\N	\N	\N
1212	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:40:47+00	\N	34.19631	0.0	0.00000	\N	\N	\N	\N
1213	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:42:00+00	\N	80.53133	0.0	0.00000	\N	\N	\N	\N
1214	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:43:09+00	\N	72.38463	0.0	0.00000	\N	\N	\N	\N
1215	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:44:24+00	\N	84.88668	0.0	0.00000	\N	\N	\N	\N
1216	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:45:52+00	\N	79.89497	0.0	0.00000	\N	\N	\N	\N
1217	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:47:31+00	\N	98.39327	0.0	0.00000	\N	\N	\N	\N
1218	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:48:45+00	\N	154.71290	0.0	0.00000	\N	\N	\N	\N
1219	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:49:56+00	\N	24.66419	0.0	0.00000	\N	\N	\N	\N
1220	29	(2.29450000000000021,48.8582222200000018)	2016-01-07 14:51:10+00	\N	111.27901	0.0	0.00000	\N	\N	\N	\N
1221	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 10:46:31+00	\N	114.57035	0.0	0.00000	\N	\N	\N	\N
1222	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 10:48:37+00	\N	65.72685	0.0	0.00000	\N	\N	\N	\N
1223	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 10:50:44+00	\N	109.78337	0.0	0.00000	\N	\N	\N	\N
1224	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 10:52:48+00	\N	63.26712	0.0	0.00000	\N	\N	\N	\N
1225	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 10:54:54+00	\N	71.50779	0.0	0.00000	\N	\N	\N	\N
1226	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 10:57:00+00	\N	67.53630	0.0	0.00000	\N	\N	\N	\N
1227	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 10:59:04+00	\N	141.63606	0.0	0.00000	\N	\N	\N	\N
1228	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:01:10+00	\N	132.09523	0.0	0.00000	\N	\N	\N	\N
1229	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:03:42+00	\N	63.31962	0.0	0.00000	\N	\N	\N	\N
1230	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:05:48+00	\N	103.04637	0.0	0.00000	\N	\N	\N	\N
1231	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:12:34+00	\N	117.75251	0.0	0.00000	\N	\N	\N	\N
1232	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:15:35+00	\N	94.04950	0.0	0.00000	\N	\N	\N	\N
1233	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:18:11+00	\N	79.11864	0.0	0.00000	\N	\N	\N	\N
1234	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:20:27+00	\N	141.95906	0.0	0.00000	\N	\N	\N	\N
1235	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:23:09+00	\N	158.90621	0.0	0.00000	\N	\N	\N	\N
1236	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:25:45+00	\N	137.41710	0.0	0.00000	\N	\N	\N	\N
1237	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:34:05+00	\N	144.74081	0.0	0.00000	\N	\N	\N	\N
1238	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:36:52+00	\N	241.25920	0.0	0.00000	\N	\N	\N	\N
1239	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:39:08+00	\N	208.36707	0.0	0.00000	\N	\N	\N	\N
1240	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:41:17+00	\N	250.44724	0.0	0.00000	\N	\N	\N	\N
1241	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:43:27+00	\N	239.17050	0.0	0.00000	\N	\N	\N	\N
1242	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:45:32+00	\N	207.59862	0.0	0.00000	\N	\N	\N	\N
1243	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:47:37+00	\N	236.71580	0.0	0.00000	\N	\N	\N	\N
1244	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:49:45+00	\N	238.54556	0.0	0.00000	\N	\N	\N	\N
1245	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:51:54+00	\N	248.95326	0.0	0.00000	\N	\N	\N	\N
1246	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:54:01+00	\N	250.15757	0.0	0.00000	\N	\N	\N	\N
1247	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:56:07+00	\N	229.62757	0.0	0.00000	\N	\N	\N	\N
1248	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 11:58:11+00	\N	231.15033	0.0	0.00000	\N	\N	\N	\N
1249	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:00:23+00	\N	254.82332	0.0	0.00000	\N	\N	\N	\N
1250	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:02:30+00	\N	254.67160	0.0	0.00000	\N	\N	\N	\N
1251	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:04:37+00	\N	246.92173	0.0	0.00000	\N	\N	\N	\N
1252	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:06:45+00	\N	232.80016	0.0	0.00000	\N	\N	\N	\N
1253	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:08:57+00	\N	145.40776	0.0	0.00000	\N	\N	\N	\N
1254	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:08:57+00	\N	145.40776	0.0	0.00000	\N	\N	\N	\N
1255	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:11:06+00	\N	233.81307	0.0	0.00000	\N	\N	\N	\N
1256	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:13:12+00	\N	232.61863	0.0	0.00000	\N	\N	\N	\N
1257	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:15:20+00	\N	264.20051	0.0	0.00000	\N	\N	\N	\N
1258	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:17:31+00	\N	263.64677	0.0	0.00000	\N	\N	\N	\N
1259	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:19:40+00	\N	242.61455	0.0	0.00000	\N	\N	\N	\N
1260	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:21:51+00	\N	225.64360	0.0	0.00000	\N	\N	\N	\N
1261	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:24:04+00	\N	244.84832	0.0	0.00000	\N	\N	\N	\N
1262	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:26:13+00	\N	233.44105	0.0	0.00000	\N	\N	\N	\N
1263	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:28:22+00	\N	273.51968	0.0	0.00000	\N	\N	\N	\N
1264	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:30:29+00	\N	240.87434	0.0	0.00000	\N	\N	\N	\N
1265	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:32:37+00	\N	259.40222	0.0	0.00000	\N	\N	\N	\N
1266	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:34:46+00	\N	259.87000	0.0	0.00000	\N	\N	\N	\N
1267	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:34:46+00	\N	259.87000	0.0	0.00000	\N	\N	\N	\N
1268	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:36:54+00	\N	240.36106	0.0	0.00000	\N	\N	\N	\N
1269	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:39:02+00	\N	269.46737	0.0	0.00000	\N	\N	\N	\N
1270	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:41:11+00	\N	231.60738	0.0	0.00000	\N	\N	\N	\N
1271	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:43:18+00	\N	252.65272	0.0	0.00000	\N	\N	\N	\N
1272	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:45:30+00	\N	245.75208	0.0	0.00000	\N	\N	\N	\N
1273	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:47:38+00	\N	220.39484	0.0	0.00000	\N	\N	\N	\N
1274	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:47:38+00	\N	220.39484	0.0	0.00000	\N	\N	\N	\N
1275	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:47:38+00	\N	220.39484	0.0	0.00000	\N	\N	\N	\N
1276	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:49:48+00	\N	261.10292	0.0	0.00000	\N	\N	\N	\N
1277	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:51:56+00	\N	264.04856	0.0	0.00000	\N	\N	\N	\N
1278	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:51:56+00	\N	264.04856	0.0	0.00000	\N	\N	\N	\N
1279	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:54:02+00	\N	246.38965	0.0	0.00000	\N	\N	\N	\N
1280	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:56:14+00	\N	295.00250	0.0	0.00000	\N	\N	\N	\N
1281	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 12:58:22+00	\N	241.80717	0.0	0.00000	\N	\N	\N	\N
1282	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:00:31+00	\N	254.67662	0.0	0.00000	\N	\N	\N	\N
1283	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:02:38+00	\N	302.85570	0.0	0.00000	\N	\N	\N	\N
1284	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:02:38+00	\N	302.85570	0.0	0.00000	\N	\N	\N	\N
1285	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:02:38+00	\N	302.85570	0.0	0.00000	\N	\N	\N	\N
1286	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:04:46+00	\N	228.85575	0.0	0.00000	\N	\N	\N	\N
1287	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:06:55+00	\N	223.16110	0.0	0.00000	\N	\N	\N	\N
1288	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:09:02+00	\N	247.83562	0.0	0.00000	\N	\N	\N	\N
1289	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:11:09+00	\N	282.80042	0.0	0.00000	\N	\N	\N	\N
1290	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:13:15+00	\N	220.84012	0.0	0.00000	\N	\N	\N	\N
1291	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:15:21+00	\N	226.20299	0.0	0.00000	\N	\N	\N	\N
1292	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:17:27+00	\N	222.09348	0.0	0.00000	\N	\N	\N	\N
1293	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:19:37+00	\N	221.57114	0.0	0.00000	\N	\N	\N	\N
1294	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:21:45+00	\N	275.48429	0.0	0.00000	\N	\N	\N	\N
1295	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:23:53+00	\N	256.61705	0.0	0.00000	\N	\N	\N	\N
1296	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:26:01+00	\N	262.07328	0.0	0.00000	\N	\N	\N	\N
1297	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:28:03+00	\N	242.14316	0.0	0.00000	\N	\N	\N	\N
1298	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:30:09+00	\N	250.30857	0.0	0.00000	\N	\N	\N	\N
1299	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:32:13+00	\N	275.72823	0.0	0.00000	\N	\N	\N	\N
1300	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:34:16+00	\N	255.88397	0.0	0.00000	\N	\N	\N	\N
1301	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:36:20+00	\N	276.72394	0.0	0.00000	\N	\N	\N	\N
1302	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:38:24+00	\N	237.59560	0.0	0.00000	\N	\N	\N	\N
1303	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:40:28+00	\N	238.60852	0.0	0.00000	\N	\N	\N	\N
1304	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:42:33+00	\N	278.15651	0.0	0.00000	\N	\N	\N	\N
1305	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:44:37+00	\N	227.55302	0.0	0.00000	\N	\N	\N	\N
1306	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:46:40+00	\N	310.06210	0.0	0.00000	\N	\N	\N	\N
1307	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:48:42+00	\N	211.44326	0.0	0.00000	\N	\N	\N	\N
1308	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:50:46+00	\N	287.79830	0.0	0.00000	\N	\N	\N	\N
1309	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:52:48+00	\N	275.40186	0.0	0.00000	\N	\N	\N	\N
1310	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:54:53+00	\N	240.54723	0.0	0.00000	\N	\N	\N	\N
1311	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:56:58+00	\N	251.35790	0.0	0.00000	\N	\N	\N	\N
1312	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 13:59:03+00	\N	229.47043	0.0	0.00000	\N	\N	\N	\N
1313	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:01:08+00	\N	210.64084	0.0	0.00000	\N	\N	\N	\N
1314	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:03:11+00	\N	222.17415	0.0	0.00000	\N	\N	\N	\N
1315	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:05:14+00	\N	207.07153	0.0	0.00000	\N	\N	\N	\N
1316	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:07:16+00	\N	171.87476	0.0	0.00000	\N	\N	\N	\N
1317	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:09:21+00	\N	157.54076	0.0	0.00000	\N	\N	\N	\N
1318	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:11:24+00	\N	194.57809	0.0	0.00000	\N	\N	\N	\N
1319	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:13:27+00	\N	159.76590	0.0	0.00000	\N	\N	\N	\N
1320	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:15:30+00	\N	190.09517	0.0	0.00000	\N	\N	\N	\N
1321	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:17:40+00	\N	191.56645	0.0	0.00000	\N	\N	\N	\N
1322	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:19:43+00	\N	215.02582	0.0	0.00000	\N	\N	\N	\N
1323	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:21:46+00	\N	205.54639	0.0	0.00000	\N	\N	\N	\N
1324	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:23:51+00	\N	214.58979	0.0	0.00000	\N	\N	\N	\N
1325	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:25:55+00	\N	228.58027	0.0	0.00000	\N	\N	\N	\N
1326	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:27:58+00	\N	231.97750	0.0	0.00000	\N	\N	\N	\N
1327	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:30:01+00	\N	236.24717	0.0	0.00000	\N	\N	\N	\N
1328	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:32:03+00	\N	206.76351	0.0	0.00000	\N	\N	\N	\N
1329	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:34:08+00	\N	266.56486	0.0	0.00000	\N	\N	\N	\N
1330	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:36:12+00	\N	248.64722	0.0	0.00000	\N	\N	\N	\N
1331	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:38:17+00	\N	222.02083	0.0	0.00000	\N	\N	\N	\N
1332	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:40:22+00	\N	221.57529	0.0	0.00000	\N	\N	\N	\N
1333	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:42:28+00	\N	229.73587	0.0	0.00000	\N	\N	\N	\N
1334	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:44:30+00	\N	207.01894	0.0	0.00000	\N	\N	\N	\N
1335	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:46:35+00	\N	208.20430	0.0	0.00000	\N	\N	\N	\N
1336	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:48:38+00	\N	204.84813	0.0	0.00000	\N	\N	\N	\N
1337	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:48:38+00	\N	204.84813	0.0	0.00000	\N	\N	\N	\N
1338	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:50:43+00	\N	190.82709	0.0	0.00000	\N	\N	\N	\N
1339	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:50:43+00	\N	190.82709	0.0	0.00000	\N	\N	\N	\N
1340	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:52:47+00	\N	177.86771	0.0	0.00000	\N	\N	\N	\N
1341	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:54:53+00	\N	132.08363	0.0	0.00000	\N	\N	\N	\N
1342	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:56:57+00	\N	166.15985	0.0	0.00000	\N	\N	\N	\N
1343	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 14:59:01+00	\N	196.74485	0.0	0.00000	\N	\N	\N	\N
1344	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:01:06+00	\N	203.69675	0.0	0.00000	\N	\N	\N	\N
1345	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:03:11+00	\N	215.21655	0.0	0.00000	\N	\N	\N	\N
1346	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:05:15+00	\N	212.99024	0.0	0.00000	\N	\N	\N	\N
1347	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:07:19+00	\N	222.55243	0.0	0.00000	\N	\N	\N	\N
1348	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:09:25+00	\N	211.79012	0.0	0.00000	\N	\N	\N	\N
1349	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:11:28+00	\N	222.96631	0.0	0.00000	\N	\N	\N	\N
1350	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:13:34+00	\N	251.47744	0.0	0.00000	\N	\N	\N	\N
1351	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:15:37+00	\N	222.24688	0.0	0.00000	\N	\N	\N	\N
1352	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:17:40+00	\N	231.35491	0.0	0.00000	\N	\N	\N	\N
1353	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:19:43+00	\N	208.53613	0.0	0.00000	\N	\N	\N	\N
1354	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:21:45+00	\N	229.44093	0.0	0.00000	\N	\N	\N	\N
1355	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:23:51+00	\N	256.14896	0.0	0.00000	\N	\N	\N	\N
1356	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:25:55+00	\N	256.73130	0.0	0.00000	\N	\N	\N	\N
1357	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:27:58+00	\N	216.86961	0.0	0.00000	\N	\N	\N	\N
1358	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:30:00+00	\N	218.33836	0.0	0.00000	\N	\N	\N	\N
1359	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:32:03+00	\N	235.46579	0.0	0.00000	\N	\N	\N	\N
1360	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:34:06+00	\N	201.91989	0.0	0.00000	\N	\N	\N	\N
1361	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:36:09+00	\N	180.58161	0.0	0.00000	\N	\N	\N	\N
1362	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:38:11+00	\N	205.13184	0.0	0.00000	\N	\N	\N	\N
1363	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:40:15+00	\N	241.97388	0.0	0.00000	\N	\N	\N	\N
1364	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:42:18+00	\N	174.96621	0.0	0.00000	\N	\N	\N	\N
1365	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:44:20+00	\N	218.63867	0.0	0.00000	\N	\N	\N	\N
1366	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:46:23+00	\N	243.10234	0.0	0.00000	\N	\N	\N	\N
1367	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:48:25+00	\N	222.65266	0.0	0.00000	\N	\N	\N	\N
1368	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:50:28+00	\N	235.00775	0.0	0.00000	\N	\N	\N	\N
1369	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:52:30+00	\N	276.36246	0.0	0.00000	\N	\N	\N	\N
1370	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:54:33+00	\N	231.87436	0.0	0.00000	\N	\N	\N	\N
1371	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:56:35+00	\N	214.87966	0.0	0.00000	\N	\N	\N	\N
1372	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 15:58:38+00	\N	265.20939	0.0	0.00000	\N	\N	\N	\N
1373	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:00:41+00	\N	266.95782	0.0	0.00000	\N	\N	\N	\N
1374	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:02:44+00	\N	207.24872	0.0	0.00000	\N	\N	\N	\N
1375	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:04:51+00	\N	255.34070	0.0	0.00000	\N	\N	\N	\N
1376	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:06:53+00	\N	223.87031	0.0	0.00000	\N	\N	\N	\N
1377	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:08:58+00	\N	338.73064	21.8	269.34628	\N	\N	\N	\N
1378	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:11:02+00	\N	227.34499	0.0	0.00000	\N	\N	\N	\N
1379	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:11:02+00	\N	227.34499	0.0	0.00000	\N	\N	\N	\N
1380	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:13:07+00	\N	158.58727	22.8	16.63575	\N	\N	\N	\N
1381	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:15:10+00	\N	153.80896	29.8	272.40491	\N	\N	\N	\N
1382	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:17:14+00	\N	151.96810	25.2	235.29823	\N	\N	\N	\N
1383	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:19:16+00	\N	143.16188	0.0	0.00000	\N	\N	\N	\N
1384	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:21:19+00	\N	151.54806	0.0	0.00000	\N	\N	\N	\N
1385	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:23:23+00	\N	118.35828	0.0	0.00000	\N	\N	\N	\N
1386	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:25:26+00	\N	93.07239	27.5	348.85513	\N	\N	\N	\N
1387	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:27:30+00	\N	65.82455	26.1	344.37808	\N	\N	\N	\N
1388	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:29:32+00	\N	69.16727	22.3	292.67218	\N	\N	\N	\N
1389	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:31:35+00	\N	80.13149	0.0	0.00000	\N	\N	\N	\N
1390	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:33:37+00	\N	63.99849	19.5	297.77524	\N	\N	\N	\N
1391	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:35:42+00	\N	81.44192	0.0	0.00000	\N	\N	\N	\N
1392	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:37:47+00	\N	89.03619	23.0	278.93558	\N	\N	\N	\N
1393	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:39:51+00	\N	88.58311	0.0	0.00000	\N	\N	\N	\N
1394	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:41:54+00	\N	100.45986	0.0	0.00000	\N	\N	\N	\N
1395	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:43:58+00	\N	106.32168	0.0	0.00000	\N	\N	\N	\N
1396	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:46:08+00	\N	93.27480	0.0	0.00000	\N	\N	\N	\N
1397	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:48:17+00	\N	58.96672	0.0	0.00000	\N	\N	\N	\N
1398	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:50:23+00	\N	98.84715	0.0	0.00000	\N	\N	\N	\N
1399	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:52:37+00	\N	130.69641	0.0	0.00000	\N	\N	\N	\N
1400	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:54:52+00	\N	81.67397	0.0	0.00000	\N	\N	\N	\N
1401	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:57:06+00	\N	124.20540	0.0	0.00000	\N	\N	\N	\N
1402	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 16:59:15+00	\N	103.08276	0.0	0.00000	\N	\N	\N	\N
1403	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:01:30+00	\N	6.46054	0.0	0.00000	\N	\N	\N	\N
1404	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:03:46+00	\N	127.85283	0.0	0.00000	\N	\N	\N	\N
1405	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:06:02+00	\N	65.49579	0.0	0.00000	\N	\N	\N	\N
1406	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:08:12+00	\N	83.66673	0.0	0.00000	\N	\N	\N	\N
1407	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:10:22+00	\N	95.43977	0.0	0.00000	\N	\N	\N	\N
1408	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:12:31+00	\N	125.69916	0.0	0.00000	\N	\N	\N	\N
1409	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:14:39+00	\N	102.07652	0.0	0.00000	\N	\N	\N	\N
1410	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:16:49+00	\N	85.88842	0.0	0.00000	\N	\N	\N	\N
1411	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:18:59+00	\N	81.58980	0.0	0.00000	\N	\N	\N	\N
1412	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:21:10+00	\N	170.20714	0.0	0.00000	\N	\N	\N	\N
1413	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:23:20+00	\N	13.72055	0.0	0.00000	\N	\N	\N	\N
1414	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:25:29+00	\N	94.18628	0.0	0.00000	\N	\N	\N	\N
1415	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:27:38+00	\N	48.88631	0.0	0.00000	\N	\N	\N	\N
1416	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:29:49+00	\N	160.23621	0.0	0.00000	\N	\N	\N	\N
1417	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:32:05+00	\N	62.13086	0.0	0.00000	\N	\N	\N	\N
1418	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:34:14+00	\N	141.03163	0.0	0.00000	\N	\N	\N	\N
1419	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:36:25+00	\N	79.38320	0.0	0.00000	\N	\N	\N	\N
1420	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:38:36+00	\N	112.22670	0.0	0.00000	\N	\N	\N	\N
1421	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:40:44+00	\N	63.14650	0.0	0.00000	\N	\N	\N	\N
1422	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:42:57+00	\N	96.24970	0.0	0.00000	\N	\N	\N	\N
1423	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:45:08+00	\N	104.41220	0.0	0.00000	\N	\N	\N	\N
1424	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:47:51+00	\N	100.00000	0.0	0.00000	\N	\N	\N	\N
1425	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:50:06+00	\N	92.23238	0.0	0.00000	\N	\N	\N	\N
1426	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:52:18+00	\N	123.25989	0.0	0.00000	\N	\N	\N	\N
1427	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:54:35+00	\N	100.01967	0.0	0.00000	\N	\N	\N	\N
1428	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:56:49+00	\N	110.07779	0.0	0.00000	\N	\N	\N	\N
1429	29	(2.29450000000000021,48.8582222200000018)	2016-02-19 17:59:07+00	\N	23.19553	0.0	0.00000	\N	\N	\N	\N
1584	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:19:07.139+00	23.0	0.00000	0.0	\N	\N	\N	\N	\N
1585	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:04:58.36+00	16.0	51.09192	0.0	\N	\N	\N	\N	\N
1586	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:10:06.514+00	32.0	125.56415	0.0	\N	\N	\N	\N	\N
1587	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:15:10.64+00	48.0	49.37104	11.9	\N	\N	\N	\N	\N
1588	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:25:08.381+00	48.0	109.73980	0.0	\N	\N	\N	\N	\N
1589	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:30:09.154+00	48.0	83.58111	0.0	\N	\N	\N	\N	\N
1590	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:40:11.156+00	24.0	66.52248	8.5	\N	\N	\N	\N	\N
1591	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 10:50:06.515+00	48.0	48.34206	0.0	\N	\N	\N	\N	\N
1592	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:00:03.189+00	48.0	111.46332	30.3	\N	\N	\N	\N	\N
1593	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:10:03.251+00	24.0	206.32573	30.9	\N	\N	\N	\N	\N
1594	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:20:00.955+00	32.0	97.54374	22.7	\N	\N	\N	\N	\N
1595	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:25:04.288+00	24.0	87.00727	30.9	\N	\N	\N	\N	\N
1596	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:35:01.882+00	24.0	94.24696	30.0	\N	\N	\N	\N	\N
1597	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:40:10.616+00	32.0	170.12395	26.9	\N	\N	\N	\N	\N
1598	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:50:01.38+00	48.0	17.60809	16.3	\N	\N	\N	\N	\N
1599	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 11:55:03.442+00	16.0	16.94053	0.0	\N	\N	\N	\N	\N
1600	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 12:05:03.349+00	32.0	11.81109	0.0	\N	\N	\N	\N	\N
1601	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 12:10:06.537+00	32.0	19.34044	0.0	\N	\N	\N	\N	\N
1602	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 12:20:07.55+00	16.0	32.07724	0.0	\N	\N	\N	\N	\N
1603	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:10:09.334+00	24.0	23.29288	0.0	\N	\N	\N	\N	\N
1604	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:20:28.425+00	64.0	17.89340	0.0	\N	\N	\N	\N	\N
1605	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:43:27.46+00	64.0	20.78518	0.0	\N	\N	\N	\N	\N
1606	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:48:27.82+00	32.0	24.14507	0.0	\N	\N	\N	\N	\N
1607	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:53:28.792+00	24.0	21.19114	0.0	\N	\N	\N	\N	\N
1608	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 14:58:29.3+00	12.0	21.12493	1.5	\N	\N	\N	\N	\N
1609	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:03:29.92+00	12.0	14.91000	1.5	\N	\N	\N	\N	\N
1610	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:08:30.416+00	16.0	14.16052	3.4	\N	\N	\N	\N	\N
1611	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:13:30.629+00	16.0	31.10615	31.4	\N	\N	\N	\N	\N
1612	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:18:31.649+00	16.0	46.47290	26.4	\N	\N	\N	\N	\N
1613	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:23:32.52+00	24.0	178.95087	26.1	\N	\N	\N	\N	\N
1614	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:28:32.988+00	24.0	123.36554	25.1	\N	\N	\N	\N	\N
1615	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:33:33.173+00	16.0	72.06099	25.7	\N	\N	\N	\N	\N
1616	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:38:33.696+00	24.0	50.52177	26.4	\N	\N	\N	\N	\N
1617	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:43:34+00	24.0	114.15440	27.0	\N	\N	\N	\N	\N
1618	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:48:34.876+00	32.0	91.05626	25.8	\N	\N	\N	\N	\N
1619	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:53:35.945+00	24.0	172.98328	27.4	\N	\N	\N	\N	\N
1620	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 15:58:36.853+00	24.0	224.66151	27.5	\N	\N	\N	\N	\N
1621	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:08:37.654+00	24.0	117.04468	27.4	\N	\N	\N	\N	\N
1622	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:18:37.77+00	32.0	91.70271	27.1	\N	\N	\N	\N	\N
1623	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:23:38.264+00	48.0	37.52547	19.6	\N	\N	\N	\N	\N
1624	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:28:39.234+00	12.0	41.92637	6.0	\N	\N	\N	\N	\N
1625	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:33:50.132+00	48.0	78.80940	24.4	\N	\N	\N	\N	\N
1626	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:38:50.798+00	16.0	75.52290	22.5	\N	\N	\N	\N	\N
1627	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:43:51.704+00	24.0	68.09069	10.9	\N	\N	\N	\N	\N
1628	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:53:52.854+00	16.0	58.24796	5.3	\N	\N	\N	\N	\N
1629	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 16:59:58.571+00	48.0	51.63332	5.0	\N	\N	\N	\N	\N
1630	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 17:04:58.702+00	24.0	40.75135	10.2	\N	\N	\N	\N	\N
1631	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 17:09:59.035+00	8.0	36.48204	0.0	\N	\N	\N	\N	\N
1632	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 17:14:59.739+00	8.0	38.30668	0.0	\N	\N	\N	\N	\N
1633	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:20:07.444+00	28.0	0.00000	0.0	\N	\N	\N	\N	\N
1634	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:20:27.395+00	21.0	0.00000	0.0	\N	\N	\N	\N	\N
1635	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:20:32.541+00	16.0	35.29953	0.0	\N	\N	\N	\N	\N
1636	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:21:41.363+00	20.0	0.00000	0.0	\N	\N	\N	\N	\N
1637	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:21:52.355+00	32.0	68.84431	0.0	\N	\N	\N	\N	\N
1638	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:21:57.812+00	24.0	67.74007	0.0	\N	\N	\N	\N	\N
1639	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:22:03.822+00	16.0	70.75603	0.0	\N	\N	\N	\N	\N
1640	3	(2.29450000000000021,48.8582222200000018)	2015-12-14 21:22:12.777+00	48.0	76.91284	2.0	\N	\N	\N	\N	\N
15233	29	(2.29450000000000021,48.8582222200000018)	2016-02-29 13:14:59+00	\N	\N	\N	\N	\N	\N	\N	\N
15234	29	(2.29450000000000021,48.8582222200000018)	2016-02-29 13:14:59+00	1320.0	\N	\N	\N	\N	\N	\N	\N
15235	29	(2.29450000000000021,48.8582222200000018)	2016-02-29 13:14:59+00	1320.0	0.00000	0.0	0.00000	\N	\N	\N	\N
15236	29	(2.29450000000000021,48.8582222200000018)	2016-02-29 13:36:32+00	1320.0	0.00000	0.0	0.00000	\N	\N	\N	\N
15237	29	(2.29450000000000021,48.8582222200000018)	2016-02-29 14:32:50+00	1596.9	261.73477	0.0	0.37360	\N	\N	\N	\N
15238	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 13:28:38+01	22.0	0.00000	0.0	0.00000	\N	\N	\N	\N
15239	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 13:28:38+01	22.0	0.00000	0.0	0.00000	\N	\N	\N	\N
15240	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 13:28:38+01	22.0	0.00000	0.0	0.00000	\N	\N	\N	\N
15241	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 13:28:38+01	22.0	0.00000	0.0	0.00000	31	network	92.0	\N
15242	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:07:46+01	40.5	0.00000	0.0	0.00000	31	network	90.0	\N
15243	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:08:14+01	36.0	0.00000	0.0	0.00000	31	network	90.0	\N
15244	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:08:35+01	26.0	0.00000	0.0	0.00000	31	network	90.0	\N
15245	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:08:56+01	24.0	0.00000	0.0	0.00000	31	network	89.0	\N
15246	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:09:13+01	9.0	109.00000	0.0	0.00000	31	gps	89.0	\N
15247	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:09:29+01	11.0	109.00000	0.0	0.00000	31	gps	89.0	\N
15248	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:09:53+01	33.0	0.00000	0.0	0.00000	22	network	89.0	\N
15249	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:10:09+01	6.0	106.00000	0.0	0.00000	22	gps	89.0	\N
15250	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:10:25+01	5.0	106.00000	0.0	0.00000	22	gps	89.0	\N
15251	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:10:40+01	5.0	106.00000	0.0	0.00000	23	gps	89.0	\N
15252	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:10:56+01	11.0	106.00000	0.0	0.00000	23	gps	89.0	\N
15253	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:11:11+01	11.0	106.00000	0.0	0.00000	23	gps	89.0	\N
15254	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:11:27+01	10.0	106.00000	0.0	0.00000	23	gps	89.0	\N
15255	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:11:43+01	10.0	106.00000	0.0	0.00000	23	gps	89.0	\N
15256	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:11:58+01	10.0	106.00000	0.0	0.00000	23	gps	88.0	\N
15257	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:12:14+01	11.0	106.00000	0.0	0.00000	23	gps	88.0	\N
15258	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:12:30+01	11.0	106.00000	0.0	0.00000	23	gps	88.0	\N
15259	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:12:51+01	37.5	0.00000	0.0	0.00000	23	network	88.0	\N
15260	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 14:13:10+01	37.5	0.00000	0.0	0.00000	23	network	88.0	\N
15261	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 20:22:50+01	48.0	0.00000	0.0	0.00000	19	network	80.0	\N
15262	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 20:23:09+01	24.0	0.00000	0.0	0.00000	19	network	79.0	Test note
15263	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 20:23:32+01	34.5	0.00000	0.0	0.00000	19	network	79.0	\N
15264	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 20:24:29+01	39.0	0.00000	0.0	0.00000	19	network	79.0	\N
15265	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 20:25:37+01	25.0	0.00000	0.0	0.00000	19	network	79.0	\N
15266	29	(2.29450000000000021,48.8582222200000018)	2016-04-22 20:26:38+01	28.0	0.00000	0.0	0.00000	19	network	79.0	A longer note than the previous one.
15416	29	(2.29450000000000021,48.8582222200000018)	2017-01-15 13:36:26.292+00	20.0	-46.72000	0.0	0.00000	\N	\N	\N	\N
15417	29	(2.29450000000000021,48.8582222200000018)	2017-01-15 13:36:57.189+00	13.0	40.28000	0.0	0.00000	\N	\N	\N	\N
15418	29	(2.29450000000000021,48.8582222200000018)	2017-01-15 13:37:28.148+00	12.0	42.28000	0.0	0.00000	\N	\N	\N	\N
15419	29	(2.29450000000000021,48.8582222200000018)	2017-01-15 13:40:10+00	31.0	0.00000	0.0	0.00000	5	gps	56.0	\N
15420	29	(2.29450000000000021,48.8582222200000018)	2017-01-15 13:34:28.073+00	27.2	-46.72000	38.4	43.80000	\N	\N	\N	\N
15422	29	(2.29450000000000021,48.8582222200000018)	2017-01-15 15:53:18.14+00	23.0	-46.72000	0.0	0.00000	\N	\N	\N	\N
15423	29	(2.29450000000000021,48.8582222200000018)	2017-01-15 15:54:44+00	46.0	74.00000	0.0	0.00000	9	gps	54.0	\N
15424	3	(2.29450000000000021,48.8582222200000018)	2017-01-15 16:05:24+00	27.0	0.00000	0.2	5.10000	6	gps	53.0	\N
15425	3	(2.29450000000000021,48.8582222200000018)	2017-01-15 16:05:38+00	17.0	59.00000	0.0	0.00000	4	gps	53.0	\N
15426	3	(2.29450000000000021,48.8582222200000018)	2017-01-15 16:11:42+00	42.0	0.00000	0.4	149.50000	9	gps	53.0	\N
15427	3	(2.29450000000000021,48.8582222200000018)	2017-01-15 16:12:03+00	43.0	63.00000	0.0	0.00000	10	gps	53.0	\N
15428	3	(2.29450000000000021,48.8582222200000018)	2017-01-15 16:31:18+00	83.0	0.00000	0.0	0.00000	10	gps	52.0	\N
15429	3	(2.29450000000000021,48.8582222200000018)	2017-01-15 16:45:15+00	12.0	62.00000	0.0	0.00000	9	gps	52.0	\N
15430	3	(2.29450000000000021,48.8582222200000018)	2017-01-15 17:04:58+00	33.0	0.00000	0.0	0.00000	8	gps	52.0	\N
15431	3	(2.29450000000000021,48.8582222200000018)	2017-01-15 18:18:49+00	20.0	0.00000	0.0	0.00000	11	gps	51.0	\N
15432	3	(2.29450000000000021,48.8582222200000018)	2017-01-15 22:12:38.323+00	27.0	0.00000	0.3	172.70000	7	gps	45.0	\N
15455	29	(2.29450000000000021,48.8582222200000018)	2017-01-18 16:44:09+00	\N	118.00000	0.0	0.00000	\N	\N	73.0	\N
\.


--
-- Name: location_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('location_seq', 15455, true);


--
-- Data for Name: location_sharing; Type: TABLE DATA; Schema: public; Owner: -
--

COPY location_sharing (shared_by_id, shared_to_id, recent_minutes, max_minutes, active) FROM stdin;
2	29	\N	\N	t
3	29	\N	\N	t
3	1	\N	\N	t
\.


--
-- Data for Name: path_color; Type: TABLE DATA; Schema: public; Owner: -
--

COPY path_color (key, value, html_code) FROM stdin;
Black	Black	black
White	White	white
Red	Red	red
Yellow	Yellow	yellow
Blue	Blue	blue
Magenta	Magenta	fuchsia
Cyan	Cyan	aqua
DarkRed	Dark Red	maroon
Green	Green	lime
DarkGreen	Dark Green	green
LightGray	Light Gray	silver
DarkGray	Dark Gray	gray
DarkBlue	Dark Blue	navy
DarkMagenta	Dark Magenta	purple
DarkYellow	Dark Yellow	olive
DarkCyan	Dark Cyan	teal
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY role (id, name) FROM stdin;
1	Admin
2	User
\.


--
-- Name: role_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('role_seq', 2, true);


--
-- Name: tile_download_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tile_download_seq', 180, true);


--
-- Data for Name: tile_metric; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tile_metric ("time", count) FROM stdin;
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_role (user_id, role_id) FROM stdin;
1	1
99	1
\.


--
-- Data for Name: usertable; Type: TABLE DATA; Schema: public; Owner: -
--

COPY usertable (id, firstname, lastname, email, uuid, password, nickname) FROM stdin;
62	oswald	smith	oswald@trip.test	d7cb7b56-f53c-4c64-a795-fdb256775b80	$2a$10$YoVIqJLcUD.AW6ZU7JxUzOoGkumJk0QZyisc0I/3LIdBK6Hq.UrTy	oswald5
63	Oswald	Jones	oswald6@trip.test	7edf973d-312c-489b-9784-34aad58861d8	$2a$10$5iUvXmI0rEJKzPW26tpuQO6j3EhZwGsVd./WH6IbOIpgdrU0rNhES	oswald6
31	test	test	tes999t@trip.test	14c9a561-522b-8932-97e0-b6b916296c21	$2y$10$sr0pxDTRTmA9nPfm/I67LO5tLZbqtdVkrRVdKWRq.WIIXoX0/xFPW	test997u9879
32	test	test	test998@trip.test	23b10128-7001-68ab-2150-f36e73a923f4	$2y$10$1LmJbfDKhmDecam19rGTDOA3Sj8XA4VLEwVnb9APKIQGodCyKgLce	tset99
30	test	test	tes99t@trip.test	f2017e90-6f0b-24a9-ee41-e6a93530a5e7	$2a$10$lHw51RHaxpsSsJzFEih5i.49zLK6LUlCrlIjw.3eDEK5jX.pJR1Uu	test997u987
456	purple	purple	purple@trip.test	3ef65320-f920-4e88-a3a6-bdf36bb17532	$2a$10$YGUYdOlkdi1NamxkppzV9ekIAwrq32IhlwNyzFOU.teemJzhDAcKm	purple
791	Orange	Orange	orange@trip.test	bd54bb2d-4f64-4ace-ad4a-cc0fc4152378	$2a$10$CUzhW4pxQKEPfZxA1JwnxupDP7LyxYTAj2ueobipHWivVMEuZK1ne	orange
1	admin	admin	admin@trip.test	38de8ade-de0b-4c71-a7ff-7ec37ab5c781	$2a$10$oKt167vnqz7QyBvA8h5JHuYKfiW29Na35Bpl.LtBo2Yxg.m5c0wlm	admin
2	Test	Test	test2@trip.test	f68a8d21-6e39-e1f5-79f5-55dc9603b138	$2y$10$u26z37kPq5hHDFBSQe6.weD1wnjgw2S4IcZubBf2.OiSDz4AQmMGO	test2
3	Fred	Test	fred@trip.test	1103c87d-d0f6-e01a-2114-27699feea78b	$2a$10$CNiaAPQX6ANmbe3SYzhSD.fzmmd4Zw.ga3j3hmbxI3tOYU7dW8Sae	Fred
4	John	Test	john@trip.test	389561bd-1365-eab3-1e6f-3295e14491f1	$2y$10$fy1fmvCZ4T/gXLIVSmRftuMd/DoPUc1u1iJDeSMrKHdHCYXjt/f8y	John
5	Jane	Test	jane@trip.test	1280186b-2d80-6f34-ae56-525d576f133f	$2y$10$8XTbrY9LooDhCClYiZ4BZOR4amciyOFpEdPtaNmL9..uizayg.wQe	Jane
6	Adam	Test	adam@trip.test	45448370-02a1-aabc-0f41-c7dfb63f050d	$2y$10$/bfCvk6wGdrRm.skSmcnoOlWRDGrvTBg3xE3VowPJrf3l8E3eDa5.	Adam
7	Adam	Test	adam2@trip.test	628f8e5e-a7aa-a100-e87e-04daca339255	$2y$10$xlK.3YKn2zh8duQoE2f7r.mYfovQLOS3DJ4.Fx7lqWl6.tzowgotC	Adam2
9	Adam	Test	adam3@trip.test	ac039082-7574-62b7-a035-3f35e1b4c1a1	$2y$10$8fYio5H.clRBAOfqqzN4Dea9RJKhnl26H3rhDaApaHqLm.0hbPhru	Adam3
10	test	test	oswald1@trip.test	789cec4d-3980-19a3-9515-a6f53f1dba86	$2y$10$Ur/yQeKkOjUX0BQnWc6ZqeXIFEkqni.3/VvB4tFCsAWU1Fu/HgZxm	oswald
11	test	test	oswald2@trip.test	6830d8fb-a71c-9a41-cd11-4eaf5e58496e	$2y$10$CJkQGukvcGBoEZnWmzOh9e2nHb4BLSFWGMjptN.3Aa0DZHFOmLTqq	oswald2
12	test	test	oswald3@trip.test	7ca61784-93da-db15-011f-80b71dc947d2	$2y$10$5LGcQ.mGzVRYm5noUojrJ.HL660x9/omQm5yoEpNrUFkzXbB6NdMK	oswald3
13	test	test	oswald4@trip.test	af5f4dfd-dce8-95b9-fd1c-956b165a08ea	$2y$10$5OKage5jjnsH5tY6sCd7l.ulY.uGpFjERyWg3P.K.59DHK5JrqI8i	oswald4
670	John	Smith	test@trip.test	c33aae96-050b-41b8-9304-a9779c7c6708	$2a$10$nxCIaZdDxggtTfudKS31L.QQ6A404cdvl1a/tdascYdxAI.kamaom	test
29	user	user	user@trip.test	b1d747dc-197f-4aee-b095-296612a4081d	$2a$10$UbA8Zjohob/0.XO0poqh7.FxXNuajfh2sLQCMG5MLJylYgCPHGcUm	user
\.


--
-- Name: usertable_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('usertable_seq', 920, true);


--
-- Data for Name: waypoint_symbol; Type: TABLE DATA; Schema: public; Owner: -
--

COPY waypoint_symbol (key, value) FROM stdin;
ATV	ATV
Airport	Airport
Amusement Park	Amusement Park
Anchor	Anchor
Animal Tracks	Animal Tracks
Ball Park	Ball Park
Bank	Bank
Bar	Bar
Beach	Beach
Bell	Bell
Big Game	Big Game
Bike Trail	Bike Trail
Blind	Blind
Block, Blue	Block, Blue
Block, Green	Block, Green
Block, Red	Block, Red
Blood Trail	Blood Trail
Boat Ramp	Boat Ramp
Bowling	Bowling
Bridge	Bridge
Building	Building
Buoy, White	Buoy, White
Campground	Campground
Car	Car
Car Rental	Car Rental
Car Repair	Car Repair
Cemetery	Cemetery
Church	Church
City (Large)	City (Large)
City (Medium)	City (Medium)
City (Small)	City (Small)
Civil	Civil
Controlled Area	Controlled Area
Convenience Store	Convenience Store
Covey	Covey
Crossing	Crossing
Dam	Dam
Danger Area	Danger Area
Department Store	Department Store
Diver Down Flag 1	Diver Down Flag 1
Diver Down Flag 2	Diver Down Flag 2
Drinking Water	Drinking Water
Fast Food	Fast Food
Fishing Area	Fishing Area
Fishing Hot Spot Facility	Fishing Hot Spot Facility
Fitness Center	Fitness Center
Flag, Blue	Flag, Blue
Flag, Green	Flag, Green
Flag, Red	Flag, Red
Food Source	Food Source
Forest	Forest
Furbearer	Furbearer
Gas Station	Gas Station
Geocache	Geocache
Geocache Found	Geocache Found
Glider Area	Glider Area
Golf Course	Golf Course
Horn	Horn
Ice Skating	Ice Skating
Information	Information
Light	Light
Live Theater	Live Theater
Lodge	Lodge
Lodging	Lodging
Man Overboard	Man Overboard
Medical Facility	Medical Facility
Mine	Mine
Movie Theater	Movie Theater
Museum	Museum
Navaid, Amber	Navaid, Amber
Navaid, Black	Navaid, Black
Navaid, Blue	Navaid, Blue
Navaid, Green	Navaid, Green
Navaid, Green/Red	Navaid, Green/Red
Navaid, Green/White	Navaid, Green/White
Navaid, Orange	Navaid, Orange
Navaid, Red	Navaid, Red
Navaid, Red/Green	Navaid, Red/Green
Navaid, Red/White	Navaid, Red/White
Navaid, Violet	Navaid, Violet
Navaid, White	Navaid, White
Navaid, White/Green	Navaid, White/Green
Navaid, White/Red	Navaid, White/Red
Oil Field	Oil Field
Parachute Area	Parachute Area
Park	Park
Parking Area	Parking Area
Pharmacy	Pharmacy
Picnic Area	Picnic Area
Pin, Blue	Pin, Blue
Pin, Green	Pin, Green
Pin, Red	Pin, Red
Pizza	Pizza
Police Station	Police Station
Post Office	Post Office
RV Park	RV Park
Radio Beacon	Radio Beacon
Residence	Residence
Restaurant	Restaurant
Restricted Area	Restricted Area
Restroom	Restroom
Scales	Scales
Scenic Area	Scenic Area
School	School
Shipwreck	Shipwreck
Shopping Center	Shopping Center
Short Tower	Short Tower
Shower	Shower
Ski Resort	Ski Resort
Skiing Area	Skiing Area
Skull and Crossbones	Skull and Crossbones
Small Game	Small Game
Stadium	Stadium
Summit	Summit
Swimming Area	Swimming Area
Tall Tower	Tall Tower
Telephone	Telephone
Toll Booth	Toll Booth
Trail Head	Trail Head
Tree Stand	Tree Stand
Treed Quarry	Treed Quarry
Truck	Truck
Truck Stop	Truck Stop
Tunnel	Tunnel
Ultralight Area	Ultralight Area
Upland Game	Upland Game
Water Source	Water Source
Waterfowl	Waterfowl
Wrecker	Wrecker
Zoo	Zoo
\.


--
-- Name: georef_format_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY georef_format
    ADD CONSTRAINT georef_format_pkey PRIMARY KEY (key);


--
-- Name: georef_format_value_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY georef_format
    ADD CONSTRAINT georef_format_value_key UNIQUE (value);


--
-- Name: itinerary_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY itinerary
    ADD CONSTRAINT itinerary_pkey PRIMARY KEY (id);


--
-- Name: itinerary_route_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY itinerary_route
    ADD CONSTRAINT itinerary_route_pkey PRIMARY KEY (id);


--
-- Name: itinerary_route_point_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY itinerary_route_point
    ADD CONSTRAINT itinerary_route_point_pkey PRIMARY KEY (id);


--
-- Name: itinerary_sharing_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY itinerary_sharing
    ADD CONSTRAINT itinerary_sharing_pkey PRIMARY KEY (itinerary_id, shared_to_id);


--
-- Name: itinerary_track_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY itinerary_track
    ADD CONSTRAINT itinerary_track_pkey PRIMARY KEY (id);


--
-- Name: itinerary_track_point_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY itinerary_track_point
    ADD CONSTRAINT itinerary_track_point_pkey PRIMARY KEY (id);


--
-- Name: itinerary_track_segment_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY itinerary_track_segment
    ADD CONSTRAINT itinerary_track_segment_pkey PRIMARY KEY (id);


--
-- Name: itinerary_waypoint_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY itinerary_waypoint
    ADD CONSTRAINT itinerary_waypoint_pkey PRIMARY KEY (id);


--
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- Name: location_sharing_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY location_sharing
    ADD CONSTRAINT location_sharing_pkey PRIMARY KEY (shared_by_id, shared_to_id);


--
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: tile_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tile
    ADD CONSTRAINT tile_pkey PRIMARY KEY (server_id, x, y, z);


--
-- Name: track_color_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY path_color
    ADD CONSTRAINT track_color_pkey PRIMARY KEY (key);


--
-- Name: track_color_value_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY path_color
    ADD CONSTRAINT track_color_value_key UNIQUE (value);


--
-- Name: user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: usertable_email_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usertable
    ADD CONSTRAINT usertable_email_key UNIQUE (email);


--
-- Name: usertable_nickname_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usertable
    ADD CONSTRAINT usertable_nickname_key UNIQUE (nickname);


--
-- Name: usertable_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usertable
    ADD CONSTRAINT usertable_pkey PRIMARY KEY (id);


--
-- Name: usertable_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usertable
    ADD CONSTRAINT usertable_uuid_key UNIQUE (uuid);


--
-- Name: waypoint_symbol_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY waypoint_symbol
    ADD CONSTRAINT waypoint_symbol_pkey PRIMARY KEY (key);


--
-- Name: waypoint_symbol_value_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY waypoint_symbol
    ADD CONSTRAINT waypoint_symbol_value_key UNIQUE (value);


--
-- Name: idx_time_inverse; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_time_inverse ON location USING btree (id, "time" DESC);

ALTER TABLE location CLUSTER ON idx_time_inverse;


--
-- Name: itinerary_route_itinerary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_route
    ADD CONSTRAINT itinerary_route_itinerary_id_fkey FOREIGN KEY (itinerary_id) REFERENCES itinerary(id) ON DELETE CASCADE;


--
-- Name: itinerary_route_point_itinerary_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_route_point
    ADD CONSTRAINT itinerary_route_point_itinerary_route_id_fkey FOREIGN KEY (itinerary_route_id) REFERENCES itinerary_route(id) ON DELETE CASCADE;


--
-- Name: itinerary_sharing_itinerary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_sharing
    ADD CONSTRAINT itinerary_sharing_itinerary_id_fkey FOREIGN KEY (itinerary_id) REFERENCES itinerary(id) ON DELETE CASCADE;


--
-- Name: itinerary_sharing_shared_to_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_sharing
    ADD CONSTRAINT itinerary_sharing_shared_to_id_fkey FOREIGN KEY (shared_to_id) REFERENCES usertable(id) ON DELETE CASCADE;


--
-- Name: itinerary_track_itinerary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_track
    ADD CONSTRAINT itinerary_track_itinerary_id_fkey FOREIGN KEY (itinerary_id) REFERENCES itinerary(id) ON DELETE CASCADE;


--
-- Name: itinerary_track_point_itinerary_track_segment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_track_point
    ADD CONSTRAINT itinerary_track_point_itinerary_track_segment_id_fkey FOREIGN KEY (itinerary_track_segment_id) REFERENCES itinerary_track_segment(id) ON DELETE CASCADE;


--
-- Name: itinerary_track_segment_itinerary_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_track_segment
    ADD CONSTRAINT itinerary_track_segment_itinerary_track_id_fkey FOREIGN KEY (itinerary_track_id) REFERENCES itinerary_track(id) ON DELETE CASCADE;


--
-- Name: itinerary_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary
    ADD CONSTRAINT itinerary_user_id_fkey FOREIGN KEY (user_id) REFERENCES usertable(id);


--
-- Name: itinerary_waypoint_itinerary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY itinerary_waypoint
    ADD CONSTRAINT itinerary_waypoint_itinerary_id_fkey FOREIGN KEY (itinerary_id) REFERENCES itinerary(id) ON DELETE CASCADE;


--
-- Name: location_sharing_shared_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY location_sharing
    ADD CONSTRAINT location_sharing_shared_by_id_fkey FOREIGN KEY (shared_by_id) REFERENCES usertable(id) ON DELETE CASCADE;


--
-- Name: location_sharing_shared_to_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY location_sharing
    ADD CONSTRAINT location_sharing_shared_to_id_fkey FOREIGN KEY (shared_to_id) REFERENCES usertable(id) ON DELETE CASCADE;


--
-- Name: location_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_user_id_fkey FOREIGN KEY (user_id) REFERENCES usertable(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: georef_format; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE georef_format FROM PUBLIC;
REVOKE ALL ON TABLE georef_format FROM trip;
GRANT ALL ON TABLE georef_format TO trip;
GRANT SELECT ON TABLE georef_format TO trip_role;


--
-- Name: itinerary; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE itinerary FROM PUBLIC;
REVOKE ALL ON TABLE itinerary FROM trip;
GRANT ALL ON TABLE itinerary TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE itinerary TO trip_role;


--
-- Name: itinerary_route; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE itinerary_route FROM PUBLIC;
REVOKE ALL ON TABLE itinerary_route FROM trip;
GRANT ALL ON TABLE itinerary_route TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE itinerary_route TO trip_role;


--
-- Name: itinerary_route_point; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE itinerary_route_point FROM PUBLIC;
REVOKE ALL ON TABLE itinerary_route_point FROM trip;
GRANT ALL ON TABLE itinerary_route_point TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE itinerary_route_point TO trip_role;


--
-- Name: itinerary_route_point_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE itinerary_route_point_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE itinerary_route_point_seq FROM trip;
GRANT ALL ON SEQUENCE itinerary_route_point_seq TO trip;
GRANT USAGE ON SEQUENCE itinerary_route_point_seq TO trip_role;


--
-- Name: itinerary_route_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE itinerary_route_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE itinerary_route_seq FROM trip;
GRANT ALL ON SEQUENCE itinerary_route_seq TO trip;
GRANT USAGE ON SEQUENCE itinerary_route_seq TO trip_role;


--
-- Name: itinerary_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE itinerary_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE itinerary_seq FROM trip;
GRANT ALL ON SEQUENCE itinerary_seq TO trip;
GRANT USAGE ON SEQUENCE itinerary_seq TO trip_role;


--
-- Name: itinerary_sharing; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE itinerary_sharing FROM PUBLIC;
REVOKE ALL ON TABLE itinerary_sharing FROM trip;
GRANT ALL ON TABLE itinerary_sharing TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE itinerary_sharing TO trip_role;


--
-- Name: itinerary_track; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE itinerary_track FROM PUBLIC;
REVOKE ALL ON TABLE itinerary_track FROM trip;
GRANT ALL ON TABLE itinerary_track TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE itinerary_track TO trip_role;


--
-- Name: itinerary_track_point; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE itinerary_track_point FROM PUBLIC;
REVOKE ALL ON TABLE itinerary_track_point FROM trip;
GRANT ALL ON TABLE itinerary_track_point TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE itinerary_track_point TO trip_role;


--
-- Name: itinerary_track_point_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE itinerary_track_point_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE itinerary_track_point_seq FROM trip;
GRANT ALL ON SEQUENCE itinerary_track_point_seq TO trip;
GRANT USAGE ON SEQUENCE itinerary_track_point_seq TO trip_role;


--
-- Name: itinerary_track_segment; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE itinerary_track_segment FROM PUBLIC;
REVOKE ALL ON TABLE itinerary_track_segment FROM trip;
GRANT ALL ON TABLE itinerary_track_segment TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE itinerary_track_segment TO trip_role;


--
-- Name: itinerary_track_segment_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE itinerary_track_segment_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE itinerary_track_segment_seq FROM trip;
GRANT ALL ON SEQUENCE itinerary_track_segment_seq TO trip;
GRANT USAGE ON SEQUENCE itinerary_track_segment_seq TO trip_role;


--
-- Name: itinerary_track_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE itinerary_track_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE itinerary_track_seq FROM trip;
GRANT ALL ON SEQUENCE itinerary_track_seq TO trip;
GRANT USAGE ON SEQUENCE itinerary_track_seq TO trip_role;


--
-- Name: itinerary_waypoint; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE itinerary_waypoint FROM PUBLIC;
REVOKE ALL ON TABLE itinerary_waypoint FROM trip;
GRANT ALL ON TABLE itinerary_waypoint TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE itinerary_waypoint TO trip_role;


--
-- Name: itinerary_waypoint_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE itinerary_waypoint_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE itinerary_waypoint_seq FROM trip;
GRANT ALL ON SEQUENCE itinerary_waypoint_seq TO trip;
GRANT USAGE ON SEQUENCE itinerary_waypoint_seq TO trip_role;


--
-- Name: location_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE location_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE location_seq FROM trip;
GRANT ALL ON SEQUENCE location_seq TO trip;
GRANT USAGE ON SEQUENCE location_seq TO trip_role;


--
-- Name: location; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE location FROM PUBLIC;
REVOKE ALL ON TABLE location FROM trip;
GRANT ALL ON TABLE location TO trip;
GRANT SELECT,INSERT ON TABLE location TO trip_role;


--
-- Name: location_sharing; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE location_sharing FROM PUBLIC;
REVOKE ALL ON TABLE location_sharing FROM trip;
GRANT ALL ON TABLE location_sharing TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE location_sharing TO trip_role;


--
-- Name: path_color; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE path_color FROM PUBLIC;
REVOKE ALL ON TABLE path_color FROM trip;
GRANT ALL ON TABLE path_color TO trip;
GRANT SELECT ON TABLE path_color TO trip_role;


--
-- Name: role; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE role FROM PUBLIC;
REVOKE ALL ON TABLE role FROM trip;
GRANT ALL ON TABLE role TO trip;
GRANT SELECT,INSERT ON TABLE role TO trip_role;


--
-- Name: role_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE role_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE role_seq FROM trip;
GRANT ALL ON SEQUENCE role_seq TO trip;
GRANT USAGE ON SEQUENCE role_seq TO trip_role;


--
-- Name: tile; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE tile FROM PUBLIC;
REVOKE ALL ON TABLE tile FROM trip;
GRANT ALL ON TABLE tile TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tile TO trip_role;


--
-- Name: tile_download_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE tile_download_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tile_download_seq FROM trip;
GRANT ALL ON SEQUENCE tile_download_seq TO trip;
GRANT USAGE ON SEQUENCE tile_download_seq TO trip_role;


--
-- Name: tile_metric; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE tile_metric FROM PUBLIC;
REVOKE ALL ON TABLE tile_metric FROM trip;
GRANT ALL ON TABLE tile_metric TO trip;
GRANT SELECT,INSERT ON TABLE tile_metric TO trip_role;


--
-- Name: user_role; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE user_role FROM PUBLIC;
REVOKE ALL ON TABLE user_role FROM trip;
GRANT ALL ON TABLE user_role TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE user_role TO trip_role;


--
-- Name: usertable_seq; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON SEQUENCE usertable_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE usertable_seq FROM trip;
GRANT ALL ON SEQUENCE usertable_seq TO trip;
GRANT USAGE ON SEQUENCE usertable_seq TO trip_role;


--
-- Name: usertable; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE usertable FROM PUBLIC;
REVOKE ALL ON TABLE usertable FROM trip;
GRANT ALL ON TABLE usertable TO trip;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE usertable TO trip_role;


--
-- Name: waypoint_symbol; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE waypoint_symbol FROM PUBLIC;
REVOKE ALL ON TABLE waypoint_symbol FROM trip;
GRANT ALL ON TABLE waypoint_symbol TO trip;
GRANT SELECT ON TABLE waypoint_symbol TO trip_role;


--
-- PostgreSQL database dump complete
--

