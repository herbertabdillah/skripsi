--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg110+1)
-- Dumped by pg_dump version 15.6 (Debian 15.6-1.pgdg120+2)

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
-- Name: application_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application_configs (
    id bigint NOT NULL,
    key character varying,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.application_configs OWNER TO postgres;

--
-- Name: application_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.application_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.application_configs_id_seq OWNER TO postgres;

--
-- Name: application_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.application_configs_id_seq OWNED BY public.application_configs.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: blockchain_sync_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blockchain_sync_batches (
    id bigint NOT NULL,
    status character varying,
    description character varying,
    sync_result character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.blockchain_sync_batches OWNER TO postgres;

--
-- Name: blockchain_sync_batches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blockchain_sync_batches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blockchain_sync_batches_id_seq OWNER TO postgres;

--
-- Name: blockchain_sync_batches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blockchain_sync_batches_id_seq OWNED BY public.blockchain_sync_batches.id;


--
-- Name: blockchain_syncs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blockchain_syncs (
    id bigint NOT NULL,
    syncable_type character varying,
    syncable_id integer,
    status character varying,
    description character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    blockchain_sync_batch_id bigint
);


ALTER TABLE public.blockchain_syncs OWNER TO postgres;

--
-- Name: blockchain_syncs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blockchain_syncs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blockchain_syncs_id_seq OWNER TO postgres;

--
-- Name: blockchain_syncs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blockchain_syncs_id_seq OWNED BY public.blockchain_syncs.id;


--
-- Name: course_plan_course_semesters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_plan_course_semesters (
    id bigint NOT NULL,
    course_plan_id bigint NOT NULL,
    course_semester_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.course_plan_course_semesters OWNER TO postgres;

--
-- Name: course_plan_course_semesters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_plan_course_semesters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_plan_course_semesters_id_seq OWNER TO postgres;

--
-- Name: course_plan_course_semesters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_plan_course_semesters_id_seq OWNED BY public.course_plan_course_semesters.id;


--
-- Name: course_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_plans (
    id bigint NOT NULL,
    year integer,
    semester integer,
    student_id bigint NOT NULL,
    is_approved boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.course_plans OWNER TO postgres;

--
-- Name: course_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_plans_id_seq OWNER TO postgres;

--
-- Name: course_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_plans_id_seq OWNED BY public.course_plans.id;


--
-- Name: course_result_scores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_result_scores (
    id bigint NOT NULL,
    course_result_id bigint NOT NULL,
    course_plan_course_semester_id bigint NOT NULL,
    score numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.course_result_scores OWNER TO postgres;

--
-- Name: course_result_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_result_scores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_result_scores_id_seq OWNER TO postgres;

--
-- Name: course_result_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_result_scores_id_seq OWNED BY public.course_result_scores.id;


--
-- Name: course_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_results (
    id bigint NOT NULL,
    course_plan_id bigint NOT NULL,
    score numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.course_results OWNER TO postgres;

--
-- Name: course_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_results_id_seq OWNER TO postgres;

--
-- Name: course_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_results_id_seq OWNED BY public.course_results.id;


--
-- Name: course_semesters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_semesters (
    id bigint NOT NULL,
    year integer,
    semester integer,
    course_id bigint NOT NULL,
    lecturer_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.course_semesters OWNER TO postgres;

--
-- Name: course_semesters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_semesters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_semesters_id_seq OWNER TO postgres;

--
-- Name: course_semesters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_semesters_id_seq OWNED BY public.course_semesters.id;


--
-- Name: course_years; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_years (
    id bigint NOT NULL,
    year integer,
    semester character varying,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.course_years OWNER TO postgres;

--
-- Name: course_years_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_years_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_years_id_seq OWNER TO postgres;

--
-- Name: course_years_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_years_id_seq OWNED BY public.course_years.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    id bigint NOT NULL,
    name character varying,
    department_id bigint NOT NULL,
    credit integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    kind character varying
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courses_id_seq OWNER TO postgres;

--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id bigint NOT NULL,
    faculty_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name character varying
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_id_seq OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- Name: faculties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculties (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.faculties OWNER TO postgres;

--
-- Name: faculties_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.faculties_id_seq OWNER TO postgres;

--
-- Name: faculties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculties_id_seq OWNED BY public.faculties.id;


--
-- Name: graduates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.graduates (
    id bigint NOT NULL,
    student_id bigint NOT NULL,
    score numeric,
    year integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.graduates OWNER TO postgres;

--
-- Name: graduates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.graduates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.graduates_id_seq OWNER TO postgres;

--
-- Name: graduates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.graduates_id_seq OWNED BY public.graduates.id;


--
-- Name: lecturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecturers (
    id bigint NOT NULL,
    name character varying,
    nik character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.lecturers OWNER TO postgres;

--
-- Name: lecturers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lecturers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lecturers_id_seq OWNER TO postgres;

--
-- Name: lecturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lecturers_id_seq OWNED BY public.lecturers.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id bigint NOT NULL,
    name character varying,
    nim character varying,
    department_id bigint NOT NULL,
    entry_year integer,
    status character varying,
    supervisor_lecturer_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    userable_type character varying,
    userable_id bigint,
    is_admin boolean
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.versions (
    id bigint NOT NULL,
    item_type character varying NOT NULL,
    item_id bigint NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object json,
    object_changes json,
    created_at timestamp without time zone
);


ALTER TABLE public.versions OWNER TO postgres;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versions_id_seq OWNER TO postgres;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: application_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_configs ALTER COLUMN id SET DEFAULT nextval('public.application_configs_id_seq'::regclass);


--
-- Name: blockchain_sync_batches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blockchain_sync_batches ALTER COLUMN id SET DEFAULT nextval('public.blockchain_sync_batches_id_seq'::regclass);


--
-- Name: blockchain_syncs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blockchain_syncs ALTER COLUMN id SET DEFAULT nextval('public.blockchain_syncs_id_seq'::regclass);


--
-- Name: course_plan_course_semesters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_plan_course_semesters ALTER COLUMN id SET DEFAULT nextval('public.course_plan_course_semesters_id_seq'::regclass);


--
-- Name: course_plans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_plans ALTER COLUMN id SET DEFAULT nextval('public.course_plans_id_seq'::regclass);


--
-- Name: course_result_scores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_result_scores ALTER COLUMN id SET DEFAULT nextval('public.course_result_scores_id_seq'::regclass);


--
-- Name: course_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_results ALTER COLUMN id SET DEFAULT nextval('public.course_results_id_seq'::regclass);


--
-- Name: course_semesters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_semesters ALTER COLUMN id SET DEFAULT nextval('public.course_semesters_id_seq'::regclass);


--
-- Name: course_years id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_years ALTER COLUMN id SET DEFAULT nextval('public.course_years_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- Name: faculties id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculties ALTER COLUMN id SET DEFAULT nextval('public.faculties_id_seq'::regclass);


--
-- Name: graduates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graduates ALTER COLUMN id SET DEFAULT nextval('public.graduates_id_seq'::regclass);


--
-- Name: lecturers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturers ALTER COLUMN id SET DEFAULT nextval('public.lecturers_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Data for Name: application_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application_configs (id, key, value, created_at, updated_at) FROM stdin;
1	year	2023	2023-05-29 19:24:19.847014	2023-05-29 19:24:19.847014
2	semester	1	2023-05-31 20:04:12.772018	2023-05-31 20:04:12.772018
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-05-29 18:59:34.912637	2023-05-29 18:59:34.912637
\.


--
-- Data for Name: blockchain_sync_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blockchain_sync_batches (id, status, description, sync_result, created_at, updated_at) FROM stdin;
2	success	Test	\N	2024-01-03 02:36:20.19759	2024-01-03 02:36:20.432924
7	success	Semester baru	\N	2024-01-03 03:15:29.274645	2024-01-03 03:15:29.416524
8	success	mulai tahun ajaran baru	\N	2024-01-03 04:44:38.52337	2024-01-03 04:44:47.163461
\.


--
-- Data for Name: blockchain_syncs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blockchain_syncs (id, syncable_type, syncable_id, status, description, created_at, updated_at, blockchain_sync_batch_id) FROM stdin;
3	Faculty	1	success	\N	2023-06-25 05:51:10.20502	2023-06-25 05:51:10.20502	\N
4	Department	1	success	\N	2023-06-25 05:51:12.293291	2023-06-25 05:51:12.293291	\N
5	Course	1	error	\N	2023-06-25 05:51:12.3073	2023-06-25 05:51:12.3073	\N
6	Course	2	error	\N	2023-06-25 05:51:12.312908	2023-06-25 05:51:12.312908	\N
7	Course	3	error	\N	2023-06-25 05:51:12.318246	2023-06-25 05:51:12.318246	\N
8	Faculty	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T12:53:46.947241386+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 05:53:46.956609	2023-06-25 05:53:46.956609	\N
9	Department	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T12:53:46.977550001+07:00"}}	2023-06-25 05:53:46.978611	2023-06-25 05:53:46.978611	\N
10	Course	1	error	Invalid argument for bytes field 'args' (given Integer).	2023-06-25 05:53:46.994404	2023-06-25 05:53:46.994404	\N
11	Course	2	error	Invalid argument for bytes field 'args' (given Integer).	2023-06-25 05:53:47.001314	2023-06-25 05:53:47.001314	\N
12	Course	3	error	Invalid argument for bytes field 'args' (given Integer).	2023-06-25 05:53:47.010255	2023-06-25 05:53:47.010255	\N
13	Faculty	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T12:56:27.068162348+07:00"}}	2023-06-25 05:56:27.077041	2023-06-25 05:56:27.077041	\N
14	Department	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T12:56:27.101532541+07:00"}}	2023-06-25 05:56:27.102402	2023-06-25 05:56:27.102402	\N
15	Course	1	error	Invalid argument for bytes field 'args' (given Integer).	2023-06-25 05:58:00.091354	2023-06-25 05:58:00.091354	\N
16	Course	2	error	Invalid argument for bytes field 'args' (given Integer).	2023-06-25 05:58:00.897273	2023-06-25 05:58:00.897273	\N
17	Course	3	error	Invalid argument for bytes field 'args' (given Integer).	2023-06-25 05:58:01.279713	2023-06-25 05:58:01.279713	\N
18	Faculty	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T12:58:54.078049508+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 05:58:54.089039	2023-06-25 05:58:54.089039	\N
19	Department	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T12:58:54.111043751+07:00"}}	2023-06-25 05:58:54.111943	2023-06-25 05:58:54.111943	\N
20	Course	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T12:58:54.131494816+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 05:58:54.132296	2023-06-25 05:58:54.132296	\N
21	Course	2	success	\N	2023-06-25 05:58:56.226252	2023-06-25 05:58:56.226252	\N
22	Course	3	success	\N	2023-06-25 05:58:58.299179	2023-06-25 05:58:58.299179	\N
23	Lecturer	1	success	\N	2023-06-25 06:01:53.004863	2023-06-25 06:01:53.004863	\N
24	Lecturer	2	success	\N	2023-06-25 06:01:55.074874	2023-06-25 06:01:55.074874	\N
25	Lecturer	3	success	\N	2023-06-25 06:01:57.16508	2023-06-25 06:01:57.16508	\N
26	Student	1	error	undefined method `faculty_id' for #<Student id: 1, name: "Herbert Abdillah", nim: "11170910000046", department_id: 1, entry_year: 2017, status: "active", supervisor_lecturer_id: 2, created_at: "2023-05-29 19:58:25.852400000 +0000", updated_at: "2023-06-25 05:37:06.731269000 +0000">	2023-06-25 06:01:57.185639	2023-06-25 06:01:57.185639	\N
27	Student	2	error	undefined method `faculty_id' for #<Student id: 2, name: "Soekarno", nim: "11100910000047", department_id: 1, entry_year: 2010, status: "active", supervisor_lecturer_id: 2, created_at: "2023-06-25 05:37:37.479783000 +0000", updated_at: "2023-06-25 05:37:37.479783000 +0000">	2023-06-25 06:01:57.198499	2023-06-25 06:01:57.198499	\N
28	Lecturer	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:04:32.551518796+07:00"}}	2023-06-25 06:04:32.552414	2023-06-25 06:04:32.552414	\N
29	Lecturer	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:04:32.564970555+07:00"}}	2023-06-25 06:04:32.565677	2023-06-25 06:04:32.565677	\N
30	Lecturer	3	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:04:32.575905045+07:00"}}	2023-06-25 06:04:32.577107	2023-06-25 06:04:32.577107	\N
31	Student	1	error	undefined method `faculty_id' for #<Student id: 1, name: "Herbert Abdillah", nim: "11170910000046", department_id: 1, entry_year: 2017, status: "active", supervisor_lecturer_id: 2, created_at: "2023-05-29 19:58:25.852400000 +0000", updated_at: "2023-06-25 05:37:06.731269000 +0000">	2023-06-25 06:04:32.588213	2023-06-25 06:04:32.588213	\N
32	Student	2	error	undefined method `faculty_id' for #<Student id: 2, name: "Soekarno", nim: "11100910000047", department_id: 1, entry_year: 2010, status: "active", supervisor_lecturer_id: 2, created_at: "2023-06-25 05:37:37.479783000 +0000", updated_at: "2023-06-25 05:37:37.479783000 +0000">	2023-06-25 06:04:32.599793	2023-06-25 06:04:32.599793	\N
33	Lecturer	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:04:57.946764752+07:00"}}	2023-06-25 06:04:58.006166	2023-06-25 06:04:58.006166	\N
34	Lecturer	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:04:58.019424992+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:04:58.020218	2023-06-25 06:04:58.020218	\N
35	Lecturer	3	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:04:58.030621581+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:04:58.031405	2023-06-25 06:04:58.031405	\N
36	Student	1	error	Invalid argument for bytes field 'args' (given Integer).	2023-06-25 06:04:58.048924	2023-06-25 06:04:58.048924	\N
37	Student	2	error	Invalid argument for bytes field 'args' (given Integer).	2023-06-25 06:04:58.056909	2023-06-25 06:04:58.056909	\N
164	CourseResultScore	15	error	evaluate call to endorser returned error: chaincode response 500, get state with key=CourseResult.2: state entry not found	2023-06-25 09:55:55.10655	2023-06-25 09:55:55.10655	\N
38	Lecturer	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:06:24.681086199+07:00"}}	2023-06-25 06:06:24.690274	2023-06-25 06:06:24.690274	\N
39	Lecturer	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:06:24.703193483+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:06:24.704357	2023-06-25 06:06:24.704357	\N
40	Lecturer	3	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:06:24.7156911+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:06:24.716465	2023-06-25 06:06:24.716465	\N
41	Student	1	success	\N	2023-06-25 06:06:26.806647	2023-06-25 06:06:26.806647	\N
42	Student	2	success	\N	2023-06-25 06:06:28.897124	2023-06-25 06:06:28.897124	\N
43	CourseSemester	3	success	\N	2023-06-25 06:09:43.328762	2023-06-25 06:09:43.328762	\N
44	CourseSemester	2	success	\N	2023-06-25 06:09:45.689708	2023-06-25 06:09:45.689708	\N
45	CourseSemester	1	success	\N	2023-06-25 06:09:48.082466	2023-06-25 06:09:48.082466	\N
46	CoursePlan	1	error	Invalid argument for bytes field 'args' (given Array).	2023-06-25 06:10:27.655705	2023-06-25 06:10:27.655705	\N
47	CourseResultScore	3	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:10:27.68537599+07:00"}}	2023-06-25 06:10:27.686615	2023-06-25 06:10:27.686615	\N
48	CourseResultScore	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:10:27.70129023+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:10:27.701996	2023-06-25 06:10:27.701996	\N
49	CourseResultScore	4	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:10:27.716972463+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:10:27.717873	2023-06-25 06:10:27.717873	\N
50	CourseResultScore	6	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:10:27.732192412+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:10:27.73308	2023-06-25 06:10:27.73308	\N
51	CourseResultScore	7	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:10:27.757060544+07:00"}}	2023-06-25 06:10:27.757871	2023-06-25 06:10:27.757871	\N
52	CourseResultScore	8	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:10:27.771756691+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:10:27.772729	2023-06-25 06:10:27.772729	\N
53	CourseResultScore	9	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:10:27.785254252+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:10:27.785979	2023-06-25 06:10:27.785979	\N
54	CourseResultScore	10	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:10:27.798998494+07:00"}}	2023-06-25 06:10:27.799798	2023-06-25 06:10:27.799798	\N
55	CourseResultScore	11	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:10:27.811378752+07:00"}}	2023-06-25 06:10:27.812099	2023-06-25 06:10:27.812099	\N
56	CourseResultScore	12	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:10:27.825206453+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:10:27.825897	2023-06-25 06:10:27.825897	\N
57	CourseResultScore	5	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:10:27.839749224+07:00"}}	2023-06-25 06:10:27.840484	2023-06-25 06:10:27.840484	\N
58	CoursePlan	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:13:44.298503408+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:13:44.308558	2023-06-25 06:13:44.308558	\N
59	CourseResultScore	3	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:13:45.401378566+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:13:45.402496	2023-06-25 06:13:45.402496	\N
60	CourseResultScore	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:13:45.417693733+07:00"}}	2023-06-25 06:13:45.418398	2023-06-25 06:13:45.418398	\N
61	CourseResultScore	4	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:13:45.431875777+07:00"}}	2023-06-25 06:13:45.432716	2023-06-25 06:13:45.432716	\N
62	CourseResultScore	6	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:13:45.446131359+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:13:45.446861	2023-06-25 06:13:45.446861	\N
63	CourseResultScore	7	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:13:45.473558115+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:13:45.474499	2023-06-25 06:13:45.474499	\N
64	CourseResultScore	8	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:13:45.491685073+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:13:45.492588	2023-06-25 06:13:45.492588	\N
65	CourseResultScore	9	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:13:45.506659514+07:00"}}	2023-06-25 06:13:45.507507	2023-06-25 06:13:45.507507	\N
66	CourseResultScore	10	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:13:45.522751541+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:13:45.524228	2023-06-25 06:13:45.524228	\N
67	CourseResultScore	11	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:13:45.536583476+07:00"}}	2023-06-25 06:13:45.537382	2023-06-25 06:13:45.537382	\N
68	CourseResultScore	12	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:13:45.553233799+07:00"}}	2023-06-25 06:13:45.554081	2023-06-25 06:13:45.554081	\N
69	CourseResultScore	5	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:13:45.566982141+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:13:45.567688	2023-06-25 06:13:45.567688	\N
70	CoursePlan	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:25:47.463881926+07:00"}}	2023-06-25 06:25:47.475614	2023-06-25 06:25:47.475614	\N
71	CourseResultScore	3	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:25:48.245842449+07:00"}}	2023-06-25 06:25:48.2468	2023-06-25 06:25:48.2468	\N
72	CourseResultScore	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:25:48.258515644+07:00"}}	2023-06-25 06:25:48.259227	2023-06-25 06:25:48.259227	\N
73	CourseResultScore	4	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:25:48.271895751+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:25:48.273122	2023-06-25 06:25:48.273122	\N
74	CourseResultScore	6	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:25:48.286349221+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:25:48.288094	2023-06-25 06:25:48.288094	\N
75	CourseResultScore	7	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:25:48.300708676+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:25:48.301388	2023-06-25 06:25:48.301388	\N
76	CourseResultScore	8	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:25:48.314497281+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:25:48.315273	2023-06-25 06:25:48.315273	\N
77	CourseResultScore	9	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:25:48.329588385+07:00"}}	2023-06-25 06:25:48.330415	2023-06-25 06:25:48.330415	\N
78	CourseResultScore	10	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:25:48.343877464+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:25:48.344699	2023-06-25 06:25:48.344699	\N
79	CourseResultScore	11	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:25:48.357307024+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:25:48.358888	2023-06-25 06:25:48.358888	\N
80	CourseResultScore	12	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:25:48.372560417+07:00"}}	2023-06-25 06:25:48.373431	2023-06-25 06:25:48.373431	\N
81	CourseResultScore	5	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:25:48.386486087+07:00"}}	2023-06-25 06:25:48.387296	2023-06-25 06:25:48.387296	\N
82	CoursePlan	1	success	\N	2023-06-25 06:26:22.835686	2023-06-25 06:26:22.835686	\N
83	CourseResultScore	3	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:26:22.865184059+07:00"}}	2023-06-25 06:26:22.866314	2023-06-25 06:26:22.866314	\N
84	CourseResultScore	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:26:22.877907503+07:00"}}	2023-06-25 06:26:22.878717	2023-06-25 06:26:22.878717	\N
85	CourseResultScore	4	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:26:22.891794351+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:26:22.892482	2023-06-25 06:26:22.892482	\N
86	CourseResultScore	6	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:26:22.905465532+07:00"}}	2023-06-25 06:26:22.906258	2023-06-25 06:26:22.906258	\N
87	CourseResultScore	7	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:26:22.917534733+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:26:22.91831	2023-06-25 06:26:22.91831	\N
88	CourseResultScore	8	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:26:22.935395894+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:26:22.936538	2023-06-25 06:26:22.936538	\N
89	CourseResultScore	9	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:26:22.961366358+07:00"}}	2023-06-25 06:26:22.962446	2023-06-25 06:26:22.962446	\N
90	CourseResultScore	10	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:26:22.978699861+07:00"}}	2023-06-25 06:26:22.979936	2023-06-25 06:26:22.979936	\N
91	CourseResultScore	11	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:26:22.997245699+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:26:22.998091	2023-06-25 06:26:22.998091	\N
92	CourseResultScore	12	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:26:23.013061808+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:26:23.013795	2023-06-25 06:26:23.013795	\N
93	CourseResultScore	5	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:26:23.027353994+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:26:23.028213	2023-06-25 06:26:23.028213	\N
94	CoursePlan	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:27:36.425861874+07:00"}}	2023-06-25 06:27:36.434981	2023-06-25 06:27:36.434981	\N
95	CourseResultScore	3	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:27:36.469000925+07:00"}}	2023-06-25 06:27:36.470024	2023-06-25 06:27:36.470024	\N
96	CourseResultScore	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:27:36.484779314+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:27:36.485655	2023-06-25 06:27:36.485655	\N
97	CourseResultScore	4	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:27:36.500486147+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:27:36.501202	2023-06-25 06:27:36.501202	\N
98	CourseResultScore	6	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:27:36.514867306+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:27:36.515869	2023-06-25 06:27:36.515869	\N
99	CourseResultScore	7	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:27:36.528646321+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:27:36.52998	2023-06-25 06:27:36.52998	\N
100	CourseResultScore	8	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:27:36.542950395+07:00"}}	2023-06-25 06:27:36.543811	2023-06-25 06:27:36.543811	\N
101	CourseResultScore	9	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:27:36.55740478+07:00"}}	2023-06-25 06:27:36.55841	2023-06-25 06:27:36.55841	\N
102	CourseResultScore	10	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:27:36.572827999+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:27:36.573581	2023-06-25 06:27:36.573581	\N
103	CourseResultScore	11	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:27:36.586679514+07:00"}}	2023-06-25 06:27:36.587479	2023-06-25 06:27:36.587479	\N
104	CourseResultScore	12	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:27:36.600241422+07:00"}}	2023-06-25 06:27:36.601803	2023-06-25 06:27:36.601803	\N
105	CourseResultScore	5	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:27:36.614906651+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:27:36.615662	2023-06-25 06:27:36.615662	\N
106	CoursePlan	1	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:30:14.325486123+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:30:14.344821	2023-06-25 06:30:14.344821	\N
107	CourseResultScore	3	error	undefined method `course_plan_id' for #<CourseResultScore id: 3, course_result_id: 12, course_plan_course_semester_id: 12, score: 0.2e1, created_at: "2023-06-01 01:19:11.702384000 +0000", updated_at: "2023-06-01 01:26:34.267035000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.387527	2023-06-25 06:30:14.387527	\N
108	CourseResultScore	2	error	undefined method `course_plan_id' for #<CourseResultScore id: 2, course_result_id: 12, course_plan_course_semester_id: 11, score: 0.5e1, created_at: "2023-06-01 01:19:11.699628000 +0000", updated_at: "2023-06-01 01:26:38.881658000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.407931	2023-06-25 06:30:14.407931	\N
109	CourseResultScore	4	error	undefined method `course_plan_id' for #<CourseResultScore id: 4, course_result_id: 13, course_plan_course_semester_id: 11, score: nil, created_at: "2023-06-01 02:48:39.170734000 +0000", updated_at: "2023-06-01 02:48:39.170734000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.42594	2023-06-25 06:30:14.42594	\N
110	CourseResultScore	6	error	undefined method `course_plan_id' for #<CourseResultScore id: 6, course_result_id: 13, course_plan_course_semester_id: 13, score: 0.4e1, created_at: "2023-06-01 02:48:39.175659000 +0000", updated_at: "2023-06-01 03:12:31.918297000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.445386	2023-06-25 06:30:14.445386	\N
111	CourseResultScore	7	error	undefined method `course_plan_id' for #<CourseResultScore id: 7, course_result_id: 14, course_plan_course_semester_id: 11, score: nil, created_at: "2023-06-01 03:58:46.856635000 +0000", updated_at: "2023-06-01 03:58:46.856635000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.468777	2023-06-25 06:30:14.468777	\N
112	CourseResultScore	8	error	undefined method `course_plan_id' for #<CourseResultScore id: 8, course_result_id: 14, course_plan_course_semester_id: 12, score: nil, created_at: "2023-06-01 03:58:46.860367000 +0000", updated_at: "2023-06-01 03:58:46.860367000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.488646	2023-06-25 06:30:14.488646	\N
113	CourseResultScore	9	error	undefined method `course_plan_id' for #<CourseResultScore id: 9, course_result_id: 14, course_plan_course_semester_id: 13, score: nil, created_at: "2023-06-01 03:58:46.863853000 +0000", updated_at: "2023-06-01 03:58:46.863853000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.507486	2023-06-25 06:30:14.507486	\N
114	CourseResultScore	10	error	undefined method `course_plan_id' for #<CourseResultScore id: 10, course_result_id: 15, course_plan_course_semester_id: 11, score: nil, created_at: "2023-06-01 03:59:12.524010000 +0000", updated_at: "2023-06-01 03:59:12.524010000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.526818	2023-06-25 06:30:14.526818	\N
115	CourseResultScore	11	error	undefined method `course_plan_id' for #<CourseResultScore id: 11, course_result_id: 15, course_plan_course_semester_id: 12, score: nil, created_at: "2023-06-01 03:59:12.528276000 +0000", updated_at: "2023-06-01 03:59:12.528276000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.545	2023-06-25 06:30:14.545	\N
116	CourseResultScore	12	error	undefined method `course_plan_id' for #<CourseResultScore id: 12, course_result_id: 15, course_plan_course_semester_id: 13, score: nil, created_at: "2023-06-01 03:59:12.532375000 +0000", updated_at: "2023-06-01 03:59:12.532375000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.565395	2023-06-25 06:30:14.565395	\N
117	CourseResultScore	5	error	undefined method `course_plan_id' for #<CourseResultScore id: 5, course_result_id: 13, course_plan_course_semester_id: 12, score: 0.3e1, created_at: "2023-06-01 02:48:39.173661000 +0000", updated_at: "2023-06-02 03:52:36.799348000 +0000">\nDid you mean?  course_result_id	2023-06-25 06:30:14.583514	2023-06-25 06:30:14.583514	\N
118	Graduate	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {grpc_message:"failed to endorse transaction, see attached details for more info", grpc_status:10, created_time:"2023-06-25T13:31:45.61294032+07:00"}}	2023-06-25 06:31:45.614051	2023-06-25 06:31:45.614051	\N
119	Graduate	2	error	10:failed to endorse transaction, see attached details for more info. debug_error_string:{UNKNOWN:Error received from peer  {created_time:"2023-06-25T13:32:28.368065343+07:00", grpc_status:10, grpc_message:"failed to endorse transaction, see attached details for more info"}}	2023-06-25 06:32:28.369101	2023-06-25 06:32:28.369101	\N
120	Graduate	2	error	evaluate call to endorser returned error: chaincode response 500, haven't done all course	2023-06-25 07:05:21.661476	2023-06-25 07:05:21.661476	\N
121	Lecturer	1	error	evaluate call to endorser returned error: chaincode response 500, state key already exists: Lecturer.1	2023-06-25 07:07:30.49387	2023-06-25 07:07:30.49387	\N
122	Lecturer	2	error	evaluate call to endorser returned error: chaincode response 500, state key already exists: Lecturer.2	2023-06-25 07:07:30.510899	2023-06-25 07:07:30.510899	\N
123	Lecturer	3	error	evaluate call to endorser returned error: chaincode response 500, state key already exists: Lecturer.3	2023-06-25 07:07:30.527347	2023-06-25 07:07:30.527347	\N
124	Student	2	error	evaluate call to endorser returned error: chaincode response 500, state key already exists: Transcript.2	2023-06-25 07:07:30.653779	2023-06-25 07:07:30.653779	\N
125	Student	1	error	evaluate call to endorser returned error: chaincode response 500, state key already exists: Transcript.1	2023-06-25 07:07:30.685368	2023-06-25 07:07:30.685368	\N
126	Student	2	error	evaluate call to endorser returned error: chaincode response 500, state key already exists: Transcript.2	2023-06-25 07:09:18.340489	2023-06-25 07:09:18.340489	\N
127	Student	3	success	\N	2023-06-25 07:09:20.432694	2023-06-25 07:09:20.432694	\N
128	CoursePlan	1	error	evaluate call to endorser returned error: chaincode response 500, state key already exists: CoursePlan.1	2023-06-25 07:17:53.062211	2023-06-25 07:17:53.062211	\N
129	CourseResultScore	3	success	\N	2023-06-25 07:17:55.191262	2023-06-25 07:17:55.191262	\N
130	CourseResultScore	2	success	\N	2023-06-25 07:17:57.270428	2023-06-25 07:17:57.270428	\N
131	CourseResultScore	4	success	\N	2023-06-25 07:17:59.346671	2023-06-25 07:17:59.346671	\N
132	CourseResultScore	6	success	\N	2023-06-25 07:18:01.430768	2023-06-25 07:18:01.430768	\N
133	CourseResultScore	7	success	\N	2023-06-25 07:18:03.530902	2023-06-25 07:18:03.530902	\N
134	CourseResultScore	8	success	\N	2023-06-25 07:18:05.61031	2023-06-25 07:18:05.61031	\N
135	CourseResultScore	9	success	\N	2023-06-25 07:18:07.690038	2023-06-25 07:18:07.690038	\N
136	CourseResultScore	10	success	\N	2023-06-25 07:18:09.771425	2023-06-25 07:18:09.771425	\N
137	CourseResultScore	11	success	\N	2023-06-25 07:18:11.848163	2023-06-25 07:18:11.848163	\N
138	CourseResultScore	12	success	\N	2023-06-25 07:18:13.952231	2023-06-25 07:18:13.952231	\N
139	CourseResultScore	5	success	\N	2023-06-25 07:18:16.035211	2023-06-25 07:18:16.035211	\N
140	Graduate	2	error	evaluate call to endorser returned error: chaincode response 500, haven't done all course	2023-06-25 07:18:47.22104	2023-06-25 07:18:47.22104	\N
141	Faculty	1	success	\N	2023-06-25 09:17:47.406524	2023-06-25 09:17:47.406524	\N
142	Department	1	success	\N	2023-06-25 09:17:49.493209	2023-06-25 09:17:49.493209	\N
143	Course	1	success	\N	2023-06-25 09:17:51.565234	2023-06-25 09:17:51.565234	\N
144	Course	2	success	\N	2023-06-25 09:17:53.646118	2023-06-25 09:17:53.646118	\N
145	Course	3	success	\N	2023-06-25 09:17:55.710445	2023-06-25 09:17:55.710445	\N
146	Lecturer	1	success	\N	2023-06-25 09:18:32.597031	2023-06-25 09:18:32.597031	\N
147	Lecturer	2	success	\N	2023-06-25 09:18:34.660836	2023-06-25 09:18:34.660836	\N
148	Lecturer	3	success	\N	2023-06-25 09:18:36.72171	2023-06-25 09:18:36.72171	\N
149	Student	2	success	\N	2023-06-25 09:18:38.798095	2023-06-25 09:18:38.798095	\N
150	Student	1	success	\N	2023-06-25 09:18:40.870116	2023-06-25 09:18:40.870116	\N
151	Student	3	success	\N	2023-06-25 09:18:42.955428	2023-06-25 09:18:42.955428	\N
152	CourseSemester	3	success	\N	2023-06-25 09:22:46.398688	2023-06-25 09:22:46.398688	\N
153	CourseSemester	2	success	\N	2023-06-25 09:22:48.478454	2023-06-25 09:22:48.478454	\N
154	CourseSemester	1	success	\N	2023-06-25 09:22:50.541308	2023-06-25 09:22:50.541308	\N
155	CoursePlan	1	success	\N	2023-06-25 09:23:26.67096	2023-06-25 09:23:26.67096	\N
156	CourseResultScore	3	success	\N	2023-06-25 09:23:28.759248	2023-06-25 09:23:28.759248	\N
157	CourseResultScore	2	success	\N	2023-06-25 09:23:30.834982	2023-06-25 09:23:30.834982	\N
158	CourseResultScore	13	success	\N	2023-06-25 09:23:32.906221	2023-06-25 09:23:32.906221	\N
159	Graduate	2	success	\N	2023-06-25 09:24:07.636514	2023-06-25 09:24:07.636514	\N
160	Faculty	2	success	\N	2023-06-25 09:55:48.762671	2023-06-25 09:55:48.762671	\N
161	Department	2	success	\N	2023-06-25 09:55:50.853518	2023-06-25 09:55:50.853518	\N
162	Lecturer	4	success	\N	2023-06-25 09:55:52.952698	2023-06-25 09:55:52.952698	\N
163	Student	4	success	\N	2023-06-25 09:55:55.039837	2023-06-25 09:55:55.039837	\N
165	CourseResultScore	16	error	evaluate call to endorser returned error: chaincode response 500, get state with key=CourseResult.2: state entry not found	2023-06-25 09:55:55.132176	2023-06-25 09:55:55.132176	\N
166	CourseResultScore	14	error	evaluate call to endorser returned error: chaincode response 500, get state with key=CourseResult.2: state entry not found	2023-06-25 09:55:55.149955	2023-06-25 09:55:55.149955	\N
167	CoursePlan	2	success	\N	2023-06-25 09:58:27.29204	2023-06-25 09:58:27.29204	\N
168	CourseResultScore	15	success	\N	2023-06-25 09:59:40.737451	2023-06-25 09:59:40.737451	\N
169	CourseResultScore	16	success	\N	2023-06-25 09:59:43.076961	2023-06-25 09:59:43.076961	\N
170	CourseResultScore	14	success	\N	2023-06-25 09:59:45.471374	2023-06-25 09:59:45.471374	\N
171	Graduate	3	error	evaluate call to endorser returned error: chaincode response 500, haven't done all course	2023-06-25 10:02:17.781538	2023-06-25 10:02:17.781538	\N
172	Graduate	3	error	evaluate call to endorser returned error: chaincode response 500, haven't done all course	2023-06-25 10:02:37.109733	2023-06-25 10:02:37.109733	\N
173	Graduate	3	error	evaluate call to endorser returned error: chaincode response 500, haven't done all course	2023-06-25 10:05:56.321455	2023-06-25 10:05:56.321455	\N
174	Graduate	3	error	evaluate call to endorser returned error: chaincode response 500, haven't done all course	2023-06-25 10:06:24.571229	2023-06-25 10:06:24.571229	\N
175	Graduate	3	error	evaluate call to endorser returned error: chaincode response 500, haven't done all course	2023-06-25 10:06:31.243863	2023-06-25 10:06:31.243863	\N
176	CourseResultScore	15	success	\N	2023-06-25 10:07:54.695554	2023-06-25 10:07:54.695554	\N
177	CourseResultScore	16	success	\N	2023-06-25 10:07:56.778112	2023-06-25 10:07:56.778112	\N
178	Graduate	3	success	\N	2023-06-25 10:08:51.826345	2023-06-25 10:08:51.826345	\N
179	Graduate	3	success	\N	2023-06-25 10:10:34.660906	2023-06-25 10:10:34.660906	\N
180	CourseResultScore	15	success	\N	2023-06-25 10:10:53.371318	2023-06-25 10:10:53.371318	\N
181	CourseResultScore	16	success	\N	2023-06-25 10:10:55.455943	2023-06-25 10:10:55.455943	\N
182	Graduate	3	success	\N	2023-06-25 10:10:57.529992	2023-06-25 10:10:57.529992	\N
183	Student	5	success	\N	2024-01-03 01:34:24.89506	2024-01-03 01:34:24.89506	\N
184	Student	6	error	evaluate call to endorser returned error: chaincode response 500, state key already exists: Transcript.6	2024-01-03 03:15:29.392203	2024-01-03 03:15:29.392203	7
185	Student	7	success	\N	2024-01-03 04:44:40.74677	2024-01-03 04:44:40.74677	8
186	Student	8	success	\N	2024-01-03 04:44:42.8425	2024-01-03 04:44:42.8425	8
187	Student	9	success	\N	2024-01-03 04:44:44.948411	2024-01-03 04:44:44.948411	8
188	Student	10	success	\N	2024-01-03 04:44:47.031087	2024-01-03 04:44:47.031087	8
189	CoursePlan	3	error	evaluate call to endorser returned error: chaincode response 500, strconv.Atoi: parsing "": invalid syntax	2024-01-03 04:44:47.061843	2024-01-03 04:44:47.061843	8
190	CourseResultScore	17	error	evaluate call to endorser returned error: chaincode response 500, get state with key=CourseResult.3: state entry not found	2024-01-03 04:44:47.095917	2024-01-03 04:44:47.095917	8
191	CourseResultScore	18	error	evaluate call to endorser returned error: chaincode response 500, get state with key=CourseResult.3: state entry not found	2024-01-03 04:44:47.124836	2024-01-03 04:44:47.124836	8
192	CourseResultScore	19	error	evaluate call to endorser returned error: chaincode response 500, get state with key=CourseResult.3: state entry not found	2024-01-03 04:44:47.152149	2024-01-03 04:44:47.152149	8
\.


--
-- Data for Name: course_plan_course_semesters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_plan_course_semesters (id, course_plan_id, course_semester_id, created_at, updated_at) FROM stdin;
11	1	1	2023-05-31 22:47:28.25366	2023-05-31 22:47:28.25366
12	1	2	2023-05-31 22:48:35.984983	2023-05-31 22:48:35.984983
13	1	3	2023-06-01 02:46:48.021309	2023-06-01 02:46:48.021309
14	2	3	2023-06-25 09:53:02.93306	2023-06-25 09:53:02.93306
15	2	2	2023-06-25 09:53:02.946496	2023-06-25 09:53:02.946496
16	2	1	2023-06-25 09:53:02.957703	2023-06-25 09:53:02.957703
17	3	3	2024-01-03 04:41:26.937066	2024-01-03 04:41:26.937066
18	3	2	2024-01-03 04:41:26.959825	2024-01-03 04:41:26.959825
19	3	1	2024-01-03 04:41:26.981888	2024-01-03 04:41:26.981888
\.


--
-- Data for Name: course_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_plans (id, year, semester, student_id, is_approved, created_at, updated_at) FROM stdin;
1	2017	1	1	t	2023-05-31 20:30:50.270666	2023-06-25 05:39:19.698191
2	2017	1	4	t	2023-06-25 09:52:56.142322	2023-06-25 09:53:24.558752
3	2023	1	10	t	2024-01-03 04:41:02.76101	2024-01-03 04:52:37.791336
4	2023	1	1	\N	2024-01-31 05:25:31.577269	2024-01-31 05:25:31.577269
\.


--
-- Data for Name: course_result_scores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_result_scores (id, course_result_id, course_plan_course_semester_id, score, created_at, updated_at) FROM stdin;
3	12	12	3.0	2023-06-01 01:19:11.702384	2023-06-25 07:24:16.122496
2	12	11	4.0	2023-06-01 01:19:11.699628	2023-06-25 07:24:27.450516
13	12	13	3.0	2023-06-25 07:30:39.351103	2023-06-25 07:32:43.508404
14	16	14	4.0	2023-06-25 09:53:24.572959	2023-06-25 09:53:50.618719
15	16	15	3.0	2023-06-25 09:53:24.57619	2023-06-25 10:01:25.561172
16	16	16	3.0	2023-06-25 09:53:24.578621	2023-06-25 10:01:30.879494
17	17	17	\N	2024-01-03 04:44:15.978692	2024-01-03 04:44:15.978692
18	17	18	\N	2024-01-03 04:44:15.98892	2024-01-03 04:44:15.98892
19	17	19	\N	2024-01-03 04:44:15.997758	2024-01-03 04:44:15.997758
\.


--
-- Data for Name: course_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_results (id, course_plan_id, score, created_at, updated_at) FROM stdin;
12	1	\N	2023-06-01 01:19:11.673862	2023-06-01 01:19:11.673862
16	2	\N	2023-06-25 09:53:24.564174	2023-06-25 09:53:24.564174
17	3	\N	2024-01-03 04:44:15.956464	2024-01-03 04:44:15.956464
\.


--
-- Data for Name: course_semesters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_semesters (id, year, semester, course_id, lecturer_id, created_at, updated_at) FROM stdin;
3	2017	1	3	2	2023-06-01 02:30:18.443251	2023-06-25 05:38:58.292315
2	2017	1	2	3	2023-05-31 20:43:51.67708	2023-06-25 05:39:03.575893
1	2017	1	1	3	2023-05-31 20:17:04.608014	2023-06-25 05:39:08.309907
\.


--
-- Data for Name: course_years; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_years (id, year, semester, status, created_at, updated_at) FROM stdin;
1	2017	2		2023-06-25 05:38:11.401805	2023-06-25 05:38:11.401805
2	2017	1		2023-06-25 05:38:38.040515	2023-06-25 05:38:38.040515
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (id, name, department_id, credit, created_at, updated_at, kind) FROM stdin;
1	Dasar Dasar Pemrograman	1	6	2023-05-29 19:42:54.65389	2023-05-29 19:55:20.82386	class
2	Matematika Dasar	1	3	2023-05-31 20:43:40.657566	2023-05-31 20:43:40.657566	class
3	Matematika Diskrit	1	3	2023-06-01 02:30:08.983732	2023-06-01 02:30:08.983732	class
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (id, faculty_id, created_at, updated_at, name) FROM stdin;
1	1	2023-05-29 19:42:15.039967	2023-05-29 19:42:15.039967	Teknik Informatika
2	1	2023-06-25 09:52:15.519034	2023-06-25 09:52:15.519034	Sistem Informasi
\.


--
-- Data for Name: faculties; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculties (id, name, created_at, updated_at) FROM stdin;
1	Sains dan Teknologi	2023-05-29 19:42:02.898237	2023-05-29 19:42:02.898237
2	Ekonomi dan Bisnis	2023-06-25 09:52:27.606327	2023-06-25 09:52:27.606327
\.


--
-- Data for Name: graduates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.graduates (id, student_id, score, year, created_at, updated_at) FROM stdin;
2	1	12.0	2023	2023-06-25 06:31:40.470456	2023-06-25 06:31:40.470456
3	4	10.0	2023	2023-06-25 10:02:00.033719	2023-06-25 10:02:00.033719
\.


--
-- Data for Name: lecturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lecturers (id, name, nik, created_at, updated_at) FROM stdin;
1	Donald Knuth	19450001	2023-05-29 19:56:10.6205	2023-05-29 19:56:10.6205
2	Ken Thompson	19450002	2023-05-29 19:56:35.62545	2023-05-29 19:56:35.62545
3	Thomas Cormen	19450003	2023-05-29 19:57:02.65709	2023-05-29 19:57:02.65709
4	Denis Ritchie	19450004	2023-06-25 09:51:36.525791	2023-06-25 09:51:36.525791
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20220101180305
20230529184941
20230529185204
20230529185300
20230529185502
20230529185650
20230529185852
20230531201350
20230531202429
20230531202843
20230531211339
20230601004703
20230601005314
20230601021254
20230602022753
20230625044102
20230625044755
20240103021535
20240103032905
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (id, name, nim, department_id, entry_year, status, supervisor_lecturer_id, created_at, updated_at) FROM stdin;
2	Soekarno	11100910000047	1	2010	active	2	2023-06-25 05:37:37.479783	2023-06-25 05:37:37.479783
1	Herbert Abdillah	11170910000046	1	2017	graduated	2	2023-05-29 19:58:25.8524	2023-06-25 06:31:40.497592
3	Natsir	11170910000048	1	2017	active	2	2023-06-25 07:09:06.245044	2023-06-25 07:09:06.245044
4	Aidit	11170910000049	1	2017	graduated	2	2023-06-25 09:50:53.366263	2023-06-25 10:02:00.056825
5	Linus Torvalds	11170910000066	1	2017	active	2	2024-01-03 01:34:04.108743	2024-01-03 01:34:04.108743
6	Richard Stallman	11170910000067	1	2017	active	2	2024-01-03 02:45:25.516811	2024-01-03 02:45:25.516811
7	William H. Gates	11170910000088	2	2017	active	3	2024-01-03 03:53:15.724685	2024-01-03 03:59:28.672297
8	Steve Ballmer	11170910000089	2	2017	active	3	2024-01-03 04:32:50.718753	2024-01-03 04:32:50.718753
9	Steve Ballmer	11170910000089	2	2017	active	3	2024-01-03 04:33:10.665711	2024-01-03 04:33:10.665711
10	Scott	11170910000090	2	2017	active	2	2024-01-03 04:34:30.194474	2024-01-03 04:43:39.059679
11	Rob	11170910000088	1	2017	active	2	2024-01-31 05:30:51.032094	2024-01-31 05:30:51.032094
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, userable_type, userable_id, is_admin) FROM stdin;
5	tom@uinjkt.ac.id	$2a$12$NPhD65WO9PlsALmXMwmalO6VTkDUAYhodlJYW1OUEls0xaGkmwdMC	\N	\N	\N	2023-06-02 03:52:09.706539	2023-06-02 03:52:09.706539	Lecturer	3	\N
6	scott17@mhs.uinjkt.ac.id	$2a$12$Lh6AcxmzHOYxPakB1eEYSOCmx7OClrzBT6IHlSV6BJs9Q1EwRDe7G	\N	\N	\N	2024-01-03 04:34:30.49966	2024-01-03 04:43:44.686936	Student	10	\N
1	admin@example.com	$2a$12$1.T9WElu51C.yh4gO389dOA63Fn23Rfh7CUT1OwW5kPFcSdrIN9ke	\N	\N	\N	2023-05-29 18:59:41.203471	2024-05-10 08:09:29.543618	\N	\N	t
4	ken@uinjkt.ac.id	$2a$12$8ejhxuwuEIKDR05ucgJorOT23CBGXfpqGfoScbQSyd1VyE8tMKlUO	\N	\N	2024-05-10 08:09:40.899208	2023-06-01 02:22:47.172073	2024-05-10 08:09:40.899832	Lecturer	2	\N
2	herbert.abdillah17@mhs.uinjkt.ac.id	$2a$12$Cfi8zNVq5xczTRrR7Bmz7ObFwwpa5OL/Wvr/xfjOTRdZWy0YpxI1e	\N	\N	\N	2023-05-31 21:08:27.214438	2024-05-10 08:10:33.297742	Student	1	\N
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.versions (id, item_type, item_id, event, whodunnit, object, object_changes, created_at) FROM stdin;
1	Student	7	update	1	{"name":"William Henry Gates","nim":"11170910000088","department_id":2,"entry_year":2017,"status":"active","supervisor_lecturer_id":3,"id":7,"created_at":"2024-01-03T03:53:15.724Z","updated_at":"2024-01-03T03:54:18.285Z"}	{"name":["William Henry Gates","William H. Gates"],"updated_at":["2024-01-03T03:54:18.285Z","2024-01-03T03:59:28.672Z"]}	2024-01-03 03:59:28.672297
2	User	2	update	\N	{"remember_created_at":null,"id":2,"email":"herbert.abdillah17@mhs.uinjkt.ac.id","encrypted_password":"$2a$12$Cfi8zNVq5xczTRrR7Bmz7ObFwwpa5OL/Wvr/xfjOTRdZWy0YpxI1e","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2023-05-31T21:08:27.214Z","updated_at":"2023-06-01T03:29:33.252Z","userable_type":"Student","userable_id":1,"is_admin":null}	{"remember_created_at":[null,"2024-01-03T04:12:00.264Z"],"updated_at":["2023-06-01T03:29:33.252Z","2024-01-03T04:12:00.265Z"]}	2024-01-03 04:12:00.265452
3	Student	8	create	1	\N	{"id":[null,8],"name":[null,"Steve Ballmer"],"nim":[null,"11170910000089"],"department_id":[null,2],"entry_year":[null,2017],"status":[null,"active"],"supervisor_lecturer_id":[null,3],"created_at":[null,"2024-01-03T04:32:50.718Z"],"updated_at":[null,"2024-01-03T04:32:50.718Z"]}	2024-01-03 04:32:50.718753
4	Student	9	create	1	\N	{"id":[null,9],"name":[null,"Steve Ballmer"],"nim":[null,"11170910000089"],"department_id":[null,2],"entry_year":[null,2017],"status":[null,"active"],"supervisor_lecturer_id":[null,3],"created_at":[null,"2024-01-03T04:33:10.665Z"],"updated_at":[null,"2024-01-03T04:33:10.665Z"]}	2024-01-03 04:33:10.665711
5	Student	10	create	1	\N	{"id":[null,10],"name":[null,"Scott"],"nim":[null,"11170910000090"],"department_id":[null,2],"entry_year":[null,2017],"status":[null,"active"],"supervisor_lecturer_id":[null,4],"created_at":[null,"2024-01-03T04:34:30.194Z"],"updated_at":[null,"2024-01-03T04:34:30.194Z"]}	2024-01-03 04:34:30.194474
6	User	6	create	1	\N	{"id":[null,6],"email":["","scott17@mhs.uinjkt.ac.id"],"encrypted_password":["","$2a$12$Lh6AcxmzHOYxPakB1eEYSOCmx7OClrzBT6IHlSV6BJs9Q1EwRDe7G"],"created_at":[null,"2024-01-03T04:34:30.499Z"],"updated_at":[null,"2024-01-03T04:34:30.499Z"],"userable_type":[null,"Student"],"userable_id":[null,10]}	2024-01-03 04:34:30.49966
7	User	2	update	2	{"id":2,"remember_created_at":"2024-01-03T04:12:00.264Z","email":"herbert.abdillah17@mhs.uinjkt.ac.id","encrypted_password":"$2a$12$Cfi8zNVq5xczTRrR7Bmz7ObFwwpa5OL/Wvr/xfjOTRdZWy0YpxI1e","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2023-05-31T21:08:27.214Z","updated_at":"2024-01-03T04:12:00.265Z","userable_type":"Student","userable_id":1,"is_admin":null}	{"remember_created_at":["2024-01-03T04:12:00.264Z",null],"updated_at":["2024-01-03T04:12:00.265Z","2024-01-03T04:34:42.062Z"]}	2024-01-03 04:34:42.062867
8	User	6	update	\N	{"remember_created_at":null,"id":6,"email":"scott17@mhs.uinjkt.ac.id","encrypted_password":"$2a$12$Lh6AcxmzHOYxPakB1eEYSOCmx7OClrzBT6IHlSV6BJs9Q1EwRDe7G","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2024-01-03T04:34:30.499Z","updated_at":"2024-01-03T04:34:30.499Z","userable_type":"Student","userable_id":10,"is_admin":null}	{"remember_created_at":[null,"2024-01-03T04:34:46.651Z"],"updated_at":["2024-01-03T04:34:30.499Z","2024-01-03T04:34:46.652Z"]}	2024-01-03 04:34:46.652091
9	CoursePlan	3	create	6	\N	{"id":[null,3],"student_id":[null,10],"is_approved":[null,false],"created_at":[null,"2024-01-03T04:41:02.761Z"],"updated_at":[null,"2024-01-03T04:41:02.761Z"]}	2024-01-03 04:41:02.76101
10	CoursePlanCourseSemester	17	create	6	\N	{"id":[null,17],"course_plan_id":[null,3],"course_semester_id":[null,3],"created_at":[null,"2024-01-03T04:41:26.937Z"],"updated_at":[null,"2024-01-03T04:41:26.937Z"]}	2024-01-03 04:41:26.937066
11	CoursePlanCourseSemester	18	create	6	\N	{"id":[null,18],"course_plan_id":[null,3],"course_semester_id":[null,2],"created_at":[null,"2024-01-03T04:41:26.959Z"],"updated_at":[null,"2024-01-03T04:41:26.959Z"]}	2024-01-03 04:41:26.959825
12	CoursePlanCourseSemester	19	create	6	\N	{"id":[null,19],"course_plan_id":[null,3],"course_semester_id":[null,1],"created_at":[null,"2024-01-03T04:41:26.981Z"],"updated_at":[null,"2024-01-03T04:41:26.981Z"]}	2024-01-03 04:41:26.981888
13	Student	10	update	1	{"name":"Scott","nim":"11170910000090","department_id":2,"entry_year":2017,"status":"active","supervisor_lecturer_id":4,"id":10,"created_at":"2024-01-03T04:34:30.194Z","updated_at":"2024-01-03T04:34:30.194Z"}	{"supervisor_lecturer_id":[4,2],"updated_at":["2024-01-03T04:34:30.194Z","2024-01-03T04:43:39.059Z"]}	2024-01-03 04:43:39.059679
14	User	6	update	6	{"id":6,"remember_created_at":"2024-01-03T04:34:46.651Z","email":"scott17@mhs.uinjkt.ac.id","encrypted_password":"$2a$12$Lh6AcxmzHOYxPakB1eEYSOCmx7OClrzBT6IHlSV6BJs9Q1EwRDe7G","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2024-01-03T04:34:30.499Z","updated_at":"2024-01-03T04:34:46.652Z","userable_type":"Student","userable_id":10,"is_admin":null}	{"remember_created_at":["2024-01-03T04:34:46.651Z",null],"updated_at":["2024-01-03T04:34:46.652Z","2024-01-03T04:43:44.686Z"]}	2024-01-03 04:43:44.686936
15	CoursePlan	3	update	4	{"is_approved":false,"id":3,"year":null,"semester":null,"student_id":10,"created_at":"2024-01-03T04:41:02.761Z","updated_at":"2024-01-03T04:41:02.761Z"}	{"is_approved":[false,true],"updated_at":["2024-01-03T04:41:02.761Z","2024-01-03T04:44:15.946Z"]}	2024-01-03 04:44:15.946693
16	CourseResult	17	create	4	\N	{"id":[null,17],"course_plan_id":[null,3],"created_at":[null,"2024-01-03T04:44:15.956Z"],"updated_at":[null,"2024-01-03T04:44:15.956Z"]}	2024-01-03 04:44:15.956464
17	CourseResultScore	17	create	4	\N	{"id":[null,17],"course_result_id":[null,17],"course_plan_course_semester_id":[null,17],"created_at":[null,"2024-01-03T04:44:15.978Z"],"updated_at":[null,"2024-01-03T04:44:15.978Z"]}	2024-01-03 04:44:15.978692
18	CourseResultScore	18	create	4	\N	{"id":[null,18],"course_result_id":[null,17],"course_plan_course_semester_id":[null,18],"created_at":[null,"2024-01-03T04:44:15.988Z"],"updated_at":[null,"2024-01-03T04:44:15.988Z"]}	2024-01-03 04:44:15.98892
19	CourseResultScore	19	create	4	\N	{"id":[null,19],"course_result_id":[null,17],"course_plan_course_semester_id":[null,19],"created_at":[null,"2024-01-03T04:44:15.997Z"],"updated_at":[null,"2024-01-03T04:44:15.997Z"]}	2024-01-03 04:44:15.997758
20	BlockchainSyncBatch	8	create	1	\N	{"id":[null,8],"description":[null,"mulai tahun ajaran baru"],"created_at":[null,"2024-01-03T04:44:38.523Z"],"updated_at":[null,"2024-01-03T04:44:38.523Z"]}	2024-01-03 04:44:38.52337
21	BlockchainSync	185	create	1	\N	{"id":[null,185],"syncable_type":[null,"Student"],"syncable_id":[null,7],"status":[null,"success"],"created_at":[null,"2024-01-03T04:44:40.746Z"],"updated_at":[null,"2024-01-03T04:44:40.746Z"],"blockchain_sync_batch_id":[null,8]}	2024-01-03 04:44:40.74677
22	BlockchainSync	186	create	1	\N	{"id":[null,186],"syncable_type":[null,"Student"],"syncable_id":[null,8],"status":[null,"success"],"created_at":[null,"2024-01-03T04:44:42.842Z"],"updated_at":[null,"2024-01-03T04:44:42.842Z"],"blockchain_sync_batch_id":[null,8]}	2024-01-03 04:44:42.8425
23	BlockchainSync	187	create	1	\N	{"id":[null,187],"syncable_type":[null,"Student"],"syncable_id":[null,9],"status":[null,"success"],"created_at":[null,"2024-01-03T04:44:44.948Z"],"updated_at":[null,"2024-01-03T04:44:44.948Z"],"blockchain_sync_batch_id":[null,8]}	2024-01-03 04:44:44.948411
24	BlockchainSync	188	create	1	\N	{"id":[null,188],"syncable_type":[null,"Student"],"syncable_id":[null,10],"status":[null,"success"],"created_at":[null,"2024-01-03T04:44:47.031Z"],"updated_at":[null,"2024-01-03T04:44:47.031Z"],"blockchain_sync_batch_id":[null,8]}	2024-01-03 04:44:47.031087
25	BlockchainSync	189	create	1	\N	{"id":[null,189],"syncable_type":[null,"CoursePlan"],"syncable_id":[null,3],"status":[null,"error"],"description":[null,"evaluate call to endorser returned error: chaincode response 500, strconv.Atoi: parsing \\"\\": invalid syntax"],"created_at":[null,"2024-01-03T04:44:47.061Z"],"updated_at":[null,"2024-01-03T04:44:47.061Z"],"blockchain_sync_batch_id":[null,8]}	2024-01-03 04:44:47.061843
26	BlockchainSync	190	create	1	\N	{"id":[null,190],"syncable_type":[null,"CourseResultScore"],"syncable_id":[null,17],"status":[null,"error"],"description":[null,"evaluate call to endorser returned error: chaincode response 500, get state with key=CourseResult.3: state entry not found"],"created_at":[null,"2024-01-03T04:44:47.095Z"],"updated_at":[null,"2024-01-03T04:44:47.095Z"],"blockchain_sync_batch_id":[null,8]}	2024-01-03 04:44:47.095917
27	BlockchainSync	191	create	1	\N	{"id":[null,191],"syncable_type":[null,"CourseResultScore"],"syncable_id":[null,18],"status":[null,"error"],"description":[null,"evaluate call to endorser returned error: chaincode response 500, get state with key=CourseResult.3: state entry not found"],"created_at":[null,"2024-01-03T04:44:47.124Z"],"updated_at":[null,"2024-01-03T04:44:47.124Z"],"blockchain_sync_batch_id":[null,8]}	2024-01-03 04:44:47.124836
28	BlockchainSync	192	create	1	\N	{"id":[null,192],"syncable_type":[null,"CourseResultScore"],"syncable_id":[null,19],"status":[null,"error"],"description":[null,"evaluate call to endorser returned error: chaincode response 500, get state with key=CourseResult.3: state entry not found"],"created_at":[null,"2024-01-03T04:44:47.152Z"],"updated_at":[null,"2024-01-03T04:44:47.152Z"],"blockchain_sync_batch_id":[null,8]}	2024-01-03 04:44:47.152149
29	BlockchainSyncBatch	8	update	1	{"status":null,"id":8,"description":"mulai tahun ajaran baru","sync_result":null,"created_at":"2024-01-03T04:44:38.523Z","updated_at":"2024-01-03T04:44:38.523Z"}	{"status":[null,"success"],"updated_at":["2024-01-03T04:44:38.523Z","2024-01-03T04:44:47.163Z"]}	2024-01-03 04:44:47.163461
30	CoursePlan	3	update	4	{"year":null,"semester":null,"is_approved":true,"id":3,"student_id":10,"created_at":"2024-01-03T04:41:02.761Z","updated_at":"2024-01-03T04:44:15.946Z"}	{"year":[null,2023],"semester":[null,1],"updated_at":["2024-01-03T04:44:15.946Z","2024-01-03T04:52:37.791Z"]}	2024-01-03 04:52:37.791336
31	User	2	update	\N	{"remember_created_at":null,"id":2,"email":"herbert.abdillah17@mhs.uinjkt.ac.id","encrypted_password":"$2a$12$Cfi8zNVq5xczTRrR7Bmz7ObFwwpa5OL/Wvr/xfjOTRdZWy0YpxI1e","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2023-05-31T21:08:27.214Z","updated_at":"2024-01-03T04:34:42.062Z","userable_type":"Student","userable_id":1,"is_admin":null}	{"remember_created_at":[null,"2024-01-31T05:24:41.813Z"],"updated_at":["2024-01-03T04:34:42.062Z","2024-01-31T05:24:41.813Z"]}	2024-01-31 05:24:41.813719
32	CoursePlan	4	create	2	\N	{"id":[null,4],"year":[null,2023],"semester":[null,1],"student_id":[null,1],"created_at":[null,"2024-01-31T05:25:31.577Z"],"updated_at":[null,"2024-01-31T05:25:31.577Z"]}	2024-01-31 05:25:31.577269
33	Student	11	create	\N	\N	{"id":[null,11],"name":[null,"Rob"],"nim":[null,"11170910000088"],"department_id":[null,1],"entry_year":[null,2017],"status":[null,"active"],"supervisor_lecturer_id":[null,2],"created_at":[null,"2024-01-31T05:30:51.032Z"],"updated_at":[null,"2024-01-31T05:30:51.032Z"]}	2024-01-31 05:30:51.032094
34	User	1	update	\N	{"remember_created_at":null,"id":1,"email":"admin@example.com","encrypted_password":"$2a$12$1.T9WElu51C.yh4gO389dOA63Fn23Rfh7CUT1OwW5kPFcSdrIN9ke","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2023-05-29T18:59:41.203Z","updated_at":"2024-01-03T00:06:56.278Z","userable_type":null,"userable_id":null,"is_admin":true}	{"remember_created_at":[null,"2024-05-10T07:33:51.213Z"],"updated_at":["2024-01-03T00:06:56.278Z","2024-05-10T07:33:51.215Z"]}	2024-05-10 07:33:51.215107
35	User	1	update	1	{"id":1,"remember_created_at":"2024-05-10T07:33:51.213Z","email":"admin@example.com","encrypted_password":"$2a$12$1.T9WElu51C.yh4gO389dOA63Fn23Rfh7CUT1OwW5kPFcSdrIN9ke","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2023-05-29T18:59:41.203Z","updated_at":"2024-05-10T07:33:51.215Z","userable_type":null,"userable_id":null,"is_admin":true}	{"remember_created_at":["2024-05-10T07:33:51.213Z",null],"updated_at":["2024-05-10T07:33:51.215Z","2024-05-10T07:35:42.911Z"]}	2024-05-10 07:35:42.911124
36	User	1	update	\N	{"remember_created_at":null,"id":1,"email":"admin@example.com","encrypted_password":"$2a$12$1.T9WElu51C.yh4gO389dOA63Fn23Rfh7CUT1OwW5kPFcSdrIN9ke","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2023-05-29T18:59:41.203Z","updated_at":"2024-05-10T07:35:42.911Z","userable_type":null,"userable_id":null,"is_admin":true}	{"remember_created_at":[null,"2024-05-10T08:08:59.639Z"],"updated_at":["2024-05-10T07:35:42.911Z","2024-05-10T08:08:59.641Z"]}	2024-05-10 08:08:59.641127
37	User	1	update	1	{"id":1,"remember_created_at":"2024-05-10T08:08:59.639Z","email":"admin@example.com","encrypted_password":"$2a$12$1.T9WElu51C.yh4gO389dOA63Fn23Rfh7CUT1OwW5kPFcSdrIN9ke","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2023-05-29T18:59:41.203Z","updated_at":"2024-05-10T08:08:59.641Z","userable_type":null,"userable_id":null,"is_admin":true}	{"remember_created_at":["2024-05-10T08:08:59.639Z",null],"updated_at":["2024-05-10T08:08:59.641Z","2024-05-10T08:09:29.543Z"]}	2024-05-10 08:09:29.543618
38	User	4	update	\N	{"remember_created_at":null,"id":4,"email":"ken@uinjkt.ac.id","encrypted_password":"$2a$12$8ejhxuwuEIKDR05ucgJorOT23CBGXfpqGfoScbQSyd1VyE8tMKlUO","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2023-06-01T02:22:47.172Z","updated_at":"2023-06-01T02:23:50.656Z","userable_type":"Lecturer","userable_id":2,"is_admin":null}	{"remember_created_at":[null,"2024-05-10T08:09:40.899Z"],"updated_at":["2023-06-01T02:23:50.656Z","2024-05-10T08:09:40.899Z"]}	2024-05-10 08:09:40.899832
39	User	2	update	2	{"id":2,"remember_created_at":"2024-01-31T05:24:41.813Z","email":"herbert.abdillah17@mhs.uinjkt.ac.id","encrypted_password":"$2a$12$Cfi8zNVq5xczTRrR7Bmz7ObFwwpa5OL/Wvr/xfjOTRdZWy0YpxI1e","reset_password_token":null,"reset_password_sent_at":null,"created_at":"2023-05-31T21:08:27.214Z","updated_at":"2024-01-31T05:24:41.813Z","userable_type":"Student","userable_id":1,"is_admin":null}	{"remember_created_at":["2024-01-31T05:24:41.813Z",null],"updated_at":["2024-01-31T05:24:41.813Z","2024-05-10T08:10:33.297Z"]}	2024-05-10 08:10:33.297742
\.


--
-- Name: application_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.application_configs_id_seq', 2, true);


--
-- Name: blockchain_sync_batches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blockchain_sync_batches_id_seq', 8, true);


--
-- Name: blockchain_syncs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blockchain_syncs_id_seq', 192, true);


--
-- Name: course_plan_course_semesters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_plan_course_semesters_id_seq', 19, true);


--
-- Name: course_plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_plans_id_seq', 4, true);


--
-- Name: course_result_scores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_result_scores_id_seq', 19, true);


--
-- Name: course_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_results_id_seq', 17, true);


--
-- Name: course_semesters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_semesters_id_seq', 3, true);


--
-- Name: course_years_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_years_id_seq', 2, true);


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_id_seq', 3, true);


--
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_id_seq', 2, true);


--
-- Name: faculties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculties_id_seq', 2, true);


--
-- Name: graduates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.graduates_id_seq', 3, true);


--
-- Name: lecturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lecturers_id_seq', 4, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_id_seq', 11, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.versions_id_seq', 39, true);


--
-- Name: application_configs application_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_configs
    ADD CONSTRAINT application_configs_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: blockchain_sync_batches blockchain_sync_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blockchain_sync_batches
    ADD CONSTRAINT blockchain_sync_batches_pkey PRIMARY KEY (id);


--
-- Name: blockchain_syncs blockchain_syncs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blockchain_syncs
    ADD CONSTRAINT blockchain_syncs_pkey PRIMARY KEY (id);


--
-- Name: course_plan_course_semesters course_plan_course_semesters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_plan_course_semesters
    ADD CONSTRAINT course_plan_course_semesters_pkey PRIMARY KEY (id);


--
-- Name: course_plans course_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_plans
    ADD CONSTRAINT course_plans_pkey PRIMARY KEY (id);


--
-- Name: course_result_scores course_result_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_result_scores
    ADD CONSTRAINT course_result_scores_pkey PRIMARY KEY (id);


--
-- Name: course_results course_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_results
    ADD CONSTRAINT course_results_pkey PRIMARY KEY (id);


--
-- Name: course_semesters course_semesters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_semesters
    ADD CONSTRAINT course_semesters_pkey PRIMARY KEY (id);


--
-- Name: course_years course_years_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_years
    ADD CONSTRAINT course_years_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: faculties faculties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_pkey PRIMARY KEY (id);


--
-- Name: graduates graduates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graduates
    ADD CONSTRAINT graduates_pkey PRIMARY KEY (id);


--
-- Name: lecturers lecturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturers
    ADD CONSTRAINT lecturers_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_blockchain_syncs_on_blockchain_sync_batch_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_blockchain_syncs_on_blockchain_sync_batch_id ON public.blockchain_syncs USING btree (blockchain_sync_batch_id);


--
-- Name: index_course_plan_course_semesters_on_course_plan_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_course_plan_course_semesters_on_course_plan_id ON public.course_plan_course_semesters USING btree (course_plan_id);


--
-- Name: index_course_plan_course_semesters_on_course_semester_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_course_plan_course_semesters_on_course_semester_id ON public.course_plan_course_semesters USING btree (course_semester_id);


--
-- Name: index_course_plans_on_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_course_plans_on_student_id ON public.course_plans USING btree (student_id);


--
-- Name: index_course_result_scores_on_course_plan_course_semester_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_course_result_scores_on_course_plan_course_semester_id ON public.course_result_scores USING btree (course_plan_course_semester_id);


--
-- Name: index_course_result_scores_on_course_result_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_course_result_scores_on_course_result_id ON public.course_result_scores USING btree (course_result_id);


--
-- Name: index_course_results_on_course_plan_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_course_results_on_course_plan_id ON public.course_results USING btree (course_plan_id);


--
-- Name: index_course_semesters_on_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_course_semesters_on_course_id ON public.course_semesters USING btree (course_id);


--
-- Name: index_course_semesters_on_lecturer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_course_semesters_on_lecturer_id ON public.course_semesters USING btree (lecturer_id);


--
-- Name: index_courses_on_department_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_courses_on_department_id ON public.courses USING btree (department_id);


--
-- Name: index_departments_on_faculty_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_departments_on_faculty_id ON public.departments USING btree (faculty_id);


--
-- Name: index_graduates_on_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_graduates_on_student_id ON public.graduates USING btree (student_id);


--
-- Name: index_students_on_department_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_students_on_department_id ON public.students USING btree (department_id);


--
-- Name: index_students_on_supervisor_lecturer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_students_on_supervisor_lecturer_id ON public.students USING btree (supervisor_lecturer_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_userable; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_userable ON public.users USING btree (userable_type, userable_id);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: course_result_scores fk_rails_24b78def63; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_result_scores
    ADD CONSTRAINT fk_rails_24b78def63 FOREIGN KEY (course_result_id) REFERENCES public.course_results(id);


--
-- Name: students fk_rails_40b1704bbd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT fk_rails_40b1704bbd FOREIGN KEY (supervisor_lecturer_id) REFERENCES public.lecturers(id);


--
-- Name: graduates fk_rails_4749fceed9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graduates
    ADD CONSTRAINT fk_rails_4749fceed9 FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: course_plans fk_rails_48fee3ad8f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_plans
    ADD CONSTRAINT fk_rails_48fee3ad8f FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: course_semesters fk_rails_4a81003270; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_semesters
    ADD CONSTRAINT fk_rails_4a81003270 FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: courses fk_rails_4e7d7b190d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_rails_4e7d7b190d FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- Name: departments fk_rails_925f039a87; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT fk_rails_925f039a87 FOREIGN KEY (faculty_id) REFERENCES public.faculties(id);


--
-- Name: students fk_rails_96a32b5819; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT fk_rails_96a32b5819 FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- Name: course_results fk_rails_acceded171; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_results
    ADD CONSTRAINT fk_rails_acceded171 FOREIGN KEY (course_plan_id) REFERENCES public.course_plans(id);


--
-- Name: course_semesters fk_rails_b16f322fdc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_semesters
    ADD CONSTRAINT fk_rails_b16f322fdc FOREIGN KEY (lecturer_id) REFERENCES public.lecturers(id);


--
-- Name: course_result_scores fk_rails_b866ec3f3d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_result_scores
    ADD CONSTRAINT fk_rails_b866ec3f3d FOREIGN KEY (course_plan_course_semester_id) REFERENCES public.course_plan_course_semesters(id);


--
-- Name: course_plan_course_semesters fk_rails_fa1510bed4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_plan_course_semesters
    ADD CONSTRAINT fk_rails_fa1510bed4 FOREIGN KEY (course_plan_id) REFERENCES public.course_plans(id);


--
-- Name: course_plan_course_semesters fk_rails_fa56de65aa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_plan_course_semesters
    ADD CONSTRAINT fk_rails_fa56de65aa FOREIGN KEY (course_semester_id) REFERENCES public.course_semesters(id);


--
-- PostgreSQL database dump complete
--

