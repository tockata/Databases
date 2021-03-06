USE [School]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 18.6.2015 г. 19:07:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[MaxStudents] [int] NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Students]    Script Date: 18.6.2015 г. 19:07:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Age] [int] NOT NULL,
	[PhoneNumber] [nvarchar](50) NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Classes] ON 

INSERT [dbo].[Classes] ([Id], [Name], [MaxStudents]) VALUES (1, N'OOP', 250)
INSERT [dbo].[Classes] ([Id], [Name], [MaxStudents]) VALUES (2, N'Javascript Apps', 200)
INSERT [dbo].[Classes] ([Id], [Name], [MaxStudents]) VALUES (3, N'Databases', 230)
SET IDENTITY_INSERT [dbo].[Classes] OFF
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([Id], [Name], [Age], [PhoneNumber]) VALUES (1, N'Pesho Peshev', 23, N'359888-987654')
INSERT [dbo].[Students] ([Id], [Name], [Age], [PhoneNumber]) VALUES (2, N'Gosho Goshev', 27, N'02-123456')
INSERT [dbo].[Students] ([Id], [Name], [Age], [PhoneNumber]) VALUES (3, N'Mimi Georgieva', 33, NULL)
SET IDENTITY_INSERT [dbo].[Students] OFF
