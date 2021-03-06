USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOVCTOPACTO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_LISTADOVCTOPACTO 'VENTAS CON PACTO DEL DIA'

CREATE PROCEDURE [dbo].[SP_LISTADOVCTOPACTO]
    (
    @titulo VARCHAR(80)
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @acfecproc CHAR (10) ,
        @acfecprox CHAR (10) ,
        @uf_hoy  FLOAT  ,
        @uf_man  FLOAT  ,
        @ivp_hoy FLOAT  ,
        @ivp_man FLOAT  ,
        @do_hoy  FLOAT  ,
        @do_man  FLOAT  ,
        @da_hoy  FLOAT  ,
        @da_man  FLOAT  ,
        @acnomprop CHAR (40) ,
        @rut_empresa CHAR (12) ,
        @nRutemp NUMERIC (09,0) ,
        @hora  CHAR (08) ,
        @paso  CHAR (01)
 EXECUTE Sp_Base_Del_Informe
           @acfecproc OUTPUT ,
           @acfecprox OUTPUT ,
           @uf_hoy  OUTPUT ,
           @uf_man  OUTPUT ,
           @ivp_hoy OUTPUT ,
           @ivp_man OUTPUT ,
           @do_hoy  OUTPUT ,
           @do_man  OUTPUT ,
           @da_hoy  OUTPUT ,
           @da_man  OUTPUT ,
           @acnomprop OUTPUT ,
           @rut_empresa OUTPUT ,
           @hora  OUTPUT

		   -- FUSION ---
			SET @acnomprop       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
			-------------

  SELECT 'acfecproc'    = @acfecproc    ,
         'acfecprox'    = @acfecprox    ,
         'uf_hoy'       = @uf_hoy       ,
         'uf_man'       = @uf_man       ,
         'ivp_hoy'      = @ivp_hoy      ,
         'ivp_man'      = @ivp_man      ,
         'do_hoy'       = @do_hoy       ,
         'do_man'       = @do_man       ,
         'da_hoy'       = @da_hoy       ,
         'da_man'       = @da_man       ,
         'acnomprop'    = @acnomprop    ,
         'rut_empresa'  = @rut_empresa  ,
         'hora'         = @hora         ,
         'numoper'      = ISNULL(monumoper,0)                         , --1
         'nomcli'       = ISNULL(VIEW_CLIENTE.clnombre , '')          , --2
         'monto'        = ISNULL(movalinip,0)                         , --3
         'tasa'         = ISNULL(motaspact,0.0)                       , --4
         'plazo'        = ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0) , --5
         'fecven'       = ISNULL(CONVERT(CHAR(10),mofecven,103), '')  , --6
         'mtofinal'     = ISNULL(movalvenp,0)                         , --7
         'moneda'       = ISNULL(( SELECT mnnemo FROM VIEW_MONEDA WHERE MNCODMON = MOMONPACT), ''),--8
         'forpago'      = ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo= moforpagv), ''),--9
         'titulo'       = @titulo                                      --10
  INTO #temp1
  FROM   MDMO LEFT OUTER JOIN  VIEW_MONEDA ON momonemi = mncodmon
       , MDAC
--       , VIEW_MONEDA
       , VIEW_CLIENTE    
         WHERE   (motipoper='VI' AND mostatreg<>'A') AND 
                 acrutprop=morutcart AND
                 (clrut=morutcli AND clcodigo=mocodcli)  
--                 momonemi*=mncodmon

  ORDER BY nomcli
 IF (SELECT COUNT(*) FROM #temp1) = 0
 BEGIN
  INSERT INTO #temp1
  SELECT 'acfecproc'    = @acfecproc    ,
         'acfecprox'    = @acfecprox    ,
         'uf_hoy'       = @uf_hoy       ,
         'uf_man'       = @uf_man       ,
         'ivp_hoy'      = @ivp_hoy      ,
         'ivp_man'      = @ivp_man      ,
         'do_hoy'       = @do_hoy       ,
         'do_man'       = @do_man       ,
         'da_hoy'       = @da_hoy       ,
         'da_man'       = @da_man       ,
         'acnomprop'    = @acnomprop    ,
         'rut_empresa'  = @rut_empresa  ,
         'hora'         = @hora         ,
         'numoper'      = 0             ,--1
         'nomcli'       = ''            ,--2
         'monto'        = 0             ,--3
         'tasa'         = 0             ,--4
         'plazo'        = 0             ,--5
         'fecven'       = ''            ,--6
         'mtofinal'     = 0             ,--7
         'moneda'       = ''            ,--8
         'forpago'      = ''            ,--9
         'titulo'       = @titulo        --10
 END
 SELECT * FROM #temp1
 SET NOCOUNT OFF
END
GO
