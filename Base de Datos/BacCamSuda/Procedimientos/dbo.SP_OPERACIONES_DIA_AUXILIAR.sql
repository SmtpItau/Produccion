USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONES_DIA_AUXILIAR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OPERACIONES_DIA_AUXILIAR]
            ( 
              @ENTIDAD    NUMERIC(3),
              @TIPMERC    CHAR(4) = '',
              @TIPOPER    VARCHAR(3) = '',
              @ORDEN      NUMERIC(1)= '',
              @NUMOPER    NUMERIC(7) = 0
            )
AS
BEGIN
SET NOCOUNT ON
--    SELECT @TIPOPER = CASE WHEN @TIPOPER = '' THEN 'CVA' ELSE @TIPOPER END
    SELECT DISTINCT 'M01'  = moentidad,
       'm02'      = motipmer,
       'm03'      = monumope,
       'm04'      = a.clrut,
       'm05'      = a.cldv, 
       'm06'      = a.clcodigo,
       'm07'      = a.clnombre,
       'm08'      = motipope,
       'm09'      = mocodmon,
       'm10'      = mocodcnv,
       'q11'      = momonmo,
       'q12'      = moticam,
       'q13'      = motctra,
       'q14'      = moparme,
       'q15'      = mopartr,
       'q16'      = moprecio,
       'q17'      = mopretra,
       'q18'      = moussme,
       'q19'      = momonpe,
       'q20'      = moentre,
       'f21'      = b.glosa,
       'f22'      = convert(char(10),movaluta1,110), -- entregamos
       'f23'      = morecib,
       'f24'      = c.glosa,
       'f25'      = convert(char(10),movaluta2,110), -- recibimos
       'f26'      = mooper,
       'f27'      = convert(char(10),mofech,103),
       'f28'      = mohora,
       'f29'      = d.mnglosa,   -- glosa de mocodmon
       'a30'      = e.mnglosa,   -- glosa de mocodcnv
       'a31'      = movamos,
       'a32'      = moterm,
       'a33'      = mocodoma,
       'a34'      = moestatus,
       'a35'      = morentab,
       'a36'      = moalinea,
       'a37'      = motipcar,
       'a38'      = monumfut,
       'a39'      = mofecini,
       'a40'      = moaprob,       -- indica c/v si la operacion fue anulada
       'a41'      = d.mncodbanco,  -- codigo bcch de mocodmon
       'a42'      = e.mncodbanco,   -- codigo bcch de mocodcnv
       'entidad'  = ( select distinct f.rcnombre from  VIEW_ENTIDAD where  f.rccodcar = moentidad ),--bactrader..mdrc  
       'nomcli'   = ( select distinct acnombre   from  MEAC ),
       'fechap'   = ( select  distinct acfecpro  from  MEAC ),
       'hora'     = convert(char(08),getdate(),108)
  INTO #TEMP
  FROM MEMO  ,
       VIEW_CLIENTE A,
       VIEW_FORMA_DE_PAGO B,
       VIEW_FORMA_DE_PAGO C,
       VIEW_MONEDA D,
       VIEW_MONEDA E,
       VIEW_ENTIDAD F, -- BACTRADER..MDRC TABLA ENTIDADES 
       MEAC -- MEAC G -- TABLA PARAMETROS
 WHERE    morutcli                       =      a.clrut
     and  mocodcli                       =      a.clcodigo
     and  (motipmer                      =      @TIPMERC ) or ( @TIPMERC = '' )
     and ( motipope                      =      @TIPOPER) or ( @TIPOPER = '')
     and ( @ENTIDAD                      =     0             or  moentidad  =  @ENTIDAD )
     and  moentre                        =     b.codigo --
     and  morecib                        =     c.codigo
     and  mocodmon                       =     substring(d.mnsimbol,1,3)--
     and  mocodcnv                       =     substring(e.mnsimbol,1,3)
     and (@NUMOPER                       =     0             or  monumope   =  @NUMOPER )
IF @ORDEN <= 0 OR @ORDEN > 4      -- NRO OPERACION
   SELECT DISTINCT * FROM #TEMP ORDER BY m01,m03
IF @ORDEN = 1                     -- TIPO OPERACION
   SELECT  * FROM #TEMP ORDER BY m01,m08
IF @ORDEN = 2                     -- CLIENTE
   SELECT  * FROM #TEMP ORDER BY m01,m07
IF @ORDEN = 3                     -- OPERADOR
   SELECT  * FROM #TEMP ORDER BY m01,f26
IF @ORDEN = 4                     -- TIPO DE MERCADO
   SELECT *  FROM #TEMP ORDER BY m01,m02,m03
END

GO
