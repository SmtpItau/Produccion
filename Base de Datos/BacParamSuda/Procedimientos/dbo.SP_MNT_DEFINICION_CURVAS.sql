USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_DEFINICION_CURVAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNT_DEFINICION_CURVAS]  
   (   @iAccion         INT  
   ,   @cCodigoCurva    VARCHAR(20)   = ''  
   ,   @cDescripcion    VARCHAR(100)  = ''  
   ,   @cTipoCurva      CHAR(1)       = ''  
   ,   @cCurvaLocal     CHAR(1)       = 'N'  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   IF @iAccion = 1  
   BEGIN  
      SELECT CodigoCurva  
      ,      Descripcion  
      ,      TipoCurva  
   -- 05/12/2008  - Actualización Curvas Locales:  parametrización de campo CurvaLocal  
      ,      CurvaLocal        
      FROM   DEFINICION_CURVAS   
      WHERE (CodigoCurva  = @cCodigoCurva OR @cCodigoCurva = '')  
      ORDER BY CodigoCurva , TipoCurva , Descripcion  
   END  
     
   IF @iAccion = 2  
   BEGIN  
      DELETE DEFINICION_CURVAS WHERE (CodigoCurva  = @cCodigoCurva OR @cCodigoCurva = '')  
   END  
  
   IF @iAccion = 3  
   BEGIN  
      IF NOT EXISTS(SELECT 1 FROM DEFINICION_CURVAS WHERE CodigoCurva = @cCodigoCurva) -- AND TipoCurva = @cTipoCurva)  
      BEGIN  
  
  
         -- 10/12/2008  - Actualización Curvas Locales:  parametrización de campo CurvaLocal  
         INSERT INTO DEFINICION_CURVAS   
			  SELECT @cCodigoCurva , @cDescripcion , @cTipoCurva, @cCurvaLocal
	 -- MAP 20081202 Usao de Curvas Locales, pendiente que venga campo desde pantalla
      END  
   END  
  
   IF @iAccion = 4 --> Ayuda Curvas Creadas  
   BEGIN  
      SELECT CodigoCurva  = CodigoCurva   
      ,      Descripcion  = Descripcion   
      ,      TipoCurva    = TipoCurva  
      FROM   DEFINICION_CURVAS  
      ORDER BY CodigoCurva  
   END  
  
   IF @iAccion = 5 --> Validación de Definición  
   BEGIN  
  
      IF @cCodigoCurva = ''  
      BEGIN  
         RETURN  
      END  
  
      DECLARE @dFechaVigencia   CHAR(10)  
      ,       @cMensaje         VARCHAR(500)  
      DECLARE @iFound           INTEGER  
  
      SELECT  @dFechaVigencia   = ISNULL( (SELECT CONVERT(CHAR(10),MAX(FechaGeneracion),103) FROM CURVAS WHERE CodigoCurva = @cCodigoCurva) ,'-')  
      SELECT  @cMensaje         = ''  
  
      IF @dFechaVigencia <> '-'  
      BEGIN  
         SELECT @cMensaje = @cMensaje + '1.- Curva Con Definición Vigente a la Fecha. ' + @dFechaVigencia + CHAR(10)  
      END  
  
      SELECT @iFound = 0  
      SELECT @iFound = ISNULL((SELECT DISTINCT -1 FROM CURVAS_PRODUCTO WHERE CodigoCurva = @cCodigoCurva), 0)  
         IF  @iFound = -1  
            SELECT @cMensaje = @cMensaje + '2.- Curva Asignada en Curvas por Producto Como Curva Principal.' + CHAR(10)  
  
      SELECT @iFound  = 0  
      SELECT @iFound  = ISNULL((SELECT DISTINCT -1 FROM CURVAS_PRODUCTO WHERE CurAlter = @cCodigoCurva), 0)  
         IF  @iFound  = -1  
            SELECT @cMensaje = @cMensaje + '3.- Curva Asignada en Curvas por Producto Como Curva Alternativa.' + CHAR(10)  
  
      SELECT @iFound = 0  
      SELECT @iFound = ISNULL((SELECT DISTINCT -1  FROM CURVAS_PRODUCTO WHERE CurSpread = @cCodigoCurva), 0)  
         IF  @iFound = -1  
            SELECT @cMensaje = @cMensaje + '4.- Curva Asignada en Curvas por Producto Como Curva Spread.' + CHAR(10)  
  
      IF @cMensaje = ''  
      BEGIN  
         SELECT 0 , '- Curva Se Puede Eliminar Sin Cuestionar.'  
      END ELSE  
      BEGIN  
         SELECT -1 , @cMensaje   
      END  
   END  
  
   IF @iAccion = 6 --> Validación de Definición  
   BEGIN  
      DELETE FROM CURVAS  
      WHERE  CodigoCurva NOT IN( SELECT CodigoCurva FROM DEFINICION_CURVAS )  
  
      DELETE CURVAS_PRODUCTO  
      WHERE  CodigoCurva NOT IN( SELECT CodigoCurva FROM DEFINICION_CURVAS )  
  
      UPDATE CURVAS_PRODUCTO  
         SET CurAlter = ''  
        FROM CURVAS_PRODUCTO  
       WHERE CurAlter NOT IN( SELECT CodigoCurva FROM DEFINICION_CURVAS )  
  
      UPDATE CURVAS_PRODUCTO  
         SET CurSpread = ''  
        FROM CURVAS_PRODUCTO  
       WHERE CurSpread NOT IN( SELECT CodigoCurva FROM DEFINICION_CURVAS )  
   END  
  
END
GO
