# DWH Project (DataWareHouse Project)

## Project Description

**DWH Project** is a comprehensive **Data Warehouse** solution designed to centralize, integrate, and manage data from multiple sources. This project provides a robust infrastructure for collecting, transforming, and storing data in a structured data warehouse environment.

### What is This?

A modern data warehouse system built with **PL/pgSQL** that enables organizations to:
- **Consolidate** data from diverse data sources
- **Transform** raw data into meaningful business insights
- **Store** structured data in an optimized format for analytics
- **Query** data efficiently for business intelligence and reporting

### What We Do

We provide:
- **Data Integration** - Seamless integration of multi-source data
- **Data Transformation** - ETL/ELT pipelines for data processing
- **Data Modeling** - Structured dimensional and fact tables
- **Data Quality** - Validation and cleansing processes
- **Scalable Architecture** - Built for enterprise-level data operations

---

## Project Overview

The DWH Project follows a modular architecture composed of:

### Directory Structure

```
dwh-project/
├── docs/                   # Project documentation and diagrams
├── datasets/               # Sample and raw datasets
├── scripts/                # ETL and database scripts
├── tests/                  # Test cases and validations
├── LICENSE                 # MIT License
└── README.md               # This file
```

### Key Components

- **docs/** - Architecture diagrams, data models, and integration workflows
- **datasets/** - Sample data and staging areas
- **scripts/** - PL/pgSQL scripts for data transformation and loading
- **tests/** - Data validation and quality tests

---

## Data Architecture

### System Architecture

The following diagram illustrates the overall architecture of the DWH Project:

![Architecture Diagram](docs/Architecture.png)

### Data Flow

This diagram shows how data flows through the system:

![Data Flow Diagram](docs/Data%20Flow.png)

### Data Integration Pattern

The integration pattern used in this project:

![Data Integration Diagram](docs/Data%20Intregration.png)

### Data Model

The dimensional model and schema design:

![Data Model Diagram](docs/Data%20Model.png)

---

## Technology Stack

- **Database**: PostgreSQL with PL/pgSQL
- **Language**: PL/pgSQL for stored procedures and functions
- **License**: MIT


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

**Last Updated**: July 2026
