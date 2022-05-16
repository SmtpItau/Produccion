USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[memo_paso]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memo_paso](
	[MOENTIDAD] [numeric](10, 0) NOT NULL,
	[MOTIPMER] [char](4) NOT NULL,
	[MONUMOPE] [numeric](7, 0) NOT NULL,
	[MOTIPOPE] [char](1) NOT NULL,
	[MORUTCLI] [numeric](9, 0) NOT NULL,
	[MOCODCLI] [numeric](9, 0) NOT NULL,
	[MONOMCLI] [char](35) NOT NULL,
	[MOCODMON] [char](3) NOT NULL,
	[MOCODCNV] [char](3) NOT NULL,
	[MOMONMO] [numeric](19, 4) NOT NULL,
	[MOTICAM] [numeric](19, 4) NOT NULL,
	[MOTCTRA] [numeric](19, 4) NOT NULL,
	[MOTCFIN] [numeric](19, 4) NOT NULL,
	[MOPARME] [numeric](19, 8) NOT NULL,
	[MOPARCIE] [numeric](19, 8) NOT NULL,
	[MOPARTR] [numeric](19, 8) NOT NULL,
	[MOPAR30] [numeric](19, 8) NOT NULL,
	[MOPARFI] [numeric](19, 8) NOT NULL,
	[MOPRECIO] [numeric](19, 4) NOT NULL,
	[MOPRETRA] [numeric](19, 4) NOT NULL,
	[MOPREFI] [numeric](19, 4) NOT NULL,
	[MOUSSME] [numeric](19, 4) NOT NULL,
	[MOUSS30] [numeric](19, 4) NOT NULL,
	[MOUSSTR] [numeric](19, 4) NOT NULL,
	[MOUSSFI] [numeric](19, 4) NOT NULL,
	[MOMONPE] [numeric](19, 4) NOT NULL,
	[MOENTRE] [numeric](3, 0) NOT NULL,
	[MORECIB] [numeric](3, 0) NOT NULL,
	[MOVALUTA1] [datetime] NOT NULL,
	[MOVALUTA2] [datetime] NOT NULL,
	[MOVAMOS] [numeric](1, 0) NOT NULL,
	[MOTLXP1] [numeric](2, 0) NOT NULL,
	[MOTLXP2] [numeric](2, 0) NOT NULL,
	[MOOPER] [char](15) NOT NULL,
	[MOFECH] [datetime] NOT NULL,
	[MOHORA] [char](8) NOT NULL,
	[MOTERM] [char](15) NOT NULL,
	[MOCODOMA] [numeric](3, 0) NOT NULL,
	[MOESTATUS] [char](1) NOT NULL,
	[MOIMPRESO] [char](1) NOT NULL,
	[MOPCIERRE] [char](1) NOT NULL,
	[MORENTAB] [numeric](3, 0) NOT NULL,
	[MOCENCOS] [char](35) NOT NULL,
	[MOUNIDAD] [char](35) NOT NULL,
	[MOCODEJEC] [numeric](6, 0) NOT NULL,
	[MOGRPGEN] [numeric](3, 0) NOT NULL,
	[MOGRPPRO] [numeric](3, 0) NOT NULL,
	[MOCORRES] [numeric](7, 0) NOT NULL,
	[MOEJECUTI] [char](7) NOT NULL,
	[MOPMECO] [numeric](9, 4) NOT NULL,
	[MOPMEVE] [numeric](9, 4) NOT NULL,
	[MOTOTCO] [numeric](19, 4) NOT NULL,
	[MOTOTVE] [numeric](19, 4) NOT NULL,
	[MOTOTCOM] [numeric](19, 4) NOT NULL,
	[MOTOTVEM] [numeric](19, 4) NOT NULL,
	[MOENVIA] [char](1) NOT NULL,
	[MOALINEA] [char](1) NOT NULL,
	[MOAPROB] [char](1) NOT NULL,
	[MONUMCHE] [numeric](6, 0) NOT NULL,
	[MOCARTA] [char](1) NOT NULL,
	[MOTIPCAR] [numeric](3, 0) NOT NULL,
	[MONUMFUT] [numeric](8, 0) NOT NULL,
	[MOFECINI] [datetime] NOT NULL,
	[Swift_Corresponsal] [varchar](10) NOT NULL,
	[Swift_Recibimos] [varchar](10) NOT NULL,
	[Swift_Entregamos] [varchar](10) NOT NULL,
	[Plaza_Corresponsal] [numeric](5, 0) NOT NULL,
	[Plaza_Recibimos] [numeric](5, 0) NOT NULL,
	[Plaza_Entregamos] [numeric](5, 0) NOT NULL,
	[Precio_Cliente] [numeric](10, 4) NOT NULL,
	[Forma_Pago_Cli_Nac] [numeric](3, 0) NOT NULL,
	[Forma_Pago_Cli_Ext] [numeric](3, 0) NOT NULL,
	[Valuta_Cli_Nac] [datetime] NOT NULL,
	[Valuta_Cli_Ext] [datetime] NOT NULL,
	[Apoderado_Izquierda] [numeric](9, 0) NOT NULL,
	[Apoderado_Derecha] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Contabiliza] [char](1) NOT NULL,
	[Sintetico] [char](1) NOT NULL,
	[Mercado] [char](1) NOT NULL,
	[Codigo_Pais] [numeric](5, 0) NOT NULL,
	[Casa_Matriz] [numeric](5, 0) NOT NULL,
	[Marca] [varchar](30) NOT NULL,
	[NumeroInterfaz] [varchar](16) NOT NULL,
	[Observacion] [varchar](250) NOT NULL,
	[anula_usuario] [varchar](15) NOT NULL,
	[anula_fecha] [datetime] NOT NULL,
	[anula_hora] [char](8) NOT NULL,
	[anula_motivo] [char](60) NOT NULL,
	[codigo_area] [varchar](5) NOT NULL,
	[codigo_comercio] [char](6) NOT NULL,
	[codigo_concepto] [char](3) NOT NULL,
	[moutilpe] [numeric](19, 0) NOT NULL,
	[mocostofo] [numeric](10, 4) NOT NULL,
	[autorizador_limite] [char](15) NULL,
	[morutgir] [numeric](9, 0) NOT NULL,
	[mofecvcto] [datetime] NULL,
	[modias] [numeric](4, 0) NOT NULL,
	[mocodigogirador] [numeric](9, 0) NOT NULL,
	[moobservlin] [char](255) NOT NULL,
	[moobservlim] [char](255) NOT NULL
) ON [PRIMARY]
GO
