CREATE TABLE person (
    person_id                 RAW(16) DEFAULT sys_guid() PRIMARY KEY,
    person                    VARCHAR2(1000) NOT NULL,
    UNIQUE ( person ),
    -- Additional columns for note and dates
    note                    VARCHAR2(4000),  -- General-purpose note field
    date_created            TIMESTAMP(9) WITH TIME ZONE DEFAULT systimestamp(9) NOT NULL,
    date_updated            TIMESTAMP(9) WITH TIME ZONE,
        date_created_or_updated TIMESTAMP(9) WITH TIME ZONE GENERATED ALWAYS AS ( coalesce(date_updated, date_created) ) VIRTUAL
);

CREATE OR REPLACE TRIGGER trigger_set_date_updated_person BEFORE
    UPDATE ON person
    FOR EACH ROW
BEGIN
    :new.date_updated := systimestamp;
END;
/
CREATE TABLE course (
    course_id                 RAW(16) DEFAULT sys_guid() PRIMARY KEY,
    course_title                    VARCHAR2(1000) NOT NULL,
    UNIQUE ( course_title ),
    course varchar(4000) not null,
    -- Additional columns for note and dates
    note                    VARCHAR2(4000),  -- General-purpose note field
    date_created            TIMESTAMP(9) WITH TIME ZONE DEFAULT systimestamp(9) NOT NULL,
    date_updated            TIMESTAMP(9) WITH TIME ZONE,
        date_created_or_updated TIMESTAMP(9) WITH TIME ZONE GENERATED ALWAYS AS ( coalesce(date_updated, date_created) ) VIRTUAL
);

CREATE OR REPLACE TRIGGER trigger_set_date_updated_course BEFORE
    UPDATE ON course
    FOR EACH ROW
BEGIN
    :new.date_updated := systimestamp;
END;
/
CREATE TABLE assignment (
    assignment_id                 RAW(16) DEFAULT sys_guid() PRIMARY KEY,
    assignment                    VARCHAR2(1000) NOT NULL,
    UNIQUE ( assignment ),
    -- Additional columns for note and dates
    note                    VARCHAR2(4000),  -- General-purpose note field
    date_created            TIMESTAMP(9) WITH TIME ZONE DEFAULT systimestamp(9) NOT NULL,
    date_updated            TIMESTAMP(9) WITH TIME ZONE,
        date_created_or_updated TIMESTAMP(9) WITH TIME ZONE GENERATED ALWAYS AS ( coalesce(date_updated, date_created) ) VIRTUAL
);

CREATE OR REPLACE TRIGGER trigger_set_date_updated_assignment BEFORE
    UPDATE ON assignment
    FOR EACH ROW
BEGIN
    :new.date_updated := systimestamp;
END;
/
CREATE TABLE grade (
    grade_id                 RAW(16) DEFAULT sys_guid() PRIMARY KEY,
    grade                    VARCHAR2(1000) NOT NULL,
    UNIQUE ( grade ),
    assignment_id raw(16) references assignment(assignment_id),
    person_id raw(16) references person(person_id),
    -- Additional columns for note and dates
    note                    VARCHAR2(4000),  -- General-purpose note field
    date_created            TIMESTAMP(9) WITH TIME ZONE DEFAULT systimestamp(9) NOT NULL,
    date_updated            TIMESTAMP(9) WITH TIME ZONE,
        date_created_or_updated TIMESTAMP(9) WITH TIME ZONE GENERATED ALWAYS AS ( coalesce(date_updated, date_created) ) VIRTUAL
);

CREATE OR REPLACE TRIGGER trigger_set_date_updated_grade BEFORE
    UPDATE ON grade
    FOR EACH ROW
BEGIN
    :new.date_updated := systimestamp;
END;
/