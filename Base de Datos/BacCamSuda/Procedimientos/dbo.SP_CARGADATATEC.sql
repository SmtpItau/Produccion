USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGADATATEC]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGADATATEC]
        (
         @CODIGO_UNICO         CHAR   (16)   ,
         @FECHA                DATETIME      ,
         @HORA                 CHAR   (8)    ,
         @CLASE_MENSAJE        NUMERIC(2)    ,    /*5-TRANSACCIÃ³N   50-ANULACIÃ³N*/
         @O_D                  CHAR   (1)    ,
         @INSTITUCION_POSTURA  CHAR   (30)   ,
         @CIUDAD_POSTURA       CHAR   (10)   ,
         @USUARIO_POSTURA      CHAR   (30)   ,
         @INSTITUCION_ACEPTANT CHAR   (30)   ,
         @CIUDAD_ACEPTANTE     CHAR   (10)   ,
         @USUARIO_ACEPTANTE    CHAR   (30)   ,
         @MERCADO              NUMERIC(02)   , 
         @MONEDA               CHAR   (1)    ,
         @PRECIO               NUMERIC(8,04) ,
         @NUMERO               NUMERIC(10)   ,
         @NUMERO_TRANSADO      NUMERIC(10)   ,
         @DIAS                 NUMERIC(3)    ,
         @NUMEROINTERFAZ       VARCHAR(16)
        )
AS BEGIN
   SET NOCOUNT ON
IF EXISTS ( SELECT numerointerfaz from MEMO WHERE @NUMEROINTERFAZ = numerointerfaz )
BEGIN
   SELECT 'OK','EXISTE'
   RETURN
END
   DECLARE @RUTCLIENTE NUMERIC(9)
   DECLARE @CODCLIENTE NUMERIC(9)
   DECLARE @ACNUMOPER  NUMERIC(10)
   DECLARE @NUMOPERAUX NUMERIC(9)
   IF NOT EXISTS( SELECT 1 FROM VIEW_CLIENTE
                  WHERE (CASE @O_D
                            WHEN 'D' THEN @INSTITUCION_POSTURA
                            WHEN 'O' THEN @INSTITUCION_ACEPTANT
                         END) = clnombre
               )
   BEGIN
      SELECT 'OK','NO EXISTE CLIENTE'
      RETURN
   END
   SELECT @RUTCLIENTE = (
                        SELECT clrut FROM VIEW_CLIENTE
                         WHERE (CASE @O_D
                          WHEN 'D' THEN @INSTITUCION_POSTURA
                          WHEN 'O' THEN @INSTITUCION_ACEPTANT
                           END) = clnombre)
   SELECT @CODCLIENTE = (
                         SELECT clcodigo FROM VIEW_CLIENTE
                         WHERE (CASE @O_D
                         WHEN 'D' THEN @INSTITUCION_POSTURA
                         WHEN 'O' THEN @INSTITUCION_ACEPTANT
                         END) = clnombre)
   SELECT @FECHA = DATEADD( HH, CONVERT( INT, SUBSTRING( @HORA, 1, 2 ) ), @FECHA)
   SELECT @FECHA = DATEADD( MI, CONVERT( INT, SUBSTRING( @HORA, 4, 2 ) ), @FECHA)
   SELECT @FECHA = DATEADD( SS, CONVERT( INT, SUBSTRING( @HORA, 7, 2 ) ), @FECHA)
   IF NOT EXISTS(SELECT 1 FROM MEMO/*mfca*/ WHERE numerointerfaz = @CODIGO_UNICO)
   BEGIN
         --      UPDATE MEAC /*mfac*/  SET accorope = accorope +1 /*acnumoper = acnumoper + 1*/
         --      SELECT @ACNUMOPER = accorope FROM MEAC /*mfac*/
      DECLARE @NUMEROOPERACION  NUMERIC(9)
      DECLARE @TIPO             CHAR(4)
      DECLARE @INTITUCION       VARCHAR(255)
      DECLARE @MON              NUMERIC(19,4)
      DECLARE @FP1              NUMERIC(2)
      DECLARE @FP2              NUMERIC(2)
      DECLARE @TRUT             CHAR(10)
      DECLARE @ES               CHAR(1)
                           
      SELECT @TIPO       = CASE @o_d           WHEN 'D' THEN 'C' WHEN 'O' THEN 'V' END
      SELECT @INTITUCION = CASE @O_D           WHEN 'D' THEN @INSTITUCION_POSTURA WHEN 'O' THEN @INSTITUCION_ACEPTANT END
      SELECT @MON        = ( @NUMERO * @PRECIO )
      SELECT @FP1        = CASE @o_d           WHEN 'D' THEN 2 WHEN 'O' THEN 6 END   
      SELECT @FP2        = CASE @o_d           WHEN 'D' THEN 2 WHEN 'O' THEN 6 END   
      SELECT @TRUT       = CASE @O_D           WHEN 'D' THEN SUBSTRING(@USUARIO_POSTURA,1,10) WHEN 'O' THEN SUBSTRING(@USUARIO_ACEPTANTE,1,10) END 
      SELECT @ES         = CASE @CLASE_MENSAJE WHEN  5 THEN '' WHEN 50 THEN 'A' END
 EXECUTE @NUMOPERAUX = Sp_Gmovto
                   0                                                                                    --01 monumope
                  ,'PTAS'       --02 motipmer
                  ,@TIPO                                    --03 motipope
                  ,@RUTCLIENTE                                                                         --04 morutcli
                  ,@CODCLIENTE                                                            --05 mocodcli
                  ,@INTITUCION                               --06 monomcli
                  ,'USD'                                                                                --07 mocodmon
                  ,'CLP'                                                                                --08 mocodcnv
                  ,@NUMERO                                                                              --09 monommo
                  ,@PRECIO                                                                              --10 moticam
                  ,@PRECIO                                                                              --11 motctra
                  ,1                                                                                    --12 moparida
                  ,1                                                                                    --13 moussme
                  ,@NUMERO                                                                              
                  ,@NUMERO
                  ,@MON
                  ,@FP1
                  ,@FP2
                  ,@TRUT
                  ,'DATATEC'                                                                                     
                  ,@HORA                                                                                  
                  ,@FECHA                                                                                 
                  ,0                                                                                    
                  ,@ES
                  ,0
                  ,@FECHA                                                  
                  ,@FECHA
                  ,0 
                  ,''
                  ,1 
                  ,@PRECIO 
                  ,@PRECIO 
                  ,0       
                  ,'BCC'   
                  ,'S'     
                  ,''      
                  ,''      
                  ,''      
                  ,''      
                  ,0       
                  ,0       
                  ,0         
                  ,0         
                  ,0         
                  ,''        
                  ,''
--   DECLARE @CORRELATIVO   NUMERIC(9,0)
   SELECT @NUMOPERAUX  = ( SELECT ACCOROPE FROM MEAC )
   UPDATE MEMO
      SET  id_sistema  = 'BCC'
          ,contabiliza  = 'S'   
   ,sintetico  = 'N'
   ,mercado  = 'L'
          ,marca  = ''
          ,numerointerfaz = @NUMEROINTERFAZ
          ,moestatus            = CASE @CLASE_MENSAJE WHEN  5 THEN '' WHEN 50 THEN 'A' END 
   WHERE   monumope             = @NUMOPERAUX
    
   SELECT 'OK','AGREGADO'
   END ELSE BEGIN
       IF @CLASE_MENSAJE = 50
       BEGIN
          UPDATE MEMO SET moestatus = 'A' WHERE numerointerfaz = @CODIGO_UNICO
          SELECT 'OK', 'ANULADO'
       END
   END
   SET NOCOUNT OFF
END



GO
