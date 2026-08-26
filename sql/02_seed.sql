INSERT INTO sedes (nombre, ciudad) VALUES ('Centro de Convenciones GT', 'Ciudad de Guatemala');
INSERT INTO salas (id_sede, nombre, capacidad) VALUES (1, 'Salon A', 100), (1, 'Salon B', 50);

INSERT INTO ediciones (nombre, anio, fecha_inicio, fecha_fin, estado, id_sede) 
VALUES ('ConectaTech 2026 Presencial', 2026, '2026-10-10', '2026-10-12', 'CONFIRMADO', 1),
       ('ConectaTech Virtual 2026', 2026, '2026-11-01', '2026-11-02', 'PLANIFICACION', NULL);

INSERT INTO personas (nombre, email, pais) VALUES
('Carlos Gomez', 'carlos@tech.com', 'Guatemala'),
('Ana Martinez', 'ana@tech.com', 'Mexico'),
('Luis Rodriguez', 'luis@tech.com', 'Costa Rica'),
('Maria Lopez', 'maria@tech.com', 'Guatemala'),
('Jorge Hernandez', 'jorge@tech.com', 'El Salvador'),
('Sofia Ruiz', 'sofia@tech.com', 'Colombia');

INSERT INTO participaciones_edicion (id_persona, id_edicion) VALUES 
(1, 1), (2, 1), (3, 1), (4, 1), (5, 2), (6, 2);

INSERT INTO ponentes (id_participacion, biografia) VALUES (1, 'Experto en IA'), (2, 'Arquitecta Cloud');
INSERT INTO asistentes (id_participacion, tipo_acreditacion) VALUES (2, 'VIP'), (3, 'Estudiante'), (4, 'General'), (5, 'Virtual'), (6, 'Virtual');

INSERT INTO sesiones (id_edicion, id_sala, titulo, resumen, fecha_hora_inicio, fecha_hora_fin, tipo_sesion, minutos_preguntas)
VALUES (1, 1, 'Keynote IA', 'Introduccion a Modelos LLM', '2026-10-10 09:00:00', '2026-10-10 10:30:00', 'CHARLA', 15);

INSERT INTO sesiones (id_edicion, id_sala, titulo, resumen, fecha_hora_inicio, fecha_hora_fin, tipo_sesion, cupo_practico, requisitos_materiales)
VALUES (1, 2, 'Taller Docker', 'Hands-on Containers', '2026-10-10 11:00:00', '2026-10-10 13:00:00', 'TALLER', 30, 'Laptop con Docker instalado');

INSERT INTO sesiones (id_edicion, id_sala, titulo, resumen, fecha_hora_inicio, fecha_hora_fin, tipo_sesion, minutos_preguntas)
VALUES (1, 1, 'Arquitectura SQL', 'PostgreSQL Avanzado', '2026-10-10 11:00:00', '2026-10-10 12:00:00', 'CHARLA', 10);

INSERT INTO sesiones (id_edicion, id_sala, titulo, resumen, fecha_hora_inicio, fecha_hora_fin, tipo_sesion, minutos_preguntas, datos_transmision)
VALUES (2, NULL, 'Serverless en 2026', 'Tendencias Cloud', '2026-11-01 14:00:00', '2026-11-01 15:00:00', 'CHARLA', 15, 'https://live.conectatech.com/s1');

INSERT INTO sesiones (id_edicion, id_sala, titulo, resumen, fecha_hora_inicio, fecha_hora_fin, tipo_sesion, cupo_practico, requisitos_materiales, datos_transmision)
VALUES (2, NULL, 'Taller Kubernetes', 'Orquestacion Practica', '2026-11-01 15:30:00', '2026-11-01 17:30:00', 'TALLER', 50, 'Kubectl CLI', 'https://live.conectatech.com/taller1');

INSERT INTO sesiones (id_edicion, id_sala, titulo, resumen, fecha_hora_inicio, fecha_hora_fin, tipo_sesion, minutos_preguntas)
VALUES (1, 2, 'Seguridad en APIs', 'OAuth2 y OIDC', '2026-10-10 14:00:00', '2026-10-10 15:00:00', 'CHARLA', 10);

INSERT INTO prerrequisitos_sesion (id_sesion_dependiente, id_sesion_prerrequisito) VALUES (3, 1);

INSERT INTO asignaciones_ponentes (id_ponente, id_sesion, rol_ponente, orden_aparicion) VALUES
(1, 1, 'Keynote Speaker', 1),
(2, 2, 'Instructor Principal', 1),
(2, 3, 'Co-Disertante', 1),
(1, 4, 'Expositor', 1);

INSERT INTO inscripciones_sesion (id_asistente, id_sesion, estado, asistio) VALUES
(2, 1, 'CONFIRMADA', TRUE),
(2, 2, 'CONFIRMADA', TRUE),
(3, 1, 'CONFIRMADA', TRUE),
(3, 3, 'CONFIRMADA', FALSE),
(4, 2, 'CONFIRMADA', TRUE),
(4, 6, 'CONFIRMADA', FALSE),
(5, 4, 'CONFIRMADA', TRUE),
(6, 5, 'CONFIRMADA', FALSE);

INSERT INTO empresas (nombre, ruc_tax_id) VALUES ('TechCorp', '1234567-8'), ('CloudSystems', '8765432-1');

INSERT INTO acuerdos_patrocinio (id_empresa, id_edicion, categoria, monto) VALUES
(1, 1, 'PLATINUM', 5000.00),
(2, 1, 'GOLD', 3000.00),
(1, 2, 'DIAMOND', 8000.00);
