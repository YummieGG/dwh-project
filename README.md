# DWH Project

## Project Description

**DWH Project** is a comprehensive **Data Warehouse** solution designed to consolidate, clean, and integrate disparate data from **CRM** and **ERP** systems into a centralized analytical platform. Built from scratch using **PostgreSQL and PL/pgSQL**, this project transforms raw, messy transactional records into structured, business-ready data models optimized for Business Intelligence (BI) and reporting..

### What is This?

A modern data warehouse system built with **PL/pgSQL** that enables organizations to:
- **Consolidate** data from diverse data sources
- **Transform** raw data into meaningful business insights
- **Store** structured data in an optimized format for analytics
- **Query** data efficiently for business intelligence and reporting

### What We Do

We provide:
- **Medallion Architecture** - Implemented structured data progression across **Bronze (Raw)**, **Silver (Cleansed)**, and **Gold (Analytics-Ready)** layers.
- **Data Transformation & Cleansing** - Handled null values, standardized codes, resolved overlapping historical dates (**Slowly Changing Dimensions - SCD**), and performed deduplication using **Window Functions**.
- **Dimensional Modeling** - Designed a scalable **Star Schema** with robust Fact and Dimension tables utilizing system-generated **Surrogate Keys**.
- **Automated ETL/ELT Pipelines** - Developed idempotent **PL/pgSQL Stored Procedures** with comprehensive error handling (`EXCEPTION` blocks) and load duration monitoring.
- **Data Quality Assurance** - Formulated automated SQL test validation scripts to enforce primary key uniqueness and referential integrity.

---

## Project Overview

The DWH Project follows a modular architecture composed of:

### Directory Structure

```
dwh-project/
├── docs/                    # Project documentation and diagrams
├── datasets/               # Sample and raw datasets
├── scripts/                # ETL and database scripts
├── tests/                  # Test cases and validations
├── LICENSE                 # MIT License
└── README.md              # This file
```

### Key Components

- **docs/** - Architecture diagrams, data models, and integration workflows
- **datasets/** - Sample data and staging areas
- **scripts/** - PL/pgSQL scripts for data transformation and loading
- **tests/** - Data validation and quality tests

---

## Data Architecture

### System Architecture

The high-level architecture illustrating data extraction, multi-layer processing in PostgreSQL, and analytics consumption:

![Architecture Diagram](docs/Architecture.png)

### Data Flow & Lineage

The lineage diagram mapping how data transforms and flows from raw source files to final analytical views:

![Data Flow Diagram](docs/Data%20Flow.png)

### Data Integration Pattern

The integration model demonstrating how customer and product records from separate CRM and ERP systems are merged:

![Data Integration Diagram](docs/Data%20Intregration.png)

### Data Model (Star Schema)

The logical data model optimized for ad-hoc SQL queries and BI dashboards:

![Data Model Diagram](docs/Data%20Model.png)

---

## Technology Stack

- **Database**: PostgreSQL with PL/pgSQL
- **Language**: PL/pgSQL for stored procedures and functions
- **Design & Diagramming** LucidChart
- **License**: MIT

---

## Getting Started

### Prerequisites

- PostgreSQL 12+
- Git for version control

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/YummieGG/dwh-project.git
   cd dwh-project
   ```

2. Review the documentation in the `docs/` folder for detailed architecture information.

3. Execute scripts from the `scripts/` folder to set up your data warehouse:
   ```bash
   # Run database initialization scripts
   psql -U postgres -d your_database -f scripts/setup.sql
   ```

---

## Project Structure Details

### Scripts (`scripts/`)
Contains PL/pgSQL scripts for:
- Database initialization
- ETL processes
- Data transformations
- Stored procedures and functions

### Tests (`tests/`)
Includes validation and testing scripts to ensure:
- Data quality
- Referential integrity
- Transformation accuracy

### Datasets (`datasets/`)
Sample and raw data files for:
- Initial setup
- Testing
- Development and staging

### Documentation (`docs/`)
Visual and detailed documentation including:
- Architecture overview
- Data flow diagrams
- Integration patterns
- Data models and schema design

---

## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

---

## Acknowledgments

This project was built as a core asset for my Data Engineering portfolio. The foundational architecture and domain requirements were guided by the comprehensive data warehouse framework taught by **Baraa**.

**Original Tutorial**: [SQL Data Warehouse from Scratch | Full Hands-On Data Engineering Project by Data with Baraa](https://www.youtube.com/c/DatawithBaraa)

**Key Adaptation**: Re-engineered and migrated the entire project architecture, DDLs, and ETL pipelines from Microsoft SQL Server (T-SQL) to PostgreSQL (PL/pgSQL).


---

## Contact & Support

For questions or support, please reach out to the project maintainers or open an issue in the repository.

- **GitHub**: [YummieGG](https://github.com/YummieGG)
- **Email**: mummycza9997@gmail.com

---

**Last Updated**: July 2026
