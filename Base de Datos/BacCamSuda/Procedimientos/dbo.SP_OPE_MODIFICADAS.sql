USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPE_MODIFICADAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC SP_OPE_MODIFICADAS 'rfuentes'

CREATE PROCEDURE [dbo].[SP_OPE_MODIFICADAS] (
    @USUARIO CHAR(40)
          )
AS
BEGIN
 SET NOCOUNT ON
CREATE TABLE #Temp_Modificadas (
 [MOTIPMER] [char] (4) NULL ,
 [MONUMOPE] [numeric](7, 0) NOT NULL ,
 [MOTIPOPE] [char] (1) NULL ,
 [MONOMCLI] [char] (60) NULL ,
 [MOCODMON] [char] (3) NULL ,
 [MOMONMO] [numeric](19, 4) NULL ,
 [MOTICAM] [numeric](19, 4) NULL ,
 [MOTCTRA] [numeric](19, 4) NULL ,
 [MOPARCIE] [numeric](19, 8) NULL ,
 [MOPARTR] [numeric](19, 8) NULL ,
 [MOENTRE] [CHAR](50) NULL ,
 [MORECIB] [CHAR](50) NULL ,
 [MOVALUTA1] [datetime] NULL ,
 [MOVALUTA2] [datetime] NULL ,
 [MOVAMOS] [numeric](1, 0) NULL ,
 [MOOPER] [char] (12) NULL ,
 [MOFECH] [datetime] NULL ,
 [MOHORA] [CHAR] (8) NULL ,
 [TIPO] [char] (1) NULL,
 [Hora_Proc] [char] (8)  NULL,
[cfecpro]   [CHAR] (10) NULL,
[acfecprx]   [CHAR](10) NULL,
[uf_hoy]      [FLOAT]   NULL,
[uf_man]      [FLOAT]   NULL,
[ivp_hoy]     [FLOAT]   NULL,
[ivp_man]     [FLOAT]   NULL,
[do_hoy]      [FLOAT]   NULL,
[do_man]      [FLOAT]   NULL,
[da_hoy]      [FLOAT]   NULL,
[da_man]      [FLOAT]   NULL,
[acnombre]    [CHAR] (40) NULL,
[rut_empresa] [CHAR] (12) NULL,
 [usuario]     [CHAR] (50) NULL,
 [fech_ser]    [CHAR] (10) NULL
)
 
  DECLARE  @acfecproc   char(10),
           @acfecprox   char(10),
           @uf_hoy      float,
           @uf_man      float,
           @ivp_hoy     float,
           @ivp_man     float,
           @do_hoy      float,
           @do_man      float,
           @da_hoy      float,
           @da_man      float,
           @acnomprop   char(50),
           @rut_empresa char(12),
           @hora        char(8),
           @oma  char(5)
   EXECUTE Sp_Base_Del_Informe
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT,
    @oma  OUTPUT
INSERT #Temp_Modificadas
SELECT    MOTIPMER,
   MONUMOPE,
   MOTIPOPE,
   MONOMCLI,
   MOCODMON,
   MOMONMO,
   MOTICAM,
   MOTCTRA,
   MOPARCIE,
   MOPARTR,
   ENTRE = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MOENTRE),
   RECIB=(SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MORECIB),
   MOVALUTA1,
   MOVALUTA2,
   MOVAMOS,
   MOOPER,
   MOFECH,
   MOHORA,
   'M',
   CONVERT(CHAR(8),right (getdate(),8)),
   @acfecproc ,
             @acfecprox ,
             @uf_hoy    ,
             @uf_man    ,
             @ivp_hoy   ,
             @ivp_man   ,
             @do_hoy    ,
             @do_man    ,
             @da_hoy    ,
             @da_man    ,
             @acnomprop ,
             @rut_empresa,
   @usuario,
   CONVERT(CHAR(10),getdate(),103)
   from memo 
   where moestatus = 'M'
INSERT #Temp_Modificadas 
SELECT    a.MOTIPMER,
   a.MONUMOPE,
   a.MOTIPOPE,
   a.MONOMCLI,
   a.MOCODMON,
   a.MOMONMO,
   a.MOTICAM,
   a.MOTCTRA,
   a.MOPARCIE,
   a.MOPARTR,
   (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = a.MOENTRE),
   (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = a.MORECIB),
   a.MOVALUTA1,
   a.MOVALUTA2,
   a.MOVAMOS,
   a.MOOPER,
   a.MOFECH,
   a.MOHORA,
   'O',
   CONVERT(CHAR(8),right (getdate(),8)),
   b.cfecpro,
    b.acfecprx   ,
    b.uf_hoy     ,
    b.uf_man     ,
    b.ivp_hoy    ,
    b.ivp_man    ,
    b.do_hoy     , 
    b.do_man     ,
    b.da_hoy     ,
    b.da_man     ,
    b.acnombre   ,
    b.rut_empresa,
   b.usuario,
   CONVERT(CHAR(10),getdate(),103)
   FROM memolog a ,#Temp_Modificadas b
  WHERE a.monumope = b.monumope 
  
  
  DECLARE @COUNT INT
  SET @COUNT = (SELECT COUNT(*) FROM #Temp_Modificadas)

  IF @COUNT > 0
	BEGIN

		SELECT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #Temp_Modificadas ORDER BY monumope
	END

  ELSE
    
	BEGIN

        SELECT MOTIPMER = ' ',
			   MONUMOPE = 0,
			   MOTIPOPE = ' ',
			   MONOMCLI = ' ',
			   MOCODMON = ' ',
			   MOMONMO = 0,
			   MOTICAM = 0,
			   MOTCTRA = 0,
			   MOPARCIE = 0,
			   MOPARTR = 0,
			   MOENTRE = ' ',
			   MORECIB = ' ',
			   MOVALUTA1 = ' ',
			   MOVALUTA2 = ' ',
			   MOVAMOS = 0,
			   MOOPER = ' ',
			   MOFECH = ' ',
			   MOHORA = ' ',
			   TIPO = ' ',
			   Hora_Proc = ' ',
			   cfecpro = ' ',
			   acfecprx = ' ',
			   uf_hoy = 0     ,
			   uf_man = 0    ,
			   ivp_hoy = 0    ,
			   ivp_man = 0   ,
			   do_hoy = 0    , 
			   do_man = 0    ,
			   da_hoy = 0     ,
			   da_man = 0     ,
			   acnombre = 0   ,
			   rut_empresa = 0,
			   usuario = 0,
			   fech_ser = 0,
			   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

	END
  
  SET NOCOUNT OFF
END

GO
