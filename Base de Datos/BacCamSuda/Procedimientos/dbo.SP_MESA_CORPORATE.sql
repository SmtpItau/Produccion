USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MESA_CORPORATE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_MESA_CORPORATE](
    @USUARIO  CHAR(40)
        )
AS
BEGIN
  DECLARE @ARBI NUMERIC(19)
  DECLARE  @acfecproc   CHAR (10)
          ,@acfecprox   CHAR (10)
          ,@uf_hoy      FLOAT
          ,@uf_man      FLOAT
          ,@ivp_hoy     FLOAT
          ,@ivp_man     FLOAT
          ,@do_hoy      FLOAT
          ,@do_man      FLOAT
          ,@da_hoy      FLOAT
          ,@da_man      FLOAT
          ,@acnomprop   CHAR (40)
          ,@rut_empresa CHAR (12)
          ,@hora        CHAR ( 8)
          ,@EstoParaQue CHAR ( 3)
   EXECUTE Sp_Base_Del_Informe
           @acfecproc   OUTPUT
          ,@acfecprox   OUTPUT
          ,@uf_hoy      OUTPUT
          ,@uf_man      OUTPUT
          ,@ivp_hoy     OUTPUT
          ,@ivp_man     OUTPUT
          ,@do_hoy      OUTPUT
          ,@do_man      OUTPUT
          ,@da_hoy      OUTPUT
          ,@da_man      OUTPUT
          ,@acnomprop   OUTPUT
          ,@rut_empresa OUTPUT
          ,@hora        OUTPUT
          ,@EstoParaQue OUTPUT
   SELECT  @ARBI = (SELECT SUM(moutilpe) FROM MEMO WHERE MOTIPMER = 'ARBI' AND (MOESTATUS = 'M' OR MOESTATUS = ' '))
   SELECT  monumope
   ,monomcli
   ,mocodmon
   ,mocodcnv 
   ,momonmo 
   ,moticam 
   ,moparme 
   ,motctra
   ,mopartr
   ,Codigo_Comercio
   ,Codigo_Concepto
   ,'acobser' = @do_hoy
   ,mofech
   ,motipope
   ,mnrrda 
   ,moussme
   ,moutilpe
   ,motipmer
   ,monumfut
   ,mocostofo
   ,acutili
   ,Hora_Proc = right(getdate(),8)
   ,MOCODOMA
   ,'NVOLCOMUSD' = (CASE WHEN MOTIPOPE = 'C' AND MOCODMON = 'USD' THEN (MOTICAM * MOUSSME) ELSE 0 END)
   ,'NRENCOMUSD' = (CASE WHEN MOTIPOPE = 'C' AND MOCODMON = 'USD' THEN (MOUSSME * (ROUND((MOTCTRA-MOTICAM),4))) ELSE 0 END)
   ,'NVOLCOMMON' = (CASE WHEN MOTIPOPE = 'C' AND MOCODCNV = 'USD' THEN (ACOBSER * MOUSSME) ELSE (MOTICAM * MOUSSME) END) 
   ,'NRENCOMMON' = MOMONMO
   ,'NVOLVENUSD' = (CASE WHEN MOTIPOPE = 'V' AND MOCODMON = 'USD' THEN (MOTICAM * MOUSSME) ELSE 0 END)                      
   ,'NRENVENUSD' = (CASE WHEN MOTIPOPE = 'V' AND MOCODMON = 'USD' THEN (MOUSSME * (ROUND((MOTICAM-MOTCTRA),4))) ELSE 0 END) 
   ,'NVOLVENMON' = (CASE WHEN MOTIPOPE = 'V' AND MOCODCNV = 'USD' THEN (ACOBSER * MOUSSME) ELSE (MOTICAM * MOUSSME) END)    
   ,'NRENVENMON' = MOMONMO
   ,'NUTILFON'  = 0 
   ,'NUTILCOM'  = (CASE WHEN MOTIPOPE = 'C' AND MOCODMON = 'USD' AND MONUMFUT = 0 THEN (MOMONMO * (MOTCTRA - MOCOSTOFO))ELSE 0 END)
   ,'NUTILVEN'  = (CASE WHEN MOTIPOPE = 'V' AND MOCODMON = 'USD' AND MONUMFUT = 0 THEN (MOMONMO * (MOTCTRA - MOCOSTOFO))ELSE 0 END) 
   ,'NUTIMCOM'  = 0
   ,'NUTIMVEN'  = 0
   ,'NESTOBS'  = ((CP_TOTCO * CP_PMECOCI) + (CP_TOTVE * CP_PMEVECI)) / (CP_TOTCO + CP_TOTVE)
          ,'UTILARBI'  = ISNULL(@ARBI,0) 
   ,'acfecproc' = @acfecproc
   ,'acfecprox' = @acfecprox
   ,'uf_hoy' = @uf_hoy
   ,'uf_man' = @uf_man
   ,'ivp_hoy' = @ivp_hoy
   ,'ivp_man' = @ivp_man
   ,'do_hoy' = @do_hoy
   ,'do_man' = @do_man
   ,'da_hoy' = @da_hoy
      ,'da_man' = @da_man
   ,'pmnomprop' = @acnomprop
   ,'rut_empresa'= @rut_empresa
   ,'usuario' = @usuario
          ,'codigo_oma' = (CASE mocodoma WHEN 0 THEN 0 ELSE (SELECT codi_oma FROM tbomadelsuda WHERE mocodoma = codi_opera) END)
      FROM memo
          ,view_moneda
          ,meac 
     WHERE MOTIPMER  = 'EMPR'   AND 
           MNNEMO    = MOCODMON AND
          (MOESTATUS = ' ' OR MOESTATUS = 'M') 
  ORDER BY motipope
          ,mocodmon
          ,mocodcnv
          ,monumope
END

GO
