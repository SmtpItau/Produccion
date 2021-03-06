USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_RELACION_CLIENTE]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_RELACION_CLIENTE]
   (   @rut1      NUMERIC(10)  
   ,   @codigo1   NUMERIC( 3)  
   ,   @rut2      NUMERIC(10)  
   ,   @codigo2   NUMERIC( 3)  
   ,   @porc      FLOAT  = 0  
   ,   @AfLinea   INT    
   ,   @iForzar   INT  
   )  
AS  
BEGIN  
  
DECLARE @Rut CHAR (10)  
DECLARE @NombrePadre CHAR (70)  
DECLARE @CodPadre NUMERIC(2)  
DECLARE @NombreHijo CHAR (70)  
  
DECLARE @Num as numeric(10)  
DECLARE @iSumMontosHijo    NUMERIC(19,4)   -->   as numeric(10)  
DECLARE @MontoPadre        NUMERIC(19,4)   -->   as numeric (10)  
  
DECLARE @nMonedaP as varchar(5)  
DECLARE @nMonedaH as varchar(5)  
  
  
   SET NOCOUNT ON  
  
   --IF EXISTS(SELECT 1 FROM LINEA_GENERAL WHERE Rut_Cliente = @rut2 AND Codigo_Cliente = @codigo2 and TotalAsignado >0 )  
   --BEGIN  
      --SELECT -2 , 'Error'  
      --RETURN  
   --END  
  
 IF EXISTS(SELECT 1 FROM CLIENTE_RELACIONADO WHERE clrut_hijo = @rut1 AND clcodigo_hijo = @codigo1) --Valida si el cliente es hijo o otro padre  
 BEGIN  
  
     SET @Rut = (select clrut_padre from CLIENTE_RELACIONADO where clrut_hijo = @rut1 and clcodigo_hijo = @codigo1)  
     SET @CodPadre = (select clcodigo_padre from CLIENTE_RELACIONADO where clrut_hijo = @rut1 and clcodigo_hijo = @codigo1)  
     SET @NombrePaDRE = (SELECT Clnombre FROM VIEW_CLIENTE WHERE @Rut = clrut and Clcodigo = @CodPadre)  
     SET @NombreHijo = (SELECT Clnombre FROM VIEW_CLIENTE WHERE @rut1 = clrut and Clcodigo = @codigo1)  
 SELECT -33 , 'Cliente' + ' ' + LTRIM(RTRIM(@NombreHijo)) + ' ' + 'se encuentra bajo la custodia de' + ' ' + LTRIM(RTRIM(@NombrePadre))  
 return  
   END  
  
 IF EXISTS(SELECT 1 FROM CLIENTE_RELACIONADO WHERE clrut_hijo = @rut2 AND clcodigo_hijo = @codigo2 AND clrut_padre <> @rut1) --Valida si el cliente es hijo o otro padre  
   BEGIN  
     SET @Rut = (select clrut_padre from CLIENTE_RELACIONADO where clrut_hijo = @rut2 and clcodigo_hijo = @codigo2)  
     SET @CodPadre = (select clcodigo_padre from CLIENTE_RELACIONADO where clrut_hijo = @rut2 and clcodigo_hijo = @codigo2)  
     SET @NombrePaDRE = (SELECT Clnombre FROM VIEW_CLIENTE WHERE @Rut = clrut and Clcodigo = @CodPadre)    
     SET @NombreHijo = (SELECT Clnombre FROM VIEW_CLIENTE WHERE @rut2 = clrut and Clcodigo = @codigo2)  
 SELECT -3 , 'Cliente' + ' ' + LTRIM(RTRIM(@NombreHijo)) + ' ' + 'se encuentra bajo la custodia de' + ' ' + LTRIM(RTRIM(@NombrePadre))  
      RETURN  
   END  
  
   IF EXISTS(SELECT 1 FROM CLIENTE_RELACIONADO WHERE clrut_padre   = @rut2 AND clcodigo_padre = @codigo2) --Valida si Cliente es Padre de otro grupo  
   BEGIN  
 SET @NombrePadre = (SELECT Clnombre FROM VIEW_CLIENTE WHERE @rut2 = clrut AND Clcodigo = @codigo2)  
 SELECT -4 , 'Cliente' + ' ' +  LTRIM(RTRIM(@NombrePadre)) + ' ' + 'es padre de otro grupo.'   
 return  
   END  
  
IF @AfLinea = 1   
BEGIN  
   IF NOT EXISTS(SELECT 1 FROM LINEA_GENERAL WHERE Rut_Cliente = @rut1 AND Codigo_Cliente = @codigo1) --Valida si Cliente tiene linea  
   BEGIN  
      SELECT -5 , 'Debe Asignar Línea a Cliente'  
 return  
   END  
  
  
  
   IF NOT EXISTS(SELECT 1 FROM LINEA_GENERAL WHERE Rut_Cliente = @rut2 AND Codigo_Cliente = @codigo2) --Valida si Cliente tiene linea  
   BEGIN  
      SELECT -6 , 'Debe Asignar Línea a Cliente Relacionado'  
      RETURN  
 END   
  
  IF NOT EXISTS(SELECT 1 FROM LINEA_SISTEMA WHERE Rut_Cliente = @rut2 AND Codigo_Cliente = @codigo2)  
    BEGIN  
        SELECT -6 , 'Debe Asignar Línea (Sistema) a Cliente Relacionado'  
        RETURN  
 END    
  
--->Valida el tipo de Moneda  
 SET @nMonedaP = 0  
 SET @nMonedaP = 0  
 SET @nMonedaP = ( SELECT CONVERT(INTEGER, ltrim(rtrim(Moneda)) )   
                        FROM BacLineas.dbo.LINEA_GENERAL   
                       WHERE rut_cliente = @rut1 AND codigo_cliente = @codigo1  )  
  SET @nMonedaH = ( SELECT CONVERT(INTEGER, ltrim(rtrim(Moneda)) )   
                        FROM BacLineas.dbo.LINEA_GENERAL   
                       WHERE rut_cliente = @rut2 AND codigo_cliente = @codigo2 )  
 if @nMonedaP <> @nMonedaH  
  select -7, 'El tipo de moneda de uno de los clientes relacionados es distinta.'  
  
---> Determina si el monto ocupado de un hijo no es superior al monto asignado al Padre  
   IF  NOT EXISTS(SELECT 1 FROM LINEA_GENERAL LG1 WHERE LG1.Rut_Cliente = @rut1 and LG1.Codigo_Cliente = @codigo1  
 AND  LG1.TotalAsignado >= (SELECT SUM(LG2.TotalOcupado) FROM LINEA_GENERAL LG2 WHERE LG2.RUT_CLIENTE = @rut2 and LG2.Codigo_Cliente = @codigo2)) --Valida que el Monto asignado a un cliente hijo no sea superior al del padre  
   BEGIN  
   IF @iForzar = -1    
   BEGIN  
   SELECT -9 , 'El Monto Ocupado de las Operaciones Vigentes de los clientes (hijos) no puede sobrepasar el Monto asignado al Padre.'  
      RETURN  
   END  
   END  
  
 -----> Determina si la sumatoria de los montos totales de los hijos no es superior al monto asignado al Padre  
 SET @Num   = 1  
 SET @iSumMontosHijo = 0  
 SET @MontoPadre  = (select TotalAsignado from linea_general where Rut_Cliente = @rut1  and  Codigo_Cliente = @codigo1)  
 WHILE @Num < (SELECT count(*) CLRUT_HIJO FROM CLIENTE_RELACIONADO WHERE CLRUT_PADRE = @rut1 AND clcodigo_padre = @codigo1)   
 BEGIN  
         SET @iSumMontosHijo       = @iSumMontosHijo + ( SELECT SUM( TotalOcupado )  
                                       FROM BacLineas.dbo.CLIENTE_RELACIONADO      rc with(nolock)  
                                            INNER JOIN BacLineas.dbo.LINEA_GENERAL lg with(nolock) ON rc.clrut_hijo = lg.rut_cliente and rc.clcodigo_hijo = lg.codigo_cliente  
                                      WHERE clrut_padre = @rut1 and clcodigo_padre = @codigo1)  
     
   SET @Num = @Num + 1  
 END  
 IF @iSumMontosHijo > @MontoPadre  
   BEGIN  
  
   IF @iForzar = -1    
   BEGIN  
      SELECT -9 , 'El Monto Ocupado de las Operaciones Vigentes de los clientes (hijos) no puede sobrepasar el Monto asignado al Padre.'  
      RETURN  
   END  
  
   END  
END  
 ------  
  
   IF EXISTS(SELECT 1 FROM CLIENTE_RELACIONADO  
             WHERE @rut1 = clrut_padre AND @codigo1 = clcodigo_padre  
             AND   @rut2 = clrut_hijo  AND @codigo2 = clcodigo_hijo)  
   BEGIN  
      UPDATE CLIENTE_RELACIONADO  
      SET    clrut_padre    = @rut1  
      ,      clcodigo_padre = @codigo1  
      ,      clrut_hijo     = @rut2  
      ,      clcodigo_hijo  = @codigo2  
      ,      clporcentaje   = @porc  
      ,      Afecta_Lineas_Hijo = @AfLinea  
      WHERE  @rut1     = clrut_padre  
      AND    @codigo1     = clcodigo_padre  
      AND    @rut2     = clrut_hijo  
      AND    @codigo2     = clcodigo_hijo  
   END ELSE  
   BEGIN  
      INSERT INTO CLIENTE_RELACIONADO  
      (      clrut_padre  
      ,      clcodigo_padre  
      ,      clrut_hijo  
      ,      clcodigo_hijo  
      ,      clporcentaje  
      ,      Afecta_Lineas_Hijo  
      )   
      VALUES  
      (      @rut1  
      ,      @codigo1  
      ,      @rut2  
      ,      @codigo2  
      ,      @porc  
      ,      @AfLinea  
      )  
   END  
  
   SELECT 0 , 'OK'  
  
END  
  
GO
