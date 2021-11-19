USE [master]
GO
/****** Object:  Database [Pharmacy]    Script Date: 29.06.2021 12:36:38 ******/
CREATE DATABASE [Pharmacy]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pharmacy', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Pharmacy.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pharmacy_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Pharmacy_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Pharmacy] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pharmacy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pharmacy] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pharmacy] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pharmacy] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pharmacy] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pharmacy] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pharmacy] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Pharmacy] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pharmacy] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pharmacy] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pharmacy] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pharmacy] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pharmacy] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pharmacy] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pharmacy] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pharmacy] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Pharmacy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pharmacy] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pharmacy] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pharmacy] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pharmacy] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pharmacy] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pharmacy] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pharmacy] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Pharmacy] SET  MULTI_USER 
GO
ALTER DATABASE [Pharmacy] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pharmacy] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pharmacy] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pharmacy] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pharmacy] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pharmacy] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Pharmacy] SET QUERY_STORE = OFF
GO
USE [Pharmacy]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDrugID]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_GetDrugID](@name nvarchar(50))
RETURNS int AS
BEGIN
	DECLARE @id int;  
    SELECT @id = [ID]   
    FROM [dbo].[Drugs] 
    WHERE [Name] = @name  
    RETURN @id;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetProviderID]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetProviderID](@name nvarchar(100))
RETURNS int AS
BEGIN
	DECLARE @id int;  
    SELECT @id = [ID]   
    FROM [dbo].[Providers] 
    WHERE [Name] = @name  
    RETURN @id;
END;
GO
/****** Object:  Table [dbo].[Users]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](20) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[EmployeeID] [int] NULL,
	[UserTypeID] [int] NOT NULL,
	[Date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserData]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetUserData](@employeeID int)
RETURNS table AS
	RETURN 
	SELECT 
		[dbo].[Users].[Login], 
		[dbo].[Users].[Password], 
		[dbo].[Users].[UserTypeID] 
	FROM 
		[dbo].[Users]
	WHERE 
		[dbo].[Users].[EmployeeID] = @employeeID
	;
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Positions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Surname] [nvarchar](40) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[EmploymentDate] [date] NOT NULL,
	[Phone] [char](15) NOT NULL,
	[PositionID] [int] NOT NULL,
	[Salary] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserInfo]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetUserInfo](@employeeID int)
RETURNS table AS
	RETURN 
	SELECT 
		[dbo].[Employees].[Name] AS e_Name, 
		[dbo].[Employees].[Surname], 
		[dbo].[Positions].[Name] AS p_Name, 
		[dbo].[Users].[Login]
	FROM 
		[dbo].[Employees], 
		[dbo].[Positions], 
		[dbo].[Users]
	WHERE 
		[dbo].[Employees].[ID] = @employeeID AND 
		[dbo].[Positions].[ID] = [dbo].[Employees].[PositionID] AND 
		[dbo].[Users].[EmployeeID] = @employeeID
	;
GO
/****** Object:  Table [dbo].[Drugs]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drugs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [char](13) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[DrugTypeID] [int] NOT NULL,
	[ManufacturerID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Providers]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Providers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Phone] [char](14) NOT NULL,
	[Address] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Deliveries]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deliveries](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProviderID] [int] NOT NULL,
	[DrugID] [int] NOT NULL,
	[TotalAmount] [int] NOT NULL,
	[PurchasePrice] [smallmoney] NOT NULL,
	[ConclusionDate] [date] NOT NULL,
	[ExpirationDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[StockID] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[ExtraCharge] [decimal](3, 2) NOT NULL,
	[ReceiptDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AppWarehouse]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AppWarehouse] AS
SELECT 
    [dbo].[Warehouse].[StockID] AS 'ID Запаса',
    [dbo].[Deliveries].[ID] AS 'ID Поставки',
    [dbo].[Providers].[Name] AS 'Поставщик',
    [dbo].[Drugs].[Name] AS 'Препарат', 
    [dbo].[Warehouse].[Amount] AS 'Количество', 
    [dbo].[Warehouse].[ExtraCharge] AS 'Наценка', 
    [dbo].[Warehouse].[ReceiptDate] AS 'Поступление'
FROM 
    [dbo].[Warehouse], 
    [dbo].[Deliveries],
    [dbo].[Drugs], 
    [dbo].[Providers]
WHERE 
    [dbo].[Deliveries].[ID] = [dbo].[Warehouse].[DeliveryID] AND 
    [dbo].[Providers].[ID] = [dbo].[Deliveries].[ProviderID] AND 
    [dbo].[Drugs].[ID] = [dbo].[Deliveries].[DrugID]
;
GO
/****** Object:  View [dbo].[AppDeliveries]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AppDeliveries] AS
SELECT 
	[dbo].[Deliveries].[ID], 
	[dbo].[Providers].[Name] AS 'Поставщик', 
	[dbo].[Drugs].[Name] AS 'Препарат', 
	[dbo].[Deliveries].[TotalAmount] AS 'Количество', 
	[dbo].[Deliveries].[PurchasePrice] AS 'Цена', 
	[dbo].[Deliveries].[ConclusionDate] AS 'Начало поставок', 
	[dbo].[Deliveries].[ExpirationDate] AS 'Конец поставок'
FROM 
	[dbo].[Deliveries],
	[dbo].[Providers], 
	[dbo].[Drugs]
WHERE 
	[dbo].[Providers].[ID] = [dbo].[Deliveries].[ProviderID] AND 
	[dbo].[Drugs].[ID] = [dbo].[Deliveries].[DrugID]
;
GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[AppManagers]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AppManagers] AS
SELECT 
    [dbo].[Users].[Login] AS 'Пользователь', 
    [dbo].[Employees].[Name] AS 'Имя', 
    [dbo].[Employees].[Surname] AS 'Фамилия', 
    [dbo].[UserTypes].[Name] AS 'Роль', 
    [dbo].[Positions].[Name] AS 'Должность'
FROM 
    [dbo].[Users], 
    [dbo].[Employees], 
    [dbo].[UserTypes], 
    [dbo].[Positions]   
WHERE 
    [dbo].[Employees].[ID] = [dbo].[Users].[EmployeeID] AND 
    [dbo].[UserTypes].[ID] = [dbo].[Users].[UserTypeID] AND 
    [dbo].[Positions].[ID] = [dbo].[Employees].[PositionID]
;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_LoginAttempt]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_LoginAttempt](@login nvarchar(20), @password nvarchar(50))
RETURNS table AS
	RETURN 
	SELECT 
		[dbo].[Users].[Login], 
		[dbo].[Users].[Password], 
		[dbo].[Users].[EmployeeID], 
		[dbo].[Users].[UserTypeID] 
	FROM 
		[dbo].[Users]
	WHERE 
		[dbo].[Users].[Login] = @login AND 
		[dbo].[Users].[Password] = @password
	;
GO
/****** Object:  Table [dbo].[DrugTypes]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrugTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufactures]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufactures](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [text] NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[StockID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[TotalPrice] [money] NOT NULL,
	[Date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Deliveries] ON 

INSERT [dbo].[Deliveries] ([ID], [ProviderID], [DrugID], [TotalAmount], [PurchasePrice], [ConclusionDate], [ExpirationDate]) VALUES (1, 1, 9, 100, 350.0000, CAST(N'2021-04-01' AS Date), CAST(N'2021-04-30' AS Date))
INSERT [dbo].[Deliveries] ([ID], [ProviderID], [DrugID], [TotalAmount], [PurchasePrice], [ConclusionDate], [ExpirationDate]) VALUES (4, 4, 10, 50, 500.0000, CAST(N'2021-07-28' AS Date), CAST(N'2021-06-28' AS Date))
SET IDENTITY_INSERT [dbo].[Deliveries] OFF
GO
SET IDENTITY_INSERT [dbo].[Drugs] ON 

INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (1, N'16030322-3408', N'Abciximab', 2, 1, 48)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (2, N'16090108-0911', N'Adalimumab', 8, 3, 31)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (3, N'16180413-0191', N'Albuminum', 10, 12, 82)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (4, N'16050410-3946', N'Albunorm', 5, 14, 59)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (5, N'16400210-6849', N'Bepanthen', 15, 2, 99)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (6, N'16800315-3882', N'Bosentan', 9, 16, 65)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (7, N'16471016-1185', N'Clomipramine', 11, 15, 96)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (8, N'16570915-4305', N'Cordarone', 13, 11, 63)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (9, N'16510106-6222', N'Cytisin', 14, 17, 17)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (10, N'16530925-3416', N'Doxycycline', 17, 4, 97)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (11, N'16660908-7322', N'Euphylong', 9, 18, 95)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (12, N'16890212-9033', N'Fenadol', 12, 13, 82)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (13, N'16131005-0578', N'Isobarin', 1, 20, 62)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (14, N'16631026-7445', N'Octadinum', 1, 10, 37)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (15, N'16620123-4348', N'Omnipague', 7, 7, 4)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (16, N'16321130-3999', N'Orliks', 3, 6, 97)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (17, N'16750607-1344', N'Tonsipret', 4, 21, 89)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (18, N'16761006-3930', N'Trastuzumab', 16, 5, 56)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (19, N'16240709-3398', N'Vibramycin', 17, 19, 84)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (20, N'16110527-2189', N'Zinkit', 3, 8, 4)
INSERT [dbo].[Drugs] ([ID], [Code], [Name], [DrugTypeID], [ManufacturerID], [Amount]) VALUES (21, N'16351230-2799', N'Zoladex', 6, 9, 63)
SET IDENTITY_INSERT [dbo].[Drugs] OFF
GO
SET IDENTITY_INSERT [dbo].[DrugTypes] ON 

INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (1, N'Вегетотропные средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (2, N'Активные вещества')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (3, N'Биологически активные добавки к пище (БАДы)')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (4, N'Гомеопатические средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (5, N'Гематотропные средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (6, N'Гормоны и их антагонисты')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (7, N'Диагностические средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (8, N'Иммунотропные средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (9, N'Интермедианты')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (10, N'Метаболики')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (11, N'Нейротропные средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (12, N'Ненаркотические анальгетики, включая нестероидные и другие противовоспалительные средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (13, N'Органотропные средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (14, N'Разные средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (15, N'Регенеранты и репаранты')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (16, N'Противоопухолевые средства')
INSERT [dbo].[DrugTypes] ([ID], [Name]) VALUES (17, N'Противомикробные, противопаразитарные и противоглистные средства')
SET IDENTITY_INSERT [dbo].[DrugTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (1, N'Алексей', N'Тихонов', CAST(N'1987-10-07' AS Date), CAST(N'2019-12-14' AS Date), N'+7-914-144-7111', 1, 55660.6400)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (2, N'Антон', N'Князев', CAST(N'1998-02-23' AS Date), CAST(N'2015-12-06' AS Date), N'+7-997-604-6995', 2, 23335.4900)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (3, N'Анфиса', N'Никитина', CAST(N'1990-04-12' AS Date), CAST(N'2017-03-09' AS Date), N'+7-927-927-0071', 3, 63896.9300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (4, N'Арсений', N'Суворов', CAST(N'1997-08-22' AS Date), CAST(N'2016-07-06' AS Date), N'+7-983-168-7504', 4, 37966.7400)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (5, N'Афанасий', N'Козлов', CAST(N'1988-03-07' AS Date), CAST(N'2017-08-14' AS Date), N'+7-970-366-2005', 5, 19818.4200)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (6, N'Болеслав', N'Пестов', CAST(N'1993-09-07' AS Date), CAST(N'2015-10-20' AS Date), N'+7-945-665-6527', 6, 36605.7900)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (7, N'Валентина', N'Лыткина', CAST(N'1978-08-15' AS Date), CAST(N'2016-04-02' AS Date), N'+7-923-832-0352', 7, 36893.4800)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (8, N'Валентина', N'Филатова', CAST(N'1973-09-21' AS Date), CAST(N'2017-12-15' AS Date), N'+7-995-964-7113', 8, 20870.0400)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (9, N'Варвара', N'Мухина', CAST(N'1990-03-04' AS Date), CAST(N'2013-05-03' AS Date), N'+7-982-177-0527', 9, 22421.5200)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (10, N'Вероника', N'Авдеева', CAST(N'1982-05-27' AS Date), CAST(N'2013-07-28' AS Date), N'+7-922-722-9832', 10, 38681.4900)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (11, N'Виктор', N'Калашников', CAST(N'1972-06-06' AS Date), CAST(N'2016-02-11' AS Date), N'+7-959-646-4781', 11, 43239.2900)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (12, N'Виктория', N'Комарова', CAST(N'1985-09-18' AS Date), CAST(N'2018-05-02' AS Date), N'+7-904-228-1463', 12, 39684.9800)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (13, N'Виктория', N'Архипова', CAST(N'1972-01-11' AS Date), CAST(N'2015-11-28' AS Date), N'+7-973-980-0046', 13, 48723.3900)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (14, N'Витольд', N'Никифоров', CAST(N'1976-02-21' AS Date), CAST(N'2014-03-29' AS Date), N'+7-999-777-3970', 1, 61119.4500)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (15, N'Владлена', N'Панова', CAST(N'1986-12-12' AS Date), CAST(N'2015-06-16' AS Date), N'+7-917-955-1975', 2, 30752.6300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (16, N'Георгий', N'Гордеев', CAST(N'1993-04-28' AS Date), CAST(N'2015-10-09' AS Date), N'+7-954-109-4206', 3, 39903.3700)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (17, N'Герасим', N'Гордеев', CAST(N'1981-01-02' AS Date), CAST(N'2014-05-22' AS Date), N'+7-992-154-8947', 4, 62634.0600)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (18, N'Герман', N'Мишин', CAST(N'1987-01-01' AS Date), CAST(N'2018-09-24' AS Date), N'+7-982-633-3549', 5, 39017.4600)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (19, N'Данила', N'Шарапов', CAST(N'1985-03-01' AS Date), CAST(N'2019-03-21' AS Date), N'+7-991-567-8685', 6, 43682.8700)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (20, N'Дарья', N'Устинова', CAST(N'1977-03-06' AS Date), CAST(N'2018-08-22' AS Date), N'+7-999-200-3969', 7, 17363.5800)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (21, N'Денис', N'Субботин', CAST(N'1992-12-19' AS Date), CAST(N'2014-02-26' AS Date), N'+7-921-937-7326', 8, 69113.8200)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (22, N'Ева', N'Нестерова', CAST(N'1977-12-22' AS Date), CAST(N'2017-10-02' AS Date), N'+7-911-144-9671', 9, 66312.9100)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (23, N'Евгения', N'Николаева', CAST(N'1974-11-23' AS Date), CAST(N'2016-04-24' AS Date), N'+7-966-481-7360', 10, 61605.9900)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (24, N'Елизавета', N'Воробьёва', CAST(N'1997-02-08' AS Date), CAST(N'2015-08-15' AS Date), N'+7-974-244-5937', 11, 35019.3300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (25, N'Злата', N'Шилова', CAST(N'1988-03-12' AS Date), CAST(N'2016-11-19' AS Date), N'+7-917-479-4788', 12, 43110.1700)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (26, N'Иван', N'Колобов', CAST(N'1974-02-16' AS Date), CAST(N'2013-05-31' AS Date), N'+7-988-654-3008', 13, 59099.2200)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (27, N'Иван', N'Кулагин', CAST(N'1990-12-12' AS Date), CAST(N'2013-06-10' AS Date), N'+7-999-826-2114', 1, 24392.9700)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (28, N'Игнат', N'Виноградов', CAST(N'1977-12-21' AS Date), CAST(N'2017-08-03' AS Date), N'+7-962-264-3819', 2, 69545.2500)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (29, N'Игнатий', N'Маслов', CAST(N'1975-05-04' AS Date), CAST(N'2018-01-24' AS Date), N'+7-969-368-6641', 3, 49135.4000)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (30, N'Иммануил', N'Котов', CAST(N'1994-07-04' AS Date), CAST(N'2019-05-28' AS Date), N'+7-927-574-2632', 4, 25094.1600)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (31, N'Ирина', N'Тарасова', CAST(N'1987-11-21' AS Date), CAST(N'2019-01-31' AS Date), N'+7-937-492-6928', 5, 60402.0100)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (32, N'Искра', N'Шестакова', CAST(N'1993-08-10' AS Date), CAST(N'2016-05-27' AS Date), N'+7-999-291-1625', 6, 29128.1200)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (33, N'Клавдия', N'Филатова', CAST(N'1970-11-10' AS Date), CAST(N'2018-06-05' AS Date), N'+7-935-873-2967', 7, 67321.6200)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (34, N'Клара', N'Федотова', CAST(N'1975-01-14' AS Date), CAST(N'2019-09-28' AS Date), N'+7-920-946-9306', 8, 68084.9100)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (35, N'Клементина', N'Воробьёва', CAST(N'1990-06-20' AS Date), CAST(N'2019-11-11' AS Date), N'+7-977-950-6297', 9, 44383.6400)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (36, N'Клим', N'Ширяев', CAST(N'1993-03-28' AS Date), CAST(N'2013-03-30' AS Date), N'+7-953-311-9879', 10, 66770.3400)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (37, N'Лада', N'Белоусова', CAST(N'1984-01-14' AS Date), CAST(N'2014-07-28' AS Date), N'+7-914-383-0078', 11, 25218.4300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (38, N'Лариса', N'Ситникова', CAST(N'1995-05-24' AS Date), CAST(N'2013-07-24' AS Date), N'+7-988-977-4327', 12, 69168.1400)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (39, N'Леонид', N'Костин', CAST(N'1978-05-07' AS Date), CAST(N'2019-06-14' AS Date), N'+7-924-576-6190', 13, 61729.0300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (40, N'Людмила', N'Пахомова', CAST(N'1974-10-25' AS Date), CAST(N'2019-08-17' AS Date), N'+7-956-496-9529', 1, 61305.4100)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (41, N'Максим', N'Евсеев', CAST(N'1996-10-21' AS Date), CAST(N'2014-10-28' AS Date), N'+7-937-937-8819', 2, 44643.3800)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (42, N'Мария', N'Орлова', CAST(N'1971-06-03' AS Date), CAST(N'2015-02-26' AS Date), N'+7-983-750-4344', 3, 28973.5600)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (43, N'Марта', N'Кононова', CAST(N'1980-01-17' AS Date), CAST(N'2015-01-02' AS Date), N'+7-967-224-3489', 4, 16745.1900)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (44, N'Ника', N'Сысоева', CAST(N'1989-01-10' AS Date), CAST(N'2017-05-05' AS Date), N'+7-905-695-3524', 5, 64032.2300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (45, N'Николай', N'Анисимов', CAST(N'1986-03-23' AS Date), CAST(N'2019-05-16' AS Date), N'+7-921-779-6034', 6, 59184.0800)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (46, N'Оксана', N'Ларионова', CAST(N'1997-12-31' AS Date), CAST(N'2015-08-22' AS Date), N'+7-952-931-6841', 7, 21994.7700)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (47, N'Олег', N'Доронин', CAST(N'1995-10-12' AS Date), CAST(N'2017-08-22' AS Date), N'+7-975-440-3743', 8, 29730.0700)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (48, N'Прохор', N'Моисеев', CAST(N'1977-11-24' AS Date), CAST(N'2014-06-09' AS Date), N'+7-994-690-7964', 9, 49603.6700)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (49, N'Рада', N'Антонова', CAST(N'1988-10-16' AS Date), CAST(N'2017-04-17' AS Date), N'+7-908-343-8193', 10, 22481.5100)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (50, N'Радислав', N'Агафонов', CAST(N'1987-08-27' AS Date), CAST(N'2016-03-29' AS Date), N'+7-945-679-4564', 11, 56642.7500)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (51, N'Рафаил', N'Никифоров', CAST(N'1987-04-12' AS Date), CAST(N'2017-09-16' AS Date), N'+7-904-608-1395', 12, 50992.4200)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (52, N'Рафаил', N'Орлов', CAST(N'1993-03-19' AS Date), CAST(N'2016-05-22' AS Date), N'+7-927-477-1923', 13, 29454.7900)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (53, N'Святослав', N'Афанасьев', CAST(N'1984-02-25' AS Date), CAST(N'2019-04-21' AS Date), N'+7-938-266-0110', 1, 68699.6600)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (54, N'Святослав', N'Карпов', CAST(N'1989-06-03' AS Date), CAST(N'2014-10-11' AS Date), N'+7-994-234-3513', 2, 53243.7300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (55, N'Станислав', N'Потапов', CAST(N'1975-10-21' AS Date), CAST(N'2016-03-18' AS Date), N'+7-914-531-8080', 3, 15137.1300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (56, N'Тамара', N'Фомина', CAST(N'1990-11-20' AS Date), CAST(N'2017-05-31' AS Date), N'+7-902-469-2646', 4, 48048.4400)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (57, N'Тамара', N'Фокина', CAST(N'1979-03-06' AS Date), CAST(N'2015-05-10' AS Date), N'+7-995-939-2789', 5, 54192.8400)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (58, N'Тит', N'Соколов', CAST(N'1979-04-15' AS Date), CAST(N'2017-08-07' AS Date), N'+7-913-944-5910', 6, 29606.0200)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (59, N'Ульяна', N'Бирюкова', CAST(N'1993-10-06' AS Date), CAST(N'2014-07-13' AS Date), N'+7-968-280-1954', 7, 26451.0500)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (60, N'Фёдор', N'Колобов', CAST(N'1992-10-05' AS Date), CAST(N'2016-05-29' AS Date), N'+7-976-994-2893', 8, 58499.8500)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (61, N'Федосья', N'Большакова', CAST(N'1975-09-21' AS Date), CAST(N'2013-10-28' AS Date), N'+7-926-913-6025', 9, 55375.9000)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (62, N'Флорентина', N'Белоусова', CAST(N'1993-01-28' AS Date), CAST(N'2015-03-16' AS Date), N'+7-912-873-7133', 10, 31719.0300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (63, N'Эльвира', N'Мишина', CAST(N'1990-11-08' AS Date), CAST(N'2016-02-16' AS Date), N'+7-997-193-7189', 11, 42036.5000)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (64, N'Эмилия', N'Кудрявцева', CAST(N'1993-07-30' AS Date), CAST(N'2018-04-29' AS Date), N'+7-961-526-2684', 12, 54845.6300)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (65, N'Юрий', N'Медведев', CAST(N'1980-05-25' AS Date), CAST(N'2013-10-15' AS Date), N'+7-912-809-3835', 13, 26783.1100)
INSERT [dbo].[Employees] ([ID], [Name], [Surname], [BirthDate], [EmploymentDate], [Phone], [PositionID], [Salary]) VALUES (66, N'Альберт', N'Антонян', CAST(N'2002-05-29' AS Date), CAST(N'2021-04-13' AS Date), N'+7-911-395-2575', 14, 666666.6600)
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[Manufactures] ON 

INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (1, N'Eu Corp.', N'Россия')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (2, N'A Mi Fringilla Associates', N'Швеция')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (3, N'Faucibus Leo In Associates', N'Китай')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (4, N'Urna Nullam Lobortis Industries', N'Руанда')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (5, N'Suspendisse Dui Fusce Industries', N'Сейшелы')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (6, N'Nisi Inc.', N'Иордания')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (7, N'Lorem Lorem Luctus Institute', N'Монако')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (8, N'Urna Nullam Lobortis Company', N'Германия')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (9, N'Convallis Est Vitae Company', N'Франция')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (10, N'Ipsum Suspendisse Sagittis Limited', N'Лаос')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (11, N'Sagittis Corp.', N'Узбекистан')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (12, N'Mauris Ipsum Associates', N'Турция')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (13, N'Tincidunt Company', N'Израиль')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (14, N'Et LLP', N'Хорватия')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (15, N'Aliquam Foundation', N'Армения')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (16, N'Pellentesque Limited', N'Финлядния')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (17, N'Mus Proin Corporation', N'Израиль')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (18, N'Suscipit Nonummy Fusce Limited', N'Россия')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (19, N'Magnis Company', N'Румыния')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (20, N'Lorem Incorporated', N'Болгария')
INSERT [dbo].[Manufactures] ([ID], [Name], [Country]) VALUES (21, N'Molestie LLC', N'Китай')
SET IDENTITY_INSERT [dbo].[Manufactures] OFF
GO
SET IDENTITY_INSERT [dbo].[Positions] ON 

INSERT [dbo].[Positions] ([ID], [Name]) VALUES (1, N'директор')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (2, N'заместитель директора')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (3, N'заведующий складом организации оптовой торговли лекарственными средствами')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (4, N'заместитель заведующего складом организации оптовой торговли лекарственными средствами')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (5, N'провизор')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (6, N'провизор-аналитик')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (7, N'провизор-стажер')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (8, N'провизор-технолог')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (9, N'старший провизор')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (10, N'младший фармацевт')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (11, N'старший фармацевт')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (12, N'фармацевт')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (13, N'фасовщик')
INSERT [dbo].[Positions] ([ID], [Name]) VALUES (14, N'администратор приложения и базы данных')
SET IDENTITY_INSERT [dbo].[Positions] OFF
GO
SET IDENTITY_INSERT [dbo].[Providers] ON 

INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (1, N'АСОКА', N'8-812-555-3535', N'Московская область')
INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (2, N'АРГЕНТУМ', N'8-812-212-3212', N'Санкт-Петербург')
INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (3, N'ИП Бешенцев Д. А.', N'8-812-112-3244', N'Московская обл.')
INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (4, N'М-Техфарм', N'8-800-522-2222', N'Ростов-на-Дону')
INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (5, N'МедиаМед', N'8-812-777-1234', N'Ставрополь')
INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (6, N'Фарм-Трэйд', N'8-812-223-9786', N'Челябинск')
INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (7, N'Областной Аптечный Склад', N'8-800-451-9151', N'Москва')
INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (8, N'Норд МСК', N'8-812-535-3444', N'Москва')
INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (9, N'Givana-Pharm', N'8-812-989-8981', N'Москва')
INSERT [dbo].[Providers] ([ID], [Name], [Phone], [Address]) VALUES (10, N'Медторг', N'8-812-420-0404', N'Ставрополь')
SET IDENTITY_INSERT [dbo].[Providers] OFF
GO
SET IDENTITY_INSERT [dbo].[Sales] ON 

INSERT [dbo].[Sales] ([ID], [EmployeeID], [StockID], [Amount], [TotalPrice], [Date]) VALUES (1, 11, 1, 2, 840.0000, CAST(N'2021-04-12' AS Date))
SET IDENTITY_INSERT [dbo].[Sales] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (1, N'albert', N'123123', 66, 2, CAST(N'2021-04-13' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (2, N'alextih', N'52P77LOUUjP9tHar', 1, 2, CAST(N'2021-04-15' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (3, N'vitoldnikif', N'KYi92aNKIM', 2, 2, CAST(N'2021-04-15' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (4, N'ivankulag', N'Ztf8QhHJuf06fP9VnIb', 3, 2, CAST(N'2021-04-15' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (5, N'ludmpah', N'wkwo2XF3mvQ8ukJJ9RK', 4, 2, CAST(N'2021-04-15' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (6, N'svyatafan', N'XWaQtTfkBN', 5, 1, CAST(N'2021-04-15' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (7, N'anfnik', N'7c9XAWCBSJGbMHk35', 6, 1, CAST(N'2021-04-15' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (8, N'arssuv', N'9cC0tqEtUm', 7, 1, CAST(N'2021-04-16' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (9, N'georggord', N'3zKksjMa3pCa5fjCtEN2', 8, 1, CAST(N'2021-04-16' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (10, N'gerasgord', N'ZIklOuBXEb09w4Yzc', 9, 1, CAST(N'2021-04-16' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (11, N'ignmasl', N'HhWw7ROkm6n', 10, 1, CAST(N'2021-04-16' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (12, N'imankot', N'gMh2mfEuyvj1oXSY89', 11, 1, CAST(N'2021-04-16' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (13, N'marorl', N'g7TbNSw0j', 12, 1, CAST(N'2021-04-18' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (14, N'martkon', N'RSQLbDsA', 13, 1, CAST(N'2021-04-18' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (15, N'stanpot', N'gE0eZ57OdacsWHaW', 14, 1, CAST(N'2021-04-18' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (16, N'tamfom', N'9WBK83nWf0f6f', 15, 1, CAST(N'2021-04-18' AS Date))
INSERT [dbo].[Users] ([ID], [Login], [Password], [EmployeeID], [UserTypeID], [Date]) VALUES (17, N'elviramish', N'123456', 63, 1, CAST(N'2021-06-29' AS Date))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[UserTypes] ON 

INSERT [dbo].[UserTypes] ([ID], [Name]) VALUES (1, N'Менеджер склада')
INSERT [dbo].[UserTypes] ([ID], [Name]) VALUES (2, N'Директор')
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouse] ON 

INSERT [dbo].[Warehouse] ([StockID], [DeliveryID], [EmployeeID], [Amount], [ExtraCharge], [ReceiptDate]) VALUES (1, 1, 4, 100, CAST(0.00 AS Decimal(3, 2)), CAST(N'2021-03-22' AS Date))
SET IDENTITY_INSERT [dbo].[Warehouse] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__5E55825B060CB73E]    Script Date: 29.06.2021 12:36:38 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Deliveries]  WITH CHECK ADD FOREIGN KEY([DrugID])
REFERENCES [dbo].[Drugs] ([ID])
GO
ALTER TABLE [dbo].[Deliveries]  WITH CHECK ADD FOREIGN KEY([ProviderID])
REFERENCES [dbo].[Providers] ([ID])
GO
ALTER TABLE [dbo].[Drugs]  WITH CHECK ADD FOREIGN KEY([DrugTypeID])
REFERENCES [dbo].[DrugTypes] ([ID])
GO
ALTER TABLE [dbo].[Drugs]  WITH CHECK ADD FOREIGN KEY([ManufacturerID])
REFERENCES [dbo].[Manufactures] ([ID])
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD FOREIGN KEY([PositionID])
REFERENCES [dbo].[Positions] ([ID])
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD FOREIGN KEY([StockID])
REFERENCES [dbo].[Warehouse] ([StockID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[UserTypes] ([ID])
GO
ALTER TABLE [dbo].[Warehouse]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[Warehouse]  WITH CHECK ADD FOREIGN KEY([DeliveryID])
REFERENCES [dbo].[Deliveries] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[sp_ChangeLogin]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ChangeLogin] 
	@login nvarchar(20),
	@employeeID int
AS
	UPDATE [dbo].[Users] SET [Login] = @login WHERE [dbo].[Users].[EmployeeID] = @employeeID;
GO
/****** Object:  StoredProcedure [dbo].[sp_ChangePassword]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ChangePassword] 
	@password nvarchar(50),
	@employeeID int
AS
	UPDATE [dbo].[Users] SET [Password] = @password WHERE [dbo].[Users].[EmployeeID] = @employeeID;
GO
/****** Object:  StoredProcedure [dbo].[sp_OrderDelivery]    Script Date: 29.06.2021 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_OrderDelivery] 
	@provider nvarchar(100), 
	@drug nvarchar(50), 
	@amount int, 
	@price smallmoney, 
	@conclusionDate date, 
	@expirationDate date
AS
INSERT [dbo].[Deliveries]([ProviderID], [DrugID], [TotalAmount], [PurchasePrice], [ConclusionDate], [ExpirationDate])
VALUES 
(
    (SELECT [dbo].[fn_GetProviderID](@provider)), 
    (SELECT [dbo].[fn_GetDrugID](@drug)), 
    @amount, 
    @price, 
    @conclusionDate, 
    @expirationDate
);
GO
USE [master]
GO
ALTER DATABASE [Pharmacy] SET  READ_WRITE 
GO
