CREATE TABLE Type (
    type_id INTEGER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL
);

CREATE TABLE Status (
    status_id INTEGER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL
);

CREATE TABLE Organization (
    organization_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description CLOB,
    website_url VARCHAR2(255),
    founded_date DATE,
    headquarters_location VARCHAR2(100),
    contact_email VARCHAR2(100) NOT NULL,
    logo_image BLOB,
    open_source_policy CLOB,
    industry VARCHAR2(100)
);

CREATE TABLE Contributor (
    contributor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    full_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    expertise VARCHAR2(100),
    location VARCHAR2(100),
    join_date TIMESTAMP NOT NULL,
    total_contributions INTEGER DEFAULT 0 NOT NULL
);

CREATE TABLE Project (
    project_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    repository_url VARCHAR2(255) NOT NULL,
    primary_language VARCHAR2(50) NOT NULL,
    description CLOB,
    status_id INTEGER NOT NULL,
    creation_date TIMESTAMP NOT NULL,
    maintainer_id INTEGER NOT NULL,
    license_type VARCHAR2(100),
    CONSTRAINT fk_project_status FOREIGN KEY (status_id) REFERENCES Status(status_id),
    CONSTRAINT fk_project_maintainer FOREIGN KEY (maintainer_id) REFERENCES Contributor(contributor_id)
);

CREATE TABLE Technology (
    technology_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    type_id INTEGER NOT NULL,
    version VARCHAR2(50) NOT NULL,
    integration_date TIMESTAMP NOT NULL,
    dependency_status VARCHAR2(20) NOT NULL,
    maintenance_level VARCHAR2(20) NOT NULL,
    parent_technology_id INTEGER,
    CONSTRAINT fk_technology_type FOREIGN KEY (type_id) REFERENCES Type(type_id),
    CONSTRAINT fk_technology_parent FOREIGN KEY (parent_technology_id) REFERENCES Technology(technology_id)
);

CREATE TABLE Contribution (
    contribution_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    contributor_id INTEGER NOT NULL,
    project_id INTEGER NOT NULL,
    type VARCHAR2(50) NOT NULL,
    table_date TIMESTAMP NOT NULL,
    lines_of_code INTEGER,
    branch VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_contribution_contributor FOREIGN KEY (contributor_id) REFERENCES Contributor(contributor_id),
    CONSTRAINT fk_contribution_project FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

CREATE TABLE Issue (
    issue_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_id INTEGER NOT NULL,
    reporter_id INTEGER NOT NULL,
    assignee_id INTEGER,
    organization_id INTEGER,
    type_id INTEGER NOT NULL,
    status_id INTEGER NOT NULL,
    priority VARCHAR2(20),
    creation_date TIMESTAMP NOT NULL,
    resolution_date TIMESTAMP,
    complexity VARCHAR2(20),
    CONSTRAINT fk_issue_project FOREIGN KEY (project_id) REFERENCES Project(project_id),
    CONSTRAINT fk_issue_reporter FOREIGN KEY (reporter_id) REFERENCES Contributor(contributor_id),
    CONSTRAINT fk_issue_assignee FOREIGN KEY (assignee_id) REFERENCES Contributor(contributor_id),
    CONSTRAINT fk_issue_organization FOREIGN KEY (organization_id) REFERENCES Organization(organization_id),
    CONSTRAINT fk_issue_type FOREIGN KEY (type_id) REFERENCES Type(type_id),
    CONSTRAINT fk_issue_status FOREIGN KEY (status_id) REFERENCES Status(status_id),
    CONSTRAINT ck_issue_assignment CHECK (
        (assignee_id IS NULL AND organization_id IS NOT NULL) OR
        (assignee_id IS NOT NULL AND organization_id IS NULL) OR
        (assignee_id IS NULL AND organization_id IS NULL))
);

CREATE TABLE ProjectTechnology (
    project_id INTEGER,
    technology_id INTEGER,
    added_date TIMESTAMP NOT NULL,
    CONSTRAINT pk_project_technology PRIMARY KEY (project_id, technology_id),
    CONSTRAINT fk_pt_project FOREIGN KEY (project_id) REFERENCES Project(project_id),
    CONSTRAINT fk_pt_technology FOREIGN KEY (technology_id) REFERENCES Technology(technology_id)
);

CREATE TABLE Endorsement (
    endorsement_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    endorsed_id INTEGER NOT NULL,
    endorser_id INTEGER NOT NULL,
    skill VARCHAR2(50) NOT NULL,
    table_date TIMESTAMP NOT NULL,
    endorsement_level VARCHAR2(20) NOT NULL,
    project_context VARCHAR2(100),
    validation_type VARCHAR2(20),
    CONSTRAINT fk_endorsement_endorsed FOREIGN KEY (endorsed_id) REFERENCES Contributor(contributor_id),
    CONSTRAINT fk_endorsement_endorser FOREIGN KEY (endorser_id) REFERENCES Contributor(contributor_id)
);

CREATE TABLE ContributorOrganization (
    contributor_id INTEGER,
    organization_id INTEGER,
    role VARCHAR2(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    is_current NUMBER(1) DEFAULT 1,
    contribution_focus VARCHAR2(100),
    CONSTRAINT pk_contributor_org PRIMARY KEY (contributor_id, organization_id),
    CONSTRAINT fk_co_contributor FOREIGN KEY (contributor_id) REFERENCES Contributor(contributor_id),
    CONSTRAINT fk_co_organization FOREIGN KEY (organization_id) REFERENCES Organization(organization_id)
);

CREATE TABLE Mentorship (
    mentor_id INTEGER NOT NULL,
    mentee_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    focus_area VARCHAR2(100),
    CONSTRAINT pk_mentorship PRIMARY KEY (mentor_id, mentee_id, start_date),
    CONSTRAINT fk_mentorship_mentor FOREIGN KEY (mentor_id) REFERENCES Contributor(contributor_id),
    CONSTRAINT fk_mentorship_mentee FOREIGN KEY (mentee_id) REFERENCES Contributor(contributor_id),
    CONSTRAINT ck_mentorship_dates CHECK (end_date IS NULL OR end_date > start_date),
    CONSTRAINT ck_mentorship_not_self CHECK (mentor_id <> mentee_id)
);

CREATE TABLE ContributorHistory (
    history_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    contributor_id INTEGER NOT NULL,
    changed_attribute VARCHAR2(50) NOT NULL,
    old_value CLOB,
    new_value CLOB,
    change_date TIMESTAMP NOT NULL,
    changed_by INTEGER,  -- who made the change (another contributor or system)
    change_reason VARCHAR2(255),
    CONSTRAINT fk_contributor_history FOREIGN KEY (contributor_id) 
        REFERENCES Contributor(contributor_id),
    CONSTRAINT fk_changed_by_contributor FOREIGN KEY (changed_by) 
        REFERENCES Contributor(contributor_id)
);
