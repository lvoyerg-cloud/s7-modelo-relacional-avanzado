CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE TYPE estado_edicion_enum AS ENUM ('PLANIFICACION', 'CONFIRMADO', 'EN_CURSO', 'FINALIZADO');
CREATE TYPE tipo_sesion_enum AS ENUM ('CHARLA', 'TALLER');
CREATE TYPE estado_inscripcion_enum AS ENUM ('CONFIRMADA', 'CANCELADA', 'EN_ESPERA');

CREATE TABLE sedes (
    id_sede INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL
);

CREATE TABLE salas (
    id_sala INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_sede INT NOT NULL REFERENCES sedes(id_sede) ON DELETE RESTRICT,
    nombre VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL CHECK (capacidad > 0),
    CONSTRAINT uq_sala_sede UNIQUE (id_sede, nombre)
);

CREATE TABLE ediciones (
    id_edicion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    anio INT NOT NULL CHECK (anio >= 2020),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado estado_edicion_enum NOT NULL DEFAULT 'PLANIFICACION',
    id_sede INT REFERENCES sedes(id_sede),
    CONSTRAINT chk_fechas_edicion CHECK (fecha_fin >= fecha_inicio)
);

CREATE TABLE personas (
    id_persona INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    pais VARCHAR(60) NOT NULL
);

CREATE TABLE participaciones_edicion (
    id_participacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_persona INT NOT NULL REFERENCES personas(id_persona),
    id_edicion INT NOT NULL REFERENCES ediciones(id_edicion),
    CONSTRAINT uq_persona_edicion UNIQUE (id_persona, id_edicion)
);

CREATE TABLE asistentes (
    id_participacion INT PRIMARY KEY REFERENCES participaciones_edicion(id_participacion) ON DELETE CASCADE,
    tipo_acreditacion VARCHAR(50) NOT NULL
);

CREATE TABLE ponentes (
    id_participacion INT PRIMARY KEY REFERENCES participaciones_edicion(id_participacion) ON DELETE CASCADE,
    biografia TEXT NOT NULL
);

CREATE TABLE sesiones (
    id_sesion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_edicion INT NOT NULL REFERENCES ediciones(id_edicion),
    id_sala INT REFERENCES salas(id_sala),
    titulo VARCHAR(150) NOT NULL,
    resumen TEXT NOT NULL,
    fecha_hora_inicio TIMESTAMP NOT NULL,
    fecha_hora_fin TIMESTAMP NOT NULL,
    tipo_sesion tipo_sesion_enum NOT NULL,
    minutos_preguntas INT,
    cupo_practico INT,
    requisitos_materiales TEXT,
    datos_transmision TEXT,
    CONSTRAINT chk_horario_valido CHECK (fecha_hora_fin > fecha_hora_inicio),
    CONSTRAINT chk_reglas_charla CHECK (
        tipo_sesion <> 'CHARLA' OR (minutos_preguntas IS NOT NULL AND minutos_preguntas >= 0)
    ),
    CONSTRAINT chk_reglas_taller CHECK (
        tipo_sesion <> 'TALLER' OR (cupo_practico IS NOT NULL AND cupo_practico > 0)
    ),
    CONSTRAINT ex_sala_solapamiento EXCLUDE USING gist (
        id_sala WITH =,
        tsrange(fecha_hora_inicio, fecha_hora_fin) WITH &&
    ) WHERE (id_sala IS NOT NULL)
);

CREATE TABLE prerrequisitos_sesion (
    id_sesion_dependiente INT NOT NULL REFERENCES sesiones(id_sesion) ON DELETE CASCADE,
    id_sesion_prerrequisito INT NOT NULL REFERENCES sesiones(id_sesion) ON DELETE CASCADE,
    PRIMARY KEY (id_sesion_dependiente, id_sesion_prerrequisito),
    CONSTRAINT chk_no_autorreferencia CHECK (id_sesion_dependiente <> id_sesion_prerrequisito)
);

CREATE TABLE inscripciones_sesion (
    id_inscripcion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_asistente INT NOT NULL REFERENCES asistentes(id_participacion) ON DELETE CASCADE,
    id_sesion INT NOT NULL REFERENCES sesiones(id_sesion) ON DELETE CASCADE,
    fecha_inscripcion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado estado_inscripcion_enum NOT NULL DEFAULT 'CONFIRMADA',
    asistio BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT uq_asistente_sesion UNIQUE (id_asistente, id_sesion)
);

CREATE TABLE asignaciones_ponentes (
    id_asignacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_ponente INT NOT NULL REFERENCES ponentes(id_participacion) ON DELETE CASCADE,
    id_sesion INT NOT NULL REFERENCES sesiones(id_sesion) ON DELETE CASCADE,
    rol_ponente VARCHAR(50) NOT NULL DEFAULT 'Expositor Principal',
    orden_aparicion INT NOT NULL CHECK (orden_aparicion > 0),
    CONSTRAINT uq_ponente_sesion UNIQUE (id_ponente, id_sesion),
    CONSTRAINT uq_orden_sesion UNIQUE (id_sesion, orden_aparicion)
);

CREATE TABLE empresas (
    id_empresa INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ruc_tax_id VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE acuerdos_patrocinio (
    id_acuerdo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_empresa INT NOT NULL REFERENCES empresas(id_empresa),
    id_edicion INT NOT NULL REFERENCES ediciones(id_edicion),
    categoria VARCHAR(50) NOT NULL,
    monto NUMERIC(12, 2) NOT NULL CHECK (monto > 0),
    fecha_confirmacion DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT uq_empresa_edicion UNIQUE (id_empresa, id_edicion)
);
