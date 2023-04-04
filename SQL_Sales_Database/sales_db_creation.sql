USE [master]
GO
/****** Object:  Database [WindowFunctionsDB]    Script Date: 7-4-2021 13:40:05 ******/
CREATE DATABASE [WindowFunctionsDB]
GO



USE [WindowFunctionsDB]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sales](
	[cust] [int] NOT NULL,
	[date] [date] NOT NULL,
	[value] [int] NOT NULL
) 
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2019-12-03' AS Date), 7)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2019-12-06' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2019-12-06' AS Date), 7)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2019-12-13' AS Date), 10)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2019-12-17' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2019-12-18' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2019-12-22' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2019-12-22' AS Date), 7)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2019-12-22' AS Date), 6)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2019-12-23' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2019-12-23' AS Date), 9)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2019-12-29' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-01-02' AS Date), 9)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-01-02' AS Date), 7)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-01-03' AS Date), 6)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-01-04' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-01-04' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-01-05' AS Date), 6)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-01-05' AS Date), 6)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-01-06' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-01-12' AS Date), 6)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-01-13' AS Date), 9)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-01-14' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-01-17' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-01-18' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-01-18' AS Date), 7)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-01-19' AS Date), 10)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-01-20' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-01-20' AS Date), 9)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-01-21' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-01-22' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-01-27' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-01-28' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-02-01' AS Date), 7)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-02-05' AS Date), 7)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-02-07' AS Date), 6)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-02-08' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-02-14' AS Date), 7)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-02-16' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-02-18' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-02-20' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-02-26' AS Date), 9)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-03-02' AS Date), 10)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-03-04' AS Date), 10)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-03-13' AS Date), 11)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-03-18' AS Date), 8)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-03-26' AS Date), 12)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (103, CAST(N'2020-03-28' AS Date), 12)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (101, CAST(N'2020-03-28' AS Date), 5)
GO
INSERT [dbo].[sales] ([cust], [date], [value]) VALUES (102, CAST(N'2020-03-30' AS Date), 9)
GO
USE [master]
GO
ALTER DATABASE [WindowFunctionsDB] SET  READ_WRITE 
GO
