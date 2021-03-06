USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_AUTORIZA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_LINEAS_AUTORIZA]    
    (    
    @dFecha  DATETIME ,    
    @cSistema CHAR  (03) ,  
    @nNumoper NUMERIC (10,0) ,    
    @cOperador_Ap CHAR (15) ,    
    @limites CHAR (01) ,  
    @lineas CHAR (01) ,  
    @tasas  CHAR (01) ,  
    @grupos CHAR (01) ,  
    @precios CHAR (01) , --- Para nuevo control de Precios y Tasas  
    @bloqueos CHAR (01)  --- Para bloqueos de clientes, PRD-6066  
    )    
AS    
BEGIN     
 SET NOCOUNT ON    

 /* Para guardar registro de las operaciones
    con problemas de lineas  que son aprobadas
	por perfiles que no pueden aprobar lineas
	ni limites */




 		    -->======= Determina si es operación generada en CHile o NY =========--
		   DECLARE @EsOperacionNY as char(2)
		   SET @EsOperacionNY = 'No'
 			IF exists (select 1 from BACBONOSEXTNY..text_mvt_dri where monumoper = @nNumoper)
						set @EsOperacionNY = 'Si'

			IF exists (select 1 from BacSwapNY..CARTERA where numero_operacion = @nNumoper)
						set @EsOperacionNY = 'Si'

			IF exists (select * from BacFWDNY..MFCA where canumoper = @nNumoper)
						set @EsOperacionNY = 'Si'
			--===================================================================--

    
   DECLARE @Operador_Lineas  CHAR(15)    
   SET @Operador_Lineas = ''    
    
   DECLARE @Operador_limites CHAR(15)    
   SET @Operador_limites = ''    
    
   DECLARE @Operador_tasas CHAR(15)    
   SET @Operador_tasas = ''    
    
   DECLARE @Operador_Grupos  CHAR(15)    
   SET @Operador_Grupos  = ''    
    
   DECLARE @Operador_Precios CHAR(15)    
   SET @Operador_Precios   = ''    
    
 DECLARE @Operador_Bloqueos CHAR(15) ---PRD-6066  
 SET @Operador_Bloqueos  = ''   
  
   DECLARE @estado  CHAR(1)    
   SET @estado  = 'P'    
    
 DECLARE @estado_anterior CHAR(1) --- PRD-6066  
 SET @estado_anterior = 'P'  --- PRD-6066  
  
 DECLARE @linea_general     CHAR(1)  
 SELECT  @linea_general     = Error     
        FROM    LINEA_TRANSACCION_DETALLE    
 WHERE  Linea_Transsaccion = 'LINGEN'    
 AND numerooperacion    = @nNumoper    
 AND Id_Sistema         = @cSistema    

 --+++CONTROL IDD, jcamposd
 DECLARE @linea_IDD     CHAR(1)  
 SELECT  @linea_IDD     = Error     
        FROM    LINEA_TRANSACCION_DETALLE    
 WHERE  Linea_Transsaccion = 'LINIDD'    
 AND numerooperacion    = @nNumoper    
 AND Id_Sistema         = @cSistema
 -----CONTROL IDD, jcamposd
    
   DECLARE @linea_sistema     CHAR(1)    
 SELECT  @linea_sistema     = Error     
        FROM    LINEA_TRANSACCION_DETALLE    
 WHERE  Linea_Transsaccion = 'LINSIS'    
 AND numerooperacion    = @nNumoper    
 AND Id_Sistema         = @cSistema    
    
 DECLARE @linea_plazo       CHAR(1)    
 SELECT  @linea_plazo       = Error     
        FROM    LINEA_TRANSACCION_DETALLE    
 WHERE  Linea_Transsaccion = 'LINPZO'    
 AND numerooperacion    = @nNumoper    
 AND Id_Sistema         = @cSistema    
    
 DECLARE @linea_tasa        CHAR(1)   
 SELECT  @linea_tasa        = Error     
        FROM    LINEA_TRANSACCION_DETALLE    
 WHERE  Linea_Transsaccion = 'CTRLTA'    
 AND numerooperacion    = @nNumoper    
 AND Id_Sistema         = @cSistema    
    
 DECLARE @linea_precio   CHAR(1)  
 SELECT @linea_precio    = Error    
 FROM LINEA_TRANSACCION_DETALLE    
 WHERE Linea_Transsaccion = 'CTRLPR'    
 AND numerooperacion    = @nNumoper    
 AND Id_Sistema         = @cSistema    
    
 DECLARE @bloqueo_clientes CHAR(1) --- PRD-6066  
 SELECT @bloqueo_clientes   = Error  
 FROM  LINEA_TRANSACCION_DETALLE  
 WHERE Linea_Transsaccion = 'BLQCLI'  
 AND numerooperacion    = @nNumoper  
 AND Id_Sistema         = @cSistema   
   
 --IF @lineas = 'N' AND @limites ='N' AND (@linea_sistema = 'S' OR @linea_plazo = 'S' OR @linea_general = 'S' OR @linea_IDD = 'S' OR @bloqueo_clientes = 'S') --- PRD-6066  
 IF @lineas = 'N' AND @limites ='N' AND (@linea_sistema = 'S' OR @linea_plazo = 'S' OR @linea_general = 'S' OR  @bloqueo_clientes = 'S') --- PRD-6066  
 BEGIN    
           SELECT @estado      
           RETURN    
 END    
    
   IF NOT EXISTS(SELECT 1 FROM aprobacion_operaciones WHERE @nNumoper = NumeroOperacion AND @cSistema = Id_Sistema)    
        BEGIN    
           INSERT INTO aprobacion_operaciones    
            (   FechaOperacion      
            ,   NumeroOperacion      
            ,   Id_Sistema      
            ,   Estado       
            ,   Operador_Ap_Lineas     
            ,   Operador_Ap_Limites     
            ,   Operador_Ap_Tasas     
            ,  Operador_Ap_Grp    
            ,   Operador_Ap_LimPrecio    
   , Operador_Ap_Bloqueos  --- PRD-6066  
            )    
            VALUES    
            (   @dFecha      
            ,   @nNumoper     
            ,   @cSistema     
            ,   ' '      
            ,   ' '      
            ,   ' '      
            ,   ' '      
            ,   ' '    
       ,   ' '    
   ,   ' '      --- PRD-6066  
            )    
        END     
        ELSE    
        BEGIN    
            SELECT	@Operador_Lineas = Operador_Ap_Lineas     
            ,		@Operador_limites = Operador_Ap_Limites     
            ,		@Operador_tasas = Operador_Ap_Tasas     
            ,		@Operador_Grupos = Operador_Ap_Grp    
			,		@Operador_Precios = Operador_Ap_LimPrecio     
			,		@Operador_Bloqueos = Operador_Ap_Bloqueos  
            FROM   aprobacion_operaciones    
            WHERE  @nNumoper            = NumeroOperacion     
            AND    @cSistema            = Id_Sistema    
    
        END    
    
   IF @Operador_Lineas = '' AND @lineas = 'S'    
           UPDATE aprobacion_operaciones     
    SET    Operador_Ap_Lineas = @cOperador_Ap    
    WHERE  NumeroOperacion    = @nNumoper              
           AND    Id_Sistema         = @cSistema    
    
  
   IF @Operador_limites = '' AND @limites = 'S'    
           UPDATE aprobacion_operaciones     
           SET    Operador_Ap_Limites = @cOperador_Ap    
           WHERE  NumeroOperacion     = @nNumoper                 
           AND    Id_Sistema          = @cSistema    
    
   IF @Operador_tasas = '' AND @tasas = 'S'    
          UPDATE aprobacion_operaciones     
          SET   Operador_Ap_Tasas    = @cOperador_Ap    
          WHERE  NumeroOperacion      = @nNumoper                
          AND    Id_Sistema           = @cSistema    
    
   IF @Operador_GrUpos = '' AND @grupos = 'S'    
          UPDATE aprobacion_operaciones     
          SET   Operador_Ap_Grp      = @cOperador_Ap    
          WHERE  NumeroOperacion      = @nNumoper    
          AND    Id_Sistema           = @cSistema                
    
    
   IF @Operador_Precios = '' AND @precios = 'S'    
          UPDATE aprobacion_operaciones     
          SET   Operador_Ap_LimPrecio= @cOperador_Ap    
          WHERE  NumeroOperacion      = @nNumoper    
          AND    Id_Sistema           = @cSistema                
    
 IF @Operador_Bloqueos = '' AND @bloqueos = 'S'  --- PRD-6066  
  UPDATE aprobacion_operaciones   
  SET  Operador_Ap_Bloqueos = @cOperador_Ap  
  WHERE   NumeroOperacion      = @nNumoper  
  AND     Id_Sistema           = @cSistema               
    
 SELECT @estado_anterior = @estado --- PRD-6066  
    
   SELECT @estado                 = 'A'    
       FROM   aprobacion_operaciones    
       WHERE  NumeroOperacion    = @nNumoper          
       AND    Id_Sistema       = @cSistema            
       AND    Operador_Ap_Limites    <> ''     
       AND    Operador_Ap_Lineas     <> ''     
       AND    Operador_Ap_Tasas      <> ''     
       AND    Operador_Ap_Grp        <> ''    
--     AND    Operador_Ap_LimPrecio  <> ''  
       AND    @limites <>'N'     --- Se agrega    



       --  29 Sept. 2009  Se agrega Sistema a condición de IF ya que existia operaciones con el mismo N° en varios módulos.    
       IF EXISTS (SELECT 1 FROM LINEA_TRANSACCION_DETALLE WHERE Id_Sistema = @cSistema AND NumeroOperacion =@nNumoper AND Error='S' AND @limites ='N')    
       BEGIN    
                 SELECT @estado = Estado                      
                 FROM DETALLE_APROBACIONES     
                 WHERE Id_Sistema = @cSistema    
                 AND Numero_Operacion= @nNumoper    
                 AND Estado ='A'    
                 AND Firma1 NOT IN('','FALTA')    
                 AND Firma2 NOT IN('','FALTA')    
       END      

-- SELECT * FROM DETALLE_APROBACIONES WHERE Id_Sistema = 'btr' AND Numero_Operacion = 225722

     
       --  29 Sept. 2009  Se agrega Sistema a condición de IF ya que existia operaciones con el mismo N° en varios módulos.    
   IF EXISTS (SELECT 1 FROM DETALLE_APROBACIONES WHERE Id_Sistema = @cSistema AND Numero_Operacion = @nNumoper AND estado = 'F' and Firma2 = '' AND @limites <> 'N')    
         BEGIN    
            SELECT @estado   = 'F'    
         END                
    
        IF @cSistema='BEX'    
        BEGIN    
         IF EXISTS (SELECT 1 FROM DETALLE_APROBACIONES WHERE Numero_Operacion= @nNumoper AND Id_Sistema = @cSistema  
              AND  ESTADO='F' and Firma1=Operador_Origen and firma1<>@cOperador_Ap and @limites ='N'and  @cOperador_Ap<>'CFINANCIERO')    
         BEGIN    
            UPDATE DETALLE_APROBACIONES     
            SET Estado = 'A'    
            , Firma2 = @cOperador_Ap    
            WHERE Numero_Operacion = @nNumoper     
				 AND Id_Sistema = @cSistema  
				AND estado = 'F'     
            SET @estado = 'A'    
         END        

		 

		    --> Determina si es operación generada en CHile o NY
		  -- DECLARE @EsOperacionNY as char(2)
		  -- SET @EsOperacionNY = 'No'
 			--IF exists (select 1 from BACBONOSEXTNY..text_mvt_dri where monumoper = @nNumoper)
				--		set @EsOperacionNY = 'Si'

			IF EXISTS (SELECT 1 FROM DETALLE_APROBACIONES WHERE Numero_Operacion = @nNumoper AND ID_SISTEMA = 'BTR' AND FIRMA1 <> 'FALTA' AND FIRMA2 <> 'FALTA' AND FIRMA2 <> ' ')
			BEGIN
					IF @EsOperacionNY = 'No'
							BEGIN
							  UPDATE VIEW_TEXT_MVT_DRI     
									 SET    mostatreg = ' '     
							  WHERE  monumoper = @nNumoper     
									 AND    @estado   = 'A'    
					END
					IF @EsOperacionNY = 'Si'
		
							BEGIN
							  UPDATE VIEW_TEXT_MVT_DRI_NY     
									 SET    mostatreg = ' '     
							  WHERE  monumoper = @nNumoper     
									 AND    @estado   = 'A'    
					END
			END

      END      
    
 /* PRD-6066 inicio */  
 IF @cSistema IN ('BTR','BFW','BCC','PCS','OPT')  
 BEGIN  
  IF @bloqueo_clientes ='S' AND @estado = 'A'  --- ¿Hay un bloqueo de clientes en una op. aprobada?  
  BEGIN  
   ---INSERT INTO dbo.DEBUG_VALORES  
   ---SELECT @cSistema + ' ' + LTRIM( @nNumoper ) + ' Op. c/Bloq. Cltes= ' + @bloqueo_clientes + ' Usuario p/desbloquear= ' + @bloqueos + ' @estado=' + @estado, 0.0, '@cOperador_Ap= '+@cOperador_Ap + ' @limites= '+ @limites , 0.0  
  
   IF @bloqueos <> 'S'       --- ¿Usuario la puede desbloquear?  
   BEGIN  
    SET @estado = @estado_anterior   --- Usuario no la puede desbloquear, queda con estado anterior  
   END  
  END  
 END  
  /* PRD-6066 fin */  
   
      IF @cSistema='BTR'    
      BEGIN    
  
			  if @lineas = 'S'  
			  begin  
			   if exists( select * from View_Mdmo where monumoper = @nNumoper and morutcli = 97029000 and mousuario <> @cOperador_Ap)  
			   begin  
				UPDATE DETALLE_APROBACIONES     
				SET  Estado     = 'A'    
				,  Firma2     = @cOperador_Ap    
				WHERE Numero_Operacion  = @nNumoper     
				AND  Id_Sistema    = @cSistema  
				AND  estado     = 'F'     
				and  Firma2     = 'FALTA'  
  
				SET @estado = 'A'  
			   end  
			  end  
 
         UPDATE VIEW_MDMO     
         SET    mostatreg = ' '     
         WHERE  monumoper = @nNumoper     
         AND    @estado   = 'A'    

    
         IF EXISTS(SELECT 1 FROM VIEW_MDCP WHERE cpnumdocu = @nNumoper)    
            UPDATE VIEW_MDCP     
            SET    Estado_Operacion_Linea = ' '     
            WHERE  cpnumdocu     = @nNumoper     
            AND    @estado                = 'A'    
    
         IF EXISTS(SELECT 1 FROM VIEW_MDDI WHERE dinumdocu = @nNumoper)    
            UPDATE VIEW_MDDI     
            SET    Estado_Operacion_Linea = ' '     
            WHERE  dinumdocu              = @nNumoper     
            AND    @estado                = 'A'    
    
         IF EXISTS(SELECT 1 FROM VIEW_MDCI WHERE cinumdocu = @nNumoper)    
            UPDATE VIEW_MDCI     
            SET  Estado_Operacion_Linea = ' '     
            WHERE  cinumdocu              = @nNumoper     
            AND    @estado                = 'A'    
 

		EXEC SP_ACTUALIZA_FIRMA @nNumoper 
      END   
    
      IF @cSistema='BCC'    
         UPDATE VIEW_MEMO     
         SET  moestatus          = ' '        
         ,      autorizador_limite = @cOperador_Ap    
         WHERE  monumope           = @nNumoper     
         AND    @estado            = 'A'    
    
      IF @cSistema='BFW'    
		BEGIN
			IF @EsOperacionNY = 'No'
					 UPDATE VIEW_MFMO    
					 SET  moestado   = ' '    
					 WHERE  monumoper  = @nNumoper     
					 AND    @estado    = 'A'   

					  UPDATE VIEW_MFCA    
					  SET    caautoriza = @cOperador_Ap     
					  ,      caestado   = ' '    
					  WHERE  canumoper  = @nNumoper     
					  AND    @estado    = 'A'    

			IF @EsOperacionNY = 'Si'
					 UPDATE VIEW_MFMO_NY
					 SET  moestado   = ' '    
					 WHERE  monumoper  = @nNumoper     
					 AND    @estado    = 'A'   

					 UPDATE VIEW_MFCA_NY    
					  SET    caautoriza = @cOperador_Ap     
					  ,      caestado   = ' '    
					  WHERE  canumoper  = @nNumoper     
					  AND    @estado    = 'A'    
		END
      


	 
    
      IF @cSistema='PCS'    
	  BEGIN
			IF @EsOperacionNY = 'No'
				 UPDATE VIEW_MOVDIARIO    
				 SET  Estado_oper_lineas = 'A'    
				 WHERE  numero_operacion   = @nNumoper     
				 AND    @estado            = 'A'    
      
				   UPDATE VIEW_cartera    
				   SET    Estado_oper_lineas = 'A'    
				   WHERE  numero_operacion   = @nNumoper     
				   AND    @estado            = 'A'    

			IF @EsOperacionNY = 'No'
				 UPDATE VIEW_MOVDIARIO_NY   
				 SET  Estado_oper_lineas = 'A'    
				 WHERE  numero_operacion   = @nNumoper     
				 AND    @estado            = 'A'    
      
				   UPDATE VIEW_CARTERA_NY  
				   SET    Estado_oper_lineas = 'A'    
				   WHERE  numero_operacion   = @nNumoper     
				   AND    @estado            = 'A'    
    
		END

     IF @cSistema='OPT'    
      BEGIN    

--select 'ojo1',@nNumoper,@cOperador_Ap     ,@estado

         UPDATE BacLineas.DBO.TAB_Importada_MoEncContrato        
         SET    estado = ' '          
   ,     Estado_Oper  = 'A'    
         WHERE  numcontrato = @nNumoper       
         AND    @estado      = 'A'    
         AND    Usuario = @cOperador_Ap     
      END      
  
 		if @estado = 'A'
		Begin 
			BEGIN TRY
			INSERT INTO dbo.DEBUG_VALORES  
			SELECT @cSistema + ' ' + LTRIM( @nNumoper ) + ' Lim-Lin-Tas-Gru-Pre-Blo=' + 
														  @limites+@lineas+@tasas+@grupos+@precios+@bloqueos , 0.0, '@cOperador_Ap= '+@cOperador_Ap + ' ' + convert( varchar(20), getdate(), 20 )  , 0.0  
			END TRY
			BEGIN CATCH
			   set @cSistema = @cSistema
			END CATCH  
        end 
  
    
 UPDATE aprobacion_operaciones     
 SET    Estado             = @estado    
 WHERE  @nNumoper          = NumeroOperacion      
 AND    @cSistema          = Id_Sistema      
    
   SELECT @estado    
   SET NOCOUNT OFF    
    
   EXEC sp_lineas_autoriza_mxclp @cSistema, @nNumoper    
END  
--> +++ cvegasan 2017.08.08 Control Lineas IDD

GO
