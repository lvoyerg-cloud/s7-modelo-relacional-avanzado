SELECT e.nombre AS edicion, s.titulo AS sesion, s.tipo_sesion, COALESCE(sa.nombre, 'VIRTUAL') AS sala, s.fecha_hora_inicio, s.fecha_hora_fin
FROM sesiones s JOIN ediciones e ON s.id_edicion = e.id_edicion LEFT JOIN salas sa ON s.id_sala = sa.id_sala ORDER BY s.fecha_hora_inicio;

SELECT s.titulo AS taller, s.cupo_practico AS cupo_maximo, COUNT(i.id_inscripcion) AS total_inscritos, (s.cupo_practico - COUNT(i.id_inscripcion)) AS cupos_disponibles
FROM sesiones s LEFT JOIN inscripciones_sesion i ON s.id_sesion = i.id_sesion WHERE s.tipo_sesion = 'TALLER' GROUP BY s.id_sesion, s.titulo, s.cupo_practico;

SELECT p.nombre AS ponente, s.titulo AS sesion, ap.rol_ponente, ap.orden_aparicion
FROM asignaciones_ponentes ap JOIN ponentes po ON ap.id_ponente = po.id_participacion JOIN participaciones_edicion pe ON po.id_participacion = pe.id_participacion JOIN personas p ON pe.id_persona = p.id_persona JOIN sesiones s ON ap.id_sesion = s.id_sesion ORDER BY s.id_sesion, ap.orden_aparicion;
