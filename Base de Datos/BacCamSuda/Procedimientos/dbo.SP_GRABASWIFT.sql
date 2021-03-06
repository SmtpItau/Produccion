USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABASWIFT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABASWIFT](@rut_cliente   NUMERIC(   9)
                               ,@Tipo_Mercado  CHAR   (  10)
                               ,@Codigo_Moneda CHAR   (   3)
                               ,@Valuta1       CHAR   (   8)
                               ,@Monto         NUMERIC(19,4)
                               ,@Tipo_Cambio   NUMERIC(19,4)
                               ,@Observa       CHAR   ( 250) 
                               ,@Codigo_Swift  CHAR   (  10)
                               ,@Op_Futuro     NUMERIC(   9) 
                               )
AS
BEGIN
   SET NOCOUNT ON
     DECLARE @Mercado         CHAR    (  4)
            ,@NomEntidad      CHAR    ( 34)
            ,@FECH_O          DATETIME
            ,@CodNumMon       NUMERIC (  3)
            ,@Numero          NUMERIC (  7)
            ,@receptor        CHAR    ( 50)
            ,@mt_20           CHAR    ( 16)
            ,@mt_72           CHAR    (250)
            ,@mt_58_direccion CHAR    (150)
            ,@mt_57_sucursal  CHAR    ( 35)
            ,@mt_58_cuenta    CHAR    ( 35)
            ,@CodSwt          NUMERIC (  5)
            ,@Tipo            CHAR    (  1)     
            ,@moneda          CHAR(3)
            ,@monto2          NUMERIC(19,4)
            ,@Paridad         CHAR(20)
     CREATE TABLE #detalle_swift (
                 [MONEDA]   [char]   (    3) NULL DEFAULT('')
           ,[MONTO]    [numeric](19, 4) NULL DEFAULT(0)
          ,[PARIDAD]  [numeric](19, 8) NULL DEFAULT(0),)
-------------------------------------
     SELECT  @Mercado         = ''
            ,@NomEntidad      = ''
            ,@CodNumMon       = 0
            ,@Numero          = 0
            ,@receptor        = ''
            ,@mt_20           = ''
            ,@mt_72           = ''
            ,@mt_58_direccion = ''
            ,@mt_57_sucursal  = ''
            ,@mt_58_cuenta    = ''
            ,@CodSwt          = 0
            ,@Tipo            = ''
     SELECT @Mercado    = CASE @Tipo_Mercado 
                               WHEN 'SPOT'      THEN 'PTAS' 
                               WHEN 'CANJE'     THEN 'CANJ'
                               ELSE ' '
                          END
         
     SELECT @FECH_O     = (SELECT ACFECPRO FROM MEAC)
     SELECT @CodNumMon  = (SELECT mncodmon FROM view_moneda WHERE mnnemo = @Codigo_Moneda)                        
     SELECT @NomEntidad = (SELECT acnombre FROM MEAC)
     SET ROWCOUNT 1
     SELECT @Numero=monumope FROM memo WHERE morutcli  = @rut_cliente 
                                         AND motipmer  = @Mercado
                                         AND mocodmon  = @Codigo_Moneda 
                                         AND movaluta1 = @Valuta1 
     SET NOCOUNT ON
     SELECT @Tipo     = CASE @Tipo_Mercado WHEN 'ARBITRAJE' THEN 'A' ELSE ' ' END
     SELECT @Numero   = ISNULL(@Numero,0)
     SELECT @receptor = (CASE @Tipo_Mercado WHEN 'ARBITRAJE' THEN ISNULL((SELECT nombre FROM view_corresponsal WHERE cod_corresponsal = @CodSwt ),' ') -- swift_movimiento
                          ELSE ISNULL((SELECT nombre FROM view_corresponsal,meac WHERE rut_cliente=acrut AND accorres = codigo_corres),' ')  
                  END)
     SELECT @mt_20    = (CASE @Op_Futuro WHEN 0 THEN '18-' + CONVERT(CHAR(7),@Numero)
                                         ELSE '19-DIN-'+ CONVERT(CHAR(7),@Numero)
                   END)
     SELECT @mt_72           = CASE @Tipo_Mercado WHEN 'ARBITRAJE' THEN 'FX Transaction/DD/'+CONVERT(CHAR(8),@FECH_O,11) ELSE @Observa END
     SELECT @mt_58_direccion = ISNULL((SELECT RTRIM(clnombre)+' ' FROM view_cliente WHERE clrut = @rut_cliente AND clcodigo = 1 ),' ')+ISNULL((SELECT RTRIM(a.nom_ciu) FROM view_cliente,view_ciudad_comuna a WHERE (clrut = @rut_cliente AND clcodigo = 1) and
 (clpais = a.cod_pai AND clciudad = a.cod_ciu AND clcomuna = a.cod_com) ),' ')
--     SELECT @mt_58_direccion = @mt_58_direccion + (SELECT RTRIM(a.nom_ciu) FROM view_cliente,view_ciudad_comuna a WHERE clrut = @rut_cliente and (clpais = a.cod_pai AND clciudad = a.cod_ciu AND clcomuna = a.cod_com) )
     SELECT @mt_57_sucursal  = ISNULL((select nombre_corresponsal from view_cliente_corresponsal where rut_cliente = @rut_cliente ),' ')
     SELECT @mt_58_cuenta    = ISNULL((select cuenta_corresponsal from view_cliente_corresponsal where rut_cliente = @rut_cliente ),' ')
     DELETE FROM tbTransferencia
     INSERT tbTransferencia( numero_operacion
       ,tipo  
       ,correlativo 
       ,codigo 
       ,swift  
       ,receptor 
       ,mt_20  
       ,mt_21  
       ,mt_32a_fecha 
       ,mt_32a_monto 
       ,mt_32a_moneda 
       ,mt_50  
       ,mt_52_cuenta 
       ,mt_52_swift 
       ,mt_52_direccion
       ,mt_53_cuenta 
       ,mt_53_swift 
       ,mt_53_sucursal 
       ,mt_53_direccion
       ,mt_54_cuenta 
       ,mt_54_swift 
       ,mt_54_sucursal 
       ,mt_54_direccion
       ,mt_56_cuenta  
       ,mt_56_swift  
       ,mt_56_direccion 
       ,mt_57_cuenta  
       ,mt_57_swift  
       ,mt_57_sucursal  
       ,mt_57_direccion 
       ,mt_58_cuenta  
       ,mt_58_swift  
       ,mt_58_direccion 
       ,mt_59   
       ,mt_70   
       ,mt_71a   
       ,mt_72   
       ,fecha   
    ,usuario  
       ,estado  
) 
                     VALUES(@Numero
       ,@Tipo
       ,0 
                            ,0     
       ,' '   
       ,@receptor
       ,@mt_20
                 ,''         
                 ,@Valuta1
                ,ISNULL(@Monto,0)
              ,ISNULL(@Codigo_Moneda,'')
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,''
              ,@mt_57_sucursal 
              ,''
              ,@mt_58_cuenta 
              ,''
              ,@mt_58_direccion
              ,''
              ,''
              ,''
              ,@mt_72
              ,@FECH_O
                            ,''    
              ,'')
              
           IF @@ERROR<>0   BEGIN
              SELECT -1, 'No se pudo Agregar Transferencia a operacion'
              RETURN
           END
    
       SELECT *,'Nombre Entidad'=@NomEntidad FROM tbTransferencia 
   
END

GO
