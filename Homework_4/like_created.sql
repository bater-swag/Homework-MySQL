USE vk;

-- ������ ������� like
CREATE TABLE like_info (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
  id_like INT UNSIGNED NOT NULL COMMENT "������ �� ����",
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������",
  media_type_id INT UNSIGNED NOT NULL COMMENT "������ �� ��� ��������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "����� �������������";

-- ������ ������� post ����������
CREATE TABLE post_info (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������",
  post_id INT UNSIGNED NOT NULL COMMENT "������ �� ����",
  id_like INT UNSIGNED NOT NULL COMMENT "������ �� ����",
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������",
  media_type_id INT UNSIGNED NOT NULL COMMENT "������ �� ��� ��������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "���� ����������";