USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_PARIDAD_BLOOMBERG]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_ACTUALIZA_PARIDAD_BLOOMBERG]
               ( @fecha  char(8),  
               @costo_compra numeric(10,4),  
               @costo_venta numeric(10,4),  
               @codigo_moneda_bloomberg char(40)  
                )  
as  
BEGIN  
  
 if @fecha = ''  
 begin  
  set @fecha = CONVERT(CHAR(8), (select acfecpro from dbo.MEAC), 112)  
 end  
  
  DECLARE @MONEDA_BLOOMBERG AS CHAR(40)  
  DECLARE @MONEDA_FUERTE_DEBIL AS CHAR(1)  
    
  SELECT  @MONEDA_BLOOMBERG = MNCODMON  
  , @MONEDA_FUERTE_DEBIL = mnrrda --M = Fuerte (Multiplica), D = Débil (Divide)  
  FROM BACPARAMSUDA..MONEDA  
  WHERE MNNEMO=@codigo_moneda_bloomberg  
    
 --PARA SISTEMA BAC EL CODIGO DE MONDA "KRW" CORRESPONDE A "WON DE LA REP.KOREA"    
  IF @codigo_moneda_bloomberg = 'KRW'    
     BEGIN    
     SET @MONEDA_BLOOMBERG='144'    
  END       
  
	--> 11489 - Restricción de horario para invertir Comex - 
	DECLARE @iSwTime	INT		--> control horario
	DECLARE @iBloqued	INT		--> bloqueo temporal
		SET @iSwTime	= 1 --> True	(1=ON TIME	; 0=OUT TIME)
		SET	@iBloqued	= 0	--> Activo	(0=Activo	; 1=Bloqueado)

	SELECT	@iSwTime	= CASE WHEN (Hora_Apertura <= CONVERT(CHAR(10), GETDATE(), 108) ) AND (Hora_Cierre >= CONVERT(CHAR(10), GETDATE(), 108)) THEN 1 ELSE 0 END
		,	@iBloqued	= Bloqueado
	FROM	BacParamSuda.dbo.TBL_CONTROL_HORARIO_COMEX with(nolock)

	IF @iSwTime = 0 OR @iBloqued = 1
	BEGIN
		SET @costo_compra = 0.0
		SET @costo_venta  = 0.0
	END
	--> 11489 - Restricción de horario para invertir Comex - 

  IF @MONEDA_FUERTE_DEBIL = 'D' --si es moneda débil se intercambian las paridades  
 BEGIN  
  update COSTOS_COMEX set Costo_Compra = @costo_venta, Costo_Venta = @costo_compra  
  where  CODMONEDA = @MONEDA_BLOOMBERG    
  and    fecha = @fecha     
 END  
  ELSE  
 BEGIN  
  update COSTOS_COMEX set Costo_Compra = @costo_compra, Costo_Venta = @costo_venta  
  where  CODMONEDA = @MONEDA_BLOOMBERG    
  and    fecha = @fecha  
 END  
  
END  

GO
