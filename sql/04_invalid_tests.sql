INSERT INTO acuerdos_patrocinio (id_empresa, id_edicion, categoria, monto) VALUES (1, 1, 'SILVER', 1000.00);
INSERT INTO inscripciones_sesion (id_asistente, id_sesion) VALUES (2, 9999);
INSERT INTO acuerdos_patrocinio (id_empresa, id_edicion, categoria, monto) VALUES (2, 2, 'GOLD', -500.00);
INSERT INTO personas (nombre, email, pais) VALUES ('Juan Perez', NULL, 'Guatemala');
INSERT INTO prerrequisitos_sesion (id_sesion_dependiente, id_sesion_prerrequisito) VALUES (1, 1);
INSERT INTO sesiones (id_edicion, id_sala, titulo, resumen, fecha_hora_inicio, fecha_hora_fin, tipo_sesion, minutos_preguntas) VALUES (1, 1, 'Sesion Solapada', 'Test', '2026-10-10 09:30:00', '2026-10-10 10:30:00', 'CHARLA', 10);
