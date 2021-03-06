USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENVIARSPOTANTICIPO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ENVIARSPOTANTICIPO]( @NumOpe NUMERIC(8) )
AS 
BEGIN
 SET NOCOUNT ON
 DECLARE @moentidad numeric(10)   ,
  @monumope  numeric( 7)  ,
  @motipmer  char (4)  ,
  @motipope  char (1)  ,
  @morutcli  numeric( 9)  ,
  @mocodcli  numeric( 9)  ,
  @monomcli  char(35)  ,
  @mocodmon  char (3)  ,
  @mocodcnv  char (3)  ,
  @momonmo   numeric(19,4) ,
  @moticam   numeric(19,4) ,
  @moparme   numeric(19,8) ,
  @moprecio  numeric(19,4) ,
  @moussme   numeric(19,4) ,
  @momonpe   numeric(19,4) ,
  @moentre   numeric( 3)  ,
  @morecib   numeric( 3)  ,
  @movaluta1 datetime  ,     -- Entregamos
  @movaluta2 datetime  ,     -- Recibimos
  @mooper    char (15)  ,
  @mofech    datetime  ,
  @mohora    char ( 8)  ,
  @moterm    char (12)  ,
  @motipcar  numeric( 3)  ,
  @monumfut  numeric( 8)  ,
  @mofecini  datetime      ,
  @fecha     char (8)
--------------------------<< Valida existencia de FORWARD
 SELECT @fecha = CONVERT(CHAR(8),cafecvcto,112)
 FROM MFCA
 WHERE canumoper = @NumOpe
 IF @fecha IS NULL
  BEGIN
   SET NOCOUNT OFF
	--	select 'debug RETURN -1'
   RETURN -1

  END
--------------------------<< Valida Fecha SPOT v/s solicitud FORWARD
 IF NOT (@fecha = (SELECT acfecpro FROM VIEW_MEAC_SPOT)
     OR  @fecha = (SELECT acfecprx FROM VIEW_MEAC_SPOT))
  BEGIN
   SET NOCOUNT OFF
	--	select 'debug RETURN -2' 
	--	SELECT acfecpro FROM VIEW_MEAC_SPOT
        RETURN -2
  END
/*********************************************************************************/
--BEGIN TRANSACTION
--------------------------<< Transfiere FORWARD a tbVencimientosForward
SELECT @moentidad = accodigo  FROM VIEW_MEAC_SPOT
--------------------------<< Operacion Forward

 SELECT @moticam   = ( CASE WHEN cacodpos1 = 2                     THEN ( SELECT vmvalor FROM view_valor_moneda , mfca a where vmcodigo = 994 and a.canumoper  = @NumOpe AND vmfecha = a.cafecvcto )
                            WHEN cacodpos1 = 1 AND cacodmon1 = 998 THEN ( ( camtomon2 * ( SELECT vmvalor FROM view_valor_moneda , mfca where vmcodigo = 998 and canumoper  = @NumOpe AND vmfecha = cafecvcto ) ) / camtomon1 )
                            WHEN cacodpos1 = 1 AND cacodmon1 = 999 THEN capremon2
                            ELSE catipcam  --> CaAntPreOpEF  
                        END ) 
 FROM  MFCA
 WHERE  canumoper  = @NumOpe 

 SELECT  @moprecio  = ( CASE WHEN cacodpos1 = 2 THEN 0         
                             WHEN cacodpos1 = 1 AND cacodmon1 = 998 THEN ( ( camtomon2 * ( SELECT vmvalor FROM view_valor_moneda,mfca where vmcodigo = 998 and canumoper  = @NumOpe and vmfecha = cafecvcto ) ) / camtomon1 )
                             WHEN cacodpos1 = 1 AND cacodmon1 = 999 THEN capremon2
                             ELSE CaAntPreOpEF  
                         END ) 
 FROM  MFCA
 WHERE  canumoper  = @NumOpe 

 ---  
 ---    @momonpe   = ( CASE WHEN cacodpos1 = 2 THEN ( camtomon1 * ( @moticam / @moparme ) )
 SELECT @motipcar  = cacodpos1 ,  -- Segun MDTC=50/1=Seg;2=Arb
        @motipope  = catipoper ,
        @monumfut  = numerocontratocliente, 
        @mofecini  = cafecha   ,  
        @motipmer  = (CASE cacodpos1 WHEN 2 THEN 'ARBI' ELSE 'PTAS' END),
        @morutcli  = cacodigo  ,
        @mocodcli  = cacodcli ,
        @mocodmon  = CONVERT(CHAR(3),cacodmon1) ,
        @mocodcnv  = CASE WHEN cacodmon2 = 998 THEN '999' ELSE CONVERT(CHAR(3),cacodmon2) END ,
        @momonmo   = camtomon1 ,
        @moparme   = ( CASE WHEN cacodpos1 = 2 THEN caparmon2 ELSE  caparmon1 END ) ,
        @moussme   = ( CASE WHEN cacodpos1 = 2 THEN camtomon2  ELSE caequusd1 END ),
        @momonpe   = ( CASE WHEN cacodpos1 = 2 THEN ( camtomon2 * @moticam ) 
                            WHEN cacodpos1 = 1 AND cacodmon1 = 998 THEN ( @moticam / camtomon2 )
                            WHEN cacodpos1 = 1 AND cacodmon1 = 999 THEN camtomon2
                            ELSE camtomon2  
                        END )  ,
        @moentre   = (CASE WHEN catipoper = 'C' AND cacodpos1 <> 2 THEN cafpagomn ELSE cafpagomx END),-------
        @morecib   = (CASE WHEN catipoper = 'C'  OR cacodpos1  = 2 THEN cafpagomx ELSE cafpagomn END), -------
        @movaluta1 = cafecvcto ,     -- Entregamos
        @movaluta2 = cafecvcto ,     -- Recibimos
        @mooper    = caoperador,
        @mofech    = CONVERT(CHAR(8),cafecvcto,112),
        @mohora    = CONVERT(CHAR(8),getdate(),108),
        @moterm    = 'FORWARD'
 FROM  MFCA
 WHERE  canumoper  = @NumOpe 

--------------------------<< Valutas para Formas de Pago
 DECLARE @diasvalor INTEGER
 DECLARE @feriado   INTEGER

 SELECT  @diasvalor = diasvalor  FROM VIEW_FORMA_DE_PAGO WHERE codigo = @moentre

 WHILE (@diasvalor > 0)  ------------------ Valuta Entregamos
  BEGIN
        SELECT @movaluta1 = DATEADD(day, 1, @movaluta1)
        EXECUTE sp_feriado @movaluta1, 6, @feriado OUTPUT
        IF @feriado = 0
    SELECT @diasvalor = @diasvalor -1
  END


 SELECT  @diasvalor = diasvalor  
 FROM VIEW_FORMA_DE_PAGO  
 WHERE codigo = @morecib

 WHILE (@diasvalor > 0)  ------------------ Valuta Recibimos
  BEGIN
       SELECT @movaluta2 = DATEADD(day, 1, @movaluta2)
       EXECUTE sp_feriado @movaluta2, 6, @feriado OUTPUT
       IF @feriado = 0
          SELECT @diasvalor = @diasvalor -1
 END

 --------------------------<< Monedas
 SELECT @mocodmon = mnnemo
 FROM VIEW_MONEDA
 WHERE mncodmon  = CONVERT(NUMERIC(3),@mocodmon)
  
 SELECT @mocodcnv = mnnemo
 FROM VIEW_MONEDA
 WHERE mncodmon  = CONVERT(NUMERIC(3),@mocodcnv)
--------------------------<< Cliente y Mercado
/*
 SELECT clcodigo
 FROM VIEW_CLIENTE
 WHERE clrut = @morutcli
*/
 IF @motipmer <> 'ARBI' AND
  NOT EXISTS (SELECT clpais FROM VIEW_CLIENTE
                            WHERE clrut = @morutcli AND clcodigo = @mocodcli)
     SELECT @motipmer = 'EMPR'
--------------------------<< Agregando a tbVencimientosForward
 IF EXISTS (SELECT monumfut  FROM VIEW_TBVENCIMIENTOSFORWARD
                           WHERE monumfut = @NumOpe)
  DELETE VIEW_TBVENCIMIENTOSFORWARD
  WHERE monumfut = @NumOpe



 INSERT VIEW_TBVENCIMIENTOSFORWARD  -- select * from VIEW_TBVENCIMIENTOSFORWARD
 VALUES(
          @moentidad ,
  @motipmer  ,
  @motipope  ,
  @morutcli  ,
  @mocodcli  ,
  @mocodmon  ,
  @mocodcnv  ,
  @momonmo   ,
  @moticam   ,
  @moparme   ,
  @moprecio  ,
  @moussme   ,
  @momonpe   ,
  @moentre   ,
  @morecib   ,
  @movaluta1 ,     -- Entregamos
  @movaluta2 ,     -- Recibimos
  @mooper    ,
  @mofech    ,
  @mohora    ,
  @moterm    ,
  @motipcar  ,
  @monumfut  ,
  @mofecini
        )

-- IF @@error <> 0
--  BEGIN
--  ROLLBACK TRANSACTION
--     SELECT @@error, 'No se puede enviar a Spot Op. Forward' 
--  SET NOCOUNT OFF
--  RETURN -3
--  END
--------<< Operacion Forward en tbVencimientosForward , OK !!! ...
--COMMIT TRANSACTION
--SELECT 0,'OK' 
 SET NOCOUNT OFF
 RETURN 0
 SET NOCOUNT OFF
END


GO
