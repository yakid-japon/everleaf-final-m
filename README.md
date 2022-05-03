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



