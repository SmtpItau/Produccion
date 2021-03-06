USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_MSJ_ERRORES]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TRAE_MSJ_ERRORES]
(      
    @cSistema  CHAR (03) ,      
    @nNumoper  NUMERIC (10,0) ,       
    @ErrorLinLim VARCHAR(5000) = '' OUTPUT ,     
    @iSw   INT     = 0    
)      
AS      
BEGIN      
      
    SET NOCOUNT ON      
      
    DECLARE @Estado_Linea   CHAR(1)      
    DECLARE @Estado_Limite  CHAR(1)      
    DECLARE @ErrorLineas    VARCHAR(2500)       
    DECLARE @ErrorLimites   VARCHAR(2500)       
    DECLARE @MtoLineas      VARCHAR(25)        
      
    DECLARE @Estado_Bloqueo CHAR(1)   --- PRD-6066      
    DECLARE @ErrorBloqueos  VARCHAR(255) --- PRD-6066      
    DECLARE @ErrorBloqueo VARCHAR(1000) --Turing    
    DECLARE @ErrorLineaLim  VARCHAR(1000) --Turing    
    DECLARE @RutCliente     NUMERIC(9)    --Turing    
    DECLARE @CodCliente     NUMERIC(9)    --Turing    
      
    SELECT @Estado_Linea   = 'P'      
    SELECT @Estado_Limite  = 'P'      
    SELECT @Estado_Bloqueo = 'P'      
       
    SELECT @ErrorLineas    = ''      
    SELECT @ErrorLimites   = ''      
    SELECT @ErrorLinLim    = ''      
    SELECT @ErrorBloqueos  = ''      
    SELECT @ErrorBloqueo   = ''     --Turing    
    SELECT @ErrorLineaLim  = ''     --Turing    
    SELECT @RutCliente     = 0      --Turing    
    SELECT @CodCliente     = 0      --Turing    
       
   --SELECT * FROM LINEA_TRANSACCION_DETALLE WHERE Id_Sistema='Opt' AND NumeroOperacion=1408    
      
    SELECT @Estado_Linea   = ISNULL( ( CASE WHEN Operador_Ap_Lineas = '' THEN 'P' ELSE 'A' END ) , 'P' )      
      FROM APROBACION_OPERACIONES      
     WHERE NumeroOperacion = @nNumoper      
       AND Id_Sistema      = @cSistema      
      
    SELECT  @ErrorLineas    = ''      
          , @MtoLineas      = ''       
    SELECT  @ErrorLineas    = @ErrorLineas +  ISNULL(Convert( VarChar(2500) , RTRIM( Mensaje_Error ) ),'') + Char(13)       
          , @MtoLineas      = (CASE WHEN MontoExceso > 0 THEN  ' en ' + Convert(Varchar(25),ROUND(MontoExceso,0)) ELSE '' END) + ' - '     
          , @RutCliente     = Rut_Cliente    
          , @CodCliente     = Codigo_Cliente     
      FROM  LINEA_TRANSACCION_DETALLE      
     WHERE  Error           = 'S'      
       AND  NumeroOperacion = @nNumoper     
       AND  Id_Sistema      = @cSistema     
       AND  @estado_linea   = 'P'      
       AND  Linea_Transsaccion IN( 'LINGEN','LINSIS','LINPZO')      
      
       
    SELECT  @Estado_Bloqueo = ISNULL( ( CASE WHEN Operador_Ap_Bloqueos = '' THEN 'P' ELSE 'A' END ) , 'P' )      
      FROM  APROBACION_OPERACIONES      
     WHERE  NumeroOperacion = @nNumoper      
       AND  Id_Sistema      = @cSistema      
       
    SELECT  @ErrorBloqueos  = ''      
      
    SELECT  @ErrorBloqueos     = @ErrorBloqueos + ISNULL(CONVERT( VARCHAR(255), RTRIM( Mensaje_Error ) ),'') + ' - '       
      FROM  LINEA_TRANSACCION_DETALLE      
     WHERE  Error              = 'S'        
       AND  NumeroOperacion    = @nNumoper       
       AND  Id_Sistema         = @cSistema       
       AND  @Estado_Bloqueo    = 'P'        
       AND  Linea_Transsaccion = 'BLQCLI' --- PRD-6066, Bloqueo de Clientes       
       
    SELECT  @Estado_Limite  = ISNULL( ( CASE WHEN Operador_Ap_Limites <> '' THEN 'A' ELSE 'P' END ) , 'P' )         
      FROM  aprobacion_operaciones      
     WHERE  NumeroOperacion = @nNumoper      
       AND  Id_Sistema      = @cSistema      
      
    SELECT  @ErrorLimites   = ''      
    SELECT  @ErrorLimites   = @ErrorLimites + ltrim( rtrim(ISNULL(Convert( VarChar(2500) , rtrim( Mensaje ) ),'')  + ' - '+ ISNULL(Convert(Varchar(25),ROUND(Monto,0)),'') )) + ' '      
      FROM  LIMITE_TRANSACCION_ERROR      
     WHERE  NumeroOperacion = @nNumoper      
       AND  Id_Sistema      = @cSistema      
       AND  @Estado_Limite  = 'P'      --- select * from BacLineas..LIMITE_TRANSACCION_ERROR where    numeroOperacion = 580
           
      
    IF @ErrorLineas = '' AND @ErrorLimites = '' AND @ErrorBloqueos = '' 
    BEGIN      
     SELECT @ErrorLinLim    = 'LCR OK'    
     SELECT @ErrorLineaLim  = 'LCR OK'    
        SELECT @ErrorBloqueo   = 'LCR OK'    
    END ELSE    
    BEGIN    
     IF LTRIM(@ErrorLineas)<> ''      
        BEGIN    
            SELECT @ErrorLinLim = 'PROBLEMA LCR ' + LTRIM(RTRIM( LOWER(@ErrorLineas))) + ':'  + LTRIM(RTRIM( LOWER(@MtoLineas))) +CHAR(13) 
        END    
     IF LTRIM(@ErrorLimites)<> ''      
        BEGIN    
            SELECT @ErrorLinLim  =  ' ' + LTRIM(RTRIM(@ErrorLinLim))  + ':' + CHAR(13) + 'PROB. OPERADOR ' + LOWER( LTRIM(RTRIM(@ErrorLimites))) + CHAR(13)      
        END    
     IF LTRIM(@ErrorBloqueos)<> '' --- PRD-6066      
        BEGIN    
         SELECT @ErrorLineaLim  = @ErrorLinLim + CHAR(13)   
         SELECT @ErrorBloqueo   =   'MOTIVO BLOQUEO CLIENTES ' + LOWER( LTRIM(RTRIM(@ErrorBloqueos)))    --Turing    
            SELECT @ErrorLinLim    =   ' ' + LTRIM(RTRIM(@ErrorLinLim))  + '  ' + 'MOTIVO BLOQUEO CLIENTES ' + LOWER( LTRIM(RTRIM(@ErrorBloqueos)))                
        END    
 END       
    
 IF @iSw = 1    
 BEGIN    
  SELECT Sistema   = @cSistema     
   , NumOper   = @nNumoper    
   , RutCli   = @RutCliente        
   , CodCli          = @CodCliente    
   , TipoMensaje     = 'Linea'    
   , Glosa           = ltrim(@ErrorLineaLim)      
    
  UNION    
    
  SELECT Sistema   = @cSistema     
   , NumOper   = @nNumoper    
   , RutCli   = @RutCliente        
   , CodCli          = @CodCliente    
   , TipoMensaje     = 'Bloqueo'       
   , Glosa           = @ErrorBloqueo    
       
 END    
    
     
      
    SET NOCOUNT OFF    
    
END 


--select * from  LIMITE_TRANSACCION_ERROR where numerooperacion = 580
GO
