# README

## DATABASE SCHEMA

### USER
| Column    | Description|
|-----------|------------|
| name      | string     |
| email     | string     |
| password  | string     |
| is_admin  | boolean    |

### TAG
| Column    | Description|
|-----------|------------|
| name      | string     |

### TASK
| Column    | Description|
|-----------|------------|
| name      | string     |
| status    | string     |
| content   | string     |
| deadline  | date       |
| priority  | string     |
| user_id   | FK         |

### TAG_TASK
| Column    | Description|
|-----------|------------|
| tag_id    | FK         |
| task_id   | FK         |

## DEPLOYMENT
* heroku login (login to herohu)
* heroku create everyleaf-exam (create an heroku app)
* heroku stack:set heroku-18 (switch to stack heroku-18)
* git add -A
* git commit -m "message"
* git push heroku step2:master (make deploy)
* heroku run rails db:migrate (make migration)


