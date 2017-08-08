--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_account (
    id integer NOT NULL,
    timezone character varying(100) NOT NULL,
    language character varying(10) NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: account_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_account_id_seq OWNED BY account_account.id;


--
-- Name: account_accountdeletion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_accountdeletion (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    date_requested timestamp with time zone NOT NULL,
    date_expunged timestamp with time zone,
    user_id integer
);


--
-- Name: account_accountdeletion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_accountdeletion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_accountdeletion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_accountdeletion_id_seq OWNED BY account_accountdeletion.id;


--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_emailaddress_id_seq OWNED BY account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_emailconfirmation_id_seq OWNED BY account_emailconfirmation.id;


--
-- Name: account_signupcode; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_signupcode (
    id integer NOT NULL,
    code character varying(64) NOT NULL,
    max_uses integer NOT NULL,
    expiry timestamp with time zone,
    email character varying(254) NOT NULL,
    notes text NOT NULL,
    sent timestamp with time zone,
    created timestamp with time zone NOT NULL,
    use_count integer NOT NULL,
    inviter_id integer,
    CONSTRAINT account_signupcode_max_uses_check CHECK ((max_uses >= 0)),
    CONSTRAINT account_signupcode_use_count_check CHECK ((use_count >= 0))
);


--
-- Name: account_signupcode_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_signupcode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_signupcode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_signupcode_id_seq OWNED BY account_signupcode.id;


--
-- Name: account_signupcodeextended; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_signupcodeextended (
    signupcode_id integer NOT NULL,
    username character varying(30) NOT NULL
);


--
-- Name: account_signupcoderesult; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_signupcoderesult (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    signup_code_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: account_signupcoderesult_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_signupcoderesult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_signupcoderesult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_signupcoderesult_id_seq OWNED BY account_signupcoderesult.id;


--
-- Name: actstream_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE actstream_action (
    id integer NOT NULL,
    actor_object_id character varying(255) NOT NULL,
    verb character varying(255) NOT NULL,
    description text,
    target_object_id character varying(255),
    action_object_object_id character varying(255),
    "timestamp" timestamp with time zone NOT NULL,
    public boolean NOT NULL,
    data jsonb,
    action_object_content_type_id integer,
    actor_content_type_id integer NOT NULL,
    target_content_type_id integer
);


--
-- Name: actstream_action_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE actstream_action_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actstream_action_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE actstream_action_id_seq OWNED BY actstream_action.id;


--
-- Name: actstream_follow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE actstream_follow (
    id integer NOT NULL,
    object_id character varying(255) NOT NULL,
    actor_only boolean NOT NULL,
    started timestamp with time zone NOT NULL,
    content_type_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: actstream_follow_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE actstream_follow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actstream_follow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE actstream_follow_id_seq OWNED BY actstream_follow.id;


--
-- Name: agon_ratings_overallrating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE agon_ratings_overallrating (
    id integer NOT NULL,
    object_id integer NOT NULL,
    rating numeric(6,1),
    category integer,
    content_type_id integer NOT NULL
);


--
-- Name: agon_ratings_overallrating_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE agon_ratings_overallrating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agon_ratings_overallrating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE agon_ratings_overallrating_id_seq OWNED BY agon_ratings_overallrating.id;


--
-- Name: agon_ratings_rating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE agon_ratings_rating (
    id integer NOT NULL,
    object_id integer NOT NULL,
    rating integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    category integer,
    content_type_id integer NOT NULL,
    overall_rating_id integer,
    user_id integer NOT NULL
);


--
-- Name: agon_ratings_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE agon_ratings_rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agon_ratings_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE agon_ratings_rating_id_seq OWNED BY agon_ratings_rating.id;


--
-- Name: announcements_announcement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE announcements_announcement (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    level integer NOT NULL,
    content text NOT NULL,
    creation_date timestamp with time zone NOT NULL,
    site_wide boolean NOT NULL,
    members_only boolean NOT NULL,
    dismissal_type integer NOT NULL,
    publish_start timestamp with time zone NOT NULL,
    publish_end timestamp with time zone,
    creator_id integer NOT NULL
);


--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE announcements_announcement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE announcements_announcement_id_seq OWNED BY announcements_announcement.id;


--
-- Name: announcements_dismissal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE announcements_dismissal (
    id integer NOT NULL,
    dismissed_at timestamp with time zone NOT NULL,
    announcement_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: announcements_dismissal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE announcements_dismissal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: announcements_dismissal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE announcements_dismissal_id_seq OWNED BY announcements_dismissal.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: avatar_avatar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE avatar_avatar (
    id integer NOT NULL,
    "primary" boolean NOT NULL,
    avatar character varying(1024) NOT NULL,
    date_uploaded timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: avatar_avatar_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE avatar_avatar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: avatar_avatar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE avatar_avatar_id_seq OWNED BY avatar_avatar.id;


--
-- Name: base_backup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_backup (
    id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    name_en character varying(100),
    date timestamp with time zone NOT NULL,
    description text,
    description_en text,
    base_folder character varying(100) NOT NULL,
    location text
);


--
-- Name: base_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_backup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_backup_id_seq OWNED BY base_backup.id;


--
-- Name: base_contactrole; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_contactrole (
    id integer NOT NULL,
    role character varying(255) NOT NULL,
    contact_id integer NOT NULL,
    resource_id integer
);


--
-- Name: base_contactrole_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_contactrole_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_contactrole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_contactrole_id_seq OWNED BY base_contactrole.id;


--
-- Name: base_hierarchicalkeyword; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_hierarchicalkeyword (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    numchild integer NOT NULL,
    CONSTRAINT base_hierarchicalkeyword_depth_check CHECK ((depth >= 0)),
    CONSTRAINT base_hierarchicalkeyword_numchild_check CHECK ((numchild >= 0))
);


--
-- Name: base_hierarchicalkeyword_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_hierarchicalkeyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_hierarchicalkeyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_hierarchicalkeyword_id_seq OWNED BY base_hierarchicalkeyword.id;


--
-- Name: base_license; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_license (
    id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    name_en character varying(100),
    abbreviation character varying(20),
    description text,
    description_en text,
    url character varying(2000),
    license_text text,
    license_text_en text
);


--
-- Name: base_license_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_license_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_license_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_license_id_seq OWNED BY base_license.id;


--
-- Name: base_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_link (
    id integer NOT NULL,
    extension character varying(255) NOT NULL,
    link_type character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    mime character varying(255) NOT NULL,
    url text NOT NULL,
    resource_id integer
);


--
-- Name: base_link_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_link_id_seq OWNED BY base_link.id;


--
-- Name: base_region; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_region (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    name_en character varying(255),
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    CONSTRAINT base_region_level_check CHECK ((level >= 0)),
    CONSTRAINT base_region_lft_check CHECK ((lft >= 0)),
    CONSTRAINT base_region_rght_check CHECK ((rght >= 0)),
    CONSTRAINT base_region_tree_id_check CHECK ((tree_id >= 0))
);


--
-- Name: base_region_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_region_id_seq OWNED BY base_region.id;


--
-- Name: base_resourcebase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_resourcebase (
    id integer NOT NULL,
    uuid character varying(36) NOT NULL,
    title character varying(255) NOT NULL,
    date timestamp with time zone NOT NULL,
    date_type character varying(255) NOT NULL,
    edition character varying(255),
    abstract text NOT NULL,
    purpose text,
    maintenance_frequency character varying(255),
    constraints_other text,
    language character varying(3) NOT NULL,
    temporal_extent_start timestamp with time zone,
    temporal_extent_end timestamp with time zone,
    supplemental_information text NOT NULL,
    data_quality_statement text,
    bbox_x0 numeric(19,10),
    bbox_x1 numeric(19,10),
    bbox_y0 numeric(19,10),
    bbox_y1 numeric(19,10),
    srid character varying(255) NOT NULL,
    csw_typename character varying(32) NOT NULL,
    csw_schema character varying(64) NOT NULL,
    csw_mdsource character varying(256) NOT NULL,
    csw_insert_date timestamp with time zone,
    csw_type character varying(32) NOT NULL,
    csw_anytext text,
    csw_wkt_geometry text NOT NULL,
    metadata_uploaded boolean NOT NULL,
    metadata_xml text,
    popular_count integer NOT NULL,
    share_count integer NOT NULL,
    featured boolean NOT NULL,
    is_published boolean NOT NULL,
    thumbnail_url text,
    detail_url character varying(255),
    rating integer,
    category_id integer,
    license_id integer,
    owner_id integer,
    polymorphic_ctype_id integer,
    restriction_code_type_id integer,
    spatial_representation_type_id integer,
    metadata_uploaded_preserve boolean NOT NULL
);


--
-- Name: base_resourcebase_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_resourcebase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_resourcebase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_resourcebase_id_seq OWNED BY base_resourcebase.id;


--
-- Name: base_resourcebase_regions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_resourcebase_regions (
    id integer NOT NULL,
    resourcebase_id integer NOT NULL,
    region_id integer NOT NULL
);


--
-- Name: base_resourcebase_regions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_resourcebase_regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_resourcebase_regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_resourcebase_regions_id_seq OWNED BY base_resourcebase_regions.id;


--
-- Name: base_resourcebase_tkeywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_resourcebase_tkeywords (
    id integer NOT NULL,
    resourcebase_id integer NOT NULL,
    thesauruskeyword_id integer NOT NULL
);


--
-- Name: base_resourcebase_tkeywords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_resourcebase_tkeywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_resourcebase_tkeywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_resourcebase_tkeywords_id_seq OWNED BY base_resourcebase_tkeywords.id;


--
-- Name: base_restrictioncodetype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_restrictioncodetype (
    id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    description text NOT NULL,
    description_en text,
    gn_description text NOT NULL,
    gn_description_en text,
    is_choice boolean NOT NULL
);


--
-- Name: base_restrictioncodetype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_restrictioncodetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_restrictioncodetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_restrictioncodetype_id_seq OWNED BY base_restrictioncodetype.id;


--
-- Name: base_spatialrepresentationtype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_spatialrepresentationtype (
    id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    description_en character varying(255),
    gn_description character varying(255) NOT NULL,
    gn_description_en character varying(255),
    is_choice boolean NOT NULL
);


--
-- Name: base_spatialrepresentationtype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_spatialrepresentationtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_spatialrepresentationtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_spatialrepresentationtype_id_seq OWNED BY base_spatialrepresentationtype.id;


--
-- Name: base_taggedcontentitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_taggedcontentitem (
    id integer NOT NULL,
    content_object_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: base_taggedcontentitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_taggedcontentitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_taggedcontentitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_taggedcontentitem_id_seq OWNED BY base_taggedcontentitem.id;


--
-- Name: base_thesaurus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_thesaurus (
    id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    date character varying(20) NOT NULL,
    description text NOT NULL,
    slug character varying(64) NOT NULL
);


--
-- Name: base_thesaurus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_thesaurus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_thesaurus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_thesaurus_id_seq OWNED BY base_thesaurus.id;


--
-- Name: base_thesauruskeyword; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_thesauruskeyword (
    id integer NOT NULL,
    about character varying(255),
    alt_label character varying(255),
    thesaurus_id integer NOT NULL
);


--
-- Name: base_thesauruskeyword_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_thesauruskeyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_thesauruskeyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_thesauruskeyword_id_seq OWNED BY base_thesauruskeyword.id;


--
-- Name: base_thesauruskeywordlabel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_thesauruskeywordlabel (
    id integer NOT NULL,
    lang character varying(3) NOT NULL,
    label character varying(255) NOT NULL,
    keyword_id integer NOT NULL
);


--
-- Name: base_thesauruskeywordlabel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_thesauruskeywordlabel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_thesauruskeywordlabel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_thesauruskeywordlabel_id_seq OWNED BY base_thesauruskeywordlabel.id;


--
-- Name: base_topiccategory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE base_topiccategory (
    id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    description text NOT NULL,
    description_en text,
    gn_description text,
    gn_description_en text,
    is_choice boolean NOT NULL,
    fa_class character varying(64) NOT NULL
);


--
-- Name: base_topiccategory_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE base_topiccategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_topiccategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE base_topiccategory_id_seq OWNED BY base_topiccategory.id;


--
-- Name: celery_taskmeta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE celery_taskmeta (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    hidden boolean NOT NULL,
    meta text
);


--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE celery_taskmeta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE celery_taskmeta_id_seq OWNED BY celery_taskmeta.id;


--
-- Name: celery_tasksetmeta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE celery_tasksetmeta (
    id integer NOT NULL,
    taskset_id character varying(255) NOT NULL,
    result text NOT NULL,
    date_done timestamp with time zone NOT NULL,
    hidden boolean NOT NULL
);


--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE celery_tasksetmeta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE celery_tasksetmeta_id_seq OWNED BY celery_tasksetmeta.id;


--
-- Name: dialogos_comment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dialogos_comment (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    website character varying(255) NOT NULL,
    object_id integer NOT NULL,
    comment text NOT NULL,
    submit_date timestamp with time zone NOT NULL,
    ip_address inet,
    public boolean NOT NULL,
    author_id integer,
    content_type_id integer NOT NULL
);


--
-- Name: dialogos_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dialogos_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dialogos_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dialogos_comment_id_seq OWNED BY dialogos_comment.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: django_site; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: djcelery_crontabschedule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE djcelery_crontabschedule (
    id integer NOT NULL,
    minute character varying(64) NOT NULL,
    hour character varying(64) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(64) NOT NULL,
    month_of_year character varying(64) NOT NULL
);


--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE djcelery_crontabschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE djcelery_crontabschedule_id_seq OWNED BY djcelery_crontabschedule.id;


--
-- Name: djcelery_intervalschedule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE djcelery_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE djcelery_intervalschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE djcelery_intervalschedule_id_seq OWNED BY djcelery_intervalschedule.id;


--
-- Name: djcelery_periodictask; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE djcelery_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    CONSTRAINT djcelery_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE djcelery_periodictask_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE djcelery_periodictask_id_seq OWNED BY djcelery_periodictask.id;


--
-- Name: djcelery_periodictasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE djcelery_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


--
-- Name: djcelery_taskstate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE djcelery_taskstate (
    id integer NOT NULL,
    state character varying(64) NOT NULL,
    task_id character varying(36) NOT NULL,
    name character varying(200),
    tstamp timestamp with time zone NOT NULL,
    args text,
    kwargs text,
    eta timestamp with time zone,
    expires timestamp with time zone,
    result text,
    traceback text,
    runtime double precision,
    retries integer NOT NULL,
    hidden boolean NOT NULL,
    worker_id integer
);


--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE djcelery_taskstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE djcelery_taskstate_id_seq OWNED BY djcelery_taskstate.id;


--
-- Name: djcelery_workerstate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE djcelery_workerstate (
    id integer NOT NULL,
    hostname character varying(255) NOT NULL,
    last_heartbeat timestamp with time zone
);


--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE djcelery_workerstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE djcelery_workerstate_id_seq OWNED BY djcelery_workerstate.id;


--
-- Name: documents_document; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE documents_document (
    resourcebase_ptr_id integer NOT NULL,
    title_en character varying(255),
    abstract_en text,
    purpose_en text,
    constraints_other_en text,
    supplemental_information_en text,
    data_quality_statement_en text,
    object_id integer,
    doc_file character varying(255),
    extension character varying(128),
    doc_type character varying(128),
    doc_url character varying(255),
    content_type_id integer,
    CONSTRAINT documents_document_object_id_check CHECK ((object_id >= 0))
);


--
-- Name: gazetteer_gazetteerentry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE gazetteer_gazetteerentry (
    id integer NOT NULL,
    layer_name character varying(255) NOT NULL,
    layer_attribute character varying(255) NOT NULL,
    feature_type character varying(255) NOT NULL,
    feature_fid bigint NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    place_name text NOT NULL,
    start_date text,
    end_date text,
    julian_start integer,
    julian_end integer,
    project character varying(255),
    feature geometry(Geometry,4326),
    username character varying(30)
);


--
-- Name: gazetteer_gazetteerentry_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gazetteer_gazetteerentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gazetteer_gazetteerentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE gazetteer_gazetteerentry_id_seq OWNED BY gazetteer_gazetteerentry.id;


--
-- Name: groups_groupinvitation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE groups_groupinvitation (
    id integer NOT NULL,
    token character varying(40) NOT NULL,
    email character varying(254) NOT NULL,
    role character varying(10) NOT NULL,
    state character varying(10) NOT NULL,
    created timestamp with time zone NOT NULL,
    from_user_id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer
);


--
-- Name: groups_groupinvitation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_groupinvitation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_groupinvitation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_groupinvitation_id_seq OWNED BY groups_groupinvitation.id;


--
-- Name: groups_groupmember; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE groups_groupmember (
    id integer NOT NULL,
    role character varying(10) NOT NULL,
    joined timestamp with time zone NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: groups_groupmember_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_groupmember_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_groupmember_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_groupmember_id_seq OWNED BY groups_groupmember.id;


--
-- Name: groups_groupprofile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE groups_groupprofile (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    logo character varying(100) NOT NULL,
    description text NOT NULL,
    email character varying(254),
    access character varying(15) NOT NULL,
    last_modified timestamp with time zone NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: groups_groupprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_groupprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_groupprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_groupprofile_id_seq OWNED BY groups_groupprofile.id;


--
-- Name: guardian_groupobjectpermission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE guardian_groupobjectpermission (
    id integer NOT NULL,
    object_pk character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: guardian_groupobjectpermission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guardian_groupobjectpermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guardian_groupobjectpermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guardian_groupobjectpermission_id_seq OWNED BY guardian_groupobjectpermission.id;


--
-- Name: guardian_userobjectpermission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE guardian_userobjectpermission (
    id integer NOT NULL,
    object_pk character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    permission_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: guardian_userobjectpermission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guardian_userobjectpermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guardian_userobjectpermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guardian_userobjectpermission_id_seq OWNED BY guardian_userobjectpermission.id;


--
-- Name: layers_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE layers_attribute (
    id integer NOT NULL,
    attribute character varying(255),
    description character varying(255),
    attribute_label character varying(255),
    attribute_type character varying(50) NOT NULL,
    visible boolean NOT NULL,
    display_order integer NOT NULL,
    count integer NOT NULL,
    min character varying(255),
    max character varying(255),
    average character varying(255),
    median character varying(255),
    stddev character varying(255),
    sum character varying(255),
    unique_values text,
    last_stats_updated timestamp with time zone NOT NULL,
    layer_id integer NOT NULL,
    in_gazetteer boolean NOT NULL,
    is_gaz_end_date boolean NOT NULL,
    is_gaz_start_date boolean NOT NULL
);


--
-- Name: layers_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE layers_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: layers_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE layers_attribute_id_seq OWNED BY layers_attribute.id;


--
-- Name: layers_layer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE layers_layer (
    resourcebase_ptr_id integer NOT NULL,
    title_en character varying(255),
    abstract_en text,
    purpose_en text,
    constraints_other_en text,
    supplemental_information_en text,
    data_quality_statement_en text,
    workspace character varying(128) NOT NULL,
    store character varying(128) NOT NULL,
    "storeType" character varying(128) NOT NULL,
    name character varying(128) NOT NULL,
    typename character varying(128),
    charset character varying(255) NOT NULL,
    default_style_id integer,
    upload_session_id integer,
    elevation_regex character varying(128),
    has_elevation boolean NOT NULL,
    has_time boolean NOT NULL,
    is_mosaic boolean NOT NULL,
    time_regex character varying(128),
    gazetteer_project character varying(128),
    in_gazetteer boolean NOT NULL
);


--
-- Name: layers_layer_styles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE layers_layer_styles (
    id integer NOT NULL,
    layer_id integer NOT NULL,
    style_id integer NOT NULL
);


--
-- Name: layers_layer_styles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE layers_layer_styles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: layers_layer_styles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE layers_layer_styles_id_seq OWNED BY layers_layer_styles.id;


--
-- Name: layers_layerfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE layers_layerfile (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    base boolean NOT NULL,
    file character varying(255) NOT NULL,
    upload_session_id integer NOT NULL
);


--
-- Name: layers_layerfile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE layers_layerfile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: layers_layerfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE layers_layerfile_id_seq OWNED BY layers_layerfile.id;


--
-- Name: layers_style; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE layers_style (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    sld_title character varying(255),
    sld_body text,
    sld_version character varying(12),
    sld_url character varying(1000),
    workspace character varying(255)
);


--
-- Name: layers_style_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE layers_style_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: layers_style_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE layers_style_id_seq OWNED BY layers_style.id;


--
-- Name: layers_uploadsession; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE layers_uploadsession (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    processed boolean NOT NULL,
    error text,
    traceback text,
    context text,
    user_id integer NOT NULL
);


--
-- Name: layers_uploadsession_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE layers_uploadsession_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: layers_uploadsession_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE layers_uploadsession_id_seq OWNED BY layers_uploadsession.id;


--
-- Name: maps_map; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE maps_map (
    resourcebase_ptr_id integer NOT NULL,
    title_en character varying(255),
    abstract_en text,
    purpose_en text,
    constraints_other_en text,
    supplemental_information_en text,
    data_quality_statement_en text,
    zoom integer NOT NULL,
    projection character varying(32) NOT NULL,
    center_x double precision NOT NULL,
    center_y double precision NOT NULL,
    last_modified timestamp with time zone NOT NULL,
    urlsuffix character varying(255) NOT NULL,
    featuredurl character varying(255) NOT NULL
);


--
-- Name: maps_maplayer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE maps_maplayer (
    id integer NOT NULL,
    stack_order integer NOT NULL,
    format character varying(200),
    name character varying(200),
    opacity double precision NOT NULL,
    styles character varying(200),
    transparent boolean NOT NULL,
    fixed boolean NOT NULL,
    "group" character varying(200),
    visibility boolean NOT NULL,
    ows_url character varying(200),
    layer_params text NOT NULL,
    source_params text NOT NULL,
    local boolean NOT NULL,
    map_id integer NOT NULL
);


--
-- Name: maps_maplayer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE maps_maplayer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: maps_maplayer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE maps_maplayer_id_seq OWNED BY maps_maplayer.id;


--
-- Name: maps_mapsnapshot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE maps_mapsnapshot (
    id integer NOT NULL,
    config text NOT NULL,
    created_dttm timestamp with time zone NOT NULL,
    map_id integer NOT NULL,
    user_id integer
);


--
-- Name: maps_mapsnapshot_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE maps_mapsnapshot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: maps_mapsnapshot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE maps_mapsnapshot_id_seq OWNED BY maps_mapsnapshot.id;


--
-- Name: oauth2_provider_accesstoken; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE oauth2_provider_accesstoken (
    id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires timestamp with time zone NOT NULL,
    scope text NOT NULL,
    application_id integer NOT NULL,
    user_id integer
);


--
-- Name: oauth2_provider_accesstoken_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth2_provider_accesstoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth2_provider_accesstoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth2_provider_accesstoken_id_seq OWNED BY oauth2_provider_accesstoken.id;


--
-- Name: oauth2_provider_application; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE oauth2_provider_application (
    id integer NOT NULL,
    client_id character varying(100) NOT NULL,
    redirect_uris text NOT NULL,
    client_type character varying(32) NOT NULL,
    authorization_grant_type character varying(32) NOT NULL,
    client_secret character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    user_id integer,
    skip_authorization boolean NOT NULL
);


--
-- Name: oauth2_provider_application_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth2_provider_application_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth2_provider_application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth2_provider_application_id_seq OWNED BY oauth2_provider_application.id;


--
-- Name: oauth2_provider_grant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE oauth2_provider_grant (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    expires timestamp with time zone NOT NULL,
    redirect_uri character varying(255) NOT NULL,
    scope text NOT NULL,
    application_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: oauth2_provider_grant_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth2_provider_grant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth2_provider_grant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth2_provider_grant_id_seq OWNED BY oauth2_provider_grant.id;


--
-- Name: oauth2_provider_refreshtoken; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE oauth2_provider_refreshtoken (
    id integer NOT NULL,
    token character varying(255) NOT NULL,
    access_token_id integer NOT NULL,
    application_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: oauth2_provider_refreshtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth2_provider_refreshtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth2_provider_refreshtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth2_provider_refreshtoken_id_seq OWNED BY oauth2_provider_refreshtoken.id;


--
-- Name: people_profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE people_profile (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    organization character varying(255),
    profile text,
    "position" character varying(255),
    voice character varying(255),
    fax character varying(255),
    delivery character varying(255),
    city character varying(255),
    area character varying(255),
    zipcode character varying(255),
    country character varying(3)
);


--
-- Name: people_profile_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE people_profile_groups (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: people_profile_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_profile_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_profile_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE people_profile_groups_id_seq OWNED BY people_profile_groups.id;


--
-- Name: people_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE people_profile_id_seq OWNED BY people_profile.id;


--
-- Name: people_profile_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE people_profile_user_permissions (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: people_profile_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_profile_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_profile_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE people_profile_user_permissions_id_seq OWNED BY people_profile_user_permissions.id;


--
-- Name: services_service; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE services_service (
    resourcebase_ptr_id integer NOT NULL,
    type character varying(4) NOT NULL,
    method character varying(1) NOT NULL,
    base_url character varying(200) NOT NULL,
    version character varying(10),
    name character varying(255) NOT NULL,
    description character varying(255),
    online_resource character varying(200),
    fees character varying(1000),
    access_constraints character varying(255),
    connection_params text,
    username character varying(50),
    password character varying(50),
    api_key character varying(255),
    workspace_ref character varying(200),
    store_ref character varying(200),
    resources_ref character varying(200),
    created timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    first_noanswer timestamp with time zone,
    noanswer_retries integer,
    external_id integer,
    parent_id integer,
    CONSTRAINT services_service_noanswer_retries_check CHECK ((noanswer_retries >= 0))
);


--
-- Name: services_servicelayer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE services_servicelayer (
    id integer NOT NULL,
    typename character varying(255) NOT NULL,
    title character varying(512) NOT NULL,
    description text,
    styles text,
    layer_id integer,
    service_id integer NOT NULL
);


--
-- Name: services_servicelayer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE services_servicelayer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_servicelayer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE services_servicelayer_id_seq OWNED BY services_servicelayer.id;


--
-- Name: services_serviceprofilerole; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE services_serviceprofilerole (
    id integer NOT NULL,
    role character varying(255) NOT NULL,
    profiles_id integer NOT NULL,
    service_id integer NOT NULL
);


--
-- Name: services_serviceprofilerole_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE services_serviceprofilerole_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_serviceprofilerole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE services_serviceprofilerole_id_seq OWNED BY services_serviceprofilerole.id;


--
-- Name: services_webserviceharvestlayersjob; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE services_webserviceharvestlayersjob (
    id integer NOT NULL,
    status character varying(10) NOT NULL,
    service_id integer NOT NULL
);


--
-- Name: services_webserviceharvestlayersjob_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE services_webserviceharvestlayersjob_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_webserviceharvestlayersjob_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE services_webserviceharvestlayersjob_id_seq OWNED BY services_webserviceharvestlayersjob.id;


--
-- Name: services_webserviceregistrationjob; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE services_webserviceregistrationjob (
    id integer NOT NULL,
    base_url character varying(200) NOT NULL,
    type character varying(4) NOT NULL,
    status character varying(10) NOT NULL
);


--
-- Name: services_webserviceregistrationjob_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE services_webserviceregistrationjob_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_webserviceregistrationjob_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE services_webserviceregistrationjob_id_seq OWNED BY services_webserviceregistrationjob.id;


--
-- Name: taggit_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE taggit_tag (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL
);


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggit_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggit_tag_id_seq OWNED BY taggit_tag.id;


--
-- Name: taggit_taggeditem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE taggit_taggeditem (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggit_taggeditem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggit_taggeditem_id_seq OWNED BY taggit_taggeditem.id;


--
-- Name: tastypie_apiaccess; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tastypie_apiaccess (
    id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    request_method character varying(10) NOT NULL,
    accessed integer NOT NULL,
    CONSTRAINT tastypie_apiaccess_accessed_check CHECK ((accessed >= 0))
);


--
-- Name: tastypie_apiaccess_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tastypie_apiaccess_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tastypie_apiaccess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tastypie_apiaccess_id_seq OWNED BY tastypie_apiaccess.id;


--
-- Name: tastypie_apikey; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tastypie_apikey (
    id integer NOT NULL,
    key character varying(128) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: tastypie_apikey_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tastypie_apikey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tastypie_apikey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tastypie_apikey_id_seq OWNED BY tastypie_apikey.id;


--
-- Name: upload_upload; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE upload_upload (
    id integer NOT NULL,
    import_id bigint,
    state character varying(16) NOT NULL,
    date timestamp with time zone NOT NULL,
    upload_dir character varying(100),
    name character varying(64),
    complete boolean NOT NULL,
    session text,
    metadata text,
    mosaic_time_regex character varying(128),
    mosaic_time_value character varying(128),
    mosaic_elev_regex character varying(128),
    mosaic_elev_value character varying(128),
    layer_id integer,
    user_id integer
);


--
-- Name: upload_upload_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE upload_upload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: upload_upload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE upload_upload_id_seq OWNED BY upload_upload.id;


--
-- Name: upload_uploadfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE upload_uploadfile (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    slug character varying(50) NOT NULL,
    upload_id integer
);


--
-- Name: upload_uploadfile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE upload_uploadfile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: upload_uploadfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE upload_uploadfile_id_seq OWNED BY upload_uploadfile.id;


--
-- Name: user_messages_message; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_messages_message (
    id integer NOT NULL,
    sent_at timestamp with time zone NOT NULL,
    content text NOT NULL,
    sender_id integer NOT NULL,
    thread_id integer NOT NULL
);


--
-- Name: user_messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_messages_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_messages_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_messages_message_id_seq OWNED BY user_messages_message.id;


--
-- Name: user_messages_thread; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_messages_thread (
    id integer NOT NULL,
    subject character varying(150) NOT NULL
);


--
-- Name: user_messages_thread_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_messages_thread_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_messages_thread_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_messages_thread_id_seq OWNED BY user_messages_thread.id;


--
-- Name: user_messages_userthread; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_messages_userthread (
    id integer NOT NULL,
    unread boolean NOT NULL,
    deleted boolean NOT NULL,
    thread_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: user_messages_userthread_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_messages_userthread_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_messages_userthread_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_messages_userthread_id_seq OWNED BY user_messages_userthread.id;


--
-- Name: wm_extra_endpoint; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE wm_extra_endpoint (
    id integer NOT NULL,
    description text NOT NULL,
    url character varying(200) NOT NULL,
    owner_id integer
);


--
-- Name: wm_extra_endpoint_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wm_extra_endpoint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wm_extra_endpoint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wm_extra_endpoint_id_seq OWNED BY wm_extra_endpoint.id;


--
-- Name: wm_extra_layerstats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE wm_extra_layerstats (
    id integer NOT NULL,
    visits integer NOT NULL,
    uniques integer NOT NULL,
    downloads integer NOT NULL,
    last_modified timestamp with time zone,
    layer_id integer NOT NULL
);


--
-- Name: wm_extra_layerstats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wm_extra_layerstats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wm_extra_layerstats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wm_extra_layerstats_id_seq OWNED BY wm_extra_layerstats.id;


--
-- Name: wm_extra_mapstats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE wm_extra_mapstats (
    id integer NOT NULL,
    visits integer NOT NULL,
    uniques integer NOT NULL,
    last_modified timestamp with time zone,
    map_id integer NOT NULL
);


--
-- Name: wm_extra_mapstats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wm_extra_mapstats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wm_extra_mapstats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wm_extra_mapstats_id_seq OWNED BY wm_extra_mapstats.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_account ALTER COLUMN id SET DEFAULT nextval('account_account_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_accountdeletion ALTER COLUMN id SET DEFAULT nextval('account_accountdeletion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_emailaddress ALTER COLUMN id SET DEFAULT nextval('account_emailaddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('account_emailconfirmation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcode ALTER COLUMN id SET DEFAULT nextval('account_signupcode_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcoderesult ALTER COLUMN id SET DEFAULT nextval('account_signupcoderesult_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_action ALTER COLUMN id SET DEFAULT nextval('actstream_action_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_follow ALTER COLUMN id SET DEFAULT nextval('actstream_follow_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_overallrating ALTER COLUMN id SET DEFAULT nextval('agon_ratings_overallrating_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_rating ALTER COLUMN id SET DEFAULT nextval('agon_ratings_rating_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY announcements_announcement ALTER COLUMN id SET DEFAULT nextval('announcements_announcement_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY announcements_dismissal ALTER COLUMN id SET DEFAULT nextval('announcements_dismissal_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY avatar_avatar ALTER COLUMN id SET DEFAULT nextval('avatar_avatar_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_backup ALTER COLUMN id SET DEFAULT nextval('base_backup_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_contactrole ALTER COLUMN id SET DEFAULT nextval('base_contactrole_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_hierarchicalkeyword ALTER COLUMN id SET DEFAULT nextval('base_hierarchicalkeyword_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_license ALTER COLUMN id SET DEFAULT nextval('base_license_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_link ALTER COLUMN id SET DEFAULT nextval('base_link_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_region ALTER COLUMN id SET DEFAULT nextval('base_region_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase ALTER COLUMN id SET DEFAULT nextval('base_resourcebase_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_regions ALTER COLUMN id SET DEFAULT nextval('base_resourcebase_regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_tkeywords ALTER COLUMN id SET DEFAULT nextval('base_resourcebase_tkeywords_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_restrictioncodetype ALTER COLUMN id SET DEFAULT nextval('base_restrictioncodetype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_spatialrepresentationtype ALTER COLUMN id SET DEFAULT nextval('base_spatialrepresentationtype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_taggedcontentitem ALTER COLUMN id SET DEFAULT nextval('base_taggedcontentitem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesaurus ALTER COLUMN id SET DEFAULT nextval('base_thesaurus_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesauruskeyword ALTER COLUMN id SET DEFAULT nextval('base_thesauruskeyword_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesauruskeywordlabel ALTER COLUMN id SET DEFAULT nextval('base_thesauruskeywordlabel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_topiccategory ALTER COLUMN id SET DEFAULT nextval('base_topiccategory_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY celery_taskmeta ALTER COLUMN id SET DEFAULT nextval('celery_taskmeta_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY celery_tasksetmeta ALTER COLUMN id SET DEFAULT nextval('celery_tasksetmeta_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dialogos_comment ALTER COLUMN id SET DEFAULT nextval('dialogos_comment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_crontabschedule ALTER COLUMN id SET DEFAULT nextval('djcelery_crontabschedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_intervalschedule ALTER COLUMN id SET DEFAULT nextval('djcelery_intervalschedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_periodictask ALTER COLUMN id SET DEFAULT nextval('djcelery_periodictask_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_taskstate ALTER COLUMN id SET DEFAULT nextval('djcelery_taskstate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_workerstate ALTER COLUMN id SET DEFAULT nextval('djcelery_workerstate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gazetteer_gazetteerentry ALTER COLUMN id SET DEFAULT nextval('gazetteer_gazetteerentry_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupinvitation ALTER COLUMN id SET DEFAULT nextval('groups_groupinvitation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupmember ALTER COLUMN id SET DEFAULT nextval('groups_groupmember_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupprofile ALTER COLUMN id SET DEFAULT nextval('groups_groupprofile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_groupobjectpermission ALTER COLUMN id SET DEFAULT nextval('guardian_groupobjectpermission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_userobjectpermission ALTER COLUMN id SET DEFAULT nextval('guardian_userobjectpermission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_attribute ALTER COLUMN id SET DEFAULT nextval('layers_attribute_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layer_styles ALTER COLUMN id SET DEFAULT nextval('layers_layer_styles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layerfile ALTER COLUMN id SET DEFAULT nextval('layers_layerfile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_style ALTER COLUMN id SET DEFAULT nextval('layers_style_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_uploadsession ALTER COLUMN id SET DEFAULT nextval('layers_uploadsession_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_maplayer ALTER COLUMN id SET DEFAULT nextval('maps_maplayer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_mapsnapshot ALTER COLUMN id SET DEFAULT nextval('maps_mapsnapshot_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_accesstoken ALTER COLUMN id SET DEFAULT nextval('oauth2_provider_accesstoken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_application ALTER COLUMN id SET DEFAULT nextval('oauth2_provider_application_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_grant ALTER COLUMN id SET DEFAULT nextval('oauth2_provider_grant_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_refreshtoken ALTER COLUMN id SET DEFAULT nextval('oauth2_provider_refreshtoken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile ALTER COLUMN id SET DEFAULT nextval('people_profile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_groups ALTER COLUMN id SET DEFAULT nextval('people_profile_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_user_permissions ALTER COLUMN id SET DEFAULT nextval('people_profile_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_servicelayer ALTER COLUMN id SET DEFAULT nextval('services_servicelayer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_serviceprofilerole ALTER COLUMN id SET DEFAULT nextval('services_serviceprofilerole_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_webserviceharvestlayersjob ALTER COLUMN id SET DEFAULT nextval('services_webserviceharvestlayersjob_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_webserviceregistrationjob ALTER COLUMN id SET DEFAULT nextval('services_webserviceregistrationjob_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggit_tag ALTER COLUMN id SET DEFAULT nextval('taggit_tag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggit_taggeditem ALTER COLUMN id SET DEFAULT nextval('taggit_taggeditem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tastypie_apiaccess ALTER COLUMN id SET DEFAULT nextval('tastypie_apiaccess_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tastypie_apikey ALTER COLUMN id SET DEFAULT nextval('tastypie_apikey_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY upload_upload ALTER COLUMN id SET DEFAULT nextval('upload_upload_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY upload_uploadfile ALTER COLUMN id SET DEFAULT nextval('upload_uploadfile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_message ALTER COLUMN id SET DEFAULT nextval('user_messages_message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_thread ALTER COLUMN id SET DEFAULT nextval('user_messages_thread_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_userthread ALTER COLUMN id SET DEFAULT nextval('user_messages_userthread_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_endpoint ALTER COLUMN id SET DEFAULT nextval('wm_extra_endpoint_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_layerstats ALTER COLUMN id SET DEFAULT nextval('wm_extra_layerstats_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_mapstats ALTER COLUMN id SET DEFAULT nextval('wm_extra_mapstats_id_seq'::regclass);


--
-- Data for Name: account_account; Type: TABLE DATA; Schema: public; Owner: -
--

COPY account_account (id, timezone, language, user_id) FROM stdin;
1		en-us	-1
\.


--
-- Name: account_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('account_account_id_seq', 1, true);


--
-- Data for Name: account_accountdeletion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY account_accountdeletion (id, email, date_requested, date_expunged, user_id) FROM stdin;
\.


--
-- Name: account_accountdeletion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('account_accountdeletion_id_seq', 1, false);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: -
--

COPY account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('account_emailaddress_id_seq', 1, false);


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('account_emailconfirmation_id_seq', 1, false);


--
-- Data for Name: account_signupcode; Type: TABLE DATA; Schema: public; Owner: -
--

COPY account_signupcode (id, code, max_uses, expiry, email, notes, sent, created, use_count, inviter_id) FROM stdin;
\.


--
-- Name: account_signupcode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('account_signupcode_id_seq', 1, false);


--
-- Data for Name: account_signupcodeextended; Type: TABLE DATA; Schema: public; Owner: -
--

COPY account_signupcodeextended (signupcode_id, username) FROM stdin;
\.


--
-- Data for Name: account_signupcoderesult; Type: TABLE DATA; Schema: public; Owner: -
--

COPY account_signupcoderesult (id, "timestamp", signup_code_id, user_id) FROM stdin;
\.


--
-- Name: account_signupcoderesult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('account_signupcoderesult_id_seq', 1, false);


--
-- Data for Name: actstream_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY actstream_action (id, actor_object_id, verb, description, target_object_id, action_object_object_id, "timestamp", public, data, action_object_content_type_id, actor_content_type_id, target_content_type_id) FROM stdin;
\.


--
-- Name: actstream_action_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('actstream_action_id_seq', 1, false);


--
-- Data for Name: actstream_follow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY actstream_follow (id, object_id, actor_only, started, content_type_id, user_id) FROM stdin;
\.


--
-- Name: actstream_follow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('actstream_follow_id_seq', 1, false);


--
-- Data for Name: agon_ratings_overallrating; Type: TABLE DATA; Schema: public; Owner: -
--

COPY agon_ratings_overallrating (id, object_id, rating, category, content_type_id) FROM stdin;
\.


--
-- Name: agon_ratings_overallrating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('agon_ratings_overallrating_id_seq', 1, false);


--
-- Data for Name: agon_ratings_rating; Type: TABLE DATA; Schema: public; Owner: -
--

COPY agon_ratings_rating (id, object_id, rating, "timestamp", category, content_type_id, overall_rating_id, user_id) FROM stdin;
\.


--
-- Name: agon_ratings_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('agon_ratings_rating_id_seq', 1, false);


--
-- Data for Name: announcements_announcement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY announcements_announcement (id, title, level, content, creation_date, site_wide, members_only, dismissal_type, publish_start, publish_end, creator_id) FROM stdin;
\.


--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('announcements_announcement_id_seq', 1, false);


--
-- Data for Name: announcements_dismissal; Type: TABLE DATA; Schema: public; Owner: -
--

COPY announcements_dismissal (id, dismissed_at, announcement_id, user_id) FROM stdin;
\.


--
-- Name: announcements_dismissal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('announcements_dismissal_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY auth_group (id, name) FROM stdin;
1	anonymous
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, true);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add content type	3	add_contenttype
8	Can change content type	3	change_contenttype
9	Can delete content type	3	delete_contenttype
10	Can add session	4	add_session
11	Can change session	4	change_session
12	Can delete session	4	delete_session
13	Can add site	5	add_site
14	Can change site	5	change_site
15	Can delete site	5	delete_site
16	Can add log entry	6	add_logentry
17	Can change log entry	6	change_logentry
18	Can delete log entry	6	delete_logentry
19	Can add Tag	7	add_tag
20	Can change Tag	7	change_tag
21	Can delete Tag	7	delete_tag
22	Can add Tagged Item	8	add_taggeditem
23	Can change Tagged Item	8	change_taggeditem
24	Can delete Tagged Item	8	delete_taggeditem
25	Can add task state	9	add_taskmeta
26	Can change task state	9	change_taskmeta
27	Can delete task state	9	delete_taskmeta
28	Can add saved group result	10	add_tasksetmeta
29	Can change saved group result	10	change_tasksetmeta
30	Can delete saved group result	10	delete_tasksetmeta
31	Can add interval	11	add_intervalschedule
32	Can change interval	11	change_intervalschedule
33	Can delete interval	11	delete_intervalschedule
34	Can add crontab	12	add_crontabschedule
35	Can change crontab	12	change_crontabschedule
36	Can delete crontab	12	delete_crontabschedule
37	Can add periodic tasks	13	add_periodictasks
38	Can change periodic tasks	13	change_periodictasks
39	Can delete periodic tasks	13	delete_periodictasks
40	Can add periodic task	14	add_periodictask
41	Can change periodic task	14	change_periodictask
42	Can delete periodic task	14	delete_periodictask
43	Can add worker	15	add_workerstate
44	Can change worker	15	change_workerstate
45	Can delete worker	15	delete_workerstate
46	Can add task	16	add_taskstate
47	Can change task	16	change_taskstate
48	Can delete task	16	delete_taskstate
49	Can add account	17	add_account
50	Can change account	17	change_account
51	Can delete account	17	delete_account
52	Can add signup code	18	add_signupcode
53	Can change signup code	18	change_signupcode
54	Can delete signup code	18	delete_signupcode
55	Can add signup code extended	19	add_signupcodeextended
56	Can change signup code extended	19	change_signupcodeextended
57	Can delete signup code extended	19	delete_signupcodeextended
58	Can add signup code result	20	add_signupcoderesult
59	Can change signup code result	20	change_signupcoderesult
60	Can delete signup code result	20	delete_signupcoderesult
61	Can add email address	21	add_emailaddress
62	Can change email address	21	change_emailaddress
63	Can delete email address	21	delete_emailaddress
64	Can add email confirmation	22	add_emailconfirmation
65	Can change email confirmation	22	change_emailconfirmation
66	Can delete email confirmation	22	delete_emailconfirmation
67	Can add account deletion	23	add_accountdeletion
68	Can change account deletion	23	change_accountdeletion
69	Can delete account deletion	23	delete_accountdeletion
70	Can add avatar	24	add_avatar
71	Can change avatar	24	change_avatar
72	Can delete avatar	24	delete_avatar
73	Can add comment	25	add_comment
74	Can change comment	25	change_comment
75	Can delete comment	25	delete_comment
76	Can add overall rating	26	add_overallrating
77	Can change overall rating	26	change_overallrating
78	Can delete overall rating	26	delete_overallrating
79	Can add rating	27	add_rating
80	Can change rating	27	change_rating
81	Can delete rating	27	delete_rating
82	Can add announcement	28	add_announcement
83	Can change announcement	28	change_announcement
84	Can delete announcement	28	delete_announcement
85	Can add dismissal	29	add_dismissal
86	Can change dismissal	29	change_dismissal
87	Can delete dismissal	29	delete_dismissal
88	Can add follow	30	add_follow
89	Can change follow	30	change_follow
90	Can delete follow	30	delete_follow
91	Can add action	31	add_action
92	Can change action	31	change_action
93	Can delete action	31	delete_action
94	Can add thread	32	add_thread
95	Can change thread	32	change_thread
96	Can delete thread	32	delete_thread
97	Can add user thread	33	add_userthread
98	Can change user thread	33	change_userthread
99	Can delete user thread	33	delete_userthread
100	Can add message	34	add_message
101	Can change message	34	change_message
102	Can delete message	34	delete_message
103	Can add api access	35	add_apiaccess
104	Can change api access	35	change_apiaccess
105	Can delete api access	35	delete_apiaccess
106	Can add api key	36	add_apikey
107	Can change api key	36	change_apikey
108	Can delete api key	36	delete_apikey
109	Can add user object permission	37	add_userobjectpermission
110	Can change user object permission	37	change_userobjectpermission
111	Can delete user object permission	37	delete_userobjectpermission
112	Can add group object permission	38	add_groupobjectpermission
113	Can change group object permission	38	change_groupobjectpermission
114	Can delete group object permission	38	delete_groupobjectpermission
115	Can add application	39	add_application
116	Can change application	39	change_application
117	Can delete application	39	delete_application
118	Can add grant	40	add_grant
119	Can change grant	40	change_grant
120	Can delete grant	40	delete_grant
121	Can add access token	41	add_accesstoken
122	Can change access token	41	change_accesstoken
123	Can delete access token	41	delete_accesstoken
124	Can add refresh token	42	add_refreshtoken
125	Can change refresh token	42	change_refreshtoken
126	Can delete refresh token	42	delete_refreshtoken
127	Can add user	43	add_profile
128	Can change user	43	change_profile
129	Can delete user	43	delete_profile
130	Can add contact role	44	add_contactrole
131	Can change contact role	44	change_contactrole
132	Can delete contact role	44	delete_contactrole
133	Can add topic category	45	add_topiccategory
134	Can change topic category	45	change_topiccategory
135	Can delete topic category	45	delete_topiccategory
136	Can add spatial representation type	46	add_spatialrepresentationtype
137	Can change spatial representation type	46	change_spatialrepresentationtype
138	Can delete spatial representation type	46	delete_spatialrepresentationtype
139	Can add region	47	add_region
140	Can change region	47	change_region
141	Can delete region	47	delete_region
142	Can add restriction code type	48	add_restrictioncodetype
143	Can change restriction code type	48	change_restrictioncodetype
144	Can delete restriction code type	48	delete_restrictioncodetype
145	Can add backup	49	add_backup
146	Can change backup	49	change_backup
147	Can delete backup	49	delete_backup
148	Can add license	50	add_license
149	Can change license	50	change_license
150	Can delete license	50	delete_license
151	Can add hierarchical keyword	51	add_hierarchicalkeyword
152	Can change hierarchical keyword	51	change_hierarchicalkeyword
153	Can delete hierarchical keyword	51	delete_hierarchicalkeyword
154	Can add tagged content item	52	add_taggedcontentitem
155	Can change tagged content item	52	change_taggedcontentitem
156	Can delete tagged content item	52	delete_taggedcontentitem
157	Can add thesaurus	53	add_thesaurus
158	Can change thesaurus	53	change_thesaurus
159	Can delete thesaurus	53	delete_thesaurus
160	Can add thesaurus keyword	54	add_thesauruskeyword
161	Can change thesaurus keyword	54	change_thesauruskeyword
162	Can delete thesaurus keyword	54	delete_thesauruskeyword
163	Can add thesaurus keyword label	55	add_thesauruskeywordlabel
164	Can change thesaurus keyword label	55	change_thesauruskeywordlabel
165	Can delete thesaurus keyword label	55	delete_thesauruskeywordlabel
166	Can add resource base	56	add_resourcebase
167	Can change resource base	56	change_resourcebase
168	Can delete resource base	56	delete_resourcebase
169	Can view resource	56	view_resourcebase
170	Can change resource permissions	56	change_resourcebase_permissions
171	Can download resource	56	download_resourcebase
172	Can publish resource	56	publish_resourcebase
173	Can change resource metadata	56	change_resourcebase_metadata
174	Can add link	57	add_link
175	Can change link	57	change_link
176	Can delete link	57	delete_link
177	Can add style	58	add_style
178	Can change style	58	change_style
179	Can delete style	58	delete_style
180	Can add layer	59	add_layer
181	Can change layer	59	change_layer
182	Can delete layer	59	delete_layer
183	Can edit layer data	59	change_layer_data
184	Can change layer style	59	change_layer_style
185	Can add upload session	60	add_uploadsession
186	Can change upload session	60	change_uploadsession
187	Can delete upload session	60	delete_uploadsession
188	Can add layer file	61	add_layerfile
189	Can change layer file	61	change_layerfile
190	Can delete layer file	61	delete_layerfile
191	Can add attribute	62	add_attribute
192	Can change attribute	62	change_attribute
193	Can delete attribute	62	delete_attribute
194	Can add map	63	add_map
195	Can change map	63	change_map
196	Can delete map	63	delete_map
197	Can add map layer	64	add_maplayer
198	Can change map layer	64	change_maplayer
199	Can delete map layer	64	delete_maplayer
200	Can add map snapshot	65	add_mapsnapshot
201	Can change map snapshot	65	change_mapsnapshot
202	Can delete map snapshot	65	delete_mapsnapshot
203	Can add document	66	add_document
204	Can change document	66	change_document
205	Can delete document	66	delete_document
206	Can add group profile	67	add_groupprofile
207	Can change group profile	67	change_groupprofile
208	Can delete group profile	67	delete_groupprofile
209	Can add group member	68	add_groupmember
210	Can change group member	68	change_groupmember
211	Can delete group member	68	delete_groupmember
212	Can add group invitation	69	add_groupinvitation
213	Can change group invitation	69	change_groupinvitation
214	Can delete group invitation	69	delete_groupinvitation
215	Can add service	70	add_service
216	Can change service	70	change_service
217	Can delete service	70	delete_service
218	Can add service profile role	71	add_serviceprofilerole
219	Can change service profile role	71	change_serviceprofilerole
220	Can delete service profile role	71	delete_serviceprofilerole
221	Can add service layer	72	add_servicelayer
222	Can change service layer	72	change_servicelayer
223	Can delete service layer	72	delete_servicelayer
224	Can add web service harvest layers job	73	add_webserviceharvestlayersjob
225	Can change web service harvest layers job	73	change_webserviceharvestlayersjob
226	Can delete web service harvest layers job	73	delete_webserviceharvestlayersjob
227	Can add web service registration job	74	add_webserviceregistrationjob
228	Can change web service registration job	74	change_webserviceregistrationjob
229	Can delete web service registration job	74	delete_webserviceregistrationjob
230	Can add upload	75	add_upload
231	Can change upload	75	change_upload
232	Can delete upload	75	delete_upload
233	Can add upload file	76	add_uploadfile
234	Can change upload file	76	change_uploadfile
235	Can delete upload file	76	delete_uploadfile
236	Can add map stats	77	add_mapstats
237	Can change map stats	77	change_mapstats
238	Can delete map stats	77	delete_mapstats
239	Can add layer stats	78	add_layerstats
240	Can change layer stats	78	change_layerstats
241	Can delete layer stats	78	delete_layerstats
242	Can add endpoint	79	add_endpoint
243	Can change endpoint	79	change_endpoint
244	Can delete endpoint	79	delete_endpoint
245	Can add gazetteer entry	80	add_gazetteerentry
246	Can change gazetteer entry	80	change_gazetteerentry
247	Can delete gazetteer entry	80	delete_gazetteerentry
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('auth_permission_id_seq', 247, true);


--
-- Data for Name: avatar_avatar; Type: TABLE DATA; Schema: public; Owner: -
--

COPY avatar_avatar (id, "primary", avatar, date_uploaded, user_id) FROM stdin;
\.


--
-- Name: avatar_avatar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('avatar_avatar_id_seq', 1, false);


--
-- Data for Name: base_backup; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_backup (id, identifier, name, name_en, date, description, description_en, base_folder, location) FROM stdin;
\.


--
-- Name: base_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_backup_id_seq', 1, false);


--
-- Data for Name: base_contactrole; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_contactrole (id, role, contact_id, resource_id) FROM stdin;
\.


--
-- Name: base_contactrole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_contactrole_id_seq', 1, false);


--
-- Data for Name: base_hierarchicalkeyword; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_hierarchicalkeyword (id, name, slug, path, depth, numchild) FROM stdin;
\.


--
-- Name: base_hierarchicalkeyword_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_hierarchicalkeyword_id_seq', 1, false);


--
-- Data for Name: base_license; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_license (id, identifier, name, name_en, abbreviation, description, description_en, url, license_text, license_text_en) FROM stdin;
\.


--
-- Name: base_license_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_license_id_seq', 1, false);


--
-- Data for Name: base_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_link (id, extension, link_type, name, mime, url, resource_id) FROM stdin;
\.


--
-- Name: base_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_link_id_seq', 1, false);


--
-- Data for Name: base_region; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_region (id, code, name, name_en, lft, rght, tree_id, level, parent_id) FROM stdin;
\.


--
-- Name: base_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_region_id_seq', 1, false);


--
-- Data for Name: base_resourcebase; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_resourcebase (id, uuid, title, date, date_type, edition, abstract, purpose, maintenance_frequency, constraints_other, language, temporal_extent_start, temporal_extent_end, supplemental_information, data_quality_statement, bbox_x0, bbox_x1, bbox_y0, bbox_y1, srid, csw_typename, csw_schema, csw_mdsource, csw_insert_date, csw_type, csw_anytext, csw_wkt_geometry, metadata_uploaded, metadata_xml, popular_count, share_count, featured, is_published, thumbnail_url, detail_url, rating, category_id, license_id, owner_id, polymorphic_ctype_id, restriction_code_type_id, spatial_representation_type_id, metadata_uploaded_preserve) FROM stdin;
\.


--
-- Name: base_resourcebase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_resourcebase_id_seq', 1, false);


--
-- Data for Name: base_resourcebase_regions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_resourcebase_regions (id, resourcebase_id, region_id) FROM stdin;
\.


--
-- Name: base_resourcebase_regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_resourcebase_regions_id_seq', 1, false);


--
-- Data for Name: base_resourcebase_tkeywords; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_resourcebase_tkeywords (id, resourcebase_id, thesauruskeyword_id) FROM stdin;
\.


--
-- Name: base_resourcebase_tkeywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_resourcebase_tkeywords_id_seq', 1, false);


--
-- Data for Name: base_restrictioncodetype; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_restrictioncodetype (id, identifier, description, description_en, gn_description, gn_description_en, is_choice) FROM stdin;
\.


--
-- Name: base_restrictioncodetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_restrictioncodetype_id_seq', 1, false);


--
-- Data for Name: base_spatialrepresentationtype; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_spatialrepresentationtype (id, identifier, description, description_en, gn_description, gn_description_en, is_choice) FROM stdin;
\.


--
-- Name: base_spatialrepresentationtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_spatialrepresentationtype_id_seq', 1, false);


--
-- Data for Name: base_taggedcontentitem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_taggedcontentitem (id, content_object_id, tag_id) FROM stdin;
\.


--
-- Name: base_taggedcontentitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_taggedcontentitem_id_seq', 1, false);


--
-- Data for Name: base_thesaurus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_thesaurus (id, identifier, title, date, description, slug) FROM stdin;
\.


--
-- Name: base_thesaurus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_thesaurus_id_seq', 1, false);


--
-- Data for Name: base_thesauruskeyword; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_thesauruskeyword (id, about, alt_label, thesaurus_id) FROM stdin;
\.


--
-- Name: base_thesauruskeyword_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_thesauruskeyword_id_seq', 1, false);


--
-- Data for Name: base_thesauruskeywordlabel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_thesauruskeywordlabel (id, lang, label, keyword_id) FROM stdin;
\.


--
-- Name: base_thesauruskeywordlabel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_thesauruskeywordlabel_id_seq', 1, false);


--
-- Data for Name: base_topiccategory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY base_topiccategory (id, identifier, description, description_en, gn_description, gn_description_en, is_choice, fa_class) FROM stdin;
\.


--
-- Name: base_topiccategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('base_topiccategory_id_seq', 1, false);


--
-- Data for Name: celery_taskmeta; Type: TABLE DATA; Schema: public; Owner: -
--

COPY celery_taskmeta (id, task_id, status, result, date_done, traceback, hidden, meta) FROM stdin;
\.


--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('celery_taskmeta_id_seq', 1, false);


--
-- Data for Name: celery_tasksetmeta; Type: TABLE DATA; Schema: public; Owner: -
--

COPY celery_tasksetmeta (id, taskset_id, result, date_done, hidden) FROM stdin;
\.


--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('celery_tasksetmeta_id_seq', 1, false);


--
-- Data for Name: dialogos_comment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dialogos_comment (id, name, email, website, object_id, comment, submit_date, ip_address, public, author_id, content_type_id) FROM stdin;
\.


--
-- Name: dialogos_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dialogos_comment_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	contenttypes	contenttype
4	sessions	session
5	sites	site
6	admin	logentry
7	taggit	tag
8	taggit	taggeditem
9	djcelery	taskmeta
10	djcelery	tasksetmeta
11	djcelery	intervalschedule
12	djcelery	crontabschedule
13	djcelery	periodictasks
14	djcelery	periodictask
15	djcelery	workerstate
16	djcelery	taskstate
17	account	account
18	account	signupcode
19	account	signupcodeextended
20	account	signupcoderesult
21	account	emailaddress
22	account	emailconfirmation
23	account	accountdeletion
24	avatar	avatar
25	dialogos	comment
26	agon_ratings	overallrating
27	agon_ratings	rating
28	announcements	announcement
29	announcements	dismissal
30	actstream	follow
31	actstream	action
32	user_messages	thread
33	user_messages	userthread
34	user_messages	message
35	tastypie	apiaccess
36	tastypie	apikey
37	guardian	userobjectpermission
38	guardian	groupobjectpermission
39	oauth2_provider	application
40	oauth2_provider	grant
41	oauth2_provider	accesstoken
42	oauth2_provider	refreshtoken
43	people	profile
44	base	contactrole
45	base	topiccategory
46	base	spatialrepresentationtype
47	base	region
48	base	restrictioncodetype
49	base	backup
50	base	license
51	base	hierarchicalkeyword
52	base	taggedcontentitem
53	base	thesaurus
54	base	thesauruskeyword
55	base	thesauruskeywordlabel
56	base	resourcebase
57	base	link
58	layers	style
59	layers	layer
60	layers	uploadsession
61	layers	layerfile
62	layers	attribute
63	maps	map
64	maps	maplayer
65	maps	mapsnapshot
66	documents	document
67	groups	groupprofile
68	groups	groupmember
69	groups	groupinvitation
70	services	service
71	services	serviceprofilerole
72	services	servicelayer
73	services	webserviceharvestlayersjob
74	services	webserviceregistrationjob
75	upload	upload
76	upload	uploadfile
77	wm_extra	mapstats
78	wm_extra	layerstats
79	wm_extra	endpoint
80	gazetteer	gazetteerentry
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('django_content_type_id_seq', 80, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	sites	0001_initial	2017-08-08 16:15:53.948401+00
2	contenttypes	0001_initial	2017-08-08 16:15:53.968331+00
3	taggit	0001_initial	2017-08-08 16:15:54.028975+00
4	taggit	0002_auto_20150616_2121	2017-08-08 16:15:54.041759+00
5	contenttypes	0002_remove_content_type_name	2017-08-08 16:15:54.070396+00
6	auth	0001_initial	2017-08-08 16:15:54.159855+00
7	auth	0002_alter_permission_name_max_length	2017-08-08 16:15:54.188141+00
8	auth	0003_alter_user_email_max_length	2017-08-08 16:15:54.20464+00
9	auth	0004_alter_user_username_opts	2017-08-08 16:15:54.222609+00
10	auth	0005_alter_user_last_login_null	2017-08-08 16:15:54.244491+00
11	auth	0006_require_contenttypes_0002	2017-08-08 16:15:54.246547+00
12	people	24_initial	2017-08-08 16:15:54.3117+00
13	account	0001_initial	2017-08-08 16:15:54.595271+00
14	account	0002_fix_emailconfirmation_created	2017-08-08 16:15:54.632038+00
15	account	0003_auto_20160822_0917	2017-08-08 16:15:54.698069+00
16	account	0004_auto_20170419_1410	2017-08-08 16:15:54.76456+00
17	actstream	0001_initial	2017-08-08 16:16:18.403948+00
18	actstream	0002_remove_action_data	2017-08-08 16:16:18.406434+00
19	admin	0001_initial	2017-08-08 16:16:18.482677+00
20	agon_ratings	0001_initial	2017-08-08 16:16:18.723113+00
21	announcements	0001_initial	2017-08-08 16:16:18.845214+00
22	avatar	0001_initial	2017-08-08 16:16:18.92902+00
23	base	24_initial	2017-08-08 16:16:20.187023+00
24	base	24_to_26	2017-08-08 16:16:21.027448+00
25	base	0025_auto_20170719_1223	2017-08-08 16:16:21.171154+00
26	dialogos	0001_initial	2017-08-08 16:16:21.295938+00
27	djcelery	0001_initial	2017-08-08 16:16:21.54483+00
28	documents	24_initial	2017-08-08 16:16:21.67035+00
29	groups	24_initial	2017-08-08 16:16:22.759158+00
30	guardian	0001_initial	2017-08-08 16:16:23.269728+00
31	layers	24_initial	2017-08-08 16:16:24.586567+00
32	layers	24_to_26	2017-08-08 16:16:25.599182+00
33	layers	0025_auto_20170719_1223	2017-08-08 16:16:26.32513+00
34	maps	24_initial	2017-08-08 16:16:26.810711+00
35	oauth2_provider	0001_initial	2017-08-08 16:16:27.766266+00
36	oauth2_provider	0002_08_updates	2017-08-08 16:16:28.298881+00
37	oauth2_provider	0003_auto_20160316_1503	2017-08-08 16:16:28.473551+00
38	oauth2_provider	0004_auto_20160525_1623	2017-08-08 16:16:29.034463+00
39	services	24_initial	2017-08-08 16:16:30.277771+00
40	sessions	0001_initial	2017-08-08 16:16:30.30909+00
41	tastypie	0001_initial	2017-08-08 16:16:30.52068+00
42	upload	24_initial	2017-08-08 16:16:30.949699+00
43	user_messages	0001_initial	2017-08-08 16:16:32.009064+00
44	wm_extra	0001_initial	2017-08-08 16:16:32.412293+00
45	wm_extra	0002_endpoint	2017-08-08 16:16:32.632299+00
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('django_migrations_id_seq', 45, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: -
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: djcelery_crontabschedule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY djcelery_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year) FROM stdin;
\.


--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('djcelery_crontabschedule_id_seq', 1, false);


--
-- Data for Name: djcelery_intervalschedule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY djcelery_intervalschedule (id, every, period) FROM stdin;
\.


--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('djcelery_intervalschedule_id_seq', 1, false);


--
-- Data for Name: djcelery_periodictask; Type: TABLE DATA; Schema: public; Owner: -
--

COPY djcelery_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id) FROM stdin;
\.


--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('djcelery_periodictask_id_seq', 1, false);


--
-- Data for Name: djcelery_periodictasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY djcelery_periodictasks (ident, last_update) FROM stdin;
\.


--
-- Data for Name: djcelery_taskstate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY djcelery_taskstate (id, state, task_id, name, tstamp, args, kwargs, eta, expires, result, traceback, runtime, retries, hidden, worker_id) FROM stdin;
\.


--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('djcelery_taskstate_id_seq', 1, false);


--
-- Data for Name: djcelery_workerstate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY djcelery_workerstate (id, hostname, last_heartbeat) FROM stdin;
\.


--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('djcelery_workerstate_id_seq', 1, false);


--
-- Data for Name: documents_document; Type: TABLE DATA; Schema: public; Owner: -
--

COPY documents_document (resourcebase_ptr_id, title_en, abstract_en, purpose_en, constraints_other_en, supplemental_information_en, data_quality_statement_en, object_id, doc_file, extension, doc_type, doc_url, content_type_id) FROM stdin;
\.


--
-- Data for Name: gazetteer_gazetteerentry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY gazetteer_gazetteerentry (id, layer_name, layer_attribute, feature_type, feature_fid, latitude, longitude, place_name, start_date, end_date, julian_start, julian_end, project, feature, username) FROM stdin;
\.


--
-- Name: gazetteer_gazetteerentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('gazetteer_gazetteerentry_id_seq', 1, false);


--
-- Data for Name: groups_groupinvitation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY groups_groupinvitation (id, token, email, role, state, created, from_user_id, group_id, user_id) FROM stdin;
\.


--
-- Name: groups_groupinvitation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('groups_groupinvitation_id_seq', 1, false);


--
-- Data for Name: groups_groupmember; Type: TABLE DATA; Schema: public; Owner: -
--

COPY groups_groupmember (id, role, joined, group_id, user_id) FROM stdin;
\.


--
-- Name: groups_groupmember_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('groups_groupmember_id_seq', 1, false);


--
-- Data for Name: groups_groupprofile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY groups_groupprofile (id, title, slug, logo, description, email, access, last_modified, group_id) FROM stdin;
\.


--
-- Name: groups_groupprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('groups_groupprofile_id_seq', 1, false);


--
-- Data for Name: guardian_groupobjectpermission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY guardian_groupobjectpermission (id, object_pk, content_type_id, group_id, permission_id) FROM stdin;
\.


--
-- Name: guardian_groupobjectpermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('guardian_groupobjectpermission_id_seq', 1, false);


--
-- Data for Name: guardian_userobjectpermission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY guardian_userobjectpermission (id, object_pk, content_type_id, permission_id, user_id) FROM stdin;
\.


--
-- Name: guardian_userobjectpermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('guardian_userobjectpermission_id_seq', 1, false);


--
-- Data for Name: layers_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY layers_attribute (id, attribute, description, attribute_label, attribute_type, visible, display_order, count, min, max, average, median, stddev, sum, unique_values, last_stats_updated, layer_id, in_gazetteer, is_gaz_end_date, is_gaz_start_date) FROM stdin;
\.


--
-- Name: layers_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('layers_attribute_id_seq', 1, false);


--
-- Data for Name: layers_layer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY layers_layer (resourcebase_ptr_id, title_en, abstract_en, purpose_en, constraints_other_en, supplemental_information_en, data_quality_statement_en, workspace, store, "storeType", name, typename, charset, default_style_id, upload_session_id, elevation_regex, has_elevation, has_time, is_mosaic, time_regex, gazetteer_project, in_gazetteer) FROM stdin;
\.


--
-- Data for Name: layers_layer_styles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY layers_layer_styles (id, layer_id, style_id) FROM stdin;
\.


--
-- Name: layers_layer_styles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('layers_layer_styles_id_seq', 1, false);


--
-- Data for Name: layers_layerfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY layers_layerfile (id, name, base, file, upload_session_id) FROM stdin;
\.


--
-- Name: layers_layerfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('layers_layerfile_id_seq', 1, false);


--
-- Data for Name: layers_style; Type: TABLE DATA; Schema: public; Owner: -
--

COPY layers_style (id, name, sld_title, sld_body, sld_version, sld_url, workspace) FROM stdin;
\.


--
-- Name: layers_style_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('layers_style_id_seq', 1, false);


--
-- Data for Name: layers_uploadsession; Type: TABLE DATA; Schema: public; Owner: -
--

COPY layers_uploadsession (id, date, processed, error, traceback, context, user_id) FROM stdin;
\.


--
-- Name: layers_uploadsession_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('layers_uploadsession_id_seq', 1, false);


--
-- Data for Name: maps_map; Type: TABLE DATA; Schema: public; Owner: -
--

COPY maps_map (resourcebase_ptr_id, title_en, abstract_en, purpose_en, constraints_other_en, supplemental_information_en, data_quality_statement_en, zoom, projection, center_x, center_y, last_modified, urlsuffix, featuredurl) FROM stdin;
\.


--
-- Data for Name: maps_maplayer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY maps_maplayer (id, stack_order, format, name, opacity, styles, transparent, fixed, "group", visibility, ows_url, layer_params, source_params, local, map_id) FROM stdin;
\.


--
-- Name: maps_maplayer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('maps_maplayer_id_seq', 1, false);


--
-- Data for Name: maps_mapsnapshot; Type: TABLE DATA; Schema: public; Owner: -
--

COPY maps_mapsnapshot (id, config, created_dttm, map_id, user_id) FROM stdin;
\.


--
-- Name: maps_mapsnapshot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('maps_mapsnapshot_id_seq', 1, false);


--
-- Data for Name: oauth2_provider_accesstoken; Type: TABLE DATA; Schema: public; Owner: -
--

COPY oauth2_provider_accesstoken (id, token, expires, scope, application_id, user_id) FROM stdin;
\.


--
-- Name: oauth2_provider_accesstoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('oauth2_provider_accesstoken_id_seq', 1, false);


--
-- Data for Name: oauth2_provider_application; Type: TABLE DATA; Schema: public; Owner: -
--

COPY oauth2_provider_application (id, client_id, redirect_uris, client_type, authorization_grant_type, client_secret, name, user_id, skip_authorization) FROM stdin;
\.


--
-- Name: oauth2_provider_application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('oauth2_provider_application_id_seq', 1, false);


--
-- Data for Name: oauth2_provider_grant; Type: TABLE DATA; Schema: public; Owner: -
--

COPY oauth2_provider_grant (id, code, expires, redirect_uri, scope, application_id, user_id) FROM stdin;
\.


--
-- Name: oauth2_provider_grant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('oauth2_provider_grant_id_seq', 1, false);


--
-- Data for Name: oauth2_provider_refreshtoken; Type: TABLE DATA; Schema: public; Owner: -
--

COPY oauth2_provider_refreshtoken (id, token, access_token_id, application_id, user_id) FROM stdin;
\.


--
-- Name: oauth2_provider_refreshtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('oauth2_provider_refreshtoken_id_seq', 1, false);


--
-- Data for Name: people_profile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY people_profile (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, organization, profile, "position", voice, fax, delivery, city, area, zipcode, country) FROM stdin;
-1		\N	f	AnonymousUser				f	t	2017-08-08 16:15:55.037346+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: people_profile_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY people_profile_groups (id, profile_id, group_id) FROM stdin;
1	-1	1
\.


--
-- Name: people_profile_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('people_profile_groups_id_seq', 1, true);


--
-- Name: people_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('people_profile_id_seq', 1, false);


--
-- Data for Name: people_profile_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY people_profile_user_permissions (id, profile_id, permission_id) FROM stdin;
\.


--
-- Name: people_profile_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('people_profile_user_permissions_id_seq', 1, false);


--
-- Data for Name: services_service; Type: TABLE DATA; Schema: public; Owner: -
--

COPY services_service (resourcebase_ptr_id, type, method, base_url, version, name, description, online_resource, fees, access_constraints, connection_params, username, password, api_key, workspace_ref, store_ref, resources_ref, created, last_updated, first_noanswer, noanswer_retries, external_id, parent_id) FROM stdin;
\.


--
-- Data for Name: services_servicelayer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY services_servicelayer (id, typename, title, description, styles, layer_id, service_id) FROM stdin;
\.


--
-- Name: services_servicelayer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('services_servicelayer_id_seq', 1, false);


--
-- Data for Name: services_serviceprofilerole; Type: TABLE DATA; Schema: public; Owner: -
--

COPY services_serviceprofilerole (id, role, profiles_id, service_id) FROM stdin;
\.


--
-- Name: services_serviceprofilerole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('services_serviceprofilerole_id_seq', 1, false);


--
-- Data for Name: services_webserviceharvestlayersjob; Type: TABLE DATA; Schema: public; Owner: -
--

COPY services_webserviceharvestlayersjob (id, status, service_id) FROM stdin;
\.


--
-- Name: services_webserviceharvestlayersjob_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('services_webserviceharvestlayersjob_id_seq', 1, false);


--
-- Data for Name: services_webserviceregistrationjob; Type: TABLE DATA; Schema: public; Owner: -
--

COPY services_webserviceregistrationjob (id, base_url, type, status) FROM stdin;
\.


--
-- Name: services_webserviceregistrationjob_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('services_webserviceregistrationjob_id_seq', 1, false);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY spatial_ref_sys  FROM stdin;
\.


--
-- Data for Name: taggit_tag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY taggit_tag (id, name, slug) FROM stdin;
\.


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('taggit_tag_id_seq', 1, false);


--
-- Data for Name: taggit_taggeditem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY taggit_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('taggit_taggeditem_id_seq', 1, false);


--
-- Data for Name: tastypie_apiaccess; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tastypie_apiaccess (id, identifier, url, request_method, accessed) FROM stdin;
\.


--
-- Name: tastypie_apiaccess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tastypie_apiaccess_id_seq', 1, false);


--
-- Data for Name: tastypie_apikey; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tastypie_apikey (id, key, created, user_id) FROM stdin;
\.


--
-- Name: tastypie_apikey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tastypie_apikey_id_seq', 1, false);


--
-- Data for Name: upload_upload; Type: TABLE DATA; Schema: public; Owner: -
--

COPY upload_upload (id, import_id, state, date, upload_dir, name, complete, session, metadata, mosaic_time_regex, mosaic_time_value, mosaic_elev_regex, mosaic_elev_value, layer_id, user_id) FROM stdin;
\.


--
-- Name: upload_upload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('upload_upload_id_seq', 1, false);


--
-- Data for Name: upload_uploadfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY upload_uploadfile (id, file, slug, upload_id) FROM stdin;
\.


--
-- Name: upload_uploadfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('upload_uploadfile_id_seq', 1, false);


--
-- Data for Name: user_messages_message; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_messages_message (id, sent_at, content, sender_id, thread_id) FROM stdin;
\.


--
-- Name: user_messages_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_messages_message_id_seq', 1, false);


--
-- Data for Name: user_messages_thread; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_messages_thread (id, subject) FROM stdin;
\.


--
-- Name: user_messages_thread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_messages_thread_id_seq', 1, false);


--
-- Data for Name: user_messages_userthread; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_messages_userthread (id, unread, deleted, thread_id, user_id) FROM stdin;
\.


--
-- Name: user_messages_userthread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_messages_userthread_id_seq', 1, false);


--
-- Data for Name: wm_extra_endpoint; Type: TABLE DATA; Schema: public; Owner: -
--

COPY wm_extra_endpoint (id, description, url, owner_id) FROM stdin;
\.


--
-- Name: wm_extra_endpoint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('wm_extra_endpoint_id_seq', 1, false);


--
-- Data for Name: wm_extra_layerstats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY wm_extra_layerstats (id, visits, uniques, downloads, last_modified, layer_id) FROM stdin;
\.


--
-- Name: wm_extra_layerstats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('wm_extra_layerstats_id_seq', 1, false);


--
-- Data for Name: wm_extra_mapstats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY wm_extra_mapstats (id, visits, uniques, last_modified, map_id) FROM stdin;
\.


--
-- Name: wm_extra_mapstats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('wm_extra_mapstats_id_seq', 1, false);


--
-- Name: account_account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_account
    ADD CONSTRAINT account_account_pkey PRIMARY KEY (id);


--
-- Name: account_account_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_account
    ADD CONSTRAINT account_account_user_id_key UNIQUE (user_id);


--
-- Name: account_accountdeletion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_accountdeletion
    ADD CONSTRAINT account_accountdeletion_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: account_signupcode_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcode
    ADD CONSTRAINT account_signupcode_code_key UNIQUE (code);


--
-- Name: account_signupcode_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcode
    ADD CONSTRAINT account_signupcode_pkey PRIMARY KEY (id);


--
-- Name: account_signupcodeextended_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcodeextended
    ADD CONSTRAINT account_signupcodeextended_pkey PRIMARY KEY (signupcode_id);


--
-- Name: account_signupcoderesult_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcoderesult
    ADD CONSTRAINT account_signupcoderesult_pkey PRIMARY KEY (id);


--
-- Name: actstream_action_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_action
    ADD CONSTRAINT actstream_action_pkey PRIMARY KEY (id);


--
-- Name: actstream_follow_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_follow
    ADD CONSTRAINT actstream_follow_pkey PRIMARY KEY (id);


--
-- Name: actstream_follow_user_id_49f02cb6d67a13f2_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_follow
    ADD CONSTRAINT actstream_follow_user_id_49f02cb6d67a13f2_uniq UNIQUE (user_id, content_type_id, object_id);


--
-- Name: agon_ratings_overallrating_object_id_78a5ce0f54962845_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_overallrating
    ADD CONSTRAINT agon_ratings_overallrating_object_id_78a5ce0f54962845_uniq UNIQUE (object_id, content_type_id, category);


--
-- Name: agon_ratings_overallrating_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_overallrating
    ADD CONSTRAINT agon_ratings_overallrating_pkey PRIMARY KEY (id);


--
-- Name: agon_ratings_rating_object_id_4da1400c5e739f44_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_rating
    ADD CONSTRAINT agon_ratings_rating_object_id_4da1400c5e739f44_uniq UNIQUE (object_id, content_type_id, user_id, category);


--
-- Name: agon_ratings_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_rating
    ADD CONSTRAINT agon_ratings_rating_pkey PRIMARY KEY (id);


--
-- Name: announcements_announcement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY announcements_announcement
    ADD CONSTRAINT announcements_announcement_pkey PRIMARY KEY (id);


--
-- Name: announcements_dismissal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY announcements_dismissal
    ADD CONSTRAINT announcements_dismissal_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: avatar_avatar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY avatar_avatar
    ADD CONSTRAINT avatar_avatar_pkey PRIMARY KEY (id);


--
-- Name: base_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_backup
    ADD CONSTRAINT base_backup_pkey PRIMARY KEY (id);


--
-- Name: base_contactrole_contact_id_200c61c2eed7063c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_contactrole
    ADD CONSTRAINT base_contactrole_contact_id_200c61c2eed7063c_uniq UNIQUE (contact_id, resource_id, role);


--
-- Name: base_contactrole_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_contactrole
    ADD CONSTRAINT base_contactrole_pkey PRIMARY KEY (id);


--
-- Name: base_hierarchicalkeyword_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_hierarchicalkeyword
    ADD CONSTRAINT base_hierarchicalkeyword_name_key UNIQUE (name);


--
-- Name: base_hierarchicalkeyword_path_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_hierarchicalkeyword
    ADD CONSTRAINT base_hierarchicalkeyword_path_key UNIQUE (path);


--
-- Name: base_hierarchicalkeyword_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_hierarchicalkeyword
    ADD CONSTRAINT base_hierarchicalkeyword_pkey PRIMARY KEY (id);


--
-- Name: base_hierarchicalkeyword_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_hierarchicalkeyword
    ADD CONSTRAINT base_hierarchicalkeyword_slug_key UNIQUE (slug);


--
-- Name: base_license_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_license
    ADD CONSTRAINT base_license_pkey PRIMARY KEY (id);


--
-- Name: base_link_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_link
    ADD CONSTRAINT base_link_pkey PRIMARY KEY (id);


--
-- Name: base_region_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_region
    ADD CONSTRAINT base_region_code_key UNIQUE (code);


--
-- Name: base_region_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_region
    ADD CONSTRAINT base_region_pkey PRIMARY KEY (id);


--
-- Name: base_resourcebase_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase
    ADD CONSTRAINT base_resourcebase_pkey PRIMARY KEY (id);


--
-- Name: base_resourcebase_regions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_regions
    ADD CONSTRAINT base_resourcebase_regions_pkey PRIMARY KEY (id);


--
-- Name: base_resourcebase_regions_resourcebase_id_region_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_regions
    ADD CONSTRAINT base_resourcebase_regions_resourcebase_id_region_id_key UNIQUE (resourcebase_id, region_id);


--
-- Name: base_resourcebase_tkeywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_tkeywords
    ADD CONSTRAINT base_resourcebase_tkeywords_pkey PRIMARY KEY (id);


--
-- Name: base_resourcebase_tkeywords_resourcebase_id_thesauruskeywor_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_tkeywords
    ADD CONSTRAINT base_resourcebase_tkeywords_resourcebase_id_thesauruskeywor_key UNIQUE (resourcebase_id, thesauruskeyword_id);


--
-- Name: base_restrictioncodetype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_restrictioncodetype
    ADD CONSTRAINT base_restrictioncodetype_pkey PRIMARY KEY (id);


--
-- Name: base_spatialrepresentationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_spatialrepresentationtype
    ADD CONSTRAINT base_spatialrepresentationtype_pkey PRIMARY KEY (id);


--
-- Name: base_taggedcontentitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_taggedcontentitem
    ADD CONSTRAINT base_taggedcontentitem_pkey PRIMARY KEY (id);


--
-- Name: base_thesaurus_identifier_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesaurus
    ADD CONSTRAINT base_thesaurus_identifier_key UNIQUE (identifier);


--
-- Name: base_thesaurus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesaurus
    ADD CONSTRAINT base_thesaurus_pkey PRIMARY KEY (id);


--
-- Name: base_thesauruskeyword_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesauruskeyword
    ADD CONSTRAINT base_thesauruskeyword_pkey PRIMARY KEY (id);


--
-- Name: base_thesauruskeyword_thesaurus_id_3002ef6ea617c67b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesauruskeyword
    ADD CONSTRAINT base_thesauruskeyword_thesaurus_id_3002ef6ea617c67b_uniq UNIQUE (thesaurus_id, alt_label);


--
-- Name: base_thesauruskeywordlabel_keyword_id_df4adfe4b86d3c8_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesauruskeywordlabel
    ADD CONSTRAINT base_thesauruskeywordlabel_keyword_id_df4adfe4b86d3c8_uniq UNIQUE (keyword_id, lang);


--
-- Name: base_thesauruskeywordlabel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesauruskeywordlabel
    ADD CONSTRAINT base_thesauruskeywordlabel_pkey PRIMARY KEY (id);


--
-- Name: base_topiccategory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_topiccategory
    ADD CONSTRAINT base_topiccategory_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta_task_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_task_id_key UNIQUE (task_id);


--
-- Name: celery_tasksetmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_tasksetmeta_taskset_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_taskset_id_key UNIQUE (taskset_id);


--
-- Name: dialogos_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dialogos_comment
    ADD CONSTRAINT dialogos_comment_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_45f3b1d93ec8c61c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_45f3b1d93ec8c61c_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: djcelery_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_crontabschedule
    ADD CONSTRAINT djcelery_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_intervalschedule
    ADD CONSTRAINT djcelery_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_name_key UNIQUE (name);


--
-- Name: djcelery_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_periodictasks
    ADD CONSTRAINT djcelery_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: djcelery_taskstate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_pkey PRIMARY KEY (id);


--
-- Name: djcelery_taskstate_task_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_task_id_key UNIQUE (task_id);


--
-- Name: djcelery_workerstate_hostname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_hostname_key UNIQUE (hostname);


--
-- Name: djcelery_workerstate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_pkey PRIMARY KEY (id);


--
-- Name: documents_document_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents_document
    ADD CONSTRAINT documents_document_pkey PRIMARY KEY (resourcebase_ptr_id);


--
-- Name: gazetteer_gazetteerentry_layer_name_layer_attribute_feature_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gazetteer_gazetteerentry
    ADD CONSTRAINT gazetteer_gazetteerentry_layer_name_layer_attribute_feature_key UNIQUE (layer_name, layer_attribute, feature_fid);


--
-- Name: gazetteer_gazetteerentry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gazetteer_gazetteerentry
    ADD CONSTRAINT gazetteer_gazetteerentry_pkey PRIMARY KEY (id);


--
-- Name: groups_groupinvitation_group_id_103432029110e1_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupinvitation
    ADD CONSTRAINT groups_groupinvitation_group_id_103432029110e1_uniq UNIQUE (group_id, email);


--
-- Name: groups_groupinvitation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupinvitation
    ADD CONSTRAINT groups_groupinvitation_pkey PRIMARY KEY (id);


--
-- Name: groups_groupmember_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupmember
    ADD CONSTRAINT groups_groupmember_pkey PRIMARY KEY (id);


--
-- Name: groups_groupprofile_group_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupprofile
    ADD CONSTRAINT groups_groupprofile_group_id_key UNIQUE (group_id);


--
-- Name: groups_groupprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupprofile
    ADD CONSTRAINT groups_groupprofile_pkey PRIMARY KEY (id);


--
-- Name: groups_groupprofile_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupprofile
    ADD CONSTRAINT groups_groupprofile_slug_key UNIQUE (slug);


--
-- Name: guardian_groupobjectpermission_group_id_1692da556eb7175b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_groupobjectpermission
    ADD CONSTRAINT guardian_groupobjectpermission_group_id_1692da556eb7175b_uniq UNIQUE (group_id, permission_id, object_pk);


--
-- Name: guardian_groupobjectpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_groupobjectpermission
    ADD CONSTRAINT guardian_groupobjectpermission_pkey PRIMARY KEY (id);


--
-- Name: guardian_userobjectpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_userobjectpermission
    ADD CONSTRAINT guardian_userobjectpermission_pkey PRIMARY KEY (id);


--
-- Name: guardian_userobjectpermission_user_id_3d019018f740de5f_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_userobjectpermission
    ADD CONSTRAINT guardian_userobjectpermission_user_id_3d019018f740de5f_uniq UNIQUE (user_id, permission_id, object_pk);


--
-- Name: layers_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_attribute
    ADD CONSTRAINT layers_attribute_pkey PRIMARY KEY (id);


--
-- Name: layers_layer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layer
    ADD CONSTRAINT layers_layer_pkey PRIMARY KEY (resourcebase_ptr_id);


--
-- Name: layers_layer_styles_layer_id_style_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layer_styles
    ADD CONSTRAINT layers_layer_styles_layer_id_style_id_key UNIQUE (layer_id, style_id);


--
-- Name: layers_layer_styles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layer_styles
    ADD CONSTRAINT layers_layer_styles_pkey PRIMARY KEY (id);


--
-- Name: layers_layerfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layerfile
    ADD CONSTRAINT layers_layerfile_pkey PRIMARY KEY (id);


--
-- Name: layers_style_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_style
    ADD CONSTRAINT layers_style_name_key UNIQUE (name);


--
-- Name: layers_style_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_style
    ADD CONSTRAINT layers_style_pkey PRIMARY KEY (id);


--
-- Name: layers_uploadsession_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_uploadsession
    ADD CONSTRAINT layers_uploadsession_pkey PRIMARY KEY (id);


--
-- Name: maps_map_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_map
    ADD CONSTRAINT maps_map_pkey PRIMARY KEY (resourcebase_ptr_id);


--
-- Name: maps_maplayer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_maplayer
    ADD CONSTRAINT maps_maplayer_pkey PRIMARY KEY (id);


--
-- Name: maps_mapsnapshot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_mapsnapshot
    ADD CONSTRAINT maps_mapsnapshot_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_accesstoken_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_accesstoken_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_accesstoken_token_3f77f86fb4ecbe0f_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_accesstoken_token_3f77f86fb4ecbe0f_uniq UNIQUE (token);


--
-- Name: oauth2_provider_application_client_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_application
    ADD CONSTRAINT oauth2_provider_application_client_id_key UNIQUE (client_id);


--
-- Name: oauth2_provider_application_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_application
    ADD CONSTRAINT oauth2_provider_application_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_grant_code_a5c88732687483b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_grant
    ADD CONSTRAINT oauth2_provider_grant_code_a5c88732687483b_uniq UNIQUE (code);


--
-- Name: oauth2_provider_grant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_grant
    ADD CONSTRAINT oauth2_provider_grant_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_refreshtoken_access_token_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refreshtoken_access_token_id_key UNIQUE (access_token_id);


--
-- Name: oauth2_provider_refreshtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refreshtoken_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_refreshtoken_token_1e4e9388e6a22527_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refreshtoken_token_1e4e9388e6a22527_uniq UNIQUE (token);


--
-- Name: people_profile_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_groups
    ADD CONSTRAINT people_profile_groups_pkey PRIMARY KEY (id);


--
-- Name: people_profile_groups_profile_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_groups
    ADD CONSTRAINT people_profile_groups_profile_id_group_id_key UNIQUE (profile_id, group_id);


--
-- Name: people_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile
    ADD CONSTRAINT people_profile_pkey PRIMARY KEY (id);


--
-- Name: people_profile_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_user_permissions
    ADD CONSTRAINT people_profile_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: people_profile_user_permissions_profile_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_user_permissions
    ADD CONSTRAINT people_profile_user_permissions_profile_id_permission_id_key UNIQUE (profile_id, permission_id);


--
-- Name: people_profile_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile
    ADD CONSTRAINT people_profile_username_key UNIQUE (username);


--
-- Name: services_service_base_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_service
    ADD CONSTRAINT services_service_base_url_key UNIQUE (base_url);


--
-- Name: services_service_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_service
    ADD CONSTRAINT services_service_name_key UNIQUE (name);


--
-- Name: services_service_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_service
    ADD CONSTRAINT services_service_pkey PRIMARY KEY (resourcebase_ptr_id);


--
-- Name: services_servicelayer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_servicelayer
    ADD CONSTRAINT services_servicelayer_pkey PRIMARY KEY (id);


--
-- Name: services_serviceprofilerole_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_serviceprofilerole
    ADD CONSTRAINT services_serviceprofilerole_pkey PRIMARY KEY (id);


--
-- Name: services_webserviceharvestlayersjob_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_webserviceharvestlayersjob
    ADD CONSTRAINT services_webserviceharvestlayersjob_pkey PRIMARY KEY (id);


--
-- Name: services_webserviceharvestlayersjob_service_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_webserviceharvestlayersjob
    ADD CONSTRAINT services_webserviceharvestlayersjob_service_id_key UNIQUE (service_id);


--
-- Name: services_webserviceregistrationjob_base_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_webserviceregistrationjob
    ADD CONSTRAINT services_webserviceregistrationjob_base_url_key UNIQUE (base_url);


--
-- Name: services_webserviceregistrationjob_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_webserviceregistrationjob
    ADD CONSTRAINT services_webserviceregistrationjob_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggit_tag
    ADD CONSTRAINT taggit_tag_name_key UNIQUE (name);


--
-- Name: taggit_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggit_tag
    ADD CONSTRAINT taggit_tag_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggit_tag
    ADD CONSTRAINT taggit_tag_slug_key UNIQUE (slug);


--
-- Name: taggit_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: tastypie_apiaccess_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tastypie_apiaccess
    ADD CONSTRAINT tastypie_apiaccess_pkey PRIMARY KEY (id);


--
-- Name: tastypie_apikey_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tastypie_apikey
    ADD CONSTRAINT tastypie_apikey_pkey PRIMARY KEY (id);


--
-- Name: tastypie_apikey_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tastypie_apikey
    ADD CONSTRAINT tastypie_apikey_user_id_key UNIQUE (user_id);


--
-- Name: upload_upload_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upload_upload
    ADD CONSTRAINT upload_upload_pkey PRIMARY KEY (id);


--
-- Name: upload_uploadfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upload_uploadfile
    ADD CONSTRAINT upload_uploadfile_pkey PRIMARY KEY (id);


--
-- Name: user_messages_message_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_message
    ADD CONSTRAINT user_messages_message_pkey PRIMARY KEY (id);


--
-- Name: user_messages_thread_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_thread
    ADD CONSTRAINT user_messages_thread_pkey PRIMARY KEY (id);


--
-- Name: user_messages_userthread_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_userthread
    ADD CONSTRAINT user_messages_userthread_pkey PRIMARY KEY (id);


--
-- Name: wm_extra_endpoint_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_endpoint
    ADD CONSTRAINT wm_extra_endpoint_pkey PRIMARY KEY (id);


--
-- Name: wm_extra_layerstats_layer_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_layerstats
    ADD CONSTRAINT wm_extra_layerstats_layer_id_key UNIQUE (layer_id);


--
-- Name: wm_extra_layerstats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_layerstats
    ADD CONSTRAINT wm_extra_layerstats_pkey PRIMARY KEY (id);


--
-- Name: wm_extra_mapstats_map_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_mapstats
    ADD CONSTRAINT wm_extra_mapstats_map_id_key UNIQUE (map_id);


--
-- Name: wm_extra_mapstats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_mapstats
    ADD CONSTRAINT wm_extra_mapstats_pkey PRIMARY KEY (id);


--
-- Name: account_accountdeletion_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX account_accountdeletion_e8701ad4 ON account_accountdeletion USING btree (user_id);


--
-- Name: account_emailaddress_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX account_emailaddress_e8701ad4 ON account_emailaddress USING btree (user_id);


--
-- Name: account_emailaddress_email_206527469d8e1918_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX account_emailaddress_email_206527469d8e1918_like ON account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailconfirmation_6f1edeac; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX account_emailconfirmation_6f1edeac ON account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_7033a271201d424f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX account_emailconfirmation_key_7033a271201d424f_like ON account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: account_signupcode_code_455425ce5a0e449b_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX account_signupcode_code_455425ce5a0e449b_like ON account_signupcode USING btree (code varchar_pattern_ops);


--
-- Name: account_signupcode_d9678107; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX account_signupcode_d9678107 ON account_signupcode USING btree (inviter_id);


--
-- Name: account_signupcoderesult_819faee9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX account_signupcoderesult_819faee9 ON account_signupcoderesult USING btree (signup_code_id);


--
-- Name: account_signupcoderesult_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX account_signupcoderesult_e8701ad4 ON account_signupcoderesult USING btree (user_id);


--
-- Name: actstream_action_142874d9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_142874d9 ON actstream_action USING btree (action_object_content_type_id);


--
-- Name: actstream_action_1cd2a6ae; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_1cd2a6ae ON actstream_action USING btree (target_object_id);


--
-- Name: actstream_action_4c9184f3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_4c9184f3 ON actstream_action USING btree (public);


--
-- Name: actstream_action_53a09d9a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_53a09d9a ON actstream_action USING btree (actor_content_type_id);


--
-- Name: actstream_action_9063443c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_9063443c ON actstream_action USING btree (action_object_object_id);


--
-- Name: actstream_action_action_object_object_id_2e33a3d4d877205f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_action_object_object_id_2e33a3d4d877205f_like ON actstream_action USING btree (action_object_object_id varchar_pattern_ops);


--
-- Name: actstream_action_actor_object_id_6c93edc3fe0bc300_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_actor_object_id_6c93edc3fe0bc300_like ON actstream_action USING btree (actor_object_id varchar_pattern_ops);


--
-- Name: actstream_action_b512ddf1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_b512ddf1 ON actstream_action USING btree (verb);


--
-- Name: actstream_action_c4f7c191; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_c4f7c191 ON actstream_action USING btree (actor_object_id);


--
-- Name: actstream_action_d7e6d55b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_d7e6d55b ON actstream_action USING btree ("timestamp");


--
-- Name: actstream_action_e4f9dcc7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_e4f9dcc7 ON actstream_action USING btree (target_content_type_id);


--
-- Name: actstream_action_target_object_id_7ca7b19f4e9f7a2f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_target_object_id_7ca7b19f4e9f7a2f_like ON actstream_action USING btree (target_object_id varchar_pattern_ops);


--
-- Name: actstream_action_verb_4670610ba8e8043_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_action_verb_4670610ba8e8043_like ON actstream_action USING btree (verb varchar_pattern_ops);


--
-- Name: actstream_follow_3bebb2f8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_follow_3bebb2f8 ON actstream_follow USING btree (started);


--
-- Name: actstream_follow_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_follow_417f1b1c ON actstream_follow USING btree (content_type_id);


--
-- Name: actstream_follow_af31437c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_follow_af31437c ON actstream_follow USING btree (object_id);


--
-- Name: actstream_follow_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_follow_e8701ad4 ON actstream_follow USING btree (user_id);


--
-- Name: actstream_follow_object_id_42f751fb772fddb3_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actstream_follow_object_id_42f751fb772fddb3_like ON actstream_follow USING btree (object_id varchar_pattern_ops);


--
-- Name: agon_ratings_overallrating_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agon_ratings_overallrating_417f1b1c ON agon_ratings_overallrating USING btree (content_type_id);


--
-- Name: agon_ratings_overallrating_af31437c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agon_ratings_overallrating_af31437c ON agon_ratings_overallrating USING btree (object_id);


--
-- Name: agon_ratings_rating_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agon_ratings_rating_417f1b1c ON agon_ratings_rating USING btree (content_type_id);


--
-- Name: agon_ratings_rating_af31437c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agon_ratings_rating_af31437c ON agon_ratings_rating USING btree (object_id);


--
-- Name: agon_ratings_rating_c32276b6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agon_ratings_rating_c32276b6 ON agon_ratings_rating USING btree (overall_rating_id);


--
-- Name: agon_ratings_rating_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agon_ratings_rating_e8701ad4 ON agon_ratings_rating USING btree (user_id);


--
-- Name: announcements_announcement_3700153c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX announcements_announcement_3700153c ON announcements_announcement USING btree (creator_id);


--
-- Name: announcements_dismissal_b45f7c99; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX announcements_dismissal_b45f7c99 ON announcements_dismissal USING btree (announcement_id);


--
-- Name: announcements_dismissal_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX announcements_dismissal_e8701ad4 ON announcements_dismissal USING btree (user_id);


--
-- Name: auth_group_name_253ae2a6331666e8_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_253ae2a6331666e8_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: avatar_avatar_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX avatar_avatar_e8701ad4 ON avatar_avatar USING btree (user_id);


--
-- Name: base_contactrole_6d82f13d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_contactrole_6d82f13d ON base_contactrole USING btree (contact_id);


--
-- Name: base_contactrole_e2f3ef5b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_contactrole_e2f3ef5b ON base_contactrole USING btree (resource_id);


--
-- Name: base_hierarchicalkeyword_name_9a549fea33d659e_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_hierarchicalkeyword_name_9a549fea33d659e_like ON base_hierarchicalkeyword USING btree (name varchar_pattern_ops);


--
-- Name: base_hierarchicalkeyword_path_c538237db4790f2_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_hierarchicalkeyword_path_c538237db4790f2_like ON base_hierarchicalkeyword USING btree (path varchar_pattern_ops);


--
-- Name: base_hierarchicalkeyword_slug_1a5bf37ed2642166_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_hierarchicalkeyword_slug_1a5bf37ed2642166_like ON base_hierarchicalkeyword USING btree (slug varchar_pattern_ops);


--
-- Name: base_link_e2f3ef5b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_link_e2f3ef5b ON base_link USING btree (resource_id);


--
-- Name: base_region_3cfbd988; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_region_3cfbd988 ON base_region USING btree (rght);


--
-- Name: base_region_656442a0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_region_656442a0 ON base_region USING btree (tree_id);


--
-- Name: base_region_6be37982; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_region_6be37982 ON base_region USING btree (parent_id);


--
-- Name: base_region_c9e9a848; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_region_c9e9a848 ON base_region USING btree (level);


--
-- Name: base_region_caf7cc51; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_region_caf7cc51 ON base_region USING btree (lft);


--
-- Name: base_region_code_5c91c2ff04db7251_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_region_code_5c91c2ff04db7251_like ON base_region USING btree (code varchar_pattern_ops);


--
-- Name: base_resourcebase_366393cd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_366393cd ON base_resourcebase USING btree (license_id);


--
-- Name: base_resourcebase_5e7b1936; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_5e7b1936 ON base_resourcebase USING btree (owner_id);


--
-- Name: base_resourcebase_78eccdf7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_78eccdf7 ON base_resourcebase USING btree (restriction_code_type_id);


--
-- Name: base_resourcebase_b583a629; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_b583a629 ON base_resourcebase USING btree (category_id);


--
-- Name: base_resourcebase_d12af31d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_d12af31d ON base_resourcebase USING btree (spatial_representation_type_id);


--
-- Name: base_resourcebase_d3e32c49; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_d3e32c49 ON base_resourcebase USING btree (polymorphic_ctype_id);


--
-- Name: base_resourcebase_regions_0f442f96; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_regions_0f442f96 ON base_resourcebase_regions USING btree (region_id);


--
-- Name: base_resourcebase_regions_d31e16f1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_regions_d31e16f1 ON base_resourcebase_regions USING btree (resourcebase_id);


--
-- Name: base_resourcebase_tkeywords_d31e16f1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_tkeywords_d31e16f1 ON base_resourcebase_tkeywords USING btree (resourcebase_id);


--
-- Name: base_resourcebase_tkeywords_e0f614b7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_resourcebase_tkeywords_e0f614b7 ON base_resourcebase_tkeywords USING btree (thesauruskeyword_id);


--
-- Name: base_taggedcontentitem_09a80f33; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_taggedcontentitem_09a80f33 ON base_taggedcontentitem USING btree (content_object_id);


--
-- Name: base_taggedcontentitem_76f094bc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_taggedcontentitem_76f094bc ON base_taggedcontentitem USING btree (tag_id);


--
-- Name: base_thesaurus_identifier_4e566348455656fa_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_thesaurus_identifier_4e566348455656fa_like ON base_thesaurus USING btree (identifier varchar_pattern_ops);


--
-- Name: base_thesauruskeyword_808b7ae9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_thesauruskeyword_808b7ae9 ON base_thesauruskeyword USING btree (thesaurus_id);


--
-- Name: base_thesauruskeywordlabel_5c003bba; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_thesauruskeywordlabel_5c003bba ON base_thesauruskeywordlabel USING btree (keyword_id);


--
-- Name: celery_taskmeta_662f707d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX celery_taskmeta_662f707d ON celery_taskmeta USING btree (hidden);


--
-- Name: celery_taskmeta_task_id_1efd6ed1da631331_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX celery_taskmeta_task_id_1efd6ed1da631331_like ON celery_taskmeta USING btree (task_id varchar_pattern_ops);


--
-- Name: celery_tasksetmeta_662f707d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX celery_tasksetmeta_662f707d ON celery_tasksetmeta USING btree (hidden);


--
-- Name: celery_tasksetmeta_taskset_id_24b26c359742c9ab_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX celery_tasksetmeta_taskset_id_24b26c359742c9ab_like ON celery_tasksetmeta USING btree (taskset_id varchar_pattern_ops);


--
-- Name: dialogos_comment_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX dialogos_comment_417f1b1c ON dialogos_comment USING btree (content_type_id);


--
-- Name: dialogos_comment_4f331e2f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX dialogos_comment_4f331e2f ON dialogos_comment USING btree (author_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_461cfeaa630ca218_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_461cfeaa630ca218_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: djcelery_periodictask_1dcd7040; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_periodictask_1dcd7040 ON djcelery_periodictask USING btree (interval_id);


--
-- Name: djcelery_periodictask_f3f0d72a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_periodictask_f3f0d72a ON djcelery_periodictask USING btree (crontab_id);


--
-- Name: djcelery_periodictask_name_47c621f8dc029d22_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_periodictask_name_47c621f8dc029d22_like ON djcelery_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_662f707d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_taskstate_662f707d ON djcelery_taskstate USING btree (hidden);


--
-- Name: djcelery_taskstate_863bb2ee; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_taskstate_863bb2ee ON djcelery_taskstate USING btree (tstamp);


--
-- Name: djcelery_taskstate_9ed39e2e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_taskstate_9ed39e2e ON djcelery_taskstate USING btree (state);


--
-- Name: djcelery_taskstate_b068931c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_taskstate_b068931c ON djcelery_taskstate USING btree (name);


--
-- Name: djcelery_taskstate_ce77e6ef; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_taskstate_ce77e6ef ON djcelery_taskstate USING btree (worker_id);


--
-- Name: djcelery_taskstate_name_4337b4449e8827d_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_taskstate_name_4337b4449e8827d_like ON djcelery_taskstate USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_state_19cb9b39780e399c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_taskstate_state_19cb9b39780e399c_like ON djcelery_taskstate USING btree (state varchar_pattern_ops);


--
-- Name: djcelery_taskstate_task_id_29366bc6dcd6fd60_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_taskstate_task_id_29366bc6dcd6fd60_like ON djcelery_taskstate USING btree (task_id varchar_pattern_ops);


--
-- Name: djcelery_workerstate_f129901a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_workerstate_f129901a ON djcelery_workerstate USING btree (last_heartbeat);


--
-- Name: djcelery_workerstate_hostname_3900851044588416_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX djcelery_workerstate_hostname_3900851044588416_like ON djcelery_workerstate USING btree (hostname varchar_pattern_ops);


--
-- Name: documents_document_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX documents_document_417f1b1c ON documents_document USING btree (content_type_id);


--
-- Name: gazetteer_gazetteerentry_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gazetteer_gazetteerentry_feature_id ON gazetteer_gazetteerentry USING gist (feature);


--
-- Name: groups_groupinvitation_0e939a4f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groups_groupinvitation_0e939a4f ON groups_groupinvitation USING btree (group_id);


--
-- Name: groups_groupinvitation_6b4f059f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groups_groupinvitation_6b4f059f ON groups_groupinvitation USING btree (from_user_id);


--
-- Name: groups_groupinvitation_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groups_groupinvitation_e8701ad4 ON groups_groupinvitation USING btree (user_id);


--
-- Name: groups_groupmember_0e939a4f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groups_groupmember_0e939a4f ON groups_groupmember USING btree (group_id);


--
-- Name: groups_groupmember_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groups_groupmember_e8701ad4 ON groups_groupmember USING btree (user_id);


--
-- Name: groups_groupprofile_slug_6b92e51b821612fc_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groups_groupprofile_slug_6b92e51b821612fc_like ON groups_groupprofile USING btree (slug varchar_pattern_ops);


--
-- Name: guardian_groupobjectpermission_0e939a4f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX guardian_groupobjectpermission_0e939a4f ON guardian_groupobjectpermission USING btree (group_id);


--
-- Name: guardian_groupobjectpermission_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX guardian_groupobjectpermission_417f1b1c ON guardian_groupobjectpermission USING btree (content_type_id);


--
-- Name: guardian_groupobjectpermission_8373b171; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX guardian_groupobjectpermission_8373b171 ON guardian_groupobjectpermission USING btree (permission_id);


--
-- Name: guardian_userobjectpermission_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX guardian_userobjectpermission_417f1b1c ON guardian_userobjectpermission USING btree (content_type_id);


--
-- Name: guardian_userobjectpermission_8373b171; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX guardian_userobjectpermission_8373b171 ON guardian_userobjectpermission USING btree (permission_id);


--
-- Name: guardian_userobjectpermission_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX guardian_userobjectpermission_e8701ad4 ON guardian_userobjectpermission USING btree (user_id);


--
-- Name: layers_attribute_7a39a38c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX layers_attribute_7a39a38c ON layers_attribute USING btree (layer_id);


--
-- Name: layers_layer_d3785984; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX layers_layer_d3785984 ON layers_layer USING btree (default_style_id);


--
-- Name: layers_layer_d87a0fa8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX layers_layer_d87a0fa8 ON layers_layer USING btree (upload_session_id);


--
-- Name: layers_layer_styles_528292b4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX layers_layer_styles_528292b4 ON layers_layer_styles USING btree (style_id);


--
-- Name: layers_layer_styles_7a39a38c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX layers_layer_styles_7a39a38c ON layers_layer_styles USING btree (layer_id);


--
-- Name: layers_layerfile_d87a0fa8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX layers_layerfile_d87a0fa8 ON layers_layerfile USING btree (upload_session_id);


--
-- Name: layers_style_name_457ffc63b583f778_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX layers_style_name_457ffc63b583f778_like ON layers_style USING btree (name varchar_pattern_ops);


--
-- Name: layers_uploadsession_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX layers_uploadsession_e8701ad4 ON layers_uploadsession USING btree (user_id);


--
-- Name: maps_maplayer_728797e9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX maps_maplayer_728797e9 ON maps_maplayer USING btree (map_id);


--
-- Name: maps_mapsnapshot_728797e9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX maps_mapsnapshot_728797e9 ON maps_mapsnapshot USING btree (map_id);


--
-- Name: maps_mapsnapshot_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX maps_mapsnapshot_e8701ad4 ON maps_mapsnapshot USING btree (user_id);


--
-- Name: oauth2_provider_accesstoken_6bc0a4eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_accesstoken_6bc0a4eb ON oauth2_provider_accesstoken USING btree (application_id);


--
-- Name: oauth2_provider_accesstoken_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_accesstoken_e8701ad4 ON oauth2_provider_accesstoken USING btree (user_id);


--
-- Name: oauth2_provider_application_9d667c2b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_application_9d667c2b ON oauth2_provider_application USING btree (client_secret);


--
-- Name: oauth2_provider_application_client_id_58c909672dac14b2_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_application_client_id_58c909672dac14b2_like ON oauth2_provider_application USING btree (client_id varchar_pattern_ops);


--
-- Name: oauth2_provider_application_client_secret_7a03c41cdcace5e9_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_application_client_secret_7a03c41cdcace5e9_like ON oauth2_provider_application USING btree (client_secret varchar_pattern_ops);


--
-- Name: oauth2_provider_application_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_application_e8701ad4 ON oauth2_provider_application USING btree (user_id);


--
-- Name: oauth2_provider_grant_6bc0a4eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_grant_6bc0a4eb ON oauth2_provider_grant USING btree (application_id);


--
-- Name: oauth2_provider_grant_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_grant_e8701ad4 ON oauth2_provider_grant USING btree (user_id);


--
-- Name: oauth2_provider_refreshtoken_6bc0a4eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_refreshtoken_6bc0a4eb ON oauth2_provider_refreshtoken USING btree (application_id);


--
-- Name: oauth2_provider_refreshtoken_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth2_provider_refreshtoken_e8701ad4 ON oauth2_provider_refreshtoken USING btree (user_id);


--
-- Name: people_profile_groups_0e939a4f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_profile_groups_0e939a4f ON people_profile_groups USING btree (group_id);


--
-- Name: people_profile_groups_83a0eb3f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_profile_groups_83a0eb3f ON people_profile_groups USING btree (profile_id);


--
-- Name: people_profile_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_profile_user_permissions_8373b171 ON people_profile_user_permissions USING btree (permission_id);


--
-- Name: people_profile_user_permissions_83a0eb3f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_profile_user_permissions_83a0eb3f ON people_profile_user_permissions USING btree (profile_id);


--
-- Name: people_profile_username_79ae402c2585643a_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_profile_username_79ae402c2585643a_like ON people_profile USING btree (username varchar_pattern_ops);


--
-- Name: services_service_6be37982; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_service_6be37982 ON services_service USING btree (parent_id);


--
-- Name: services_service_base_url_7ec25cc4ba716240_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_service_base_url_7ec25cc4ba716240_like ON services_service USING btree (base_url varchar_pattern_ops);


--
-- Name: services_service_name_3b7e1895ab344468_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_service_name_3b7e1895ab344468_like ON services_service USING btree (name varchar_pattern_ops);


--
-- Name: services_servicelayer_7a39a38c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_servicelayer_7a39a38c ON services_servicelayer USING btree (layer_id);


--
-- Name: services_servicelayer_b0dc1e29; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_servicelayer_b0dc1e29 ON services_servicelayer USING btree (service_id);


--
-- Name: services_serviceprofilerole_246c83c5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_serviceprofilerole_246c83c5 ON services_serviceprofilerole USING btree (profiles_id);


--
-- Name: services_serviceprofilerole_b0dc1e29; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_serviceprofilerole_b0dc1e29 ON services_serviceprofilerole USING btree (service_id);


--
-- Name: services_webserviceregistrationj_base_url_1c807c6f4bc2d982_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_webserviceregistrationj_base_url_1c807c6f4bc2d982_like ON services_webserviceregistrationjob USING btree (base_url varchar_pattern_ops);


--
-- Name: taggit_tag_name_4ed9aad194b72af1_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggit_tag_name_4ed9aad194b72af1_like ON taggit_tag USING btree (name varchar_pattern_ops);


--
-- Name: taggit_tag_slug_703438030cd922a7_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggit_tag_slug_703438030cd922a7_like ON taggit_tag USING btree (slug varchar_pattern_ops);


--
-- Name: taggit_taggeditem_417f1b1c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggit_taggeditem_417f1b1c ON taggit_taggeditem USING btree (content_type_id);


--
-- Name: taggit_taggeditem_76f094bc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggit_taggeditem_76f094bc ON taggit_taggeditem USING btree (tag_id);


--
-- Name: taggit_taggeditem_af31437c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggit_taggeditem_af31437c ON taggit_taggeditem USING btree (object_id);


--
-- Name: taggit_taggeditem_content_type_id_3c99b32018cc9d40_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggit_taggeditem_content_type_id_3c99b32018cc9d40_idx ON taggit_taggeditem USING btree (content_type_id, object_id);


--
-- Name: tastypie_apikey_3c6e0b8a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tastypie_apikey_3c6e0b8a ON tastypie_apikey USING btree (key);


--
-- Name: tastypie_apikey_key_b86d63920e5bbcb_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tastypie_apikey_key_b86d63920e5bbcb_like ON tastypie_apikey USING btree (key varchar_pattern_ops);


--
-- Name: upload_upload_7a39a38c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_upload_7a39a38c ON upload_upload USING btree (layer_id);


--
-- Name: upload_upload_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_upload_e8701ad4 ON upload_upload USING btree (user_id);


--
-- Name: upload_uploadfile_23d3d4ae; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_uploadfile_23d3d4ae ON upload_uploadfile USING btree (upload_id);


--
-- Name: upload_uploadfile_2dbcba41; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_uploadfile_2dbcba41 ON upload_uploadfile USING btree (slug);


--
-- Name: upload_uploadfile_slug_30d5291a9c54a97a_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_uploadfile_slug_30d5291a9c54a97a_like ON upload_uploadfile USING btree (slug varchar_pattern_ops);


--
-- Name: user_messages_message_924b1846; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_messages_message_924b1846 ON user_messages_message USING btree (sender_id);


--
-- Name: user_messages_message_e3464c97; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_messages_message_e3464c97 ON user_messages_message USING btree (thread_id);


--
-- Name: user_messages_userthread_e3464c97; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_messages_userthread_e3464c97 ON user_messages_userthread USING btree (thread_id);


--
-- Name: user_messages_userthread_e8701ad4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_messages_userthread_e8701ad4 ON user_messages_userthread USING btree (user_id);


--
-- Name: wm_extra_endpoint_5e7b1936; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wm_extra_endpoint_5e7b1936 ON wm_extra_endpoint USING btree (owner_id);


--
-- Name: D2a12d0e2faf277dc66c05213d0b0fbf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_action
    ADD CONSTRAINT "D2a12d0e2faf277dc66c05213d0b0fbf" FOREIGN KEY (target_content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D3777337be8ace959a3bccac7f2b601d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_action
    ADD CONSTRAINT "D3777337be8ace959a3bccac7f2b601d" FOREIGN KEY (action_object_content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D47397aaeaa2cb394fe1d56520db7f1a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_tkeywords
    ADD CONSTRAINT "D47397aaeaa2cb394fe1d56520db7f1a" FOREIGN KEY (thesauruskeyword_id) REFERENCES base_thesauruskeyword(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D6f27058a0edec0b6bbc9b18efa8a484; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_webserviceharvestlayersjob
    ADD CONSTRAINT "D6f27058a0edec0b6bbc9b18efa8a484" FOREIGN KEY (service_id) REFERENCES services_service(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D7733692032a50f3a0aab575e00bb6e4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_action
    ADD CONSTRAINT "D7733692032a50f3a0aab575e00bb6e4" FOREIGN KEY (actor_content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D92b8c8454c94921c8f17ac3c4c109a0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_serviceprofilerole
    ADD CONSTRAINT "D92b8c8454c94921c8f17ac3c4c109a0" FOREIGN KEY (service_id) REFERENCES services_service(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D9aead397b25d8154e554023da34d33b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT "D9aead397b25d8154e554023da34d33b" FOREIGN KEY (access_token_id) REFERENCES oauth2_provider_accesstoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: a17250f96ea449de36002be9c6c6acfb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_accesstoken
    ADD CONSTRAINT a17250f96ea449de36002be9c6c6acfb FOREIGN KEY (application_id) REFERENCES oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ac_email_address_id_5bcf9f503c32d4d8_fk_account_emailaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT ac_email_address_id_5bcf9f503c32d4d8_fk_account_emailaddress_id FOREIGN KEY (email_address_id) REFERENCES account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accoun_signup_code_id_6723bc43127309ef_fk_account_signupcode_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcoderesult
    ADD CONSTRAINT accoun_signup_code_id_6723bc43127309ef_fk_account_signupcode_id FOREIGN KEY (signup_code_id) REFERENCES account_signupcode(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_account_user_id_c5f440932a9ad6b_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_account
    ADD CONSTRAINT account_account_user_id_c5f440932a9ad6b_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_accountde_user_id_2d7887738a43fedd_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_accountdeletion
    ADD CONSTRAINT account_accountde_user_id_2d7887738a43fedd_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailaddr_user_id_5c85949e40d9a61d_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddr_user_id_5c85949e40d9a61d_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_signup_inviter_id_7afa40ab6c43c9b1_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcode
    ADD CONSTRAINT account_signup_inviter_id_7afa40ab6c43c9b1_fk_people_profile_id FOREIGN KEY (inviter_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_signupcod_user_id_25e9d8ed65b0b4ff_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcoderesult
    ADD CONSTRAINT account_signupcod_user_id_25e9d8ed65b0b4ff_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_signupcode_id_2e8794b937476cd3_fk_account_signupcode_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_signupcodeextended
    ADD CONSTRAINT account_signupcode_id_2e8794b937476cd3_fk_account_signupcode_id FOREIGN KEY (signupcode_id) REFERENCES account_signupcode(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: acts_content_type_id_30a29286dd004af8_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_follow
    ADD CONSTRAINT acts_content_type_id_30a29286dd004af8_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: actstream_follow_user_id_2dbe1c43431b23ab_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actstream_follow
    ADD CONSTRAINT actstream_follow_user_id_2dbe1c43431b23ab_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: agon_content_type_id_4c0cc28f55536145_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_rating
    ADD CONSTRAINT agon_content_type_id_4c0cc28f55536145_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: agon_content_type_id_6549986451e044fd_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_overallrating
    ADD CONSTRAINT agon_content_type_id_6549986451e044fd_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: agon_ratings_rati_user_id_4a08f08374f7b7e8_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_rating
    ADD CONSTRAINT agon_ratings_rati_user_id_4a08f08374f7b7e8_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: announcements__creator_id_2550b7236088e5a3_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY announcements_announcement
    ADD CONSTRAINT announcements__creator_id_2550b7236088e5a3_fk_people_profile_id FOREIGN KEY (creator_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: announcements_dism_user_id_7beccd0fc07a2ee_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY announcements_dismissal
    ADD CONSTRAINT announcements_dism_user_id_7beccd0fc07a2ee_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_content_type_id_508cf46651277a81_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_508cf46651277a81_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: avatar_avatar_user_id_341d933ad2f6973_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY avatar_avatar
    ADD CONSTRAINT avatar_avatar_user_id_341d933ad2f6973_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: b28cf3a0ecffad4119bf626b00adb134; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase
    ADD CONSTRAINT b28cf3a0ecffad4119bf626b00adb134 FOREIGN KEY (spatial_representation_type_id) REFERENCES base_spatialrepresentationtype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: b904224de61391c19ce1f779154bd840; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase
    ADD CONSTRAINT b904224de61391c19ce1f779154bd840 FOREIGN KEY (restriction_code_type_id) REFERENCES base_restrictioncodetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_conta_resource_id_70b5a06834aae1b0_fk_base_resourcebase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_contactrole
    ADD CONSTRAINT base_conta_resource_id_70b5a06834aae1b0_fk_base_resourcebase_id FOREIGN KEY (resource_id) REFERENCES base_resourcebase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_contactro_contact_id_78e948b0ab7d5335_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_contactrole
    ADD CONSTRAINT base_contactro_contact_id_78e948b0ab7d5335_fk_people_profile_id FOREIGN KEY (contact_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_link_resource_id_66e83afffae8bd81_fk_base_resourcebase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_link
    ADD CONSTRAINT base_link_resource_id_66e83afffae8bd81_fk_base_resourcebase_id FOREIGN KEY (resource_id) REFERENCES base_resourcebase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_r_resourcebase_id_2c3e5e41baa89d71_fk_base_resourcebase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_regions
    ADD CONSTRAINT base_r_resourcebase_id_2c3e5e41baa89d71_fk_base_resourcebase_id FOREIGN KEY (resourcebase_id) REFERENCES base_resourcebase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_re_resourcebase_id_d70dfc3f59d3f72_fk_base_resourcebase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_tkeywords
    ADD CONSTRAINT base_re_resourcebase_id_d70dfc3f59d3f72_fk_base_resourcebase_id FOREIGN KEY (resourcebase_id) REFERENCES base_resourcebase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_region_parent_id_58b0699f710491a7_fk_base_region_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_region
    ADD CONSTRAINT base_region_parent_id_58b0699f710491a7_fk_base_region_id FOREIGN KEY (parent_id) REFERENCES base_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_reso_category_id_75f2899677ebd986_fk_base_topiccategory_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase
    ADD CONSTRAINT base_reso_category_id_75f2899677ebd986_fk_base_topiccategory_id FOREIGN KEY (category_id) REFERENCES base_topiccategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_resourcebas_license_id_5b1cc004d70f9080_fk_base_license_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase
    ADD CONSTRAINT base_resourcebas_license_id_5b1cc004d70f9080_fk_base_license_id FOREIGN KEY (license_id) REFERENCES base_license(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_resourcebas_owner_id_350049c3c6215b52_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase
    ADD CONSTRAINT base_resourcebas_owner_id_350049c3c6215b52_fk_people_profile_id FOREIGN KEY (owner_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_resourcebase__region_id_480f98f1634268b2_fk_base_region_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase_regions
    ADD CONSTRAINT base_resourcebase__region_id_480f98f1634268b2_fk_base_region_id FOREIGN KEY (region_id) REFERENCES base_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_t_content_object_id_de57069b4726af_fk_base_resourcebase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_taggedcontentitem
    ADD CONSTRAINT base_t_content_object_id_de57069b4726af_fk_base_resourcebase_id FOREIGN KEY (content_object_id) REFERENCES base_resourcebase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_tag_tag_id_24aeaaf4fb152233_fk_base_hierarchicalkeyword_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_taggedcontentitem
    ADD CONSTRAINT base_tag_tag_id_24aeaaf4fb152233_fk_base_hierarchicalkeyword_id FOREIGN KEY (tag_id) REFERENCES base_hierarchicalkeyword(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_th_keyword_id_721fe66a19bebfeb_fk_base_thesauruskeyword_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesauruskeywordlabel
    ADD CONSTRAINT base_th_keyword_id_721fe66a19bebfeb_fk_base_thesauruskeyword_id FOREIGN KEY (keyword_id) REFERENCES base_thesauruskeyword(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_thesaur_thesaurus_id_7969eb87a6a3fd75_fk_base_thesaurus_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_thesauruskeyword
    ADD CONSTRAINT base_thesaur_thesaurus_id_7969eb87a6a3fd75_fk_base_thesaurus_id FOREIGN KEY (thesaurus_id) REFERENCES base_thesaurus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: c82b7789df725bc603507425d1801bfa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_service
    ADD CONSTRAINT c82b7789df725bc603507425d1801bfa FOREIGN KEY (parent_id) REFERENCES services_service(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: da2196e2988877260c8db8e9bb03265e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT da2196e2988877260c8db8e9bb03265e FOREIGN KEY (application_id) REFERENCES oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dial_content_type_id_22d30df4434fdefc_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dialogos_comment
    ADD CONSTRAINT dial_content_type_id_22d30df4434fdefc_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dialogos_commen_author_id_3ecf7aa9f3c414bd_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dialogos_comment
    ADD CONSTRAINT dialogos_commen_author_id_3ecf7aa9f3c414bd_fk_people_profile_id FOREIGN KEY (author_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dj_interval_id_20cfc1cad060dfad_fk_djcelery_intervalschedule_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT dj_interval_id_20cfc1cad060dfad_fk_djcelery_intervalschedule_id FOREIGN KEY (interval_id) REFERENCES djcelery_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djan_content_type_id_697914295151027a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_697914295151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_52fdd58701c5f563_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_52fdd58701c5f563_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djce_crontab_id_1d8228f5b44b680a_fk_djcelery_crontabschedule_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djce_crontab_id_1d8228f5b44b680a_fk_djcelery_crontabschedule_id FOREIGN KEY (crontab_id) REFERENCES djcelery_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery__worker_id_30050731b1c3d3d9_fk_djcelery_workerstate_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY djcelery_taskstate
    ADD CONSTRAINT djcelery__worker_id_30050731b1c3d3d9_fk_djcelery_workerstate_id FOREIGN KEY (worker_id) REFERENCES djcelery_workerstate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: do_resourcebase_ptr_id_7cb83b58cea87e2a_fk_base_resourcebase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents_document
    ADD CONSTRAINT do_resourcebase_ptr_id_7cb83b58cea87e2a_fk_base_resourcebase_id FOREIGN KEY (resourcebase_ptr_id) REFERENCES base_resourcebase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: docum_content_type_id_be3cdaa70d32e64_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents_document
    ADD CONSTRAINT docum_content_type_id_be3cdaa70d32e64_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: e4b9f8b3aa7e2b739a85b466fc2c8c8f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY announcements_dismissal
    ADD CONSTRAINT e4b9f8b3aa7e2b739a85b466fc2c8c8f FOREIGN KEY (announcement_id) REFERENCES announcements_announcement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: e54e39f6aafd7fec50fd76ae95aedf8c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agon_ratings_rating
    ADD CONSTRAINT e54e39f6aafd7fec50fd76ae95aedf8c FOREIGN KEY (overall_rating_id) REFERENCES agon_ratings_overallrating(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ed9fd5eb4f62c9b049823c4a9799fadb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_grant
    ADD CONSTRAINT ed9fd5eb4f62c9b049823c4a9799fadb FOREIGN KEY (application_id) REFERENCES oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: efcd86ae6bfd7c65911f995bb6ed6b85; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_servicelayer
    ADD CONSTRAINT efcd86ae6bfd7c65911f995bb6ed6b85 FOREIGN KEY (service_id) REFERENCES services_service(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fb17b55a7581c3217c069e7606beb946; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY base_resourcebase
    ADD CONSTRAINT fb17b55a7581c3217c069e7606beb946 FOREIGN KEY (polymorphic_ctype_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: groups_grou_group_id_7947f328d9f6f1a1_fk_groups_groupprofile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupinvitation
    ADD CONSTRAINT groups_grou_group_id_7947f328d9f6f1a1_fk_groups_groupprofile_id FOREIGN KEY (group_id) REFERENCES groups_groupprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: groups_group_from_user_id_49b5e262c8ca9422_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupinvitation
    ADD CONSTRAINT groups_group_from_user_id_49b5e262c8ca9422_fk_people_profile_id FOREIGN KEY (from_user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: groups_group_group_id_c903953a048b4ae_fk_groups_groupprofile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupmember
    ADD CONSTRAINT groups_group_group_id_c903953a048b4ae_fk_groups_groupprofile_id FOREIGN KEY (group_id) REFERENCES groups_groupprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: groups_groupinvit_user_id_573b1b3475b95268_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupinvitation
    ADD CONSTRAINT groups_groupinvit_user_id_573b1b3475b95268_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: groups_groupmembe_user_id_4c016ad1f31d08e7_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupmember
    ADD CONSTRAINT groups_groupmembe_user_id_4c016ad1f31d08e7_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: groups_groupprofile_group_id_4de793b07f259dea_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_groupprofile
    ADD CONSTRAINT groups_groupprofile_group_id_4de793b07f259dea_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: guar_content_type_id_1d41cfa581d8d978_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_userobjectpermission
    ADD CONSTRAINT guar_content_type_id_1d41cfa581d8d978_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: guar_content_type_id_597c953df5d1232d_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_groupobjectpermission
    ADD CONSTRAINT guar_content_type_id_597c953df5d1232d_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: guardian_g_permission_id_6db56426ae60788a_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_groupobjectpermission
    ADD CONSTRAINT guardian_g_permission_id_6db56426ae60788a_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: guardian_groupobject_group_id_713e154dfd2f5937_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_groupobjectpermission
    ADD CONSTRAINT guardian_groupobject_group_id_713e154dfd2f5937_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: guardian_u_permission_id_2e655ff0bbafb1c1_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_userobjectpermission
    ADD CONSTRAINT guardian_u_permission_id_2e655ff0bbafb1c1_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: guardian_userobje_user_id_4727c7e419caead5_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY guardian_userobjectpermission
    ADD CONSTRAINT guardian_userobje_user_id_4727c7e419caead5_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: l_layer_id_2b0e96763e796a47_fk_layers_layer_resourcebase_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_attribute
    ADD CONSTRAINT l_layer_id_2b0e96763e796a47_fk_layers_layer_resourcebase_ptr_id FOREIGN KEY (layer_id) REFERENCES layers_layer(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: l_upload_session_id_2c18de1952dfdf82_fk_layers_uploadsession_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layer
    ADD CONSTRAINT l_upload_session_id_2c18de1952dfdf82_fk_layers_uploadsession_id FOREIGN KEY (upload_session_id) REFERENCES layers_uploadsession(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: l_upload_session_id_55fc511ff9172dc4_fk_layers_uploadsession_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layerfile
    ADD CONSTRAINT l_upload_session_id_55fc511ff9172dc4_fk_layers_uploadsession_id FOREIGN KEY (upload_session_id) REFERENCES layers_uploadsession(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: la_layer_id_fb1a8aaed1ff52e_fk_layers_layer_resourcebase_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layer_styles
    ADD CONSTRAINT la_layer_id_fb1a8aaed1ff52e_fk_layers_layer_resourcebase_ptr_id FOREIGN KEY (layer_id) REFERENCES layers_layer(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: la_resourcebase_ptr_id_55276820ef646366_fk_base_resourcebase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layer
    ADD CONSTRAINT la_resourcebase_ptr_id_55276820ef646366_fk_base_resourcebase_id FOREIGN KEY (resourcebase_ptr_id) REFERENCES base_resourcebase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: layers_lay_default_style_id_6f6c76540c9b39d2_fk_layers_style_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layer
    ADD CONSTRAINT layers_lay_default_style_id_6f6c76540c9b39d2_fk_layers_style_id FOREIGN KEY (default_style_id) REFERENCES layers_style(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: layers_layer_style_style_id_4d650d5f7607e6ce_fk_layers_style_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_layer_styles
    ADD CONSTRAINT layers_layer_style_style_id_4d650d5f7607e6ce_fk_layers_style_id FOREIGN KEY (style_id) REFERENCES layers_style(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: layers_uploadsess_user_id_622629ec01930897_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers_uploadsession
    ADD CONSTRAINT layers_uploadsess_user_id_622629ec01930897_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: map_resourcebase_ptr_id_a6ed5a62d49f3d0_fk_base_resourcebase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_map
    ADD CONSTRAINT map_resourcebase_ptr_id_a6ed5a62d49f3d0_fk_base_resourcebase_id FOREIGN KEY (resourcebase_ptr_id) REFERENCES base_resourcebase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maps_map_map_id_ddb6823378b3e35_fk_maps_map_resourcebase_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_maplayer
    ADD CONSTRAINT maps_map_map_id_ddb6823378b3e35_fk_maps_map_resourcebase_ptr_id FOREIGN KEY (map_id) REFERENCES maps_map(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maps_map_map_id_f5aeb9f66b255e9_fk_maps_map_resourcebase_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_mapsnapshot
    ADD CONSTRAINT maps_map_map_id_f5aeb9f66b255e9_fk_maps_map_resourcebase_ptr_id FOREIGN KEY (map_id) REFERENCES maps_map(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maps_mapsnapshot_user_id_313f9fc5c8ebddc9_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_mapsnapshot
    ADD CONSTRAINT maps_mapsnapshot_user_id_313f9fc5c8ebddc9_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_a_user_id_5e2f004fdebea22d_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_a_user_id_5e2f004fdebea22d_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_a_user_id_7fa13387c260b798_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_application
    ADD CONSTRAINT oauth2_provider_a_user_id_7fa13387c260b798_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_g_user_id_3111344894d452da_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_grant
    ADD CONSTRAINT oauth2_provider_g_user_id_3111344894d452da_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_r_user_id_3f695b639cfbc9a3_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_r_user_id_3f695b639cfbc9a3_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_pro_permission_id_605736edb0993afc_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_user_permissions
    ADD CONSTRAINT people_pro_permission_id_605736edb0993afc_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_profile_group_group_id_7d644aab0f8bb5fb_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_groups
    ADD CONSTRAINT people_profile_group_group_id_7d644aab0f8bb5fb_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_profile_profile_id_3004d22b1bcaf4eb_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_groups
    ADD CONSTRAINT people_profile_profile_id_3004d22b1bcaf4eb_fk_people_profile_id FOREIGN KEY (profile_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_profile_profile_id_5a430c62a6c13107_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people_profile_user_permissions
    ADD CONSTRAINT people_profile_profile_id_5a430c62a6c13107_fk_people_profile_id FOREIGN KEY (profile_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: se_layer_id_7a293bfa7e3fd1e_fk_layers_layer_resourcebase_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_servicelayer
    ADD CONSTRAINT se_layer_id_7a293bfa7e3fd1e_fk_layers_layer_resourcebase_ptr_id FOREIGN KEY (layer_id) REFERENCES layers_layer(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: se_resourcebase_ptr_id_2bff9b9b6b175ee6_fk_base_resourcebase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_service
    ADD CONSTRAINT se_resourcebase_ptr_id_2bff9b9b6b175ee6_fk_base_resourcebase_id FOREIGN KEY (resourcebase_ptr_id) REFERENCES base_resourcebase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: services_serv_profiles_id_3be6cb599d38d6e0_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services_serviceprofilerole
    ADD CONSTRAINT services_serv_profiles_id_3be6cb599d38d6e0_fk_people_profile_id FOREIGN KEY (profiles_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tagg_content_type_id_62e0524705c3ec8f_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggit_taggeditem
    ADD CONSTRAINT tagg_content_type_id_62e0524705c3ec8f_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem_tag_id_6318217c0d95e0d2_fk_taggit_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_tag_id_6318217c0d95e0d2_fk_taggit_tag_id FOREIGN KEY (tag_id) REFERENCES taggit_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tastypie_apikey_user_id_ffeb4840e0b406b_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tastypie_apikey
    ADD CONSTRAINT tastypie_apikey_user_id_ffeb4840e0b406b_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: u_layer_id_6346de911330a880_fk_layers_layer_resourcebase_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upload_upload
    ADD CONSTRAINT u_layer_id_6346de911330a880_fk_layers_layer_resourcebase_ptr_id FOREIGN KEY (layer_id) REFERENCES layers_layer(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: upload_upload_user_id_7fad116c8478bf31_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upload_upload
    ADD CONSTRAINT upload_upload_user_id_7fad116c8478bf31_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: upload_uploadfil_upload_id_21ef448d17dd4b6b_fk_upload_upload_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upload_uploadfile
    ADD CONSTRAINT upload_uploadfil_upload_id_21ef448d17dd4b6b_fk_upload_upload_id FOREIGN KEY (upload_id) REFERENCES upload_upload(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_mess_thread_id_2a39f32bdcb75b0e_fk_user_messages_thread_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_userthread
    ADD CONSTRAINT user_mess_thread_id_2a39f32bdcb75b0e_fk_user_messages_thread_id FOREIGN KEY (thread_id) REFERENCES user_messages_thread(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_mess_thread_id_335c99149db39253_fk_user_messages_thread_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_message
    ADD CONSTRAINT user_mess_thread_id_335c99149db39253_fk_user_messages_thread_id FOREIGN KEY (thread_id) REFERENCES user_messages_thread(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_messages_m_sender_id_7a21ec3698f782ba_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_message
    ADD CONSTRAINT user_messages_m_sender_id_7a21ec3698f782ba_fk_people_profile_id FOREIGN KEY (sender_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_messages_user_user_id_fadfb3cc476e7d3_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_messages_userthread
    ADD CONSTRAINT user_messages_user_user_id_fadfb3cc476e7d3_fk_people_profile_id FOREIGN KEY (user_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: w_layer_id_5e61fac9962837d1_fk_layers_layer_resourcebase_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_layerstats
    ADD CONSTRAINT w_layer_id_5e61fac9962837d1_fk_layers_layer_resourcebase_ptr_id FOREIGN KEY (layer_id) REFERENCES layers_layer(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wm_extr_map_id_3117ef4d5121641d_fk_maps_map_resourcebase_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_mapstats
    ADD CONSTRAINT wm_extr_map_id_3117ef4d5121641d_fk_maps_map_resourcebase_ptr_id FOREIGN KEY (map_id) REFERENCES maps_map(resourcebase_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wm_extra_endpoin_owner_id_44b616f09bc9d1b2_fk_people_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wm_extra_endpoint
    ADD CONSTRAINT wm_extra_endpoin_owner_id_44b616f09bc9d1b2_fk_people_profile_id FOREIGN KEY (owner_id) REFERENCES people_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

