USE [master]
GO
/****** Object:  Database [Desafio2DMD]    Script Date: 23/05/2025 08:38:42 ******/
CREATE DATABASE [Desafio2DMD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Desafio2DMD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLDMD\MSSQL\DATA\Desafio2DMD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Desafio2DMD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLDMD\MSSQL\DATA\Desafio2DMD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Desafio2DMD] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Desafio2DMD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Desafio2DMD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Desafio2DMD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Desafio2DMD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Desafio2DMD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Desafio2DMD] SET ARITHABORT OFF 
GO
ALTER DATABASE [Desafio2DMD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Desafio2DMD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Desafio2DMD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Desafio2DMD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Desafio2DMD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Desafio2DMD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Desafio2DMD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Desafio2DMD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Desafio2DMD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Desafio2DMD] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Desafio2DMD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Desafio2DMD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Desafio2DMD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Desafio2DMD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Desafio2DMD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Desafio2DMD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Desafio2DMD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Desafio2DMD] SET RECOVERY FULL 
GO
ALTER DATABASE [Desafio2DMD] SET  MULTI_USER 
GO
ALTER DATABASE [Desafio2DMD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Desafio2DMD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Desafio2DMD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Desafio2DMD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Desafio2DMD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Desafio2DMD] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Desafio2DMD', N'ON'
GO
ALTER DATABASE [Desafio2DMD] SET QUERY_STORE = ON
GO
ALTER DATABASE [Desafio2DMD] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Desafio2DMD]
GO
/****** Object:  Table [dbo].[DimDate]    Script Date: 23/05/2025 08:38:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDate](
	[DateKey] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Anio] [smallint] NOT NULL,
	[Trimestre] [tinyint] NOT NULL,
	[Mes] [tinyint] NOT NULL,
	[NombreMes] [varchar](9) NOT NULL,
	[dia] [tinyint] NOT NULL,
	[DiaSemana] [tinyint] NOT NULL,
	[Nombredia] [varchar](9) NOT NULL,
	[SemanaAnio] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mobility_SV_Nacional]    Script Date: 23/05/2025 08:38:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mobility_SV_Nacional](
	[country_region_code] [char](2) NOT NULL,
	[country_region] [varchar](255) NOT NULL,
	[place_id] [varchar](255) NULL,
	[date] [date] NOT NULL,
	[DateKey] [int] NOT NULL,
	[retail_and_recreation_percent_change_from_baseline] [smallint] NULL,
	[grocery_and_pharmacy_percent_change_from_baseline] [smallint] NULL,
	[parks_percent_change_from_baseline] [smallint] NULL,
	[transit_stations_percent_change_from_baseline] [smallint] NULL,
	[workplaces_percent_change_from_baseline] [smallint] NULL,
	[residential_percent_change_from_baseline] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Mobility_SV_Nacional]  WITH CHECK ADD  CONSTRAINT [FK_MobilitySVNacional_DimDate] FOREIGN KEY([DateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[Mobility_SV_Nacional] CHECK CONSTRAINT [FK_MobilitySVNacional_DimDate]
GO
USE [master]
GO
ALTER DATABASE [Desafio2DMD] SET  READ_WRITE 
GO

-- Llenar la tabla de DimDate
WITH Calendar AS
(
    SELECT CAST('2022-01-01' AS DATE) AS d
    UNION ALL
    SELECT DATEADD(DAY, 1, d)
    FROM Calendar
    WHERE d < '2022-12-31'
)
INSERT INTO dbo.DimDate
(
    DateKey,
    Fecha,
    Anio,
    Trimestre,
    Mes,
    NombreMes,
    Dia,
    DiaSemana,
    Nombredia,
    SemanaAnio
)
SELECT
    CONVERT(INT, CONVERT(CHAR(8), d, 112))  AS DateKey,
    d                                        AS Fecha,
    DATEPART(YEAR, d)                        AS Anio,
    DATEPART(QUARTER, d)                     AS Trimestre,
    DATEPART(MONTH, d)                       AS Mes,
    DATENAME(MONTH, d)                       AS NombreMes,
    DATEPART(DAY, d)                         AS Dia,
    DATEPART(WEEKDAY, d)                     AS DiaSemana,
    DATENAME(WEEKDAY, d)                     AS Nombredia,
    DATEPART(WEEK, d)                        AS SemanaAnio
FROM Calendar
OPTION (MAXRECURSION 366);
GO