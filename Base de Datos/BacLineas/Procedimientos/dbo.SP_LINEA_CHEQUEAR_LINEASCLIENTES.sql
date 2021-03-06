USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_LINEASCLIENTES]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_LINEASCLIENTES]  
   (   @cSistema             CHAR(03)  
   ,   @dFecPro              DATETIME  
   ,   @nRutcli              NUMERIC(09,0)  
   ,   @nCodigo              NUMERIC(09,0)  
   ,   @dFecvctop            DATETIME  
   ,   @nMonto               NUMERIC(19,4)  
   ,   @cTipo_Riesgo         CHAR(1)  
   ,   @cProducto            CHAR(5)  
   ,   @codigo_instrumento   NUMERIC(5)  
   ,   @moneda               NUMERIC(5)  
   ,   @formapago            NUMERIC(3)  
   ,   @MetodoLCR            NUMERIC(5)
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @dFechaHoy          DATETIME  
       SET @dFechaHoy          = (SELECT acfecproc FROM BacTraderSuda.dbo.MDAC) --	with(nolock))
  
   DECLARE @cNombre            CHAR(60)  
   DECLARE @iFound             INTEGER  
   DECLARE @nTotalDisponible   NUMERIC(19,4)  
   DECLARE @nTotalOcu          NUMERIC(19,4)  
   DECLARE @nSinriesgoOcup     NUMERIC(19,4)  
   DECLARE @nConriesgoOcup     NUMERIC(19,4)  
   DECLARE @nMontoconriesgo    NUMERIC(19,4)  
   DECLARE @nMontosinriesgo    NUMERIC(19,4)  
   DECLARE @cControl_Producto  CHAR(2)  
   DECLARE @plazominimo        NUMERIC(5)  
   DECLARE @Comder_MetodoLCR   NUMERIC(5)	-- COMDER
  
  -- PRD8800
   DECLARE @Id_SistemaNetting      CHAR(03)          
   SELECT  @Id_SistemaNetting =  CASE WHEN @MetodoLCR NOT IN (1,4) THEN Id_Grupo ELSE Id_Sistema  END
   FROM  TBL_AGRPROD
   WHERE Id_Sistema  = @cSistema
   -- PRD8800

/*
      truncate table DEBUG_VALORES
      insert into DEBUG_VALORES -- truncate table DEBUG_VALORES  -- select * from DEBUG_VALORES
      select  Variable01 = '@nRutcli'
      	  , Valor01 = @nRutcli
      	  , Variable02 = '@ncodigo' + @Id_SistemaNetting
      	  , Valor02    = @nCodigo
*/


   IF NOT EXISTS( SELECT 1	 FROM BacLineas..PRODUCTO_SISTEMA
							WHERE	(	(Id_Sistema = @cSistema			and @cProducto	= Codigo_Producto)
							   or		(Id_Sistema = @Id_SistemaNetting	and @MetodoLCR	NOT IN (1,4))
									) 
                  )
   BEGIN  
      INSERT INTO BacLineas..PRODUCTO_SISTEMA  
      SELECT case when @MetodoLCR NOT IN (1,4)  then @Id_SistemaNetting else @cSistema end   -- MAP, no es mucho el aporte
           , case when @MetodoLCR NOT IN (1,4)  then @Id_SistemaNetting else @cProducto end  -- MAP, no es mucho el aporte
           , '', 0, 0   --- select * from BacLineas..PRODUCTO_SISTEMA                        -- MAP, no es mucho el aporte
   END  
  
   IF @nCodigo = 0   --> Generalmente cuando se envia a Chequear un emisor   -- MAP Cotingencia 17 NOv. 2009 ver que paso con tabla  
      SET @nCodigo = (SELECT max(clcodigo) FROM BacParamSuda..CLIENTE with (nolock) WHERE clrut = @nRutcli)  
   ELSE  
      SET @cNombre = (SELECT max(clnombre) FROM BacParamSuda..CLIENTE with (nolock) WHERE clrut = @nRutcli AND clcodigo = @nCodigo)  
  
   IF @csistema = 'BEX' AND @cProducto = 'CP'  
      SET @cProducto = 'CPX'  
  
   -- Existe Línea de Crédito Definida a Nivel de General ?  
      SET @iFound        = 0  
   SELECT @iFound        = 1  
   FROM   BacLineas..LINEA_GENERAL with (nolock)   
   WHERE  rut_cliente    = @nRutcli  
   AND    codigo_cliente = @nCodigo  
  
   IF @iFound = 0  
   BEGIN  
      INSERT INTO BacLineas..LINEA_GENERAL  
      (   Rut_Cliente  
      ,   Codigo_Cliente  
      ,   FechaAsignacion  
      ,   FechaVencimiento  
      ,   FechaFinContrato  
      ,   Bloqueado  
      ,   TotalAsignado  
      ,   TotalOcupado  
      ,   TotalDisponible  
      ,   TotalExceso  
      )  
      VALUES  
      (   @nRutcli  
      ,   @nCodigo  
      ,   @dFechaHoy --> @dFecPro  
      ,   @dFechaHoy --> @dFecPro  
      ,   @dFechaHoy --> @dFecPro  
      ,   'N'        --> RFUENTES, 09_Enero_2012  
      ,   0  
      ,   0  
      ,   0  
      ,   0  
      )  
   END  
  
	-- COMDER: Consultar metodologia PRD21119-Consumo Línea Derivados COMDER (Metodologia 6 = LINEA DRV)
	SET @Comder_MetodoLCR = 0
	SELECT @Comder_MetodoLCR = ISNULL(ClRecMtdCod,0)
	FROM bacparamsuda.dbo.cliente
	WHERE ClRut = @nRutcli AND ClCodigo = @nCodigo
        
   -- Existe Línea de Crédito Definida a Nivel de Sistema ?  
   SET @iFound        = 0  
   SELECT @iFound        = 1  
   FROM   BacLineas..LINEA_SISTEMA with (nolock)   
   WHERE  rut_cliente    = @nRutcli  
   AND    codigo_cliente = @nCodigo  
   AND    id_sistema     = @Id_SistemaNetting   -- @cSistema PRD8800

   IF @iFound = 0  
   BEGIN
   		IF @Comder_MetodoLCR <> 6   -- PRD21119
   		BEGIN
	   	
		  INSERT INTO BacLineas..LINEA_SISTEMA  
		  (   Rut_Cliente  
		  ,   Codigo_Cliente  
		  ,   Id_Sistema  
		  ,   FechaAsignacion  
		  ,   FechaVencimiento  
		  ,   FechaFinContrato  
		  ,   Bloqueado  
		  ,   TotalAsignado  
		  ,   TotalOcupado  
		  ,   TotalDisponible  
		  ,   TotalExceso  
		  )  
		  VALUES  
		  (   @nRutcli  
		  ,   @nCodigo  
		  ,   @Id_SistemaNetting  -- @cSistema PRD8800
		  ,   @dFechaHoy --> @dFecPro  
		  ,   @dFechaHoy --> @dFecPro  
		  ,   @dFechaHoy --> @dFecPro  
		  ,   'N'  
		  ,   0  
		  ,   0  
		  ,   0  
		  ,   0  
		  )  
	   END
   END    
  
  
   -- 13676 
   declare @Rut_padre numeric(13)
   declare @Codigo_Padre numeric(5) 

   set @Rut_padre = 0
   set @Codigo_Padre = 0
   select @Rut_Padre = ClRut_padre , @Codigo_Padre = ClCodigo_padre 
   from cliente_relacionado  -- select * from cliente_relacionado 
    where Clrut_hijo = @nRutcli 
        and ClCodigo_hijo = @nCodigo


	if	(@Rut_padre <> 0 and @Codigo_Padre <> 0) and (@Rut_Padre <> @nRutcli and @Codigo_Padre <> @nCodigo)
		execute dbo.SP_LINEA_CHEQUEAR_LINEASCLIENTES	@cSistema             
                                                                ,   @dFecPro              
                                                                ,   @Rut_padre     --  Para construir linea para el padre          
                                                                ,   @Codigo_Padre  --  Para Construir linea para el padre            
                                                                ,   @dFecvctop            
                                                                ,   @nMonto               
                                                                ,   @cTipo_Riesgo         
                                                                ,   @cProducto            
                                                                ,   @codigo_instrumento   
                                                                ,   @moneda               
                                                                ,   @formapago            
                                                                ,   @MetodoLCR            
   -- 13676
 END  

GO
