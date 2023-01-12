--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Homebrew)
-- Dumped by pg_dump version 15.1 (Homebrew)

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
-- Name: activate_code; Type: TABLE; Schema: public; Owner: growerlab
--

CREATE TABLE public.activate_code (
    id integer NOT NULL,
    user_id integer NOT NULL,
    code character varying(16) NOT NULL,
    created_at integer NOT NULL,
    used_at integer NOT NULL,
    expired_at integer NOT NULL
);


ALTER TABLE public.activate_code OWNER TO growerlab;

--
-- Name: TABLE activate_code; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON TABLE public.activate_code IS '用户激活码';


--
-- Name: activate_code_id_seq; Type: SEQUENCE; Schema: public; Owner: growerlab
--

ALTER TABLE public.activate_code ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.activate_code_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);


--
-- Name: activate_code_seq; Type: SEQUENCE; Schema: public; Owner: growerlab
--

CREATE SEQUENCE public.activate_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activate_code_seq OWNER TO growerlab;

--
-- Name: namespace; Type: TABLE; Schema: public; Owner: growerlab
--

CREATE TABLE public.namespace (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    owner_id integer NOT NULL,
    type smallint NOT NULL
);


ALTER TABLE public.namespace OWNER TO growerlab;

--
-- Name: TABLE namespace; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON TABLE public.namespace IS '命名空间';


--
-- Name: COLUMN namespace.owner_id; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.namespace.owner_id IS '命名空间所有者（用户）';


--
-- Name: COLUMN namespace.type; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.namespace.type IS '1用户 2组织';


--
-- Name: namespace_id_seq; Type: SEQUENCE; Schema: public; Owner: growerlab
--

ALTER TABLE public.namespace ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.namespace_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);


--
-- Name: permission; Type: TABLE; Schema: public; Owner: growerlab
--

CREATE TABLE public.permission (
    id integer NOT NULL,
    namespace_id integer NOT NULL,
    context_type integer,
    context_param_1 integer NOT NULL,
    context_param_2 integer NOT NULL,
    user_domain_type integer NOT NULL,
    user_domain_param integer NOT NULL,
    created_at integer NOT NULL,
    deleted_at integer,
    code integer NOT NULL
);


ALTER TABLE public.permission OWNER TO growerlab;

--
-- Name: TABLE permission; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON TABLE public.permission IS '权限表';


--
-- Name: COLUMN permission.namespace_id; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.permission.namespace_id IS '权限所属命名空间（不依赖组织或个人，而是依赖命名空间）';


--
-- Name: COLUMN permission.context_type; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.permission.context_type IS '上下文类型';


--
-- Name: COLUMN permission.context_param_1; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.permission.context_param_1 IS '上下文参数1';


--
-- Name: COLUMN permission.context_param_2; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.permission.context_param_2 IS '上下文参数2';


--
-- Name: COLUMN permission.user_domain_type; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.permission.user_domain_type IS '用户域类型';


--
-- Name: COLUMN permission.user_domain_param; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.permission.user_domain_param IS '用户域参数';


--
-- Name: COLUMN permission.created_at; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.permission.created_at IS '创建时间';


--
-- Name: COLUMN permission.deleted_at; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.permission.deleted_at IS '删除时间';


--
-- Name: COLUMN permission.code; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.permission.code IS '权限代号';


--
-- Name: permission_id_seq; Type: SEQUENCE; Schema: public; Owner: growerlab
--

ALTER TABLE public.permission ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: repository; Type: TABLE; Schema: public; Owner: growerlab
--

CREATE TABLE public.repository (
    id integer NOT NULL,
    uuid character varying(16) NOT NULL,
    fork boolean DEFAULT false NOT NULL,
    path character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    namespace_id integer NOT NULL,
    owner_id integer NOT NULL,
    description text NOT NULL,
    created_at integer NOT NULL,
    public boolean DEFAULT true NOT NULL,
    last_push_at integer DEFAULT 0 NOT NULL,
    default_branch character varying(255) DEFAULT 'main'::character varying NOT NULL
);


ALTER TABLE public.repository OWNER TO growerlab;

--
-- Name: TABLE repository; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON TABLE public.repository IS '仓库表';


--
-- Name: COLUMN repository.fork; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.repository.fork IS '是否fork项目';


--
-- Name: COLUMN repository.path; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.repository.path IS '仓库路径';


--
-- Name: COLUMN repository.name; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.repository.name IS '仓库名';


--
-- Name: COLUMN repository.owner_id; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.repository.owner_id IS '仓库创建者，fork后不变';


--
-- Name: COLUMN repository.description; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.repository.description IS '仓库描述';


--
-- Name: COLUMN repository.public; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.repository.public IS '是否公开';


--
-- Name: COLUMN repository.last_push_at; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.repository.last_push_at IS '最后推送时间';


--
-- Name: COLUMN repository.default_branch; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public.repository.default_branch IS '默认分支';


--
-- Name: session; Type: TABLE; Schema: public; Owner: growerlab
--

CREATE TABLE public.session (
    id integer NOT NULL,
    owner_id integer NOT NULL,
    token character varying(36) NOT NULL,
    created_at integer NOT NULL,
    expired_at integer NOT NULL,
    client_ip character varying(46) NOT NULL
);


ALTER TABLE public.session OWNER TO growerlab;

--
-- Name: TABLE session; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON TABLE public.session IS '会话';


--
-- Name: session_id_seq; Type: SEQUENCE; Schema: public; Owner: growerlab
--

ALTER TABLE public.session ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user; Type: TABLE; Schema: public; Owner: growerlab
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    encrypted_password character varying(255) NOT NULL,
    username character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    public_email character varying(255) NOT NULL,
    last_login_ip character varying(46) DEFAULT NULL::character varying,
    last_login_at integer DEFAULT 0 NOT NULL,
    created_at integer NOT NULL,
    deleted_at integer,
    verified_at integer,
    register_ip character varying(46),
    is_admin boolean DEFAULT false NOT NULL,
    namespace_id integer NOT NULL
);


ALTER TABLE public."user" OWNER TO growerlab;

--
-- Name: COLUMN "user".email; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public."user".email IS '用户邮箱';


--
-- Name: COLUMN "user".encrypted_password; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public."user".encrypted_password IS '用户密码';


--
-- Name: COLUMN "user".username; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public."user".username IS '未一下用户名（url中唯一）';


--
-- Name: COLUMN "user".name; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public."user".name IS '用户昵称';


--
-- Name: COLUMN "user".register_ip; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public."user".register_ip IS '注册ip';


--
-- Name: COLUMN "user".namespace_id; Type: COMMENT; Schema: public; Owner: growerlab
--

COMMENT ON COLUMN public."user".namespace_id IS '用户的用户域id';


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: growerlab
--

ALTER TABLE public."user" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);


--
-- Name: activate_code activate_code_pk; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public.activate_code
    ADD CONSTRAINT activate_code_pk PRIMARY KEY (id);


--
-- Name: activate_code activate_code_unq_code; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public.activate_code
    ADD CONSTRAINT activate_code_unq_code UNIQUE (code);


--
-- Name: namespace namespace_pk; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public.namespace
    ADD CONSTRAINT namespace_pk PRIMARY KEY (id);


--
-- Name: namespace namespace_uniq_path; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public.namespace
    ADD CONSTRAINT namespace_uniq_path UNIQUE (path);


--
-- Name: permission permission_pk; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pk PRIMARY KEY (id);


--
-- Name: repository repository_pk; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public.repository
    ADD CONSTRAINT repository_pk PRIMARY KEY (id);


--
-- Name: repository repository_uniq_namespace_path; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public.repository
    ADD CONSTRAINT repository_uniq_namespace_path UNIQUE (namespace_id, path);


--
-- Name: session session_pk; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pk PRIMARY KEY (id);


--
-- Name: session session_uniq_owner; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_uniq_owner UNIQUE (owner_id, token);


--
-- Name: user user_pk; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: user user_uniq_email; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_uniq_email UNIQUE (email);


--
-- Name: user user_uniq_username; Type: CONSTRAINT; Schema: public; Owner: growerlab
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_uniq_username UNIQUE (username);


--
-- Name: namespace__index_owner; Type: INDEX; Schema: public; Owner: growerlab
--

CREATE INDEX namespace__index_owner ON public.namespace USING btree (owner_id);


--
-- Name: permission__index_ctx; Type: INDEX; Schema: public; Owner: growerlab
--

CREATE INDEX permission__index_ctx ON public.permission USING btree (code, context_type, context_param_1, context_param_2);


--
-- Name: permission__index_namespace; Type: INDEX; Schema: public; Owner: growerlab
--

CREATE INDEX permission__index_namespace ON public.permission USING btree (namespace_id);


--
-- Name: repository__index_uuid; Type: INDEX; Schema: public; Owner: growerlab
--

CREATE INDEX repository__index_uuid ON public.repository USING btree (uuid);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO growerlab;


--
-- PostgreSQL database dump complete
--

