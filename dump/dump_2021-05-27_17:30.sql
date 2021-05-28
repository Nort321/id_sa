--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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

--
-- Name: data; Type: SCHEMA; Schema: -; Owner: myuser
--

CREATE SCHEMA data;


ALTER SCHEMA data OWNER TO myuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.account (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    secret character varying(30) NOT NULL
);


ALTER TABLE data.account OWNER TO myuser;

--
-- Name: agent; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.agent (
    id integer NOT NULL,
    key character(16),
    name character varying(50) NOT NULL
);


ALTER TABLE data.agent OWNER TO myuser;

--
-- Name: collect; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.collect (
    node integer NOT NULL,
    metric integer NOT NULL,
    intvar integer NOT NULL
);


ALTER TABLE data.collect OWNER TO myuser;

--
-- Name: link; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.link (
    id integer NOT NULL,
    node_a integer NOT NULL,
    node_b integer NOT NULL
);


ALTER TABLE data.link OWNER TO myuser;

--
-- Name: map; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.map (
    id integer NOT NULL,
    account integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE data.map OWNER TO myuser;

--
-- Name: metric; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.metric (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    vmin double precision,
    vmax double precision,
    unit character varying(30) NOT NULL,
    snmp_oid character varying(100) NOT NULL,
    agnt_scale double precision
);


ALTER TABLE data.metric OWNER TO myuser;

--
-- Name: node; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.node (
    id integer NOT NULL,
    map integer NOT NULL,
    x double precision NOT NULL,
    y double precision NOT NULL,
    ip character varying(15) NOT NULL,
    name character varying(30) NOT NULL,
    agent integer NOT NULL
);


ALTER TABLE data.node OWNER TO myuser;

--
-- Name: permission; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.permission (
    account integer NOT NULL,
    func character varying(30) NOT NULL
);


ALTER TABLE data.permission OWNER TO myuser;

--
-- Name: sample; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.sample (
    ts timestamp(0) without time zone NOT NULL,
    node integer NOT NULL,
    metric integer NOT NULL,
    value double precision NOT NULL
);


ALTER TABLE data.sample OWNER TO myuser;

--
-- Name: session; Type: TABLE; Schema: data; Owner: myuser
--

CREATE TABLE data.session (
    key character(16) NOT NULL,
    account integer NOT NULL,
    t_begin timestamp(0) without time zone NOT NULL,
    t_end timestamp(0) without time zone
);


ALTER TABLE data.session OWNER TO myuser;

--
-- Data for Name: account; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.account (id, name, secret) FROM stdin;
1	user1	password
2	user2	password
\.


--
-- Data for Name: agent; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.agent (id, key, name) FROM stdin;
1	PNWWARKMYPULABCD	agent1
2	YPIHISUYLAQEVSZI	spbkit agent
\.


--
-- Data for Name: collect; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.collect (node, metric, intvar) FROM stdin;
11	1	10
11	2	10
11	3	30
11	4	20
11	5	15
12	1	10
12	2	10
12	3	30
\.


--
-- Data for Name: link; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.link (id, node_a, node_b) FROM stdin;
1	1	2
2	2	3
4	6	7
5	8	9
6	8	10
\.


--
-- Data for Name: map; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.map (id, account, name) FROM stdin;
1	1	map1
2	1	map2
3	2	map3
4	2	map4
5	2	spbkit network
\.


--
-- Data for Name: metric; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.metric (id, name, vmin, vmax, unit, snmp_oid, agnt_scale) FROM stdin;
1	cpu0	0	100	%	1.3.6.1.2.1.25.3.3.1.2.1	1
2	cpu1	0	100	%	1.3.6.1.2.1.25.3.3.1.2.2	1
3	memory	0	\N	mb	1.3.6.1.2.1.25.2.3.1.6.65536	0.001
4	voltage	0	\N	v	1.3.6.1.4.1.14988.1.1.3.8.0	0.1
5	temp	\N	\N	c	1.3.6.1.4.1.14988.1.1.3.10.0	0.1
6	cpu-temp	\N	\N	c	1.3.6.1.4.1.14988.1.1.3.11.0	0.1
\.


--
-- Data for Name: node; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.node (id, map, x, y, ip, name, agent) FROM stdin;
1	1	632	284	192.168.35.101	host1	1
2	1	742	767	192.168.35.102	host2	1
3	1	426	887	192.168.35.103	host3	1
5	2	107	662	192.168.35.105	host5	1
6	3	90	40	192.168.35.106	host6	1
7	3	40	90	192.168.35.107	host7	1
8	4	20	40	192.168.35.108	host8	1
9	4	70	30	192.168.35.109	host9	1
10	4	60	70	192.168.35.110	host10	1
11	4	50	30	192.168.35.111	host11	1
12	4	20	50	192.168.35.112	host12	1
16	4	30	20	192.168.35.116	host16	1
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.permission (account, func) FROM stdin;
1	open_session
1	close_session
1	get_maps
1	get_nodes
1	get_links
1	delete_map
1	delete_node
1	delete_node
\.


--
-- Data for Name: sample; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.sample (ts, node, metric, value) FROM stdin;
2021-05-11 23:52:32	12	1	0
2021-05-11 23:52:32	12	4	23.9
2021-05-12 04:41:08	16	6	66
2021-05-12 04:41:09	11	3	45.644
2021-05-12 04:41:12	11	2	6
2021-05-12 04:41:12	16	3	28.968
2021-05-12 04:41:12	16	3	28.968
2021-05-12 04:41:13	11	1	1
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: data; Owner: myuser
--

COPY data.session (key, account, t_begin, t_end) FROM stdin;
BEBSVETTPDFASGOM	1	2021-05-09 19:40:46	\N
BHSOSQOAIKGJLTSS	1	2021-05-09 09:17:55	\N
BWFMKMEQRLCRDOAL	1	2021-05-09 17:48:55	\N
BYZQDLIOCNVMDSHH	1	2021-05-09 12:35:00	\N
CHPNWPGFAKTTETCJ	1	2021-05-09 17:34:11	\N
CICSYGRFGOCOXFFV	1	2021-05-09 12:35:12	\N
CNWLOVETSMUYKUDS	1	2021-05-09 14:09:51	\N
CPQHERATHVCQGGJQ	1	2021-05-09 12:44:41	\N
\.


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: agent agent_key_unique; Type: CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.agent
    ADD CONSTRAINT agent_key_unique UNIQUE (key);


--
-- Name: agent agent_pkey; Type: CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.agent
    ADD CONSTRAINT agent_pkey PRIMARY KEY (id);


--
-- Name: link link_pkey; Type: CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.link
    ADD CONSTRAINT link_pkey PRIMARY KEY (id);


--
-- Name: map map_pkey; Type: CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.map
    ADD CONSTRAINT map_pkey PRIMARY KEY (id);


--
-- Name: metric metric_pkey; Type: CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.metric
    ADD CONSTRAINT metric_pkey PRIMARY KEY (id);


--
-- Name: node node_pkey; Type: CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.node
    ADD CONSTRAINT node_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (key);


--
-- Name: collect collect_metric_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.collect
    ADD CONSTRAINT collect_metric_foreign FOREIGN KEY (metric) REFERENCES data.metric(id);


--
-- Name: collect collect_node_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.collect
    ADD CONSTRAINT collect_node_foreign FOREIGN KEY (node) REFERENCES data.node(id);


--
-- Name: link link_node_a_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.link
    ADD CONSTRAINT link_node_a_foreign FOREIGN KEY (node_a) REFERENCES data.node(id);


--
-- Name: link link_node_b_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.link
    ADD CONSTRAINT link_node_b_foreign FOREIGN KEY (node_b) REFERENCES data.node(id);


--
-- Name: map map_account_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.map
    ADD CONSTRAINT map_account_foreign FOREIGN KEY (account) REFERENCES data.account(id);


--
-- Name: node node_agent_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.node
    ADD CONSTRAINT node_agent_foreign FOREIGN KEY (agent) REFERENCES data.agent(id);


--
-- Name: node node_map_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.node
    ADD CONSTRAINT node_map_foreign FOREIGN KEY (map) REFERENCES data.map(id);


--
-- Name: permission permission_account_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.permission
    ADD CONSTRAINT permission_account_foreign FOREIGN KEY (account) REFERENCES data.account(id);


--
-- Name: sample sample_metric_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.sample
    ADD CONSTRAINT sample_metric_foreign FOREIGN KEY (metric) REFERENCES data.metric(id);


--
-- Name: sample sample_node_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.sample
    ADD CONSTRAINT sample_node_foreign FOREIGN KEY (node) REFERENCES data.node(id);


--
-- Name: session session_account_foreign; Type: FK CONSTRAINT; Schema: data; Owner: myuser
--

ALTER TABLE ONLY data.session
    ADD CONSTRAINT session_account_foreign FOREIGN KEY (account) REFERENCES data.account(id);


--
-- PostgreSQL database dump complete
--

