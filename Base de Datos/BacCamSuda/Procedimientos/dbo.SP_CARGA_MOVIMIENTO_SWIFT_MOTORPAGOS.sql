USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_MOVIMIENTO_SWIFT_MOTORPAGOS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_MOVIMIENTO_SWIFT_MOTORPAGOS]
   (   @iNumOper              NUMERIC(9)   
   ,   @BancoReceptor         VARCHAR(50) OUTPUT
   ,   @SwiftReceptor         VARCHAR(50) OUTPUT
   ,   @CtaContable           VARCHAR(50) OUTPUT
   ,   @SwiftIntermediario    VARCHAR(50) OUTPUT
   ,   @BcoIntermediario      VARCHAR(50) OUTPUT
   ,   @CtaCte                VARCHAR(50) OUTPUT
   ,   @SwiftBeneficiario     VARCHAR(50) OUTPUT
   ,   @BcoBeneficiario       VARCHAR(50) OUTPUT
   ,   @DirBeneficiario       VARCHAR(50) OUTPUT
   ,   @CiuBeneficiario       VARCHAR(50) OUTPUT
   )
AS
BEGIN

 SET NOCOUNT ON

 DECLARE @regs         INTEGER  
        ,@ncont        INTEGER  
        ,@rutcli       NUMERIC( 9) 
        ,@tipmer       CHAR   (10) 
        ,@codmon       CHAR   ( 3)  
        ,@valuta1      CHAR   ( 8)  
        ,@monmo        FLOAT  
        ,@ticam        FLOAT  
        ,@observ       CHAR   (50) 
        ,@codigo_swift CHAR   (10) 
        ,@numero_fut   NUMERIC(10) 
        ,@numero       NUMERIC( 7) 
        ,@impreso      CHAR   ( 1)
 
 CREATE TABLE #TemporalSwift( RUTCLI  NUMERIC      ( 9)
                             ,NOMCLI  CHAR         (50)     
                             ,TIPMER  CHAR         ( 9)   
                             ,TIPOPE  CHAR         ( 1)   
                             ,ESTATUS CHAR         ( 1) 
                             ,USSME   NUMERIC    (19,4)
                             ,TICAM   NUMERIC    (19,4)
                             ,MONMO   NUMERIC    (19,4)
                             ,PRECIO  NUMERIC    (19,4)
                             ,CODMON  CHAR         ( 3)     
                             ,SISTEMA CHAR         ( 3)
                             ,VALUTA1 DATETIME 
                             ,FECH    DATETIME  
                             ,CODCLI  NUMERIC      ( 9)
                             ,CODIGO_PAIS  NUMERIC ( 5)
                             ,CODIGO_PLAZA NUMERIC ( 5)
                             ,CODIGO_SWIFT VARCHAR (10)
                             ,IMPRESO      CHAR    ( 1) 
                             ,NUMERO_FUT   NUMERIC ( 7)
                             ,NUMERO       NUMERIC ( 7)
                            ) 



-- SPOT
 INSERT INTO   #TemporalSwift 
      SELECT   morutcli                    
              ,monomcli                    
              ,'SPOT' 
              ,motipope
              ,' '                   --moestatus 
              ,moussme  
              ,moticam  
              ,momonmo  
              ,moprecio 
              ,mocodmon                  
              ,id_sistema                
              ,movaluta1                 
              ,mofech                    
              ,mocodcli                  
              ,0             
              ,0            
              ,' '            
              ,moimpreso
              ,monumfut
              ,monumope
        FROM   MEMO ,
               view_cliente   
       WHERE  (moestatus = ' ' OR moestatus = 'M')       AND 
               motipmer  = 'PTAS'                        AND
               motipope = 'V'                            AND
              (morutcli = clrut AND mocodcli = clcodigo) AND
              (cltipcli > 0 AND cltipcli < 4)
     ORDER BY morutcli

-- CANJE
 INSERT INTO   #TemporalSwift
      SELECT   morutcli                                                                                              --Rut Cliente
              ,monomcli                                                                                              --Nombre Cliente
              ,'CANJE'
              ,'V'      --motipope
              ,' '        ----moestatus                                                                                              --Estado / estado swift
              ,moussme                               --Monto USD
              ,moticam                                                                                          --Tipo de Cambio
              ,momonmo                                                                                          --Monto Oroginal
              ,moprecio                                                                                         --Paridad
              ,mocodmon                                                                                               --Codigo Moneda
              ,id_sistema                                                                                             --Estado de la Operacion
              ,Valuta_Cli_Ext             
              ,mofech    
              ,mocodcli                                                                                               --Codigo Cliente
              ,0                                                                                          --Codigo Pais 
              ,0  --Codigo Plaza
              ,' '                                                                  --Codigo Swift
              ,moimpreso                                                                                              --Moimpreso
              ,monumfut
              ,monumope
        FROM   MEMO  ,
               view_cliente   
       WHERE  (moestatus = ' ' OR moestatus = 'M')       AND 
               motipmer  = 'CANJ'                        AND
              (morutcli  = clrut AND mocodcli = clcodigo)AND
              (cltipcli  > 0 AND cltipcli < 4)
     ORDER BY morutcli

-- ARBITRAJE

 SELECT   'morutcli'      = morutcli      
         ,'monomcli'      = ISNULL(( CASE motipope WHEN 'C' THEN (SELECT DISTINCT nombre FROM view_corresponsal WHERE CONVERT(VARCHAR(5),cod_corresponsal) = swift_entregamos)
                                                   ELSE monomcli 
                                     END),'')    
         ,'Mercado'       = 'ARBITRAJE'     
         ,'Tipo'          = 'V'        
         ,'estado'        = ' '         
         ,'dolar'         = moussme     
         ,'ticam'         = moticam     
         ,'montoorig'     = momonmo     
         ,'Parid'         = moprecio    
         ,'mocodmon'      = mocodcnv     
         ,'Sistema'       = id_sistema     
         ,'valuta'        = movaluta1     
         ,'fecha'         = mofech     
         ,'codigo'        = mocodcli     
         ,'Codigo_Pais'   = ISNULL((SELECT DISTINCT codigo_pais  FROM view_corresponsal WHERE CONVERT(VARCHAR(10),cod_corresponsal) = swift_entregamos),0) 
         ,'Codigo_ Plaza' = ISNULL((SELECT DISTINCT codigo_plaza FROM view_corresponsal WHERE CONVERT(VARCHAR(10),cod_corresponsal) = swift_entregamos),0) 
         ,'Codigo_Swift'  = CONVERT(VARCHAR(10),swift_recibimos ) 
         ,'Impreso'       = moimpreso     
         ,'Numfut'        = monumfut
         ,'Numope'        = monumope
    INTO  #TemporalCompras
    FROM   MEMO 
          ,view_cliente   
   WHERE  (moestatus = ' ' OR moestatus = 'M')       AND 
           motipmer  = 'ARBI'                        AND
          (morutcli = clrut AND mocodcli = clcodigo) AND 
          (cltipcli > 0 AND cltipcli < 4)            AND
           motipope = 'C'
  ORDER BY morutcli

  SELECT   'morutcli'      = morutcli                       
          ,'monomcli'      = ISNULL(( CASE motipope WHEN 'C' THEN (SELECT DISTINCT nombre FROM view_corresponsal WHERE CONVERT(VARCHAR(5),cod_corresponsal) = swift_entregamos)
                                                    ELSE monomcli 
                                      END),'')    
          ,'Mercado'       = 'ARBITRAJE'     
          ,'Tipo'          = 'V'        
          ,'estado'        = ' '         
          ,'dolar'         = moussme     
          ,'ticam'         = moticam     
          ,'montoorig'     = momonmo     
          ,'Parid'         = moprecio    
          ,'mocodmon'      = mocodmon     
          ,'Sistema'       = id_sistema     
          ,'valuta'        = movaluta2     
          ,'fecha'         = mofech     
          ,'codigo'        = mocodcli     
          ,'Codigo_Pais'   = ISNULL((SELECT DISTINCT codigo_pais  FROM view_corresponsal WHERE CONVERT(VARCHAR(10),cod_corresponsal) = swift_entregamos),0) 
          ,'Codigo_ Plaza' = ISNULL((SELECT DISTINCT codigo_plaza FROM view_corresponsal WHERE CONVERT(VARCHAR(10),cod_corresponsal) = swift_entregamos),0) 
          ,'Codigo_Swift'  = CONVERT(VARCHAR(10),swift_recibimos ) 
          ,'Impreso'       = moimpreso     
          ,'Numfut'        = monumfut
          ,'Numope'        = monumope
    INTO   #TemporalVentas
    FROM    MEMO ,view_cliente   
   WHERE   (moestatus = ' ' OR moestatus = 'M')       AND 
            motipmer  = 'ARBI'                        AND
           (morutcli = clrut AND mocodcli = clcodigo) AND
           (cltipcli > 0 AND cltipcli < 4)            AND
            motipope = 'V'
   ORDER BY morutcli

 INSERT INTO #TemporalSwift SELECT * FROM  #TemporalCompras
 INSERT INTO #TemporalSwift SELECT * FROM  #TemporalVentas

 SELECT @regs = COUNT(*) FROM #TemporalSwift
 SELECT @ncont = 1

 -- Borrar Aquellos Swifts que no han sido confirmados

 DELETE  tbTransferencia_detalle 
   FROM  tbTransferencia 
  WHERE (tbTransferencia.usuario  = ''   AND 
         tbTransferencia.usuario1 = '' ) AND
         tbTransferencia.numero_operacion = tbTransferencia_detalle.numero_operacion

 DELETE  tbTransferencia WHERE usuario = '' AND usuario1 = ''

 WHILE @regs >= @ncont BEGIN
      SET ROWCOUNT @ncont  
      SELECT  @rutcli       = rutcli   
             ,@tipmer       = tipmer   
             ,@codmon       = codmon   
             ,@valuta1      = CONVERT(CHAR(8),valuta1,112) 
             ,@monmo        = (CASE WHEN tipmer = 'ARBITRAJE' AND codmon <> 'USD' THEN monmo 
                                   ELSE ussme 
                              END)
             ,@ticam        = ticam    
             ,@observ       = ''    
             ,@codigo_swift = codigo_swift   
             ,@numero_fut   = numero_fut   
             ,@numero       = numero   
             ,@impreso      = impreso
        FROM  #TemporalSwift
     ORDER BY rutcli

        SET ROWCOUNT 0

        IF @impreso = '' BEGIN   
           EXECUTE sp_Graba_SWIFT  @rutcli  
                                  ,@tipmer  
                                  ,@codmon  
                                  ,@valuta1 
                                  ,@monmo  
                                  ,@ticam  
                                  ,''  
                                  ,@codigo_swift 
                                  ,@numero_fut   
                                  ,@numero   
        END
        SELECT @ncont  = @ncont + 1
 END


   SELECT @BancoReceptor         = ''
   ,      @SwiftReceptor         = ''
   ,      @CtaContable           = ''
   ,      @SwiftIntermediario    = ''
   ,      @BcoIntermediario      = ''
   ,      @CtaCte                = ''
   ,      @SwiftBeneficiario     = ''
   ,      @BcoBeneficiario       = ''
   ,      @DirBeneficiario       = ''
   ,      @CiuBeneficiario       = ''

   SELECT @BancoReceptor         = receptor
   ,      @SwiftReceptor         = codigo_swift
   ,      @CtaContable           = codigo_contable
   ,      @SwiftIntermediario    = mt_57_swift
   ,      @BcoIntermediario      = mt_57_sucursal
   ,      @CtaCte                = mt_58_cuenta
   ,      @SwiftBeneficiario     = mt_58_swift
   ,      @BcoBeneficiario       = mt_58_direccion
   FROM   baccamsuda..MEMO LEFT JOIN bacparamsuda..CORRESPONSAL ON anula_motivo = codigo_contable
                           INNER JOIN tbTransferencia           ON monumope = numero_operacion
   WHERE  monumope               = @iNumOper

   DELETE tbTransferencia 

END




GO
