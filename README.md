# Modelo Relacional Avanzado - ConectaTech

**Universidad Mariano Gálvez de Guatemala**  
**Facultad de Ingeniería en Sistemas**  

Este repositorio contiene la implementación del modelo de base de datos relacional en PostgreSQL para la gestión del evento **ConectaTech**, incluyendo esquemas, scripts de datos de prueba (`seed`) y consultas de reporte.

---

## 📊 Modelo Conceptual

```mermaid
erDiagram
    CONFERENCIA ||--|{ EDICION : tiene
    EDICION ||--|{ SESION : incluye
    SESION ||--|{ PONENTE_SESION : asigna
    PONENTE ||--|{ PONENTE_SESION : participa
    SESION ||--o| SALA : ubica
    PARTICIPANTE ||--|{ INSCRIPCION : realiza
    EDICION ||--|{ INSCRIPCION : registra

    CONFERENCIA {
        int id PK
        string nombre
    }
    EDICION {
        int id PK
        int ano
        string ciudad
    }
    SESION {
        int id PK
        string titulo
        string tipo
    }
    PONENTE {
        int id PK
        string nombre
        string email
    }
    PARTICIPANTE {
        int id PK
        string nombre
        string email
    }
```

---

## 📐 Modelo Lógico

```mermaid
erDiagram
    ediciones_conferencia ||--|{ sesiones : "1 a N"
    salas ||--o{ sesiones : "0 a N"
    sesiones ||--|{ sesiones_ponentes : "1 a N"
    ponentes ||--|{ sesiones_ponentes : "1 a N"
    ediciones_conferencia ||--|{ inscripciones : "1 a N"
    participantes ||--|{ inscripciones : "1 a N"

    ediciones_conferencia {
        int id_edicion PK
        string nombre_edicion
        date fecha_inicio
    }
    sesiones {
        int id_sesion PK
        int id_edicion FK
        string titulo_sesion
    }
    ponentes {
        int id_ponente PK
        string nombre_completo
    }
    sesiones_ponentes {
        int id_sesion FK
        int id_ponente FK
        string rol_ponente
    }
```

---

## 🛠️ Estructura del Proyecto

* `sql/01_schema.sql`: Creación de tablas, tipos ENUM y restricciones de integridad.
* `sql/02_seed.sql`: Inserción de datos de prueba.
* `sql/03_queries.sql`: Consultas SQL para reportes y métricas.
* `sql/04_invalid_tests.sql`: Pruebas de validación y restricciones.
* `compose.yaml`: Configuración de Docker Compose para PostgreSQL.

---

## 🚀 Ejecución con Docker y PostgreSQL

Para recrear la base de datos y ejecutar el proyecto en tu entorno local:

```bash
# 1. Reiniciar base de datos
docker exec -i conectatech_db psql -U admin -d postgres -c "DROP DATABASE conectatech WITH (FORCE);"
docker exec -i conectatech_db psql -U admin -d postgres -c "CREATE DATABASE conectatech;"

# 2. Cargar esquema y datos iniciales
Get-Content sql/01_schema.sql -Encoding UTF8 | docker exec -i conectatech_db psql -U admin -d conectatech
Get-Content sql/02_seed.sql -Encoding UTF8 | docker exec -i conectatech_db psql -U admin -d conectatech

# 3. Ejecutar consultas
Get-Content sql/03_queries.sql -Encoding UTF8 | docker exec -i conectatech_db psql -U admin -d conectatech
```
