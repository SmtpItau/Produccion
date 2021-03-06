USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENVIARSPOT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_ENVIARSPOT]  
   (   @NumOpe   NUMERIC(8)   )  
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
           @mooper    char (15)  ,    -- MAP 20060920  
           @mofech    datetime  ,  
           @mohora    char ( 8)  ,  
           @moterm    char (12)  ,  
           @motipcar  numeric( 3)  ,  
           @monumfut  numeric( 8)  ,  
           @mofecini  datetime      ,  
           @fecha     char (8)  
  
   --------------------------<< Valida existencia de FORWARD  
   SET @fecha = (SELECT CONVERT(CHAR(8),cafecvcto,112) FROM MFCA with (nolock) WHERE canumoper = @NumOpe)  
  
   IF @fecha IS NULL  
   BEGIN  
      SET NOCOUNT OFF  
      RETURN -1  
   END  
  
  
   --------------------------<< Valida Fecha SPOT v/s solicitud FORWARD  
   IF NOT (@fecha = (SELECT acfecpro FROM VIEW_MEAC_SPOT with (nolock) )  
       OR  @fecha = (SELECT acfecprx FROM VIEW_MEAC_SPOT with (nolock) ))  
   BEGIN  
      SET NOCOUNT OFF  
      RETURN -2  
   END  
  
  
   /*********************************************************************************/  
   --BEGIN TRANSACTION  
   --------------------------<< Transfiere FORWARD a tbVencimientosForward  
  
   SET @moentidad = (SELECT accodigo FROM VIEW_MEAC_SPOT with (nolock) )  
  
   --------------------------<< Operacion Forward  
   SELECT @moticam  = CASE WHEN cacodpos1 = 2                     THEN   D.vmvalor  
                           WHEN cacodpos1 = 1 AND cacodmon2 = 998 THEN CONVERT(NUMERIC(19,4), ROUND( ROUND( (camtomon2 * U.vmvalor), 0 ) / camtomon1, 4) ) --> ((camtomon2 * U.vmvalor) / camtomon1)
                           WHEN cacodpos1 = 1  AND cacodmon2 = 999 THEN   capremon2
                           ELSE                                          catipcam    
                      END     
   FROM   MFCA                          with (nolock)  
          LEFT JOIN VIEW_VALOR_MONEDA D with (nolock) ON D.vmfecha = cafecvcto AND D.vmcodigo = 994 --> CASE WHEN cacodpos1 = 2 THEN 994 ELSE 998 END  
          LEFT JOIN VIEW_VALOR_MONEDA U with (nolock) ON U.vmfecha = cafecvcto AND U.vmcodigo = 998 --> CASE WHEN cacodpos1 = 2 THEN 994 ELSE 998 END  
   WHERE  canumoper  = @NumOpe  
  
   SELECT @moprecio = CASE WHEN cacodpos1 = 2                     THEN 0  
                           WHEN cacodpos1 = 1 AND cacodmon2 = 998 THEN CONVERT(NUMERIC(19,4), ROUND( ROUND( (camtomon2 * vmvalor), 0 ) / camtomon1, 4) ) --> ((camtomon2 * vmvalor) / camtomon1)
                           WHEN cacodpos1 = 1 AND cacodmon2 = 999 THEN   capremon2
                           ELSE                                          catipcam  
                      END   
    FROM  MFCA                        with (nolock)  
          LEFT JOIN VIEW_VALOR_MONEDA with (nolock) ON vmfecha = cafecvcto AND vmcodigo = 998  
   WHERE  canumoper  = @NumOpe  
  
  
   SELECT @motipcar  = case when cacodpos1 = 14 then 1 else cacodpos1 end ,  -- Segun MDTC=50/1=Seg;2=Arb  
          @motipope  = catipoper,  
          @monumfut  = canumoper,  
          @mofecini  = cafecha,  
          @motipmer  = CASE WHEN cacodpos1 = 2  THEN 'ARBI'   
                            WHEN cacodpos1 = 12 THEN 'EMPR'   
                            WHEN cacodpos1 = 14 THEN 'EMPR'  -- Forward a Observado, insidencia  
                            ELSE                     'PTAS'   
                       END,  
          @morutcli  = cacodigo,  
          @mocodcli  = cacodcli,  
          @mocodmon  = CONVERT(CHAR(3),cacodmon1),  
          @mocodcnv  = CASE WHEN cacodmon2 = 998 THEN '999' ELSE CONVERT(CHAR(3),cacodmon2) END,  
          @momonmo   = camtomon1 ,  
          @moparme   = CASE WHEN cacodpos1 = 2 THEN caparmon2 ELSE caparmon1 END,  
          @moussme   = CASE WHEN cacodpos1 = 2 THEN camtomon2 ELSE caequusd1 END,  
          @momonpe   = CASE WHEN cacodpos1 = 2 THEN                     (camtomon2 * @moticam)   
                            WHEN cacodpos1 = 1 AND cacodmon1 = 998 THEN (@moticam / camtomon2)  
                            WHEN cacodpos1 = 1 AND cacodmon1 = 999 THEN  camtomon2  
                            ELSE                                         camtomon2   
                       END,  
          @moentre   = CASE WHEN catipoper = 'C' AND cacodpos1 <> 2 THEN cafpagomn ELSE cafpagomx END,  
          @morecib   = CASE WHEN catipoper = 'C'  OR cacodpos1  = 2 THEN cafpagomx ELSE cafpagomn END,  
          @movaluta1 = cafecvcto,  
          @movaluta2 = cafecvcto,  
          @mooper    = caoperador,  
          @mofech    = CONVERT(CHAR(8),cafecvcto,112),  
          @mohora    = CONVERT(CHAR(8),getdate(),108),  
          @moterm    = 'FORWARD'  
     FROM MFCA       with (nolock)  
    WHERE canumoper  = @NumOpe   
  
   --------------------------<< Valutas para Formas de Pago  
   DECLARE @feriado   INTEGER  
  
   DECLARE @diasvalor INTEGER  
       SET @diasvalor = (SELECT diasvalor FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = @moentre )  
  
  
  
   WHILE (@diasvalor > 0)  ------------------ Valuta Entregamos  
   BEGIN  
      SET @movaluta1 = DATEADD(DAY, 1, @movaluta1)  
      EXECUTE SP_FERIADO @movaluta1, 6, @feriado OUTPUT  
  
      IF @feriado = 0  
         SET @diasvalor = @diasvalor -1  
   END  
  
   SET @diasvalor = (SELECT diasvalor FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = @morecib )  
  
   WHILE (@diasvalor > 0)  ------------------ Valuta Recibimos  
   BEGIN  
      SET @movaluta2 = DATEADD(DAY, 1, @movaluta2)  
      EXECUTE SP_FERIADO @movaluta2, 6, @feriado OUTPUT  
  
      IF @feriado = 0  
         SET @diasvalor = @diasvalor -1  
   END  
  
   --------------------------<< Monedas  
   SET @mocodmon = (SELECT mnnemo FROM VIEW_MONEDA with (nolock) WHERE mncodmon = CONVERT(NUMERIC(3),@mocodmon) )  
   SET @mocodcnv = (SELECT mnnemo FROM VIEW_MONEDA with (nolock) WHERE mncodmon = CONVERT(NUMERIC(3),@mocodcnv) )  
   --------------------------<< Cliente y Mercado  
  
   IF @motipmer <> 'ARBI' AND NOT EXISTS (SELECT clpais FROM VIEW_CLIENTE with (nolock) WHERE clrut = @morutcli AND clcodigo = @mocodcli)  
      SET @motipmer = 'EMPR'  
  
   --------------------------<< Agregando a tbVencimientosForward  
   IF EXISTS (SELECT monumfut FROM VIEW_TBVENCIMIENTOSFORWARD with (nolock) WHERE monumfut = @NumOpe)  
      DELETE FROM VIEW_TBVENCIMIENTOSFORWARD  
            WHERE monumfut = @NumOpe  
  
   INSERT INTO VIEW_TBVENCIMIENTOSFORWARD  
   VALUES ( @moentidad ,  
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
  
   RETURN 0  
  
END  
GO
