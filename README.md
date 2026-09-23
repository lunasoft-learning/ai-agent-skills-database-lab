# Laboratorio Práctico: AI Agent Skills para Bases de Datos 🚀

Bienvenido al repositorio oficial del curso de LinkedIn Learning **AI agent skills para bases de datos (Curso 4679019)** impartido por **Juanjo Luna**.

Este proyecto contiene un laboratorio de pruebas completamente aislado con **Microsoft SQL Server 2022** y la base de datos oficial **AdventureWorksLT**, preparado para que aprendas paso a paso a utilizar, crear y orquestar **Agent Skills** con Visual Studio Code y GitHub Copilot.

---

## 📋 Requisitos Previos

Antes de empezar, asegúrate de tener instalados en tu equipo o máquina virtual:
1. **[Visual Studio Code](https://code.visualstudio.com/)** (versión reciente).
2. **[Extensión de GitHub Copilot y Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)** con sesión activa.
3. **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** (en Windows/macOS) o **Docker Engine** (en Linux) corriendo en segundo plano.
4. *(Recomendada)*: **[Extensión mssql para VS Code](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql)** para consultar directamente las tablas desde el editor.

---

## ⚡ Puesta en Marcha Rápida (3 Pasos)

### 1. Clona el repositorio y ábrelo en VS Code
```bash
git clone https://github.com/tu-usuario/ai-agent-skills-database-lab.git
cd ai-agent-skills-database-lab
code .
```

### 2. Configura las variables de entorno
Copia la plantilla de ejemplo `.env.example` en un nuevo archivo llamado `.env`:
```bash
cp .env.example .env
```
*(Los parámetros por defecto apuntan a tu contenedor local en el puerto `1433` con el usuario `sa` y la contraseña `SecretPassword123!`)*.

### 3. Levanta la base de datos con Docker
Abre la terminal integrada en VS Code (`Ctrl + \`` o `Cmd + \``) y ejecuta:
```bash
docker compose up -d
```

Docker descargará la imagen oficial de Microsoft SQL Server 2022, levantará el contenedor y ejecutará automáticamente la carga de la base de datos **AdventureWorksLT** (`SalesLT`).

---

## 🧪 Verificación Inicial (Vídeo 01_02)

Para comprobar que el laboratorio está activo y responde en el puerto `1433`:
1. Abre el archivo [`queries/01_verificar_conexion.sql`](queries/01_verificar_conexion.sql).
2. Ejecuta la consulta usando la extensión **mssql** o conéctate con tus credenciales:
   - **Servidor**: `localhost,1433`
   - **Base de datos**: `AdventureWorksLT`
   - **Usuario**: `sa`
   - **Contraseña**: `SecretPassword123!`
3. Deberás ver las tablas del esquema `SalesLT` y los primeros registros de clientes.

---

## 🛠️ Estructura del Repositorio (Modo de Aprendizaje Progresivo)

El proyecto está organizado para que construyas las habilidades a lo largo de los vídeos:

```text
├── .devcontainer/                  # Configuración opcional para entornos en contenedor
├── .github/
│   ├── agents/                     # Aquí crearás los agentes especializados en el Capítulo 05
│   └── skills/                     # Directorio de trabajo de tus Agent Skills
│       └── sql-database-assistant/ # Skill comunitario que exploramos en el Capítulo 03
├── database/
│   └── init-adventureworkslt.sql   # Script T-SQL con el esquema oficial AdventureWorksLT
├── docker-compose.yml              # Orquestación de SQL Server 2022 y carga automática
├── queries/                        # Consultas de soporte para los ejercicios del curso
│   ├── 01_verificar_conexion.sql   # Comprobación inicial de tablas y clientes (Cap. 01)
│   ├── 02_consulta_lenta.sql       # Caso práctico de optimización con estadísticas (Cap. 04 y 05)
│   └── 03_pruebas_seguridad.sql    # Sentencias para poner a prueba los guardarraíles (Cap. 04)
├── soluciones/                     # 📂 Soluciones de referencia por si te quedas atascado
│   ├── skills/                     # Código final de los 3 skills creados en el Capítulo 04
│   │   ├── sql-query-optimizer/
│   │   ├── db-schema-documenter/
│   │   └── sql-safety-guardrails/
│   └── agents/                     # Definiciones finales de los 2 agentes del Capítulo 05
│       ├── dba-performance.agent.md
│       └── db-documenter.agent.md
├── .env.example                    # Plantilla de conexión
└── README.md                       # Esta guía
```

---

## 🗺️ Mapa de Ejercicios por Capítulo

| Capítulo | Qué hacemos en pantalla | Archivos implicados |
| :--- | :--- | :--- |
| **01. Entorno** | Levantamos el contenedor y comprobamos la conexión. | `docker-compose.yml`, `queries/01_verificar_conexion.sql` |
| **02. Fundamentos** | Desglosamos la anatomía del estándar `SKILL.md`. | `.github/skills/sql-database-assistant/SKILL.md` |
| **03. Skills Comunitarios** | Instalamos y probamos el skill comunitario de inspección. | `.github/skills/sql-database-assistant/`, `.env` |
| **04. Skills Propios** | Creamos paso a paso los 3 skills de rendimiento, documentación y seguridad. | `.github/skills/` *(Referencia en `soluciones/skills/`)* |
| **05. Agentes y Orquestación** | Definimos los roles de agentes y resolvemos un caso de extremo a extremo. | `.github/agents/`, `queries/02_consulta_lenta.sql` |
