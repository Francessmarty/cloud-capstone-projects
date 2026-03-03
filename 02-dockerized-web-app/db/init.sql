CREATE TABLE IF NOT EXISTS inventory (
  id INT AUTO_INCREMENT PRIMARY KEY,
  item_name VARCHAR(100) NOT NULL,
  sku VARCHAR(50) NOT NULL,
  qty INT NOT NULL,
  location VARCHAR(50) NOT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO inventory (item_name, sku, qty, location) VALUES
('Latex Gloves', 'GLV-001', 120, 'WH-A1'),
('Face Masks', 'MSK-010', 300, 'WH-B2'),
('Rescue Kits', 'RKIT-600', 190, 'WH-C3'),
('Guaze', 'GZ-046', 100, 'WH-D4'),
('Plaster Band', 'PLB-051', 200, 'WH-E5'),
('Iodine', 'IO-400', 90, 'WH-F6'),
('Cotton Wool', 'CW-088', 180, 'WH-G7'),
('Sample Kits', 'KIT-200', 45, 'WH-H8');




