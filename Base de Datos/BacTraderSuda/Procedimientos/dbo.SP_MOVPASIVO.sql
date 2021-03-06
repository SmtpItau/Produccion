USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOVPASIVO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_MOVPASIVO

CREATE PROCEDURE [dbo].[SP_MOVPASIVO]
AS
BEGIN
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
  @hora  CHAR (8)
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


SET NOCOUNT ON  
     -- select * from mdmo where motipoper = 'CPP' 
     if exists(select * from mdmo where motipoper = 'CPP' )       
 SELECT  monumdocu,
  mocorrela,
  moinstser,
  monominal,
  motir,
  mopvp,
  movalcomp,
  uf = (select vmvalor from view_valor_moneda where vmfecha = mofecpro and vmcodigo = 998),
  dolar = (select vmvalor from view_valor_moneda where vmfecha = mofecpro and vmcodigo = 994),
  FECHA = mofecpro,
  hora = convert(char(10),getdate(),108),
  tasa_emi = (select setasemi from view_serie where semascara = momascara),
  movalemis = (select cpvalemis from mdpasivo where cpnumdocu = monumdocu and cpcorrela = mocorrela),
  glosa = ' ' ,
  acnomprop = @acnomprop
 
 FROM MDMO 
 WHERE motipoper = 'CPP'
 ORDER BY monumdocu
    ELSE
 SELECT  monumdocu = 0,
  mocorrela = 0,
  moinstser = '',
  monominal = 0.0,
  motir  =0.0,
  mopvp  =0.0,
  movalcomp = 0.0,
  uf = (select vmvalor from view_valor_moneda ,mdac where vmfecha = acfecproc and vmcodigo = 998),
  dolar = (select vmvalor from view_valor_moneda , mdac where vmfecha = acfecproc and vmcodigo = 994),
  FECHA = (select acfecproc from mdac),
  hora = convert(char(10),getdate(),108),
  tasa_emi = 0.0,
  movalemis = 0.0,
  glosa = '' ,
  acnomprop = @acnomprop
SET NOCOUNT OFF       
   END
GO
