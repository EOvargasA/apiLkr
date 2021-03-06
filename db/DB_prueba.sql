USE [ProyectoI]
GO
/****** Object:  User [api_rest]    Script Date: 07/10/2020 12:16:17 a. m. ******/
CREATE USER [api_rest] FOR LOGIN [user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 07/10/2020 12:16:17 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[ID_Cliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NULL,
	[Apellido_paterno] [nvarchar](15) NULL,
	[Apellido_materno] [nvarchar](15) NULL,
	[Usuario] [nvarchar](30) NOT NULL,
	[Correo] [nvarchar](50) NOT NULL,
	[Contraseña] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[ID_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locker]    Script Date: 07/10/2020 12:16:18 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locker](
	[ID_Locker] [int] IDENTITY(1,1) NOT NULL,
	[Ubicacion_tienda] [nvarchar](100) NOT NULL,
	[Estatus] [nvarchar](20) NOT NULL,
	[ID_Orden] [int] NULL,
 CONSTRAINT [PK_Locker] PRIMARY KEY CLUSTERED 
(
	[ID_Locker] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden]    Script Date: 07/10/2020 12:16:18 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden](
	[ID_Orden] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cliente] [int] NOT NULL,
	[Fecha_orden] [date] NOT NULL,
	[Status_orden] [nvarchar](20) NOT NULL,
	[Ubicacion] [nvarchar](100) NOT NULL,
	[QR] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Orden] PRIMARY KEY CLUSTERED 
(
	[ID_Orden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden_Producto]    Script Date: 07/10/2020 12:16:18 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden_Producto](
	[ID_orden_producto] [int] IDENTITY(1,1) NOT NULL,
	[ID_Orden] [int] NOT NULL,
	[ID_Producto] [int] NOT NULL,
	[Cantidad] [int] NULL,
 CONSTRAINT [PK_Orden_Producto] PRIMARY KEY CLUSTERED 
(
	[ID_orden_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedido]    Script Date: 07/10/2020 12:16:18 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedido](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Locker_id] [int] NOT NULL,
	[User_ID] [int] NOT NULL,
	[QR] [nvarchar](20) NOT NULL,
	[Expiration_D] [date] NOT NULL,
	[Status] [char](1) NOT NULL,
 CONSTRAINT [PK_Pedido] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 07/10/2020 12:16:18 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Descripcion] [ntext] NOT NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_pedido]    Script Date: 07/10/2020 12:16:18 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto_pedido](
	[ID_Producto] [int] NOT NULL,
	[ID_Pedido] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
 CONSTRAINT [PK_producto_pedido] PRIMARY KEY CLUSTERED 
(
	[ID_Producto] ASC,
	[ID_Pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tokens]    Script Date: 07/10/2020 12:16:18 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tokens](
	[token] [nvarchar](10) NOT NULL,
	[ID_Usuario] [int] NOT NULL,
	[Fecha_Exp] [date] NOT NULL,
 CONSTRAINT [PK_Tokens] PRIMARY KEY CLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 07/10/2020 12:16:18 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([ID_Cliente], [Nombre], [Apellido_paterno], [Apellido_materno], [Usuario], [Correo], [Contraseña]) VALUES (1, N'Edgardo Osiris', N'Vargas', N'Avalos', N'EOVargasA', N'A01411438@itesm.mx', N'1234')
INSERT [dbo].[Cliente] ([ID_Cliente], [Nombre], [Apellido_paterno], [Apellido_materno], [Usuario], [Correo], [Contraseña]) VALUES (2, N'Maria', N'Jimena', N'Perez', N'BTLover1', N'MJimenasP@gmail.com', N'2345')
INSERT [dbo].[Cliente] ([ID_Cliente], [Nombre], [Apellido_paterno], [Apellido_materno], [Usuario], [Correo], [Contraseña]) VALUES (3, N'Marco', N'Rodrigez', N'Romero', N'Marco1981', N'Marco2R@gmail.com', N'3456')
INSERT [dbo].[Cliente] ([ID_Cliente], [Nombre], [Apellido_paterno], [Apellido_materno], [Usuario], [Correo], [Contraseña]) VALUES (4, N'Juan', N'Vargas', N'Mesa', N'Mesa69', N'MesaVargas@hotmail.com', N'4567')
INSERT [dbo].[Cliente] ([ID_Cliente], [Nombre], [Apellido_paterno], [Apellido_materno], [Usuario], [Correo], [Contraseña]) VALUES (5, N'Jose', N'del Angel', N'Perez', N'JoseP', N'JoseP@gmail.com', N'5678')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Locker] ON 

INSERT [dbo].[Locker] ([ID_Locker], [Ubicacion_tienda], [Estatus], [ID_Orden]) VALUES (1, N'Fila 3, Columna 2', N'En espera', 1)
INSERT [dbo].[Locker] ([ID_Locker], [Ubicacion_tienda], [Estatus], [ID_Orden]) VALUES (2, N'Fila 3, Columna 1', N'Disponible', NULL)
SET IDENTITY_INSERT [dbo].[Locker] OFF
GO
SET IDENTITY_INSERT [dbo].[Orden] ON 

INSERT [dbo].[Orden] ([ID_Orden], [ID_Cliente], [Fecha_orden], [Status_orden], [Ubicacion], [QR]) VALUES (1, 1, CAST(N'2020-09-30' AS Date), N'Procesando', N'Tienda departamental 1', N'asa123')
INSERT [dbo].[Orden] ([ID_Orden], [ID_Cliente], [Fecha_orden], [Status_orden], [Ubicacion], [QR]) VALUES (2, 2, CAST(N'2020-10-07' AS Date), N'Procesando', N'Tienda departamental 1', N'map231')
INSERT [dbo].[Orden] ([ID_Orden], [ID_Cliente], [Fecha_orden], [Status_orden], [Ubicacion], [QR]) VALUES (3, 4, CAST(N'2020-10-07' AS Date), N'Procesando', N'Tienda departamental 1', N'lata41')
SET IDENTITY_INSERT [dbo].[Orden] OFF
GO
SET IDENTITY_INSERT [dbo].[Orden_Producto] ON 

INSERT [dbo].[Orden_Producto] ([ID_orden_producto], [ID_Orden], [ID_Producto], [Cantidad]) VALUES (1, 1, 1, 3)
INSERT [dbo].[Orden_Producto] ([ID_orden_producto], [ID_Orden], [ID_Producto], [Cantidad]) VALUES (2, 1, 2, 2)
INSERT [dbo].[Orden_Producto] ([ID_orden_producto], [ID_Orden], [ID_Producto], [Cantidad]) VALUES (3, 2, 1, 3)
INSERT [dbo].[Orden_Producto] ([ID_orden_producto], [ID_Orden], [ID_Producto], [Cantidad]) VALUES (4, 2, 5, 1)
INSERT [dbo].[Orden_Producto] ([ID_orden_producto], [ID_Orden], [ID_Producto], [Cantidad]) VALUES (5, 2, 8, 5)
INSERT [dbo].[Orden_Producto] ([ID_orden_producto], [ID_Orden], [ID_Producto], [Cantidad]) VALUES (6, 3, 9, 1)
INSERT [dbo].[Orden_Producto] ([ID_orden_producto], [ID_Orden], [ID_Producto], [Cantidad]) VALUES (7, 3, 10, 1)
INSERT [dbo].[Orden_Producto] ([ID_orden_producto], [ID_Orden], [ID_Producto], [Cantidad]) VALUES (8, 3, 3, 1)
SET IDENTITY_INSERT [dbo].[Orden_Producto] OFF
GO
SET IDENTITY_INSERT [dbo].[Pedido] ON 

INSERT [dbo].[Pedido] ([ID], [Locker_id], [User_ID], [QR], [Expiration_D], [Status]) VALUES (1, 1, 1, N'minqwer', CAST(N'2020-12-31' AS Date), N'P')
SET IDENTITY_INSERT [dbo].[Pedido] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (1, N'Papel suavitel 6pz', N'Papel de baño de la marca suavitel')
INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (2, N'Sabritas 108g', N'Papas sabritas de multiples sabores')
INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (3, N'Jabon escudo 6pz', N'Proteje a tu familia')
INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (4, N'Jabon escudo 3pz', N'Proteje a tu familia')
INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (5, N'Jamon food 300g', N'Jamon de cerdo')
INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (6, N'Jamon del valle 300g', N'Jamon de pavo')
INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (7, N'Papel sanitario mimarca 12pz', N'Papel de baño')
INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (8, N'Salsa de tomate mimarca 500g', N'Salsa de tomate de tienda')
INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (9, N'Shampoo loreal 600ml', N'Por que tu lo vales')
INSERT [dbo].[Producto] ([ID], [Nombre], [Descripcion]) VALUES (10, N'Deshodorante axe 300ml', N'Olor a hombre')
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
INSERT [dbo].[producto_pedido] ([ID_Producto], [ID_Pedido], [cantidad]) VALUES (1, 1, 2)
INSERT [dbo].[producto_pedido] ([ID_Producto], [ID_Pedido], [cantidad]) VALUES (2, 1, 2)
GO
INSERT [dbo].[Tokens] ([token], [ID_Usuario], [Fecha_Exp]) VALUES (N'asa123', 1, CAST(N'2020-12-31' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([ID], [Username], [Password]) VALUES (1, N'osiris', N'1234')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
ALTER TABLE [dbo].[Locker]  WITH CHECK ADD  CONSTRAINT [Orden_Locker] FOREIGN KEY([ID_Orden])
REFERENCES [dbo].[Orden] ([ID_Orden])
GO
ALTER TABLE [dbo].[Locker] CHECK CONSTRAINT [Orden_Locker]
GO
ALTER TABLE [dbo].[Orden]  WITH CHECK ADD  CONSTRAINT [Cliente_Orden] FOREIGN KEY([ID_Cliente])
REFERENCES [dbo].[Cliente] ([ID_Cliente])
GO
ALTER TABLE [dbo].[Orden] CHECK CONSTRAINT [Cliente_Orden]
GO
ALTER TABLE [dbo].[Orden_Producto]  WITH CHECK ADD  CONSTRAINT [Orden_multi] FOREIGN KEY([ID_Orden])
REFERENCES [dbo].[Orden] ([ID_Orden])
GO
ALTER TABLE [dbo].[Orden_Producto] CHECK CONSTRAINT [Orden_multi]
GO
ALTER TABLE [dbo].[Orden_Producto]  WITH CHECK ADD  CONSTRAINT [Producto_multi] FOREIGN KEY([ID_Producto])
REFERENCES [dbo].[Producto] ([ID])
GO
ALTER TABLE [dbo].[Orden_Producto] CHECK CONSTRAINT [Producto_multi]
GO
