USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OVERNIGHT_ACTUALIZA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_OVERNIGHT_ACTUALIZA]
      ( 
               @NUMOPE               NUMERIC(3)   ,--NUMERO OPERACION
               --@MOENTIDAD            NUMERIC(10)  ,--ENTIDAD
               @MOTIPMER             CHAR(4)      ,--TIPO MERCADO
               @MOTIPOPE             CHAR(1)      ,--TIPO OPERACION
               --@MORUTCLI             NUMERIC(10)  ,--RUT CLIENTE
               --@MOCODCLI             NUMERIC(10)  ,--CODIGO CLIENTE
               --@MONOMCLI             CHAR(35)     ,--NOMBRE CLIENTE
               @MOCODMON             CHAR(3)      ,--USD
               @MOCODCNV             CHAR(3)      ,--USD
               @MOMONMO              NUMERIC(19,4),--MONTO MONEDA ORIGEN
               @MOTICAM              NUMERIC(19,4),--TASA
               @MOTCTRA              NUMERIC(19,3),--OBSERVADO
               @MOUSS30              NUMERIC(19,3),--MONTO FINAL
               @MOMONPE              NUMERIC(19,3),--MONTO EN PESOS   
               @MOENTRE              NUMERIC(2)   ,--ENTRAGAMOS
               @MORECIB              NUMERIC(2)   ,--RECIBIMS
               --@MOVALUTA1            DATETIME     ,--VALUTA ENTREGAMOS
               --@MOVALUTA2            DATETIME     ,--VALUTA RECIBIMOS
               @MOVAMOS              NUMERIC(1)   ,--RETIRO DE DOCUMENTOS      
               @MOOPER               CHAR(10)     ,--OPERADOR USUARIO
               @MOFECH               DATETIME     ,--FECHA INGRESO OPERACION
               @MOHORA               CHAR(8)      ,--HORA 
               @MOTERM               CHAR(12)     ,--TERMINAL
               --@MOESTATUS            CHAR(1)    ,-- ESTADO
               --@MOIMPRESO            CHAR(1)    ,--IMPRESO 
               --@COD_PAIS             NUMERIC(3)   ,--CODIGO PAIS
               @CASA_MATRIZ          NUMERIC(3)   ,--PAIS
               @CONTABILIZA          CHAR(1)
            )
AS
BEGIN
 SELECT @MOHORA = CONVERT(CHAR,GETDATE(),108)
    UPDATE MEMO SET 
              --moentidad    =           @moentidad,
                     motipmer     =           @MOTIPMER,
                   --monumope     =           @numope,
                     motipope     =           @MOTIPOPE,
                   --morutcli     =           @morutcli,
                   --mocodcli     =           @mocodcli,
                   --monomcli     =           @monomcli,
                     mocodmon     =           @MOCODMON,
                     mocodcnv     =           @MOCODCNV,
                     momonmo      =           @MOMONMO ,
                     moticam      =           @MOTICAM ,
                     motctra      =           @MOTCTRA ,
                     motcfin      =           0,--motcfin 
                     moparme      =           0,--moparme 
                     moparcie     =           0,--moparcie
                     mopartr      =           0,--mopartr 
                     mopar30      =           0,--mopar30 
                     moparfi      =           0,--moparfi
                     moprecio     =           0,--moprecio
                     mopretra     =           0,--mopretra
                     moprefi      =           0,--moprefi 
                     moussme      =           0,--moussme 
                     mouss30      =           @MOUSS30,
                     mousstr      =           0,--mousstr 
                     moussfi      =           0,--moussfi
                     momonpe      =           @MOMONPE ,
                     moentre      =           @MOENTRE ,
                     morecib      =           @MORECIB ,
                     --movaluta1    =           @movaluta1,
                     --movaluta2    =           @movaluta2,
                     movamos      =           @MOVAMOS ,
                     motlxp1      =           0,--motlxp1 ,
                     motlxp2      =           0,--motlxp2 
                     mooper       =           @MOOPER  ,
                     mofech       =          @MOFECH  ,
                     mohora       =         @MOHORA  ,
                     moterm       =           @MOTERM  ,
                     mocodoma     =           0,--mocodoma
                     moestatus    =           '',--moestatus
                     moimpreso    =           '',--moimpreso
                     mopcierre    =           '',--mopcierre 
                     morentab     =           0,--morentab 
                     mocencos     =           '',--mocencos 
                     mounidad     =           '',--mounidad 
                     mocodejec    =           0,--mocodejec
                     mogrpgen     =           0,--mogrpgen 
                     mogrppro     =           0,--mogrppro 
                     mocorres     =           0,--mocorres 
                     moejecuti    =           '',--moejecuti
                     mopmeco      =           0,--mopmeco  
                     mopmeve      =           0,--mopmeve  
                     mototco      =           0,--mototco  
                     mototve      =           0,--mototve  
                     mototcom     =           0,--mototcom 
                     mototvem     =           0,--mototvem 
                     moenvia      =           '',--moenvia 
                     moalinea     =           '',--moalinea
                     moaprob      =           '',--moaprob 
                     monumche     =           0,--monumche
                     mocarta      =           '',--mocarta 
                     motipcar     =           0,--motipcar
                     monumfut     =           0,--monumfut
                     mofecini     =           @MOFECH, --mofecini
                     --codigo_pais  =           @cod_pais   ,--codigo pais
                     casa_matriz  =           @CASA_MATRIZ,    --pais
                     contabiliza  =           @CONTABILIZA
           
 WHERE  monumope  =  @NUMOPE    
         AND   motipmer  =  'OVER'   
END 



GO
