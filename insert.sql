INSERT INTO Type (type_id, name) VALUES (1, 'Programming Language');
INSERT INTO Type (type_id, name) VALUES (2, 'Framework');
INSERT INTO Type (type_id, name) VALUES (3, 'Database');
INSERT INTO Type (type_id, name) VALUES (4, 'DevOps Tool');
INSERT INTO Type (type_id, name) VALUES (5, 'Testing Framework');

INSERT INTO Status (status_id, name) VALUES (1, 'Active');
INSERT INTO Status (status_id, name) VALUES (2, 'Inactive');
INSERT INTO Status (status_id, name) VALUES (3, 'Archived');
INSERT INTO Status (status_id, name) VALUES (4, 'Beta');
INSERT INTO Status (status_id, name) VALUES (5, 'Deprecated');

INSERT INTO Organization (name, description, website_url, founded_date, headquarters_location, contact_email, open_source_policy, industry)
VALUES ('OpenTech Foundation', 'Non-profit supporting open source initiatives', 'https://opentech.org', TO_DATE('2010-05-15', 'YYYY-MM-DD'), 'San Francisco, CA', 'contact@opentech.org', 'All projects must be Apache 2.0 licensed', 'Technology');

INSERT INTO Organization (name, description, website_url, founded_date, headquarters_location, contact_email, open_source_policy, industry)
VALUES ('DataScience Corp', 'Enterprise AI solutions provider', 'https://datascience.com', TO_DATE('2015-11-20', 'YYYY-MM-DD'), 'New York, NY', 'info@datascience.com', 'Selective open sourcing with commercial licenses', 'Artificial Intelligence');

INSERT INTO Organization (name, description, website_url, founded_date, headquarters_location, contact_email, open_source_policy, industry)
VALUES ('CloudNative Inc', 'Cloud infrastructure specialists', 'https://cloudnative.io', TO_DATE('2018-03-10', 'YYYY-MM-DD'), 'Seattle, WA', 'hello@cloudnative.io', 'All core infrastructure is open source', 'Cloud Computing');

INSERT INTO Organization (name, description, website_url, founded_date, headquarters_location, contact_email, open_source_policy, industry)
VALUES ('DevTools LLC', 'Developer productivity tools', 'https://devtools.dev', TO_DATE('2012-07-04', 'YYYY-MM-DD'), 'Austin, TX', 'support@devtools.dev', 'Community edition is MIT licensed', 'Software Development');

INSERT INTO Organization (name, description, website_url, founded_date, headquarters_location, contact_email, open_source_policy, industry)
VALUES ('OpenAI Research', 'AI research collective', 'https://openairesearch.org', TO_DATE('2019-01-30', 'YYYY-MM-DD'), 'Remote', 'research@openairesearch.org', 'All research code is BSD licensed', 'Machine Learning');

INSERT INTO Contributor (username, full_name, email, expertise, location, join_date, total_contributions)
VALUES ('johndoe', 'John Doe', 'john.doe@email.com', 'Backend Development', 'San Francisco, CA', TIMESTAMP '2018-05-10 09:15:22', 42);

INSERT INTO Contributor (username, full_name, email, expertise, location, join_date, total_contributions)
VALUES ('alicesmith', 'Alice Smith', 'alice.smith@email.com', 'Data Science', 'New York, NY', TIMESTAMP '2019-02-15 14:30:10', 28);

INSERT INTO Contributor (username, full_name, email, expertise, location, join_date, total_contributions)
VALUES ('bobjohnson', 'Bob Johnson', 'bob.johnson@email.com', 'DevOps', 'Austin, TX', TIMESTAMP '2017-11-03 11:45:33', 65);

INSERT INTO Contributor (username, full_name, email, expertise, location, join_date, total_contributions)
VALUES ('sarahlee', 'Sarah Lee', 'sarah.lee@email.com', 'Frontend Development', 'Chicago, IL', TIMESTAMP '2020-06-22 16:20:05', 19);

INSERT INTO Contributor (username, full_name, email, expertise, location, join_date, total_contributions)
VALUES ('mikechen', 'Mike Chen', 'mike.chen@email.com', 'Machine Learning', 'Seattle, WA', TIMESTAMP '2016-08-14 10:10:10', 87);

INSERT INTO Project (name, repository_url, primary_language, description, status_id, creation_date, maintainer_id, license_type)
VALUES ('OpenDB', 'https://github.com/opentech/opendb', 'Java', 'Distributed database system', 1, TIMESTAMP '2019-03-15 10:00:00', 1, 'Apache 2.0');

INSERT INTO Project (name, repository_url, primary_language, description, status_id, creation_date, maintainer_id, license_type)
VALUES ('DataVis', 'https://github.com/datascience/datavis', 'Python', 'Data visualization toolkit', 1, TIMESTAMP '2020-07-22 14:30:00', 2, 'MIT');

INSERT INTO Project (name, repository_url, primary_language, description, status_id, creation_date, maintainer_id, license_type)
VALUES ('CloudDeploy', 'https://github.com/cloudnative/deploy', 'Go', 'Cloud deployment automation', 4, TIMESTAMP '2021-01-10 09:15:00', 3, 'GPLv3');

INSERT INTO Project (name, repository_url, primary_language, description, status_id, creation_date, maintainer_id, license_type)
VALUES ('DevHelper', 'https://github.com/devtools/helper', 'JavaScript', 'Developer productivity tools', 1, TIMESTAMP '2018-05-05 11:20:00', 4, 'MIT');

INSERT INTO Project (name, repository_url, primary_language, description, status_id, creation_date, maintainer_id, license_type)
VALUES ('AILib', 'https://github.com/openai/ailib', 'Python', 'Machine learning library', 1, TIMESTAMP '2017-09-30 16:45:00', 5, 'BSD');

INSERT INTO Technology (name, type_id, version, integration_date, dependency_status, maintenance_level, parent_technology_id)
VALUES ('Python', 1, '3.9', TIMESTAMP '2020-10-05 00:00:00', 'Core', 'Active', NULL);

INSERT INTO Technology (name, type_id, version, integration_date, dependency_status, maintenance_level, parent_technology_id)
VALUES ('Django', 2, '4.0', TIMESTAMP '2021-12-07 00:00:00', 'Optional', 'Active', 1);

INSERT INTO Technology (name, type_id, version, integration_date, dependency_status, maintenance_level, parent_technology_id)
VALUES ('PostgreSQL', 3, '14', TIMESTAMP '2021-09-30 00:00:00', 'Core', 'Active', NULL);

INSERT INTO Technology (name, type_id, version, integration_date, dependency_status, maintenance_level, parent_technology_id)
VALUES ('Docker', 4, '20.10', TIMESTAMP '2020-12-08 00:00:00', 'Optional', 'Active', NULL);

INSERT INTO Technology (name, type_id, version, integration_date, dependency_status, maintenance_level, parent_technology_id)
VALUES ('pytest', 5, '7.0', TIMESTAMP '2022-01-15 00:00:00', 'Optional', 'Active', 1);

INSERT INTO Contribution (contributor_id, project_id, type, table_date, lines_of_code, branch)
VALUES (1, 1, 'Code', TIMESTAMP '2022-01-10 14:30:00', 250, 'main');

INSERT INTO Contribution (contributor_id, project_id, type, table_date, lines_of_code, branch)
VALUES (2, 2, 'Documentation', TIMESTAMP '2022-02-15 10:15:00', 0, 'docs-update');

INSERT INTO Contribution (contributor_id, project_id, type, table_date, lines_of_code, branch)
VALUES (3, 3, 'Code', TIMESTAMP '2022-03-05 16:45:00', 180, 'feature/deploy');

INSERT INTO Contribution (contributor_id, project_id, type, table_date, lines_of_code, branch)
VALUES (4, 4, 'Bug Fix', TIMESTAMP '2022-01-22 11:20:00', 75, 'hotfix/issue-42');

INSERT INTO Contribution (contributor_id, project_id, type, table_date, lines_of_code, branch)
VALUES (5, 5, 'Feature', TIMESTAMP '2022-02-28 09:30:00', 320, 'feature/ml-algo');

INSERT INTO Issue (project_id, reporter_id, assignee_id, organization_id, type_id, status_id, priority, creation_date, resolution_date, complexity)
VALUES (1, 2, 1, NULL, 1, 1, 'High', TIMESTAMP '2022-01-05 10:00:00', TIMESTAMP '2022-01-07 14:30:00', 'Medium');

INSERT INTO Issue (project_id, reporter_id, assignee_id, organization_id, type_id, status_id, priority, creation_date, resolution_date, complexity)
VALUES (2, 3, NULL, 2, 2, 1, 'Medium', TIMESTAMP '2022-02-10 14:15:00', NULL, 'High');

INSERT INTO Issue (project_id, reporter_id, assignee_id, organization_id, type_id, status_id, priority, creation_date, resolution_date, complexity)
VALUES (3, 1, 3, NULL, 3, 2, 'Low', TIMESTAMP '2022-01-15 11:30:00', TIMESTAMP '2022-01-20 09:45:00', 'Low');

INSERT INTO Issue (project_id, reporter_id, assignee_id, organization_id, type_id, status_id, priority, creation_date, resolution_date, complexity)
VALUES (4, 5, 4, NULL, 1, 1, 'Critical', TIMESTAMP '2022-03-01 16:20:00', NULL, 'High');

INSERT INTO Issue (project_id, reporter_id, assignee_id, organization_id, type_id, status_id, priority, creation_date, resolution_date, complexity)
VALUES (5, 4, NULL, 5, 4, 1, 'Medium', TIMESTAMP '2022-02-18 09:10:00', TIMESTAMP '2022-02-20 14:00:00', 'Medium');

INSERT INTO ProjectTechnology (project_id, technology_id, added_date)
VALUES (1, 3, TIMESTAMP '2019-04-01 00:00:00');

INSERT INTO ProjectTechnology (project_id, technology_id, added_date)
VALUES (2, 1, TIMESTAMP '2020-08-01 00:00:00');

INSERT INTO ProjectTechnology (project_id, technology_id, added_date)
VALUES (2, 2, TIMESTAMP '2020-08-15 00:00:00');

INSERT INTO ProjectTechnology (project_id, technology_id, added_date)
VALUES (3, 4, TIMESTAMP '2021-02-10 00:00:00');

INSERT INTO ProjectTechnology (project_id, technology_id, added_date)
VALUES (5, 1, TIMESTAMP '2017-10-15 00:00:00');

INSERT INTO Endorsement (endorsed_id, endorser_id, skill, table_date, endorsement_level, project_context, validation_type)
VALUES (1, 2, 'Java', TIMESTAMP '2022-01-15 10:00:00', 'Expert', 'OpenDB', 'Peer');

INSERT INTO Endorsement (endorsed_id, endorser_id, skill, table_date, endorsement_level, project_context, validation_type)
VALUES (2, 1, 'Data Analysis', TIMESTAMP '2022-02-20 14:30:00', 'Advanced', 'DataVis', 'Peer');

INSERT INTO Endorsement (endorsed_id, endorser_id, skill, table_date, endorsement_level, project_context, validation_type)
VALUES (3, 4, 'Cloud Architecture', TIMESTAMP '2022-01-28 11:15:00', 'Expert', 'CloudDeploy', 'Project');

INSERT INTO Endorsement (endorsed_id, endorser_id, skill, table_date, endorsement_level, project_context, validation_type)
VALUES (4, 5, 'JavaScript', TIMESTAMP '2022-03-05 09:45:00', 'Intermediate', 'DevHelper', 'Peer');

INSERT INTO Endorsement (endorsed_id, endorser_id, skill, table_date, endorsement_level, project_context, validation_type)
VALUES (5, 3, 'Machine Learning', TIMESTAMP '2022-02-10 16:20:00', 'Expert', 'AILib', 'Project');

INSERT INTO ContributorOrganization (contributor_id, organization_id, role, start_date, end_date, is_current, contribution_focus)
VALUES (1, 1, 'Lead Developer', DATE '2019-01-15', NULL, 1, 'Database Systems');

INSERT INTO ContributorOrganization (contributor_id, organization_id, role, start_date, end_date, is_current, contribution_focus)
VALUES (2, 2, 'Data Scientist', DATE '2020-03-10', NULL, 1, 'Visualization');

INSERT INTO ContributorOrganization (contributor_id, organization_id, role, start_date, end_date, is_current, contribution_focus)
VALUES (3, 3, 'DevOps Engineer', DATE '2018-05-20', DATE '2021-12-31', 0, 'Cloud Infrastructure');

INSERT INTO ContributorOrganization (contributor_id, organization_id, role, start_date, end_date, is_current, contribution_focus)
VALUES (4, 4, 'Frontend Developer', DATE '2019-11-05', NULL, 1, 'UI Components');

INSERT INTO ContributorOrganization (contributor_id, organization_id, role, start_date, end_date, is_current, contribution_focus)
VALUES (5, 5, 'Research Scientist', DATE '2017-09-01', NULL, 1, 'AI Algorithms');

INSERT INTO Mentorship (mentor_id, mentee_id, start_date, end_date, focus_area)
VALUES (1, 4, DATE '2021-06-01', DATE '2021-12-31', 'Backend Development');

INSERT INTO Mentorship (mentor_id, mentee_id, start_date, end_date, focus_area)
VALUES (2, 3, DATE '2022-01-15', NULL, 'Data Engineering');

INSERT INTO Mentorship (mentor_id, mentee_id, start_date, end_date, focus_area)
VALUES (3, 5, DATE '2021-09-10', DATE '2022-03-10', 'Cloud Deployment');

INSERT INTO Mentorship (mentor_id, mentee_id, start_date, end_date, focus_area)
VALUES (4, 2, DATE '2022-02-01', NULL, 'Fullstack Development');

INSERT INTO Mentorship (mentor_id, mentee_id, start_date, end_date, focus_area)
VALUES (5, 1, DATE '2021-11-15', DATE '2022-05-15', 'Machine Learning');

INSERT INTO ContributorHistory (contributor_id, changed_attribute, old_value, new_value, change_date, changed_by, change_reason)
VALUES (1, 'username', 'johndoe_old', 'johndoe', TIMESTAMP '2022-03-15 14:22:10', 3, 'Standardized username format');

INSERT INTO ContributorHistory (contributor_id, changed_attribute, old_value, new_value, change_date, changed_by, change_reason)
VALUES (2, 'email', 'alice.smith@oldmail.com', 'alice.smith@email.com', TIMESTAMP '2022-04-02 09:15:33', 2, 'Changed to organization email');

INSERT INTO ContributorHistory (contributor_id, changed_attribute, old_value, new_value, change_date, changed_by, change_reason)
VALUES (3, 'location', 'Boston, MA', 'Austin, TX', TIMESTAMP '2022-01-10 16:45:21', 3, 'Contributor relocated');

INSERT INTO ContributorHistory (contributor_id, changed_attribute, old_value, new_value, change_date, changed_by, change_reason)
VALUES (4, 'expertise', 'UI Development', 'Frontend Development', TIMESTAMP '2022-05-20 11:30:45', 1, 'Broadened expertise description');

INSERT INTO ContributorHistory (contributor_id, changed_attribute, old_value, new_value, change_date, changed_by, change_reason)
VALUES (5, 'full_name', 'Michael Chen', 'Mike Chen', TIMESTAMP '2022-02-28 13:10:18', 5, 'Preferred name update');
