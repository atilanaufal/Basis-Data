-- Tabel Audit Logs
CREATE TABLE IF NOT EXISTS audit_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(255),
    record_id INT,
    operation_type ENUM('INSERT', 'UPDATE', 'DELETE'),
    changed_by INT,
    role ENUM('admin', 'user'),
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_data JSON,
    new_data JSON
);
