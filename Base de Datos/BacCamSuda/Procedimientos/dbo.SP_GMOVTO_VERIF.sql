USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GMOVTO_VERIF]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[SP_GMOVTO_VERIF]
       (    
        @numope           NUMERIC (07) ,        -- 01    
        @tipmer           CHAR  (04) ,        -- 02    
        @tipope           CHAR  (01) ,        -- 03    
        @rutcli           NUMERIC (09) ,        -- 04    
        @codcli           NUMERIC (09) ,        -- 05    
        @nomcli           CHAR  (35) ,        -- 06    
        @codmon           CHAR  (03) ,        -- 07    
        @codcnv           CHAR  (03) ,        -- 08    
        @monmo            NUMERIC (19,4) ,        -- 09    
        @ticam            NUMERIC (19,4) ,  -- 10    
        @tctra            NUMERIC (19,4) ,        -- 11    
        @parida           NUMERIC (19,8) ,        -- 12    
        @partr            NUMERIC (19,8) ,        -- 13    
        @ussme            NUMERIC (19,4) ,        -- 14    
        @usstr            NUMERIC (19,4) ,        -- 15       
        @monpe            NUMERIC (19,4) ,        -- 16    
        @entre            NUMERIC (05) ,        -- 17    
        @recib            NUMERIC (05) ,        -- 18    
        @oper             CHAR  (15) ,        -- 19  -- MAP 20060920    
        @term             CHAR  (12) ,        -- 20    
        @fecha            DATETIME  ,        -- 21    
        @codoma           NUMERIC (03) ,        -- 22 (xxx)    
        @estatus          CHAR  (01) ,        -- 23    
        @codejec          NUMERIC (06) ,        -- 24    
        @valuta1          DATETIME  ,        -- 25 (entregamos)    
        @valuta2          DATETIME  ,        -- 26 (recibimos)    
        @rentab           NUMERIC (03) ,        -- 27    
        @linea            CHAR  (01) ,        -- 28    
        @entidad          NUMERIC (03) ,        -- 29    
        @precio           NUMERIC (19,4)=0,        -- 30    
        @pretra           NUMERIC (19,4)=0,        -- 31    
        @estado           NUMERIC (01) =-1,        -- 32 (para la captura automatica de fwd)    
        @respon           CHAR  (03) ,        -- 33    
        @cotab            CHAR  (01) ,        -- 34    
        @observa          VARCHAR (250) ,        -- 35    
        @swift_corrdonde  VARCHAR (10) ,        -- 36    
        @swift_corrquien  VARCHAR (10) ,        -- 37    
        @swift_corrdesde  VARCHAR (10) ,        -- 38    
        @plaza_corrdonde  NUMERIC (05) ,        -- 39    
        @plaza_corrquien  NUMERIC (05) ,        -- 40    
        @plaza_corrdesde  NUMERIC (05) ,        -- 41    
        @fpagomxcli       NUMERIC (05) ,        -- 42 (Canjes) fp mx    
        @fpagomncli       NUMERIC (05) ,        -- 43 (Canjes) FP MN    
        @valuta3          DATETIME  ,        -- 44 (Canjes) Valuta MN    
        @valuta4          DATETIME  ,        -- 45 (Canjes) Valuta MX    
        @codigo_area      VARCHAR (05) ,        -- 46    
        @codigo_comercio  CHAR  (06) ,        -- 47    
        @codigo_concepto  CHAR  (03) ,        -- 48    
        @casamatriz       NUMERIC (03)  =0,        -- 49    
        @montofinal       NUMERIC (19,4)=0,        -- 50    
        @dias             NUMERIC (09)  =0,        -- 51    
        @rutgir           NUMERIC (09) ,        -- 52    
        @codigogirador   NUMERIC (09) ,        -- 53     
        @CostoFondo       NUMERIC (10,4) ,        -- 54    
        @utilpe           NUMERIC (19,0) ,  -- 55    
        @tcfin            NUMERIC (19,4) ,        -- 56    
        @FechVcto         DATETIME  ,  -- 57    
        @VamosVienen      NUMERIC (01) ,        -- 58 Vamos - Vienen    
        @MoCorres         NUMERIC (08) ,        -- 59 Codigo Corresponsal           
		@forward   CHAR  (01)='N',  -- 60 Indica si es de Forward    
		@der_numero   NUMERIC (08)= 0 ,  -- 61     
		@der_inicio   DATETIME      = '',  -- 62     
		@der_vcto   DATETIME      = '',  -- 63    
        @der_precio   NUMERIC (19,4)=0,  -- 64         
        @der_instr        NUMERIC (02)  =0,  -- 65    
		@netting   NUMERIC (10)  =0,  -- 66    
		@numero_tbtx   NUMERIC (10)  =0,  -- 67    
		@controla_tran   CHAR    (01)='S',  -- 68    
        @CorresponsalCNT  CHAR  (10)='0',  -- 69 Corresponsal Contable del Cliente Banco CorpBanca    
        @p_IndOriManual NUMERIC       (2,0)=0,         -- 70    
		@CMX_Punta_Pizarra NUMERIC (18,4)= 0,  --71 Bac Operativo COMEX    
		@CMX_TC_Costo_Trad NUMERIC (18,4)= 0,        --72     
		@DifTran_Mo   NUMERIC (19,4)= 0 ,  -- 73 Resultados de diferencia de precios y paridades    
        @DifTran_Clp       NUMERIC (19, 0)= 0       ,-- 74    
        @Canal             VARCHAR(15) = ''        -- 75    
       )     
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   create table #tmp_cod_moneda ( Codigo_Moneda int )    
    
   ----<< Para Planillas Automaticas    
   DECLARE @hora            CHAR (08)    
   DECLARE @planilla_numero NUMERIC (06)    
   DECLARE @planilla_fecha  DATETIME    
   DECLARE @rel_numero      NUMERIC (06)    
   DECLARE @rel_fecha       DATETIME    
   DECLARE @rel_arbitraje   CHAR (01)    
   DECLARE @moneda          NUMERIC (03)    
   DECLARE @rut             NUMERIC (09)    
   DECLARE @codcar          NUMERIC (10)    
   DECLARE @EntidadBCCH     INTEGER    
   DECLARE @oper_contra     CHAR (01) -- Operacione Inversa en Operaciones M/X-USD    
   DECLARE @rut_banco       NUMERIC (10)     
   DECLARE @PesosxCompra    NUMERIC (19,4)    
   DECLARE @Rut_Corre_Corp  NUMERIC (10)      
   DECLARE @Cod_Corre_Corp  NUMERIC (10)    
   declare @Existe		    varchar(1)
   declare @fechamemo       datetime

   -- Para validaciones BAC
   declare @Mensaje varchar(2)
    
   IF @monmo > 9999999999     
   begin
      select 'NO', 'Monto muy grande no es soportado por sistema BAC'
      return 	
   end

   /************** Bloqueo TEMPORAL hasta corregir Turing - Integracion ******************/
/*
   if   @codmon  <> 'USD' and @codcnv = 'CLP' 
   begin  
      select 'NO', 'TURING no capta correctamente los Datos de Spot MX-CLP'
      return 	
   end  
*/   
   /*************** Evitar que se hagan operaciones sin moneda extranjera como moneda 
                    principal y evita posible error de integración con las monedas divide
                    en que turing intercambia la moneda principal maravilla que no tiene BAC
   ***************************************************************************************/
   if ( select count(1) from BacParamSuda..moneda where mnnemo = @codmon and mnmx = 'C' ) = 0
   begin  
      select 'NO', 'Moneda '+ @codmon + ' No puede usarse como moneda principal en Spot'
      return 	
   end  

    
   /************************Valida que tipo d mercado sea PTAS, EMPR, PTAS****************/
   IF NOT (@tipmer = 'EMPR' OR @tipmer = 'PTAS' OR @TipMer = 'ARBI')
   begin  
      select 'NO', 'Tipo de Mercado no Corresponde a BacCambio'
      return 	
   end  
  
   /*************************Valida que tipo de operacion sea correcto********************/
   exec BacParamSuda.dbo.SP_TURING_TIPOOPERACION @tipope ,@Existe output -- Ok SS
   if @Existe = 'N' 
   begin
      select 'NO', 'Tipo Operacion No Existe en BAC'
	  return
   end
   /*-----------Valida que cliente exista en Bac------------------------------------------*/
   if not exists(SELECT 1 FROM BacParamSuda..Cliente where clrut=@rutcli and Clcodigo=@codcli) 
   begin
      select 'NO', 'Cliente No Existe en BAC'
	  return
   end
   else
   begin   
      select @nomcli=(SELECT clnombre FROM BacParamSuda..Cliente where clrut=@rutcli and Clcodigo=@codcli)
   end
   /*********************************Validar código de moneda*********************************/
   -- usando el SP_TURING_MONEDA
   exec BacParamSuda..SP_TURING_MONEDA_NEMO @codmon ,@Existe output -- Ok 
   if @Existe = 'N' 
   begin
      select 'NO', 'Codigo de Moneda ' +@codmon +' No Existe en BAC '
	  return
   end
   /**********************************Validar código de moneda*********************************/
   exec BacParamSuda..SP_TURING_MONEDA_NEMO @codcnv ,@Existe output -- Ok 
   if @Existe = 'N' 
   begin
      select 'NO', 'Codigo de Moneda ' +@codcnv +' No Existe en BAC '
	  return
   end
   /*****************--Validar que este valor no sea cero.***********************************/
   if @monmo=0 
   begin
      select 'NO','Monto moneda no puede ser cero'
      return
   end
   /****************--Validar que este valor no sea cero.******************************************/
   if @ticam = 0
   begin
      select 'NO','Tipo de cambio no puede ser cero'
      return
   end

   if @tipope = 'C' 
   begin
      -- Moneda @CodMon es siempre extranjera
      exec BacParamSuda..SP_TURING_FORMADEPAGOMX @recib ,@Existe output -- Ok  
	  if @Existe = 'N' 
      begin
         select 'NO', 'Forma de Pago Recibe Moneda Extranjera No Existe en BAC'
         return
      end 	
   end
   else
   begin
      exec BacParamSuda..SP_TURING_FORMADEPAGOMX @entre ,@Existe output -- Ok  
      if @Existe = 'N' 
      begin
         select 'NO', 'Forma de Pago Entrega Moneda Extranjera No Existe en BAC'
         return
      end 	
   end

   /***************--funcion Forma de pago monedas Extranjeras**************************************/
   SELECT @Mensaje = BacparamSuda.dbo.fnMonedaMNoMX (@codCnv)
   /***************--funcion Forma de pago monedas Extranjeras**************************************/
   if @Mensaje = 'MX' 
      if @tipope = 'C' 
         begin
            exec BacParamSuda..SP_TURING_FORMADEPAGOMX @entre ,@Existe output -- Ok  
	        if @Existe = 'N' 
            begin
               select 'NO', 'Forma de Pago Recibe Moneda Extranjera No Existe en BAC'
               return
            end 	
         end
      else -- 'V'
      begin      
         exec BacParamSuda..SP_TURING_FORMADEPAGOMX @recib ,@Existe output -- Ok  
	     if @Existe = 'N' 
         begin
            select 'NO', 'Forma de Pago Recibe Moneda Extranjera No Existe en BAC'
            return
         end 	 
      end
   else -- 'MN'
      if @tipope = 'C' 
         begin
            exec BacParamSuda..SP_TURING_FORMADEPAGOMN @entre ,@Existe output -- Ok  
	        if @Existe = 'N' 
            begin
               select 'NO', 'Forma de Pago Recibe Moneda Extranjera No Existe en BAC'
               return
            end 	
         end
      else -- 'V'
      begin      
         exec BacParamSuda..SP_TURING_FORMADEPAGOMN @recib ,@Existe output -- Ok  
	     if @Existe = 'N' 
         begin
            select 'NO', 'Forma de Pago Recibe Moneda Extranjera No Existe en BAC'
            return
         end 	 
      end
   /*************************************Valida que operador exista en Bac******************************************/
   exec bacparamsuda..SP_TURING_VALIDA_OPERADOR @oper,@Existe output
   if @Existe = 'N' 
   begin
      select 'NO', 'Operador No Existe en BAC'
      return
   end 	
   /**************************************Valida que usuario no sea comex*******************************************/
   exec bacparamsuda..SP_TURING_USUARIOCOMEX @term ,@Existe output
   if @Existe = 'S' 
   begin
      select 'NO', 'Usuario tiene perfil Comex'
      return
   end 		
   /***********************Valida que @Fecha tenga la misma fecha de proceso de BacCamSuda..memo*******************/
   --Declare  @fechamemo datetime
   -- Se correige tabla de donde se saca la fecha de proceso.
   --select @fechamemo = mofech 
   --from    BacCamSuda..memo    
   Select @Fechamemo = AcFecPro 
   from BacCamSuda..meac     
 
   if @fecha != @fechamemo
   begin
      select 'NO', 'Fecha de Operacion es distinta a Fecha de Proceso'
      return
   end 		    
   
   --> OPERACIONES PLATAFORMAS EXTERNA    
      /*    
   IF  @rutcli=472655828     
 SELECT @term='STANDART'    
       
   IF  @rutcli=403770828    
 SELECT @term='BARCLAYS'    
    
   IF @rutcli=411885828    
 SELECT @term='CITIBANK'    
      */    
    
   IF @Canal <> 'CORREDORA'    
   BEGIN    
   IF (SELECT 1 FROM bacparamsuda..sinacofi WHERE clrut = @rutcli AND PlataformaExterna = 1) = 1   
      BEGIN    
          SELECT @term             = Isnull(terminal, @term)     
            FROM bacparamsuda..sinacofi     
           WHERE clrut             = @rutcli     
            AND  PlataformaExterna = 1    
      END    
   END    
    
    
   if @Canal = 'CORREDORA'    
        SET @tipmer = 'CCBB'    
    
      -->     
   SELECT @Rut_Corre_Corp = 96665450,     -- Rut corredora CorpBanca    
          @Cod_Corre_Corp = 1             -- Codigo corredora CorpBanca    
    
   SELECT @estatus = 'P'    
    
   SELECT  @rut_banco = acrut FROM meac    

   
   /*** Variables Para la Modificacion ***/    
   DECLARE @fx_ticam NUMERIC(19,4)    
   DECLARE @fx_monmo NUMERIC(19,4)    
   DECLARE @fx_ussme NUMERIC(19,4)    
   DECLARE @fx_codcnv CHAR(03)    
   DECLARE @fx_tctra NUMERIC(19,4)    
   DECLARE @fx_parida NUMERIC(19,8)    
   DECLARE @fx_partr       NUMERIC(19,8)    
   DECLARE @fx_tipmer CHAR(04)    
   DECLARE @fx_tipope CHAR(01)    
   DECLARE @fx_codmon CHAR(03)    
   DECLARE @fx_costfn  NUMERIC(15,04)    
   DECLARE @fx_USD30   NUMERIC(19,04)    
   DECLARE @fx_Rentab NUMERIC(19,4)    
   
   /*** Planilla Automatica ***/    
   DECLARE @parBCCH         NUMERIC(19,8)    
   DECLARE @MtoUSD          NUMERIC(19,8)    
   DECLARE @tc_BCCH         NUMERIC(19,8)    
   DECLARE @cv_BCCH         CHAR(1)    
   DECLARE @tipmoneda       CHAR(1)    
   DECLARE @USD30dias       NUMERIC(19,4)    
    
   DECLARE @TipoCliente     NUMERIC(05)    
    
   /*** Fin de Variables  ***/    
   SELECT @planilla_numero = 0    
   SELECT @planilla_fecha  = @Fecha    
   SELECT @rel_numero      = 0    
   SELECT @rel_fecha       = ''    
   SELECT @rel_arbitraje   = ''    
   SELECT @moneda          = 0    
   SELECT @TipoCliente     = 0    
    
   SELECT @hora            = CONVERT( CHAR(8), GETDATE() ,108 )    
    
    
   IF LTRIM(RTRIM(@term)) = '' AND @tipmer = 'ARBI' AND @der_numero = 0    
      SET @term = 'TELEFONO'    
    
   SELECT       @TipoCliente = ISNULL(cltipcli,0)    
          FROM  view_cliente    
          WHERE clrut        = @rutcli AND    
                clcodigo     = @codcli    
    
   SELECT       @EntidadBCCH = ISNULL( clcodban , 32 )    
          FROM  view_cliente, meac     
          WHERE clrut        = acrut and     
                clcodigo     =   1    
    
   SELECT       @tipmoneda = ISNULL(mnrrda,'D')    
          FROM  VIEW_MONEDA    
          WHERE SUBSTRING(mnnemo,1,3) = @codmon    
    
   SELECT @estado = -1                -- PARA TODOS    
    
   IF @tipmer ='EMPR' AND @term  ='DATATEC'     
     SELECT  @CostoFondo =@ticam    
    
   IF @codoma = 0    
   BEGIN    
      IF @tipmer = 'PTAS'    
      BEGIN    
         IF @tipope = 'C'    
            SELECT @codoma = 2    
         ELSE    
            SELECT @codoma = 7    
      END    
   END    

   -- MAP
   IF       @Canal != 'CORREDORA'    
        AND @codcnv = 'CLP'               
        AND @tipmer IN ('PTAS' , 'CANJ', 'EMPR')         
       AND     
         (  @TipoCliente > 0 AND @TipoCliente < 5  OR @forward = 'S' ) AND     
         ( @rutcli <> 1 AND @rutcli <> 2 AND @rutcli <> 3 AND @rutcli <> 4 AND @rutcli <> 5   AND     
           @rutcli <> 70 AND @rutcli <> @rut_banco) AND    
           @rutcli <> @Rut_Corre_Corp -- Op. con corp corredora no debe generar planilla segun guillermo silva 06/05/2004    
   BEGIN    
    
      /*----<< Carga codigo de Moneda*/    
      SELECT @moneda = 0        
      SELECT       @moneda = ISNULL(mncodmon,0)    
             FROM  VIEW_MONEDA    
             WHERE SUBSTRING(mnnemo,1,3) = @codmon        
      IF @moneda = 0 
      BEGIN            
         SELECT 'NO', 'CODIGO DE MONEDA ORIGINAL PARA PLANILLA AUTOMATICA NO FUE ENCONTRADA'    
         RETURN         
      END    
      /*----<< Carga Paridad BCCH y otros para planilla*/    
      SELECT @parBCCH = 0    
      SELECT @MtoUSD  = 0    
      SELECT @tc_BCCH = 0    
      SELECT @cv_BCCH = @tipope    
    
      /*---- Valida Paridad Mensual del BCCH*/    
      SELECT       @parBCCH = ISNULL(vmparmes,0)     
             FROM  VIEW_POSICION_SPT     
             WHERE CONVERT( CHAR(8), vmfecha, 112) = CONVERT( CHAR(8), @fecha, 112) AND    
                   vmcodigo = @codmon        
      IF @parBCCH IS NULL 
      BEGIN            
         SELECT 'NO', 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA'    
         RETURN         
      END     
      ELSE 
      IF @parBCCH = 0 
      BEGIN            
            SELECT 'NO', 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA'    
            RETURN        
      END    
   END
   -------------------------------------------<< Arbitrajes    
   IF @tipmer = 'ARBI' OR ( @tipmer = 'EMPR' AND @forward = 'S' AND  @codcnv = 'USD'  AND @Canal != 'CORREDORA') 
   BEGIN    
      SELECT @parBCCH = 0    
      SELECT @MtoUSD  = 0    
      SELECT @tc_BCCH = 0    
      SELECT @cv_BCCH = ''    
      SELECT       @moneda = ISNULL(mncodmon,0)    
             FROM  VIEW_MONEDA    
             WHERE SUBSTRING(mnnemo,1,3) = @codmon        
      ---- Valida Paridad Mensual del BCCH    
      SELECT   @parBCCH = ISNULL(vmparmes,0)     
             FROM  VIEW_POSICION_SPT     
             WHERE CONVERT( CHAR(8), vmfecha, 112) = CONVERT( CHAR(8), @fecha, 112) AND    
                   vmcodigo = @codmon        
      IF @parBCCH IS NULL 
      BEGIN            
         SELECT 'NO', 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA DE ARBITRAJE'    
         RETURN         
      END 
      IF @parBCCH = 0 
      BEGIN        
         SELECT 'NO', 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA DE ARBITRAJE'    
         RETURN         
      END        
      ----<< Planilla Moneda Cnv de operacion    
      SELECT @moneda  = 0    
      SELECT       @moneda  = ISNULL(mncodmon,1)    
             FROM  VIEW_MONEDA    
             WHERE SUBSTRING(mnnemo,1,3) = @codcnv        
      IF @moneda is NULL 
      BEGIN        
         SELECT 'NO','PARIDAD BCHH DE MONEDA CONVERSION PARA PLANILLA AUTOMTICA NO FUE ENCONTRADA'    
         RETURN     
      END 
      IF @moneda = 0 
      BEGIN        
         SELECT 'NO','PARIDAD BCHH DE MONEDA CONVERSION PARA PLANILLA AUTOMTICA NO FUE ENCONTRADA'    
         RETURN         
      END        
    
      select 'OK', ''
      return
      SET NOCOUNT OFF  
   END    
END

GO
