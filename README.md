# Laboratorio Práctico: AI Agent Skills para Bases de Datos 🚀

Bienvenido al repositorio oficial del curso de LinkedIn Learning **AI agent skills para bases de datos** impartido por **Juanjo Luna**.

Este proyecto contiene un laboratorio de pruebas completamente aislado con **Microsoft SQL Server 2022** y la base de datos oficial **AdventureWorksLT**, preparado para que aprendas paso a paso a utilizar, crear y orquestar **Agent Skills** con Visual Studio Code y GitHub Copilot.

---

## 📋 Requisitos Previos

Antes de empezar, asegúrate de tener instalados en tu equipo o máquina virtual:
1. **[Visual Studio Code](https://code.visualstudio.com/)** (versión reciente).
2. **[Extensión oficial de GitHub Copilot y Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)** con sesión activa vinculada a tu cuenta de GitHub.
3. **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** (en Windows/macOS) o **Docker Engine** (en Linux) corriendo en segundo plano con soporte para WSL 2.
4. *(Recomendada)*: **[Extensión mssql para VS Code](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql)** para consultar directamente las tablas desde el editor.

---

## ⚡ Puesta en Marcha Rápida (3 Pasos)

### 1. Clona el repositorio y ábrelo en VS Code
Abre tu terminal favorita (PowerShell, Terminal o Git Bash) y ejecuta:
```bash
git clone https://github.com/lunasoft-learning/ai-agent-skills-database-lab.git
cd ai-agent-skills-database-lab
code .
```

### 2. Levanta el contenedor de base de datos con Docker
Toda la configuración del entorno viene lista de serie, por lo que no necesitas configurar archivos `.env` ni tocar variables intermedias. Abre la terminal integrada de VS Code (`Ctrl + \`` en Windows/Linux o `Cmd + \`` en macOS) y ejecuta:
```bash
docker compose up -d
```

Docker se encargará de descargar la imagen oficial de Microsoft SQL Server 2022, arrancar el contenedor en segundo plano y cargar automáticamente el esquema completo de **AdventureWorksLT** (`SalesLT`).

### 3. Conéctate a la base de datos desde VS Code
Para conectar en un solo paso sin tener que rellenar formularios interactivos:
1. Haz clic en el icono de **SQL Server** en la barra lateral izquierda de VS Code (extensión `mssql`).
2. Haz clic en el botón **Add Connection** (`+`).
3. Pega la cadena de conexión completa incluida en el archivo [`connection-string.txt`](connection-string.txt):
   ```text
   Server=localhost,1433;Database=AdventureWorksLT;User Id=sa;Password=SecretPassword123!;Encrypt=false;TrustServerCertificate=true;
   ```
4. Pulsa **Intro** dos veces para confirmar. En un segundo tendrás acceso directo a todas las tablas del laboratorio.

---

## 🧪 Verificación Inicial (Vídeo 01_02)

Para comprobar que el laboratorio está activo y responde con normalidad en el puerto `1433`:
1. Abre el archivo de prueba [`queries/01_verificar_conexion.sql`](queries/01_verificar_conexion.sql) en el editor.
2. Haz clic derecho y selecciona **Execute Query** (`Ctrl + Shift + E`).
3. Comprueba que el panel inferior muestra las tablas creadas (`Customer`, `Product`, `SalesOrderHeader`...) y los primeros cinco registros de clientes de prueba.

---

## 🛠️ Estructura del Repositorio

El proyecto está organizado siguiendo el orden progresivo del curso:

```text
├── .devcontainer/                  # Configuración opcional para entornos en contenedor
├── .github/
│   ├── agents/                     # Aquí crearás los agentes especializados en el Capítulo 05
│   └── skills/                     # Directorio de trabajo de tus Agent Skills
│       └── sql-database-assistant/ # Skill comunitario que exploramos en el Capítulo 03
├── connection-string.txt           # 🔑 Cadena de conexión directa para VS Code y otras herramientas
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
├── .env.example                    # Plantilla de referencia informativa de credenciales
└── README.md                       # Esta guía de uso
```

---

## 🗺️ Mapa de Ejercicios por Capítulo

| Capítulo | Qué hacemos en pantalla | Archivos implicados |
| :--- | :--- | :--- |
| **01. Entorno** | Clonamos el laboratorio, levantamos el contenedor en Docker y comprobamos la conexión. | `docker-compose.yml`, `connection-string.txt`, `queries/01_verificar_conexion.sql` |
| **02. Fundamentos** | Desglosamos la anatomía del estándar `SKILL.md` y su formato YAML frontmatter. | `.github/skills/sql-database-assistant/SKILL.md` |
| **03. Skills Comunitarios** | Instalamos y probamos el skill comunitario de inspección e introspección de esquemas. | `.github/skills/sql-database-assistant/` |
| **04. Skills Propios** | Creamos paso a paso los tres skills de rendimiento, documentación automática y guardarraíles de seguridad. | `.github/skills/` *(Soluciones en `soluciones/skills/`)* |
| **05. Agentes y Orquestación** | Definimos los roles de agentes especializados y resolvemos un caso de optimización de extremo a extremo. | `.github/agents/`, `queries/02_consulta_lenta.sql` |

---

## 🔄 Reset del Entorno

Si en cualquier momento deseas restablecer la base de datos a su estado original o borrar las tablas modificadas, ejecuta en la terminal integrada:

```bash
docker compose down -v
docker compose up -d
```

Esto eliminará el volumen de datos persistente y volverá a cargar el esquema limpio de AdventureWorksLT en pocos segundos.
